/* Includes ------------------------------------------------------------------*/
#include "eeprom.h"
#include "FreeRTOS.h"
#include "lcd.h"
#include <string.h>
#include <stdlib.h>
#include <stdbool.h>

/* Select SPI FLASH: ChipSelect pin low  */
#define Select_Flash()     HAL_GPIO_WritePin(SST_CS_GPIO_Port, SST_CS_Pin, GPIO_PIN_RESET)
/* Deselect SPI FLASH: ChipSelect pin high */
#define NotSelect_Flash()    HAL_GPIO_WritePin(SST_CS_GPIO_Port, SST_CS_Pin, GPIO_PIN_SET)

osThreadId EEPRomTaskHandle;
//osMutexId spcGSMTestmutex;
static void EEPRomTask(void *arg);
/*----------------------------------------------------------------------------*/
/* Private functions                                                           */
/*----------------------------------------------------------------------------*/
static void EEPRomTask(void *arg)
{
  tftprintf("Entering %s", __func__);
	
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
