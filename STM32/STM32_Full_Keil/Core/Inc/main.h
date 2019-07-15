/* USER CODE BEGIN Header */
/**
  ******************************************************************************
  * @file           : main.h
  * @brief          : Header for main.c file.
  *                   This file contains the common defines of the application.
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

/* Define to prevent recursive inclusion -------------------------------------*/
#ifndef __MAIN_H
#define __MAIN_H

#ifdef __cplusplus
extern "C" {
#endif

/* Includes ------------------------------------------------------------------*/
#include "stm32f1xx_hal.h"
#include "stm32f1xx_hal.h"

/* Private includes ----------------------------------------------------------*/
/* USER CODE BEGIN Includes */
#include <stdbool.h>
/* USER CODE END Includes */

/* Exported types ------------------------------------------------------------*/
/* USER CODE BEGIN ET */

/* USER CODE END ET */

/* Exported constants --------------------------------------------------------*/
/* USER CODE BEGIN EC */

/* USER CODE END EC */

/* Exported macro ------------------------------------------------------------*/
/* USER CODE BEGIN EM */

/* USER CODE END EM */

/* Exported functions prototypes ---------------------------------------------*/
void Error_Handler(void);

/* USER CODE BEGIN EFP */

/* USER CODE END EFP */

/* Private defines -----------------------------------------------------------*/
#define SST_CS_Pin GPIO_PIN_4
#define SST_CS_GPIO_Port GPIOA
#define Key_Pin GPIO_PIN_15
#define Key_GPIO_Port GPIOB
#define Key_EXTI_IRQn EXTI15_10_IRQn
#define LCD_Light_Pin GPIO_PIN_13
#define LCD_Light_GPIO_Port GPIOD
#define Led_Pin GPIO_PIN_5
#define Led_GPIO_Port GPIOB
#define LCD_Rst_Pin GPIO_PIN_1
#define LCD_Rst_GPIO_Port GPIOE
/* USER CODE BEGIN Private defines */
#define NUM_ROWS(ARRAY) (sizeof(ARRAY) / sizeof(ARRAY[0]))

#define SPC_SCREEN_POSITION    ( 4 )
#define SPC_SCREEN_SCALE       ( 2 )

typedef enum
{
    SPC_NORMAL = true,
    SPC_ERROR = false
} SpcStatus_t;

typedef enum
{
    SPC_ALARM_SELFCHKFAIL = 0,
    SPC_MAX_ALARM_TYPE
} SpcAlarmType_t;

typedef void (*pfnDelete)(SpcAlarmType_t alarmType);
typedef void (*pfnAdd)(SpcAlarmType_t alarmType);
struct xSpcItem_t
{
    SpcAlarmType_t alarmType;
    bool alarmPrio;
    pfnDelete delfunc;
    pfnAdd addfunc;
    struct xSpcItem_t *next;
};
typedef struct xSpcItem_t SpcItem_t;

typedef struct
{
    uint8_t totalNum;
    uint8_t maxSize;
    SpcItem_t item;
} SpcList_t;

typedef struct
{
    uint32_t alarmMask;
    SpcList_t alarmList;
} SpcAlarm_t;

typedef struct
{
    SpcAlarmType_t type;
    bool prio;
} SpcAlarmTable_t;

#define SpcAlarmEn        ( SPC_NORMAL )
#define SpcAlarmDis       ( SPC_ERROR )
#define SpcAlarmCritical  ( SPC_NORMAL )
#define SpcAlarmNormal    ( SPC_ERROR )

extern volatile uint32_t spctick;

SpcStatus_t SpcListInsert(SpcList_t * list, SpcItem_t *itemToAdd);
SpcStatus_t SpcListRemove(SpcList_t * list, SpcAlarmType_t alarmType);
void Spc_AlarmMgr(SpcList_t * list, SpcAlarmType_t type, bool enable);
/* USER CODE END Private defines */

#ifdef __cplusplus
}
#endif

#endif /* __MAIN_H */

/************************ (C) COPYRIGHT STMicroelectronics *****END OF FILE****/
