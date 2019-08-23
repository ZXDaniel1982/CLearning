/**
  ******************************************************************************
  * File Name          : USART.c
  * Description        : This file provides code for the configuration
  *                      of the USART instances.
  ******************************************************************************
  * @attention
  *
  * <h2><center>&copy; Copyright (c) 2019 STMicroelectronics.
  * All rights reserved.</center></h2>
  *
  * This software component is licensed by ST under BSD 3-Clause license,
  * the "License"; You may not use this file except in compliance with the
  * License. You may obtain a copy of the License at:
  *                        opensource.org/licenses/BSD-3-Clause
  *
  ******************************************************************************
  */

/* Includes ------------------------------------------------------------------*/
#include "usart.h"

/* USER CODE BEGIN 0 */
#include <string.h>
#define MAX_UART_BUF_LEN 255
uint8_t UsartTxBuf[MAX_UART_BUF_LEN] = {0};
uint8_t UsartRxBuf[MAX_UART_BUF_LEN] = {0};

//pFunction JumpToApplication;
//uint32_t JumpAddress;

static uint8_t IAP_HeaderIsValid(uint8_t* Buf);
static void IAP_Init(uint8_t *Buf);
static void IAP_DeInit(uint8_t *Buf);
static void IAP_Erase(uint8_t *Buf);
static void IAP_Store(uint8_t *Buf);
static void IAP_Reboot(uint8_t* Buf);
static void IAP_Jump(uint8_t* Buf);
static void IAP_SendReply(uint8_t replyType, uint8_t replyDetail);
static void IAP_EraseProcess(uint32_t Add);
static void IAP_StoreProcess(uint8_t *dest, uint8_t *src);
static inline uint32_t IAP_CONV_TO_32(uint8_t *buf);
/* USER CODE END 0 */

UART_HandleTypeDef huart1;
DMA_HandleTypeDef hdma_usart1_rx;
DMA_HandleTypeDef hdma_usart1_tx;

/* USART1 init function */

void MX_USART1_UART_Init(void)
{

  huart1.Instance = USART1;
  huart1.Init.BaudRate = 115200;
  huart1.Init.WordLength = UART_WORDLENGTH_8B;
  huart1.Init.StopBits = UART_STOPBITS_1;
  huart1.Init.Parity = UART_PARITY_NONE;
  huart1.Init.Mode = UART_MODE_TX_RX;
  huart1.Init.HwFlowCtl = UART_HWCONTROL_NONE;
  huart1.Init.OverSampling = UART_OVERSAMPLING_16;
  if (HAL_UART_Init(&huart1) != HAL_OK)
  {
    Error_Handler();
  }
  HAL_UART_Receive_DMA(&huart1,UsartRxBuf,20);
}

