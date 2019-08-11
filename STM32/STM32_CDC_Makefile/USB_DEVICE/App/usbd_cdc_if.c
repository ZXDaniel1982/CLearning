/* USER CODE BEGIN Header */
/**
  ******************************************************************************
  * @file           : usbd_cdc_if.c
  * @version        : v2.0_Cube
  * @brief          : Usb device for Virtual Com Port.
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
/* USER CODE END Header */

/* Includes ------------------------------------------------------------------*/
#include "usbd_cdc_if.h"

/* USER CODE BEGIN INCLUDE */
#include "eeprom.h"
/* USER CODE END INCLUDE */

/* Private typedef -----------------------------------------------------------*/
/* Private define ------------------------------------------------------------*/
/* Private macro -------------------------------------------------------------*/

/* USER CODE BEGIN PV */
/* Private variables ---------------------------------------------------------*/

/* USER CODE END PV */

/** @addtogroup STM32_USB_OTG_DEVICE_LIBRARY
  * @brief Usb device library.
  * @{
  */

/** @addtogroup USBD_CDC_IF
  * @{
  */

/** @defgroup USBD_CDC_IF_Private_TypesDefinitions USBD_CDC_IF_Private_TypesDefinitions
  * @brief Private types.
  * @{
  */

/* USER CODE BEGIN PRIVATE_TYPES */

/* USER CODE END PRIVATE_TYPES */

/**
  * @}
  */

/** @defgroup USBD_CDC_IF_Private_Defines USBD_CDC_IF_Private_Defines
  * @brief Private defines.
  * @{
  */

/* USER CODE BEGIN PRIVATE_DEFINES */
/* Define size for the receive and transmit buffer over CDC */
/* It's up to user to redefine and/or remove those define */
#define APP_RX_DATA_SIZE  1000
#define APP_TX_DATA_SIZE  1000
/* USER CODE END PRIVATE_DEFINES */

/**
  * @}
  */

/** @defgroup USBD_CDC_IF_Private_Macros USBD_CDC_IF_Private_Macros
  * @brief Private macros.
  * @{
  */

/* USER CODE BEGIN PRIVATE_MACRO */

/* USER CODE END PRIVATE_MACRO */

/**
  * @}
  */

/** @defgroup USBD_CDC_IF_Private_Variables USBD_CDC_IF_Private_Variables
  * @brief Private variables.
  * @{
  */
/* Create buffer for reception and transmission           */
/* It's up to user to redefine and/or remove those define */
/** Received data over USB are stored in this buffer      */
uint8_t UserRxBufferFS[APP_RX_DATA_SIZE];

/** Data to send over USB CDC are stored in this buffer   */
uint8_t UserTxBufferFS[APP_TX_DATA_SIZE];

/* USER CODE BEGIN PRIVATE_VARIABLES */

/* USER CODE END PRIVATE_VARIABLES */

/**
  * @}
  */

/** @defgroup USBD_CDC_IF_Exported_Variables USBD_CDC_IF_Exported_Variables
  * @brief Public variables.
  * @{
  */

extern USBD_HandleTypeDef hUsbDeviceFS;

/* USER CODE BEGIN EXPORTED_VARIABLES */

/* USER CODE END EXPORTED_VARIABLES */

/**
  * @}
  */

/** @defgroup USBD_CDC_IF_Private_FunctionPrototypes USBD_CDC_IF_Private_FunctionPrototypes
  * @brief Private functions declaration.
  * @{
  */

static int8_t CDC_Init_FS(void);
static int8_t CDC_DeInit_FS(void);
static int8_t CDC_Control_FS(uint8_t cmd, uint8_t* pbuf, uint16_t length);
static int8_t CDC_Receive_FS(uint8_t* pbuf, uint32_t *Len);

/* USER CODE BEGIN PRIVATE_FUNCTIONS_DECLARATION */
static void ProcessRxData(uint8_t* Buf, uint32_t *Len);
static uint8_t CDC_HeaderIsValid(uint8_t* Buf);
static uint8_t CDC_LenIsValid(uint8_t* Buf, uint32_t *Len);
static void CDC_CacheData(uint8_t* Buf, uint32_t *Len);
static void CDC_StoreData(uint8_t* Buf, uint32_t *Len);
static void CDC_GetData(uint8_t* Buf, uint32_t *Len);
static void CDC_GetInfo(uint8_t* Buf, uint32_t *Len);
static void CDC_SetInfo(uint8_t* Buf, uint32_t *Len);
static void CDC_SendReplyData();
static void CDC_SendReply(uint8_t replyType, uint8_t replyDetail);
/* USER CODE END PRIVATE_FUNCTIONS_DECLARATION */

