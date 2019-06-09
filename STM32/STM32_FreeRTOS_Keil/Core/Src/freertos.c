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
#include "spc.h"
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
osThreadId spcTaskHandle;

// definition of Message
osMessageQId myQueue01Handle;

// definition of Mutex
osMutexId mymutex;

// definition of timer
osTimerId sTimer;

/* Private function prototypes -----------------------------------------------*/
/* USER CODE BEGIN FunctionPrototypes */
   
/* USER CODE END FunctionPrototypes */

void StartDefaultTask(void const * argument);
void TimerCallback(void const * argument);
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
	osMutexDef(SampleMutex);
  mymutex = osMutexCreate (osMutex (SampleMutex));
  /* USER CODE END RTOS_MUTEX */

  /* USER CODE BEGIN RTOS_SEMAPHORES */
  /* add semaphores, ... */
  /* USER CODE END RTOS_SEMAPHORES */

  /* USER CODE BEGIN RTOS_TIMERS */
  /* start timers, add new ones, ... */
  /* USER CODE END RTOS_TIMERS */
	osTimerDef(myTimer, TimerCallback);
  sTimer = osTimerCreate (osTimer(myTimer), osTimerPeriodic, NULL);

  /* USER CODE BEGIN RTOS_QUEUES */
  /* add queues, ... */
  /* USER CODE END RTOS_QUEUES */
	osMessageQDef(myQueue01, 4, uint16_t);
  myQueue01Handle = osMessageCreate(osMessageQ(myQueue01), NULL);

  /* Create the thread(s) */
  /* definition and creation of defaultTask */
  osThreadDef(spcTask, SpcMainLoop, osPriorityBelowNormal, 0, 256);
  spcTaskHandle = osThreadCreate(osThread(spcTask), NULL);

  /* USER CODE BEGIN RTOS_THREADS */
  /* add threads, ... */
  /* USER CODE END RTOS_THREADS */
  //vTaskSetApplicationTaskTag(spcTaskHandle, ( void * ) '1' );
}

void TimerCallback(void const * argument)
{
  size_t used = 12;

  HAL_GPIO_TogglePin(Led_GPIO_Port, Led_Pin);
  osMessagePut (myQueue01Handle, used, 100);
}

/* Private application code --------------------------------------------------*/
/* USER CODE BEGIN Application */
void MonitorDefTask()
{
#if 0
  if( xTaskGetCurrentTaskHandle() == defaultTaskHandle )
  {
    //tftprintf("Entering StartDefaultTask");
    //osDelay(50);
  }
#endif
}

void MonitorMyTask()
{
#if 0
  if( xTaskGetCurrentTaskHandle() == spcTaskHandle )
  {
    //tftprintf("Leaving StartTask02");
    //osDelay(50);
  }
#endif
}
/* USER CODE END Application */

/************************ (C) COPYRIGHT STMicroelectronics *****END OF FILE****/