void HAL_UART_MspInit(UART_HandleTypeDef* uartHandle)
{

  GPIO_InitTypeDef GPIO_InitStruct = {0};
  if(uartHandle->Instance==USART1)
  {
  /* USER CODE BEGIN USART1_MspInit 0 */

  /* USER CODE END USART1_MspInit 0 */
    /* USART1 clock enable */
    __HAL_RCC_USART1_CLK_ENABLE();
  
    __HAL_RCC_GPIOA_CLK_ENABLE();
    /**USART1 GPIO Configuration    
    PA9     ------> USART1_TX
    PA10     ------> USART1_RX 
    */
    GPIO_InitStruct.Pin = GPIO_PIN_9;
    GPIO_InitStruct.Mode = GPIO_MODE_AF_PP;
    GPIO_InitStruct.Speed = GPIO_SPEED_FREQ_HIGH;
    HAL_GPIO_Init(GPIOA, &GPIO_InitStruct);

    GPIO_InitStruct.Pin = GPIO_PIN_10;
    GPIO_InitStruct.Mode = GPIO_MODE_INPUT;
    GPIO_InitStruct.Pull = GPIO_NOPULL;
    HAL_GPIO_Init(GPIOA, &GPIO_InitStruct);

    /* USART1 DMA Init */
    /* USART1_RX Init */
    hdma_usart1_rx.Instance = DMA1_Channel5;
    hdma_usart1_rx.Init.Direction = DMA_PERIPH_TO_MEMORY;
    hdma_usart1_rx.Init.PeriphInc = DMA_PINC_DISABLE;
    hdma_usart1_rx.Init.MemInc = DMA_MINC_ENABLE;
    hdma_usart1_rx.Init.PeriphDataAlignment = DMA_PDATAALIGN_BYTE;
    hdma_usart1_rx.Init.MemDataAlignment = DMA_MDATAALIGN_BYTE;
    hdma_usart1_rx.Init.Mode = DMA_CIRCULAR;
    hdma_usart1_rx.Init.Priority = DMA_PRIORITY_LOW;
    if (HAL_DMA_Init(&hdma_usart1_rx) != HAL_OK)
    {
      Error_Handler();
    }

    __HAL_LINKDMA(uartHandle,hdmarx,hdma_usart1_rx);

    /* USART1_TX Init */
    hdma_usart1_tx.Instance = DMA1_Channel4;
    hdma_usart1_tx.Init.Direction = DMA_MEMORY_TO_PERIPH;
    hdma_usart1_tx.Init.PeriphInc = DMA_PINC_DISABLE;
    hdma_usart1_tx.Init.MemInc = DMA_MINC_ENABLE;
    hdma_usart1_tx.Init.PeriphDataAlignment = DMA_PDATAALIGN_BYTE;
    hdma_usart1_tx.Init.MemDataAlignment = DMA_MDATAALIGN_BYTE;
    hdma_usart1_tx.Init.Mode = DMA_NORMAL;
    hdma_usart1_tx.Init.Priority = DMA_PRIORITY_LOW;
    if (HAL_DMA_Init(&hdma_usart1_tx) != HAL_OK)
    {
      Error_Handler();
    }

    __HAL_LINKDMA(uartHandle,hdmatx,hdma_usart1_tx);

  /* USER CODE BEGIN USART1_MspInit 1 */

  /* USER CODE END USART1_MspInit 1 */
  }
}

void HAL_UART_MspDeInit(UART_HandleTypeDef* uartHandle)
{

  if(uartHandle->Instance==USART1)
  {
  /* USER CODE BEGIN USART1_MspDeInit 0 */

  /* USER CODE END USART1_MspDeInit 0 */
    /* Peripheral clock disable */
    __HAL_RCC_USART1_CLK_DISABLE();
  
    /**USART1 GPIO Configuration    
    PA9     ------> USART1_TX
    PA10     ------> USART1_RX 
    */
    HAL_GPIO_DeInit(GPIOA, GPIO_PIN_9|GPIO_PIN_10);

    /* USART1 DMA DeInit */
    HAL_DMA_DeInit(uartHandle->hdmarx);
    HAL_DMA_DeInit(uartHandle->hdmatx);
  /* USER CODE BEGIN USART1_MspDeInit 1 */

  /* USER CODE END USART1_MspDeInit 1 */
  }
} 

/* USER CODE BEGIN 1 */
void IAP_ProcessPack()
{
  if (IAP_HeaderIsValid(UsartRxBuf) == 0) {
    IAP_SendReply(IAP_ERROR, IAP_ERROR_HEAD_INVALID);
    return;
  }

	IAP_Init(&UsartRxBuf[2]);
	IAP_DeInit(&UsartRxBuf[2]);
  IAP_Erase(&UsartRxBuf[2]);
  IAP_Store(&UsartRxBuf[2]);
  IAP_Reboot(&UsartRxBuf[2]);
	IAP_Jump(&UsartRxBuf[2]);
}

static uint8_t IAP_HeaderIsValid(uint8_t* Buf)
{
  if (Buf == NULL) return 0;

  if ((Buf[0] != 0x22) || (Buf[1] != 0x33)) {
    return 0;
  }

  return 1;
}

static void IAP_Init(uint8_t *Buf)
{
  if (Buf == NULL) {
    IAP_SendReply(IAP_ERROR, IAP_INIT_FAIL);
    return;
  }
	
	if (Buf[0] != IAP_CMD_INIT) {
	  return;
	}
	
	HAL_FLASH_Unlock();
	IAP_SendReply(IAP_SUCCESS, IAP_INIT_SUCCESS);
}

static void IAP_DeInit(uint8_t *Buf)
{
  if (Buf == NULL) {
    IAP_SendReply(IAP_ERROR, IAP_DEINIT_FAIL);
    return;
  }
	
	if (Buf[0] != IAP_CMD_DEINIT) {
	  return;
	}
	
	HAL_FLASH_Lock();
	IAP_SendReply(IAP_SUCCESS, IAP_DEINIT_SUCCESS);
}

