/* Includes ------------------------------------------------------------------*/
#include "cli.h"
#include "lcd.h"
#include "FreeRTOS.h"

osThreadId CliTaskHandle;
osMessageQId CliQueueHandle;

static void CliTask(void const *arg);
/*----------------------------------------------------------------------------*/
/* Public functions                                                           */
/*----------------------------------------------------------------------------*/
void Cli_Init(void)
{
  osThreadDef(CliTaskName, CliTask, osPriorityBelowNormal, 0, 128);
  CliTaskHandle = osThreadCreate(osThread(CliTaskName), NULL);
	
	osMessageQDef(CliQueueName, 4, uint16_t);
	CliQueueHandle = osMessageCreate(osMessageQ(CliQueueName), NULL);
}

static void CliTask(void const *arg)
{
	osEvent event;
	uint16_t val;
	
	while (1) {
	  event = osMessageGet (CliQueueHandle, osWaitForever );
		if (event.status == osEventMessage) {
      val = event.value.v;
      tftprintf("Get command %x", val);
    }
	}
}
