/**
  ******************************************************************************
  * @file           : main.c
  * @brief          : Main program body
  ******************************************************************************
  */
	
/* Includes ------------------------------------------------------------------*/
#include <string.h>
#include "gpio.h"
#include "usart.h"
#include "iap.h"

#include "stm32f1xx_hal.h"

FLASH_EraseInitTypeDef f;

static uint8_t command[IAP_MAX_COMMAND_NUM][2] = {
  {0x21, 0x31},
	{0x22, 0x32}
};
	
/**
  * @brief  The application entry point.
  *
  * @retval None
  */
void IAP_Init()
{
  MX_Led_Init();
	MX_Uart_Transmit((uint8_t*)IAP_INIT_MSG, strlen(IAP_INIT_MSG)+1, IAP_TIMEOUT);
}

void IAP_Flash()
{
	uint32_t writeFlashData = 0x55555555;
  uint32_t addr = 0x08007000;
	
  HAL_FLASH_Unlock();
	
	f.TypeErase = FLASH_TYPEERASE_PAGES;
  f.PageAddress = IAP_FLASH_PRG_ADDR;
  f.NbPages = 1;
	
	uint32_t PageError = 0;
	HAL_FLASHEx_Erase(&f, &PageError);
	
	HAL_FLASH_Program(FLASH_TYPEPROGRAM_WORD, addr, writeFlashData);
	
	uint32_t temp = *(__IO uint32_t*)(addr);
	uint8_t msg[100] = {0};
	snprintf((char *)msg, 100, "addr:0x%x, data:0x%x\r\n", addr, temp);
	MX_Uart_Transmit(msg, strlen((char *)msg)+1, IAP_TIMEOUT);

	
	f.TypeErase = FLASH_TYPEERASE_PAGES;
  f.PageAddress = IAP_FLASH_PRG_ADDR;
  f.NbPages = 1;
	
	PageError = 0;
	HAL_FLASHEx_Erase(&f, &PageError);
	
	writeFlashData = 0xaaaaaaaa;
	HAL_FLASH_Program(FLASH_TYPEPROGRAM_WORD, addr, writeFlashData);
	
	temp = *(__IO uint32_t*)(addr);
	memset(msg, 0, 100);
	snprintf((char *)msg, 100, "addr:0x%x, data:0x%x\r\n", addr, temp);
	MX_Uart_Transmit(msg, strlen((char *)msg)+1, IAP_TIMEOUT);
}

void IAP_Process()
{
	uint32_t preProgFlag = 0;
	
	MX_Led_On();
	HAL_FLASH_Unlock();
  if (MX_Key_Read() != GPIO_PIN_SET) {
		// Key is not pushed down
		preProgFlag = *(__IO uint32_t*)IAP_FLASH_FLG_ADDR;
	  if (preProgFlag == IAP_FLASH_FLG_DATA) {
		  // Existing previous programming, Do jumping
		} else {
		  // No previous programming, Do programming
		}
	}
	
	// Key is pushed down, Do programming
	uint16_t commandSeq = 0;
	MX_Uart_Transmit(command[commandSeq], 2, IAP_TIMEOUT);  // send 0x21, 0x31
	commandSeq++;
	
	HAL_Delay(500);
	uint8_t recBuf[2] = {0};
	MX_Uart_Receive(recBuf, 2, IAP_TIMEOUT);
	if ((recBuf[0] != 0x22) || (recBuf[1] != 0x32)) {       // rev 0x22, 0x32
	  return;
	}
	
	HAL_Delay(500);
	MX_Uart_Transmit(command[commandSeq], 2, IAP_TIMEOUT);   // send 0x22, 0x32
	
	HAL_Delay(500);
	MX_Uart_Receive(recBuf, 2, IAP_TIMEOUT);                  // rev 0x23, 0x33
	if ((recBuf[0] != 0x23) || (recBuf[1] != 0x33)) {
	  return;
	}
	
	HAL_Delay(500);
	MX_Uart_Receive(recBuf, 2, IAP_TIMEOUT);                   // rev  block number
	uint16_t blockTotal = (recBuf[1] << 16) | recBuf[0];
	
	HAL_Delay(500);
	uint16_t block = 0;
	if (blockTotal > 0) {
	  while (block < blockTotal) {
		  MX_Uart_Receive(recBuf, 2, IAP_TIMEOUT);
		}
	}
	
	HAL_Delay(500);
	uint16_t i;
	for (i=0; i<dataLen; i++) {
	  MX_Uart_Receive(recBuf, 2, IAP_TIMEOUT);
	}
}
