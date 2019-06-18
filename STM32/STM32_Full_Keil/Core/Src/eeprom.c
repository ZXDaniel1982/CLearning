/* Includes ------------------------------------------------------------------*/
#include "eeprom.h"
#include "FreeRTOS.h"
#include "lcd.h"
#include <string.h>
#include <stdlib.h>
#include <stdbool.h>

#include "spi.h"

/* Select SPI FLASH: ChipSelect pin low  */
#define Select_Flash()     HAL_GPIO_WritePin(SST_CS_GPIO_Port, SST_CS_Pin, GPIO_PIN_RESET);
/* Deselect SPI FLASH: ChipSelect pin high */
#define NotSelect_Flash()    HAL_GPIO_WritePin(SST_CS_GPIO_Port, SST_CS_Pin, GPIO_PIN_SET);

const uint8_t TEXT_Buffer[]={"Chen An SST25VF"};       //???flash???

osThreadId EEPRomTaskHandle;
//osMutexId spcGSMTestmutex;
static void EEPRomTask(void const *arg);
/*----------------------------------------------------------------------------*/
/* Private functions                                                           */
/*----------------------------------------------------------------------------*/
uint16_t SPI_Flash_ReadID(void)  
{  
	uint8_t Temp = 0;
  uint8_t Ret = 0; 
  uint16_t id = 0;	
	Select_Flash();
			
	//????ID??    
	Temp = 0xAB;
  HAL_SPI_TransmitReceive(&hspi1, &Temp, &Ret, 1, 1000);
	
	Temp = 0x00;
	HAL_SPI_TransmitReceive(&hspi1, &Temp, &Ret, 1, 1000);
	
	Temp = 0x00;
	HAL_SPI_TransmitReceive(&hspi1, &Temp, &Ret, 1, 1000);
	
	Temp = 0x00;
	HAL_SPI_TransmitReceive(&hspi1, &Temp, &Ret, 1, 1000);

	//?????16??    
	Temp = 0xFF;
	HAL_SPI_TransmitReceive(&hspi1, &Temp, &Ret, 1, 1000);
	tftprintf("High value is %x", Ret);
	id = ((uint16_t) Ret) << 8;
	
	Temp = 0xFF;
	HAL_SPI_TransmitReceive(&hspi1, &Temp, &Ret, 1, 1000);
	tftprintf("Low value is %x", Ret);
	id += (uint16_t) Ret;
	
	NotSelect_Flash();                                     
	return id;  
}  

static void EEPRomTask(void const *arg)
{
  tftprintf("EEPROM ID is %d", SPI_Flash_ReadID());
	
	while (1) {
	  osDelay(2000);
	}
}

/*----------------------------------------------------------------------------*/
/* Public functions                                                           */
/*----------------------------------------------------------------------------*/
void EEPRom_Init(void)
{
//	osMutexDef(GSMTestmutex);
//  spcGSMTestmutex = osMutexCreate (osMutex (GSMTestmutex));
//	
  osThreadDef(EEPRomTaskName, EEPRomTask, osPriorityBelowNormal, 0, 128);
  EEPRomTaskHandle = osThreadCreate(osThread(EEPRomTaskName), NULL);
}
