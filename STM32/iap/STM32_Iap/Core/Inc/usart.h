/**
  ******************************************************************************
  * File Name          : USART.h
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
/* Define to prevent recursive inclusion -------------------------------------*/
#ifndef __usart_H
#define __usart_H
#ifdef __cplusplus
 extern "C" {
#endif

/* Includes ------------------------------------------------------------------*/
#include "main.h"

/* USER CODE BEGIN Includes */
#define MAX_UART_BUF_LEN 255
/* USER CODE END Includes */

extern UART_HandleTypeDef huart1;

/* USER CODE BEGIN Private defines */
typedef enum
{
  IAP_ERROR = 0,
  IAP_SUCCESS,

  IAP_ERROR_HEAD_INVALID,
	
	IAP_INIT_FAIL,
	IAP_CMD_INIT,
	IAP_INIT_SUCCESS,
	
	IAP_DEINIT_FAIL,
	IAP_CMD_DEINIT,
	IAP_DEINIT_SUCCESS,

  IAP_ERASE_FAIL,
  IAP_CMD_ERASE,
  IAP_SUCCESS_ERASE,

  IAP_STORE_FAIL,
  IAP_STORE_BUSY,
  IAP_SUCCESS_STORE,
  IAP_CMD_STORE,

  IAP_REBOOT_FAIL,
  IAP_SUCCESS_REBOOT,
  IAP_CMD_REBOOT,
	
	IAP_JUMP_FAIL,
  IAP_SUCCESS_JUMP,
  IAP_CMD_JUMP,

  IAP_MAX_COMMAND = 100,
} IAP_COMMANDS;
/* USER CODE END Private defines */

void MX_USART1_UART_Init(void);

/* USER CODE BEGIN Prototypes */
void IAP_ProcessPack(void);
/* USER CODE END Prototypes */

#ifdef __cplusplus
}
#endif
#endif /*__ usart_H */

/**
  * @}
  */

/**
  * @}
  */

/************************ (C) COPYRIGHT STMicroelectronics *****END OF FILE****/
