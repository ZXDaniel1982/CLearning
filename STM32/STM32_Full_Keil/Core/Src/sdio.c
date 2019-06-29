/**
  ******************************************************************************
  * File Name          : SDIO.c
  * Description        : This file provides code for the configuration
  *                      of the SDIO instances.
  ******************************************************************************
  * @attention
  *
  * <h2><center>&copy; Copyright (c) 2019 STMicroelectronics.
  * All rights reserved.</center></h2>
  *
  * This software component is licensed by ST under Ultimate Liberty license
  * SLA0044, the "License"; You may not use this file except in compliance with
  * the License. You may obtain a copy of the License at:
  *                             www.st.com/SLA0044
  *
  ******************************************************************************
  */

/* Includes ------------------------------------------------------------------*/
#include "sdio.h"

/* USER CODE BEGIN 0 */
#include "fatfs.h"
#include "lcd.h"
#include "usart.h"
/* USER CODE END 0 */

SD_HandleTypeDef hsd;

/* SDIO init function */

void MX_SDIO_SD_Init(void)
{

  hsd.Instance = SDIO;
  hsd.Init.ClockEdge = SDIO_CLOCK_EDGE_RISING;
  hsd.Init.ClockBypass = SDIO_CLOCK_BYPASS_DISABLE;
  hsd.Init.ClockPowerSave = SDIO_CLOCK_POWER_SAVE_DISABLE;
  hsd.Init.BusWide = SDIO_BUS_WIDE_1B;
  hsd.Init.HardwareFlowControl = SDIO_HARDWARE_FLOW_CONTROL_DISABLE;
  hsd.Init.ClockDiv = 4;
	
  if (HAL_SD_Init(&hsd) != HAL_OK)
  {
    Error_Handler();
  }
  if (HAL_SD_ConfigWideBusOperation(&hsd, SDIO_BUS_WIDE_4B) != HAL_OK)
  {
    Error_Handler();
  }
}

void HAL_SD_MspInit(SD_HandleTypeDef* sdHandle)
{

  GPIO_InitTypeDef GPIO_InitStruct = {0};
  if(sdHandle->Instance==SDIO)
  {
  /* USER CODE BEGIN SDIO_MspInit 0 */

  /* USER CODE END SDIO_MspInit 0 */
    /* SDIO clock enable */
    __HAL_RCC_SDIO_CLK_ENABLE();
  
    __HAL_RCC_GPIOC_CLK_ENABLE();
    __HAL_RCC_GPIOD_CLK_ENABLE();
    /**SDIO GPIO Configuration    
    PC8     ------> SDIO_D0
    PC9     ------> SDIO_D1
    PC10     ------> SDIO_D2
    PC11     ------> SDIO_D3
    PC12     ------> SDIO_CK
    PD2     ------> SDIO_CMD 
    */
    GPIO_InitStruct.Pin = GPIO_PIN_8|GPIO_PIN_9|GPIO_PIN_10|GPIO_PIN_11 
                          |GPIO_PIN_12;
    GPIO_InitStruct.Mode = GPIO_MODE_AF_PP;
    GPIO_InitStruct.Speed = GPIO_SPEED_FREQ_HIGH;
    HAL_GPIO_Init(GPIOC, &GPIO_InitStruct);

    GPIO_InitStruct.Pin = GPIO_PIN_2;
    GPIO_InitStruct.Mode = GPIO_MODE_AF_PP;
    GPIO_InitStruct.Speed = GPIO_SPEED_FREQ_HIGH;
    HAL_GPIO_Init(GPIOD, &GPIO_InitStruct);

  /* USER CODE BEGIN SDIO_MspInit 1 */

  /* USER CODE END SDIO_MspInit 1 */
  }
}