/**
  * @}
  */

USBD_CDC_ItfTypeDef USBD_Interface_fops_FS =
{
  CDC_Init_FS,
  CDC_DeInit_FS,
  CDC_Control_FS,
  CDC_Receive_FS
};

/* Private functions ---------------------------------------------------------*/
/**
  * @brief  Initializes the CDC media low layer over the FS USB IP
  * @retval USBD_OK if all operations are OK else USBD_FAIL
  */
static int8_t CDC_Init_FS(void)
{
  /* USER CODE BEGIN 3 */
  /* Set Application Buffers */
  USBD_CDC_SetTxBuffer(&hUsbDeviceFS, UserTxBufferFS, 0);
  USBD_CDC_SetRxBuffer(&hUsbDeviceFS, UserRxBufferFS);
  return (USBD_OK);
  /* USER CODE END 3 */
}

/**
  * @brief  DeInitializes the CDC media low layer
  * @retval USBD_OK if all operations are OK else USBD_FAIL
  */
static int8_t CDC_DeInit_FS(void)
{
  /* USER CODE BEGIN 4 */
  return (USBD_OK);
  /* USER CODE END 4 */
}

/**
  * @brief  Manage the CDC class requests
  * @param  cmd: Command code
  * @param  pbuf: Buffer containing command data (request parameters)
  * @param  length: Number of data to be sent (in bytes)
  * @retval Result of the operation: USBD_OK if all operations are OK else USBD_FAIL
  */
static int8_t CDC_Control_FS(uint8_t cmd, uint8_t* pbuf, uint16_t length)
{
  /* USER CODE BEGIN 5 */
  switch(cmd)
  {
    case CDC_SEND_ENCAPSULATED_COMMAND:

    break;

    case CDC_GET_ENCAPSULATED_RESPONSE:

    break;

    case CDC_SET_COMM_FEATURE:

    break;

    case CDC_GET_COMM_FEATURE:

    break;

    case CDC_CLEAR_COMM_FEATURE:

    break;

  /*******************************************************************************/
  /* Line Coding Structure                                                       */
  /*-----------------------------------------------------------------------------*/
  /* Offset | Field       | Size | Value  | Description                          */
  /* 0      | dwDTERate   |   4  | Number |Data terminal rate, in bits per second*/
  /* 4      | bCharFormat |   1  | Number | Stop bits                            */
  /*                                        0 - 1 Stop bit                       */
  /*                                        1 - 1.5 Stop bits                    */
  /*                                        2 - 2 Stop bits                      */
  /* 5      | bParityType |  1   | Number | Parity                               */
  /*                                        0 - None                             */
  /*                                        1 - Odd                              */
  /*                                        2 - Even                             */
  /*                                        3 - Mark                             */
  /*                                        4 - Space                            */
  /* 6      | bDataBits  |   1   | Number Data bits (5, 6, 7, 8 or 16).          */
  /*******************************************************************************/
    case CDC_SET_LINE_CODING:

    break;

    case CDC_GET_LINE_CODING:

    break;

    case CDC_SET_CONTROL_LINE_STATE:

    break;

    case CDC_SEND_BREAK:

    break;

  default:
    break;
  }

  return (USBD_OK);
  /* USER CODE END 5 */
}

/**
  * @brief  Data received over USB OUT endpoint are sent over CDC interface
  *         through this function.
  *
  *         @note
  *         This function will block any OUT packet reception on USB endpoint
  *         untill exiting this function. If you exit this function before transfer
  *         is complete on CDC interface (ie. using DMA controller) it will result
  *         in receiving more data while previous ones are still not sent.
  *
  * @param  Buf: Buffer of data to be received
  * @param  Len: Number of data received (in bytes)
  * @retval Result of the operation: USBD_OK if all operations are OK else USBD_FAIL
  */
static int8_t CDC_Receive_FS(uint8_t* Buf, uint32_t *Len)
{
  /* USER CODE BEGIN 6 */
  ProcessRxData(Buf, Len);
  USBD_CDC_SetRxBuffer(&hUsbDeviceFS, &Buf[0]);
  USBD_CDC_ReceivePacket(&hUsbDeviceFS);
  return (USBD_OK);
  /* USER CODE END 6 */
}