static void IAP_Erase(uint8_t *Buf)
{
  if (Buf == NULL) {
    IAP_SendReply(IAP_ERROR, IAP_ERASE_FAIL);
    return;
  }
	
	if (Buf[0] != IAP_CMD_ERASE) {
	  return;
	}
	
	uint32_t addr = IAP_CONV_TO_32(&Buf[1]);
  IAP_EraseProcess(addr);
}

static void IAP_Store(uint8_t *Buf)
{
  if (Buf == NULL) {
    IAP_SendReply(IAP_ERROR, IAP_STORE_FAIL);
    return;
  }
	
	if (Buf[0] != IAP_CMD_STORE) {
	  return;
	}
	
	uint8_t *src = (uint8_t *)IAP_CONV_TO_32(&Buf[1]);
  IAP_StoreProcess(src, &Buf[5]);
}

static void IAP_Reboot(uint8_t* Buf)
{
  if (Buf == NULL) {
    IAP_SendReply(IAP_ERROR, IAP_REBOOT_FAIL);
    return;
  }

  if (Buf[0] != IAP_CMD_REBOOT) {
    return;
  }

  IAP_SendReply(IAP_SUCCESS, IAP_SUCCESS_REBOOT);

	HAL_Delay(500);
	HAL_NVIC_SystemReset();
}

static void IAP_Jump(uint8_t* Buf)
{
  if (Buf == NULL) {
    IAP_SendReply(IAP_ERROR, IAP_JUMP_FAIL);
    return;
  }

  if (Buf[0] != IAP_CMD_JUMP) {
    return;
  }

  IAP_SendReply(IAP_SUCCESS, IAP_SUCCESS_JUMP);
	
	GoToApp = 1;
}

static void IAP_SendReply(uint8_t replyType, uint8_t replyDetail)
{
  memset(UsartTxBuf, 0, MAX_UART_BUF_LEN);
  UsartTxBuf[0] = 0x33;
  UsartTxBuf[1] = 0x44;
  UsartTxBuf[2] = replyType;
  UsartTxBuf[3] = replyDetail;

  HAL_UART_Transmit_DMA(&huart1,UsartTxBuf,20);
}

static void IAP_EraseProcess(uint32_t Add)
{
  /* USER CODE BEGIN 2 */
  uint32_t PageError = 0;

  /* Variable contains Flash operation status */
  HAL_StatusTypeDef status;
  FLASH_EraseInitTypeDef eraseinitstruct;

  /* Get the number of sector to erase from 1st sector */
  eraseinitstruct.TypeErase = FLASH_TYPEERASE_PAGES;
  eraseinitstruct.PageAddress = Add;
  eraseinitstruct.NbPages = 1;
  status = HAL_FLASHEx_Erase(&eraseinitstruct, &PageError);

  if (status != HAL_OK) {
    IAP_SendReply(IAP_ERROR, IAP_ERASE_FAIL);
  } else {
    IAP_SendReply(IAP_SUCCESS, IAP_SUCCESS_ERASE);
  }
  /* USER CODE END 2 */
}

static void IAP_StoreProcess(uint8_t *dest, uint8_t *src)
{
  /* USER CODE BEGIN 3 */

	/* Device voltage range supposed to be [2.7V to 3.6V], the operation will
	 * be done by byte */
	if (HAL_FLASH_Program(FLASH_TYPEPROGRAM_WORD, (uint32_t) (dest), *(uint32_t *) (src)) == HAL_OK) {
		/* Check the written value */
		if (*(uint32_t *) (src) != *(uint32_t *) (dest)) {
			/* Flash content doesn't match SRAM content */
			IAP_SendReply(IAP_ERROR, IAP_STORE_FAIL);
			return;
		}
	} else {
		/* Error occurred while writing data in Flash memory */
		IAP_SendReply(IAP_ERROR, IAP_STORE_BUSY);
		return;
	}

  IAP_SendReply(IAP_SUCCESS, IAP_SUCCESS_STORE);
  /* USER CODE END 3 */
}

static inline uint32_t IAP_CONV_TO_32(uint8_t *buf)
{
  uint32_t ret = 0;
  ret = (*buf) << 24;
  ret += *(buf+1) << 16;
  ret += *(buf+2) << 8;
  ret += *(buf+3);
  return ret;
}
/* USER CODE END 1 */

/************************ (C) COPYRIGHT STMicroelectronics *****END OF FILE****/