void HAL_SD_MspDeInit(SD_HandleTypeDef* sdHandle)
{

  if(sdHandle->Instance==SDIO)
  {
  /* USER CODE BEGIN SDIO_MspDeInit 0 */

  /* USER CODE END SDIO_MspDeInit 0 */
    /* Peripheral clock disable */
    __HAL_RCC_SDIO_CLK_DISABLE();
  
    /**SDIO GPIO Configuration    
    PC8     ------> SDIO_D0
    PC9     ------> SDIO_D1
    PC10     ------> SDIO_D2
    PC11     ------> SDIO_D3
    PC12     ------> SDIO_CK
    PD2     ------> SDIO_CMD 
    */
    HAL_GPIO_DeInit(GPIOC, GPIO_PIN_8|GPIO_PIN_9|GPIO_PIN_10|GPIO_PIN_11 
                          |GPIO_PIN_12);

    HAL_GPIO_DeInit(GPIOD, GPIO_PIN_2);

  /* USER CODE BEGIN SDIO_MspDeInit 1 */

  /* USER CODE END SDIO_MspDeInit 1 */
  }
} 

/* USER CODE BEGIN 1 */
void SD_ShowCardInfo()
{
	HAL_SD_CardStateTypeDef State = HAL_SD_GetCardState(&hsd);
	if (State == HAL_SD_CARD_TRANSFER) {
	  HAL_SD_CardCIDTypeDef CardCID;
		
		HAL_SD_GetCardCID(&hsd, &CardCID);
		tftprintf("Initial SD card success.");
		tftprintf("Car block size %d", hsd.SdCard.BlockSize);
		tftprintf("Car block number %d", hsd.SdCard.BlockNbr);
		tftprintf("Car capacity %ld", ((uint32_t)hsd.SdCard.BlockSize*hsd.SdCard.BlockNbr));
//		tftprintf("Car type %d", hsd.SdCard.CardType);
//		tftprintf("Car version %d", hsd.SdCard.CardVersion);
//		tftprintf("Car manufacture ID %d", CardCID.ManufacturerID);
//		tftprintf("Car manufacture date %d", CardCID.ManufactDate);
	} else {
	  tftprintf("Initial SD card fail.");
	}
}

/* USER CODE BEGIN 1 */
void cliShowSdInfo(void *arg)
{
	UNUSED(arg);
	HAL_SD_CardStateTypeDef State = HAL_SD_GetCardState(&hsd);
	if (State == HAL_SD_CARD_TRANSFER) {
	  HAL_SD_CardCIDTypeDef CardCID;
		
		HAL_SD_GetCardCID(&hsd, &CardCID);
		uartprintf("Car block size %d\r\n", hsd.SdCard.BlockSize);
		uartprintf("Car block number %d\r\n", hsd.SdCard.BlockNbr);
		uartprintf("Car capacity %ld\r\n", ((uint32_t)hsd.SdCard.BlockSize*hsd.SdCard.BlockNbr));
		uartprintf("Car type %d\r\n", hsd.SdCard.CardType);
		uartprintf("Car version %d\r\n", hsd.SdCard.CardVersion);
		uartprintf("Car manufacture ID %d\r\n", CardCID.ManufacturerID);
		uartprintf("Car manufacture date %d\r\n", CardCID.ManufactDate);
	} else {
	  uartprintf("Get SD card info fail.\r\n");
	}
}

void cliShowSdFileInfo(void *arg)
{
	UNUSED(arg);
	
	DIR dir;
	FILINFO finfo;
	HAL_SD_CardStateTypeDef State = HAL_SD_GetCardState(&hsd);
	if (State == HAL_SD_CARD_TRANSFER) {
	  if (f_opendir (&dir, "") == FR_OK) {
			uartprintf("   %-20s     %-10s    %s\r\n",
			    F_NAME, F_SIZE, F_DATE);
		  while (f_readdir(&dir, &finfo) == FR_OK) {
			  if(!finfo.fname[0])	 break;
				uartprintf("   %-20s     %-10d    %u-%02u-%02u, %02u:%02u\r\n",
				    finfo.fname, finfo.fsize, (finfo.fdate >> 9) + 1980, finfo.fdate >> 5 & 15, finfo.fdate & 31,
               finfo.ftime >> 11, finfo.ftime >> 5 & 63);
			}
		}
	} else {
	  uartprintf("Get SD card info fail.\r\n");
	}
}
/* USER CODE END 1 */

/************************ (C) COPYRIGHT STMicroelectronics *****END OF FILE****/