/**
  * @brief  CDC_Transmit_FS
  *         Data to send over USB IN endpoint are sent over CDC interface
  *         through this function.
  *         @note
  *
  *
  * @param  Buf: Buffer of data to be sent
  * @param  Len: Number of data to be sent (in bytes)
  * @retval USBD_OK if all operations are OK else USBD_FAIL or USBD_BUSY
  */
uint8_t CDC_Transmit_FS(uint8_t* Buf, uint16_t Len)
{
  uint8_t result = USBD_OK;
  /* USER CODE BEGIN 7 */
  USBD_CDC_HandleTypeDef *hcdc = (USBD_CDC_HandleTypeDef*)hUsbDeviceFS.pClassData;
  if (hcdc->TxState != 0){
    return USBD_BUSY;
  }
  USBD_CDC_SetTxBuffer(&hUsbDeviceFS, Buf, Len);
  result = USBD_CDC_TransmitPacket(&hUsbDeviceFS);
  /* USER CODE END 7 */
  return result;
}

/* USER CODE BEGIN PRIVATE_FUNCTIONS_IMPLEMENTATION */
static void ProcessRxData(uint8_t* Buf, uint32_t *Len)
{
  if (CDC_HeaderIsValid(Buf) == 0) {
    CDC_SendReply(CDC_ERROR, CDC_ERROR_HEAD_INVALID);
    return;
  }

  if (CDC_LenIsValid(Buf, Len) == 0) {
    CDC_SendReply(CDC_ERROR, CDC_ERROR_LEN_INVALID);
    return;
  }

  CDC_CacheData(Buf, Len);
  CDC_StoreData(Buf, Len);
  CDC_GetInfo(Buf, Len);
  CDC_SetInfo(Buf, Len);
  CDC_GetData(Buf, Len);
}

static uint8_t CDC_HeaderIsValid(uint8_t* Buf)
{
  if (Buf == NULL) return 0;

  if ((Buf[0] != 0x22) || (Buf[1] != 0x33)) {
    return 0;
  }

  return 1;
}

static uint8_t CDC_LenIsValid(uint8_t* Buf, uint32_t *Len)
{
  if ((Buf == NULL) || (Len == NULL)) return 0;

  uint16_t length = (uint16_t)Buf[2] * 256 + Buf[3];
  if (length != (*Len)) {
    return 0;
  }

  return 1;
}

static void CDC_CacheData(uint8_t* Buf, uint32_t *Len)
{
  if ((Buf == NULL) || (Len == NULL)) {
    CDC_SendReply(CDC_ERROR, CDC_ERROR_CACHE_FAIL);
    return;
  }

  if (Buf[4] != CDC_CMD_CACHE) {
    CDC_SendReply(CDC_ERROR, CDC_ERROR_CACHE_FAIL);
    return;
  }

  if ((*Len) != CDC_LEN_CACHE) {
    CDC_SendReply(CDC_ERROR, CDC_ERROR_CACHE_FAIL);
    return;
  }

  uint16_t index = (uint16_t)Buf[5] * 512;
  memcpy(&SST25_buffer[index], &Buf[6], 512);

  CDC_SendReply(CDC_SUCCESS, CDC_SUCCESS_CACHE);
}

static void CDC_StoreData(uint8_t* Buf, uint32_t *Len)
{
  if ((Buf == NULL) || (Len == NULL)) {
    CDC_SendReply(CDC_ERROR, CDC_ERROR_STORE_FAIL);
    return;
  }

  if (Buf[4] != CDC_CMD_STORE) {
    CDC_SendReply(CDC_ERROR, CDC_ERROR_STORE_FAIL);
    return;
  }

  if ((*Len) != CDC_LEN_STORE) {
    CDC_SendReply(CDC_ERROR, CDC_ERROR_STORE_FAIL);
    return;
  }

  uint16_t page = Buf[5] * 256 + Buf[6];
  SST25_W_BLOCK(page, SST25_buffer,4096);

  CDC_SendReply(CDC_SUCCESS, CDC_SUCCESS_STORE);
}

