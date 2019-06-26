/* Includes ------------------------------------------------------------------*/
#include "eeprom.h"
#include "FreeRTOS.h"
#include "lcd.h"
#include "usart.h"
#include <string.h>
#include <stdlib.h>
#include <stdbool.h>

#include "spi.h"
#include "cmsis_os.h"

#include "fatfs.h"

/* Select SPI FLASH: ChipSelect pin low  */
#define Select_Flash()     HAL_GPIO_WritePin(SST_CS_GPIO_Port, SST_CS_Pin, GPIO_PIN_RESET);
/* Deselect SPI FLASH: ChipSelect pin high */
#define NotSelect_Flash()    HAL_GPIO_WritePin(SST_CS_GPIO_Port, SST_CS_Pin, GPIO_PIN_SET);

#define countof(a)   (sizeof(a) / sizeof(*(a)))
	
#define TxBufferSize1   (countof(TxBuffer1) - 1)
#define RxBufferSize1   (countof(TxBuffer1) - 1)

unsigned char SST25_buffer[4096];

const uint8_t TxBuffer1[]={"Chen An SST25VF"};       //???flash???

osThreadId EEPRomTaskHandle;

static void EEPRomTask(void const *arg);
/*----------------------------------------------------------------------------*/
/* Private functions                                                           */
/*----------------------------------------------------------------------------*/
static void EEPRom_SendByte(uint8_t byte)
{
	uint8_t val = byte;
  HAL_SPI_Transmit(&hspi1, &val, 1, 100);
}

static uint16_t SPI_Flash_ReadID(void)  
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
	uartprintf("High value is %x\r\n", Ret);
	id = ((uint16_t) Ret) << 8;
	
	Temp = 0xFF;
	HAL_SPI_TransmitReceive(&hspi1, &Temp, &Ret, 1, 1000);
	uartprintf("Low value is %x\r\n", Ret);
	id += (uint16_t) Ret;
	
	NotSelect_Flash();  

	return id;  
}  

static uint8_t rdsr(void){
	uint8_t busy;
	
	Select_Flash();
	EEPRom_SendByte(0x05);
	HAL_SPI_Receive(&hspi1, &busy, 1, 300);
	NotSelect_Flash();
	return(busy);
}

static void wip(void){
	uint8_t a=1;
	while((a&0x01)==1) a=rdsr();	
}

static void wsr(void){	
	Select_Flash();
	EEPRom_SendByte(0x50);
	NotSelect_Flash(); 
	
	Select_Flash();
	EEPRom_SendByte(0x01);
	EEPRom_SendByte(0x00);
	NotSelect_Flash();
	
  wip();
}

static void wen(void){
	Select_Flash();
	EEPRom_SendByte(0x06);
	NotSelect_Flash();
}

static void EEProm_SectorErrase(unsigned long a1){
	wsr();
	wen();  
	
	Select_Flash();	  
	EEPRom_SendByte(0x20);
	EEPRom_SendByte((uint8_t)((a1&0xffffff)>>16));    //addh
	EEPRom_SendByte((uint8_t)((a1&0xffff)>>8));       //addl 
	EEPRom_SendByte((uint8_t)(a1&0xff));              //wtt
	NotSelect_Flash();
	
	wip();
}

static void wdis(void){
	Select_Flash();
	EEPRom_SendByte(0x04);
	NotSelect_Flash();
	
	wip();
}	

static void SST25_W_BLOCK(uint32_t addr, uint8_t *readbuff, uint16_t BlockSize){
	uint16_t i=0,a2;

	EEProm_SectorErrase(addr);   								  //删除页		  
	wsr();
  wen();	
	Select_Flash();
	EEPRom_SendByte(0xad);
	EEPRom_SendByte((uint8_t)((addr&0xffffff)>>16));
	EEPRom_SendByte((uint8_t)((addr&0xffff)>>8));
	EEPRom_SendByte((uint8_t)(addr&0xff));
	EEPRom_SendByte(readbuff[0]);
	EEPRom_SendByte(readbuff[1]);
	NotSelect_Flash();
	
	i=2;
	while(i<BlockSize){
		a2=120;
		while(a2>0) a2--;
		
		Select_Flash();
		EEPRom_SendByte(0xad);
		EEPRom_SendByte(readbuff[i]); i++;
		EEPRom_SendByte(readbuff[i]); i++;
		NotSelect_Flash();
	}
	
	a2=100;
	while(a2>0) a2--;
	
	wdis();	
	Select_Flash();	
	wip();
}

static void SST25_R_BLOCK(unsigned long addr, unsigned char *readbuff, unsigned int BlockSize){
	uint16_t i=0; 	
	
	Select_Flash();
	EEPRom_SendByte(0x0b);
	EEPRom_SendByte((uint8_t)((addr&0xffffff)>>16));
	EEPRom_SendByte((uint8_t)((addr&0xffff)>>8));
	EEPRom_SendByte((uint8_t)(addr&0xff));
	EEPRom_SendByte(0);

	while(i<BlockSize){	
		HAL_SPI_Receive(&hspi1, &(readbuff[i]), 1, 300); i++;
	}
	NotSelect_Flash();	 	
}

static void test()
{
	uint8_t a=0;
	uint16_t i=0;	
/* 将测试用的数据复制到读写缓存区里 */
   for(i=0; i<TxBufferSize1;i++) SST25_buffer[i]=TxBuffer1[i];  
   //SST25_W_BLOCK(0, SST25_buffer,4096);	        //将册数数据写入到SST25VF016B的0页里
	
	 memset(SST25_buffer, 0, 4096);
   osDelay(2000);
   SST25_R_BLOCK(0, SST25_buffer,4096);	        //从SST25VF016B的0页里读出数据
   a=0;
   for(i=0; i<TxBufferSize1;i++){
  	 if(SST25_buffer[i]==TxBuffer1[i]) a=1;	    //读出的数据和测试数据进行比较， 以判别是否读写正常
	   else {a=0; i=TxBufferSize1;}
   }
   if(a==1) {
  	 tftprintf("success read");
		 tftprintf("%s", SST25_buffer);
   } else {
	   tftprintf("fail read");
	 }
}

#define SD_FILE_NAME "book1.txt"
static void EEPRomTask(void const *arg)
{
	UINT bytesread = 0;
	char rtext[10] = {0};
  tftprintf("EEPROM ID is %d", SPI_Flash_ReadID());
	
	test();
	
	if (f_open(&SDFile, SD_FILE_NAME, FA_OPEN_EXISTING | FA_READ) == FR_OK) {
	  tftprintf("Opened file %s", SD_FILE_NAME);
		if (f_read(&SDFile, rtext, sizeof(rtext), &bytesread) == FR_OK) {
		  tftprintf("Read data %s", rtext);
		} else {
		  tftprintf("Fail to read data");
		}
		f_close(&SDFile);
	} else {
	  tftprintf("Fail to open file %s", SD_FILE_NAME);
	}
	
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

void cliShowEEPROMInfo(void *arg)
{
	UNUSED(arg);
  uartprintf("EEPROM ID is %d\r\n", SPI_Flash_ReadID());
	uartprintf("\r\n");
	uartprintf("\r\n");
}
