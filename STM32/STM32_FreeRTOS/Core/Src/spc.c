/* Includes ------------------------------------------------------------------*/
#include "spc.h"
#include "FreeRTOS.h"
#include "lcd.h"
#include <string.h>

/*----------------------------------------------------------------------------*/
/* Public functions                                                           */
/*----------------------------------------------------------------------------*/
void SpcMainLoop(void const * argument)
{
  /* USER CODE BEGIN SpcMainLoop */
  osEvent event;
  size_t used = 0;

  osTimerStart(sTimer, 1000);

  tftprintf("I am running SpcMainLoop used %d", used);

  /* Infinite loop */
  for(;;)
  {

    event = osMessageGet (myQueue01Handle, 0xffffffff);
    if (event.status == osEventMessage) {
      used = event.value.v;
      tftprintf("I am running SpcMainLoop used %d", used);
    }
  }
  /* USER CODE END SpcMainLoop */
}
