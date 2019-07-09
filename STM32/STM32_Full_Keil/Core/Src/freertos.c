/* USER CODE BEGIN Header */
/**
  ******************************************************************************
  * File Name          : freertos.c
  * Description        : Code for freertos applications
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
#include "FreeRTOS.h"
#include "task.h"
#include "main.h"
#include "cmsis_os.h"

/* Private includes ----------------------------------------------------------*/
/* USER CODE BEGIN Includes */     
#include "lcd.h"
#include "cli.h"
#include "usart.h"
/* USER CODE END Includes */

/* Private typedef -----------------------------------------------------------*/
/* USER CODE BEGIN PTD */

/* USER CODE END PTD */

/* Private define ------------------------------------------------------------*/
/* USER CODE BEGIN PD */

/* USER CODE END PD */

/* Private macro -------------------------------------------------------------*/
/* USER CODE BEGIN PM */

/* USER CODE END PM */

/* Private variables ---------------------------------------------------------*/
/* USER CODE BEGIN Variables */

/* USER CODE END Variables */

/* Private function prototypes -----------------------------------------------*/
/* USER CODE BEGIN FunctionPrototypes */
   
/* USER CODE END FunctionPrototypes */
void MX_FREERTOS_Init(void); /* (MISRA C 2004 rule 8.1) */

/**
  * @brief  FreeRTOS initialization
  * @param  None
  * @retval None
  */
void MX_FREERTOS_Init(void) {
  /* USER CODE BEGIN Init */
       
  /* USER CODE END Init */

  /* USER CODE BEGIN RTOS_MUTEX */
  /* add mutexes, ... */
  /* USER CODE END RTOS_MUTEX */

  /* USER CODE BEGIN RTOS_SEMAPHORES */
  /* add semaphores, ... */
  /* USER CODE END RTOS_SEMAPHORES */

  /* USER CODE BEGIN RTOS_TIMERS */
  /* start timers, add new ones, ... */
  /* USER CODE END RTOS_TIMERS */

  /* USER CODE BEGIN RTOS_QUEUES */
  /* add queues, ... */
  /* USER CODE END RTOS_QUEUES */

  /* Create the thread(s) */
  /* definition and creation of defaultTask */

  /* USER CODE BEGIN RTOS_THREADS */
  /* add threads, ... */
  /* USER CODE END RTOS_THREADS */

}

/* Private application code --------------------------------------------------*/
/* USER CODE BEGIN Application */
#define tskRUNNING_CHAR		( 'X' )
#define tskBLOCKED_CHAR		( 'B' )
#define tskREADY_CHAR		( 'R' )
#define tskDELETED_CHAR		( 'D' )
#define tskSUSPENDED_CHAR	( 'S' )
void cliShowTaskInfo(void *arg)
{
  UNUSED(arg);
  
  char cStatus;
  uint16_t array;
  uint32_t TotalRunTime, ulStatsAsPercentage;
  UBaseType_t ArraySize;
  TaskStatus_t *StatusArray;
  ArraySize = uxTaskGetNumberOfTasks();
  StatusArray = pvPortMalloc(ArraySize*sizeof(TaskStatus_t));

  if( StatusArray != NULL ) {
    ArraySize = uxTaskGetSystemState((TaskStatus_t* ) StatusArray, 
                                     (UBaseType_t) ArraySize,
                                     (uint32_t*) &TotalRunTime);

    uartprintf("TotalRunTime : %ld\r\n", TotalRunTime);
    uartprintf("  %-20s%-10s%-10s%-10s%-10s%-10s%s\r\n", "TaskName", "TaskStat", "TaskPrio", "StackMin",
                "TaskNum", "TakRTim", "Avg");
    for(array=0; array<ArraySize; array++) {
      switch(StatusArray[array].eCurrentState) {
        case eRunning:    cStatus = tskRUNNING_CHAR;
          break;
        case eReady:    cStatus = tskREADY_CHAR;
          break;
        case eBlocked:    cStatus = tskBLOCKED_CHAR;
          break;
        case eSuspended:  cStatus = tskSUSPENDED_CHAR;
          break;
        case eDeleted:    cStatus = tskDELETED_CHAR;
          break;
        case eInvalid:    /* Fall through. */
        default:      /* Should not get here, but it is included
                  to prevent static checking errors. */
          cStatus = (char) 0x00;
          break;
      }
      ulStatsAsPercentage = (StatusArray[array].ulRunTimeCounter * 100) / TotalRunTime;
			
			char avgStr[10] = {0};
			if (ulStatsAsPercentage == 0) {
			  snprintf(avgStr, 10, "%s", "<1");
			} else {
			  snprintf(avgStr, 10, "%u", ulStatsAsPercentage);
			}

      uartprintf("  %-20s%-10c%-10u%-10u%-10u%-10u%s\r\n",
              StatusArray[array].pcTaskName,
              cStatus,
              (unsigned int) StatusArray[array].uxCurrentPriority,
              (unsigned int) StatusArray[array].usStackHighWaterMark,
              (unsigned int) StatusArray[array].xTaskNumber,
              (unsigned int) StatusArray[array].ulRunTimeCounter,
              avgStr);
    }

    vPortFree(StatusArray);
  } else {
    mtCOVERAGE_TEST_MARKER();
  }
}
/* USER CODE END Application */

/************************ (C) COPYRIGHT STMicroelectronics *****END OF FILE****/
