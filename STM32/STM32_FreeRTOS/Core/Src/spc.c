/* Includes ------------------------------------------------------------------*/
#include "spc.h"
#include "cmsis_os.h"
#include "FreeRTOS.h"
#include "lcd.h"
#include <string.h>

/*----------------------------------------------------------------------------*/
/* Public functions                                                           */
/*----------------------------------------------------------------------------*/
void SpcMainLoop(void const * argument)
{
  /* USER CODE BEGIN StartTask02 */

  /* Infinite loop */
  for(;;)
  {
    osDelay(2000);
    tftprintf("I am running SpcMainLoop");
  }
  /* USER CODE END StartTask02 */
}