static void CDC_GetData(uint8_t* Buf, uint32_t *Len)
{
  if ((Buf == NULL) || (Len == NULL)) {
    CDC_SendReply(CDC_ERROR, CDC_ERROR_GET_DATA_FAIL);
    return;
  }

  if (Buf[4] != CDC_CMD_GET_DATA) {
    CDC_SendReply(CDC_ERROR, CDC_ERROR_GET_DATA_FAIL);
    return;
  }

  if ((*Len) != CDC_LEN_GET_DATA) {
    CDC_SendReply(CDC_ERROR, CDC_ERROR_GET_DATA_FAIL);
    return;
  }

  uint16_t page = Buf[5] * 256 + Buf[6];
  SST25_R_BLOCK(page, SST25_buffer,4096);

  uint8_t i;
  memset(UserTxBufferFS, 0, APP_TX_DATA_SIZE);
  UserTxBufferFS[0] = 0x33;
  UserTxBufferFS[1] = 0x44;
  UserTxBufferFS[2] = CDC_SUCCESS;
  UserTxBufferFS[3] = CDC_SUCCESS_GET_DATA;

  uint16_t len = 6 + 512;
  UserTxBufferFS[4] = (uint8_t)((len >> 8) & 0x00ff);
  UserTxBufferFS[5] = (uint8_t)(len & 0x00ff);

  uint16_t index = 0;
  for (i=0; i<8; i++) {
    index = i*512;
    memcpy(&UserTxBufferFS[6], &SST25_buffer[index], 512);
    CDC_Transmit_FS(UserTxBufferFS, len);

    HAL_Delay(100);
  }
}

static void CDC_GetInfo(uint8_t* Buf, uint32_t *Len)
{
  if ((Buf == NULL) || (Len == NULL)) {
    CDC_SendReply(CDC_ERROR, CDC_ERROR_GET_INFO_FAIL);
    return;
  }

  if (Buf[4] != CDC_CMD_GET_INFO) {
    CDC_SendReply(CDC_ERROR, CDC_ERROR_GET_INFO_FAIL);
    return;
  }

  if ((*Len) != CDC_LEN_GET_INFO) {
    CDC_SendReply(CDC_ERROR, CDC_ERROR_GET_INFO_FAIL);
    return;
  }

  CDC_SendReplyData();
}

static void CDC_SetInfo(uint8_t* Buf, uint32_t *Len)
{
  if ((Buf == NULL) || (Len == NULL)) {
    CDC_SendReply(CDC_ERROR, CDC_ERROR_SET_INFO_FAIL);
    return;
  }

  if (Buf[4] != CDC_CMD_SET_INFO) {
    CDC_SendReply(CDC_ERROR, CDC_ERROR_SET_INFO_FAIL);
    return;
  }

  if ((*Len) != CDC_LEN_SET_INFO) {
    CDC_SendReply(CDC_ERROR, CDC_ERROR_SET_INFO_FAIL);
    return;
  }

  memcpy(SST25_buffer, &Buf[5], sizeof(eepInfo_t));
  SST25_W_BLOCK(1, SST25_buffer,4096);
  CDC_SendReply(CDC_SUCCESS, CDC_SUCCESS_SET_INFO);
}

static void CDC_SendReplyData()
{
  memset(UserTxBufferFS, 0, APP_TX_DATA_SIZE);
  UserTxBufferFS[0] = 0x33;
  UserTxBufferFS[1] = 0x44;
  UserTxBufferFS[2] = CDC_SUCCESS;
  UserTxBufferFS[3] = CDC_SUCCESS_GET_INFO;

  uint16_t len = 6 + sizeof(eepInfo_t);
  UserTxBufferFS[4] = (uint8_t)((len >> 8) & 0x00ff);
  UserTxBufferFS[5] = (uint8_t)(len & 0x00ff);
  memcpy(&UserTxBufferFS[6], &eepInfo, sizeof(eepInfo_t));
  CDC_Transmit_FS(UserTxBufferFS, len);
}

static void CDC_SendReply(uint8_t replyType, uint8_t replyDetail)
{
  memset(UserTxBufferFS, 0, APP_TX_DATA_SIZE);
  UserTxBufferFS[0] = 0x33;
  UserTxBufferFS[1] = 0x44;
  UserTxBufferFS[2] = replyType;
  UserTxBufferFS[3] = replyDetail;

  uint16_t len = 6;
  UserTxBufferFS[4] = (uint8_t)((len >> 8) & 0x00ff);
  UserTxBufferFS[5] = (uint8_t)(len & 0x00ff);
  CDC_Transmit_FS(UserTxBufferFS, len);
}
/* USER CODE END PRIVATE_FUNCTIONS_IMPLEMENTATION */

/**
  * @}
  */

/**
  * @}
  */

/************************ (C) COPYRIGHT STMicroelectronics *****END OF FILE****/
