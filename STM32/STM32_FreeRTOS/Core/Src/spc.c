#include "spc.h"
#include "cmsis_os.h"
#include "FreeRTOS.h"

#include "lcd.h"
#include <string.h>

void MyTask(void const * argument)
{
  /* USER CODE BEGIN StartTask02 */

  /* Infinite loop */
  for(;;)
  {
    osDelay(2000);

    tftprintf("I am running MyTask");
  }
  /* USER CODE END StartTask02 */
}
