/* Includes ------------------------------------------------------------------*/
#include "spc.h"
#include "FreeRTOS.h"
#include "lcd.h"
#include <string.h>
#include <stdlib.h>
#include <stdbool.h>

osThreadId SpcTaskHandle;
static void SpcTask(void const *arg);
/*----------------------------------------------------------------------------*/
/* Private functions                                                           */
/*----------------------------------------------------------------------------*/

/* SPC related functions */
static void Spc_ScreenUpdate(SpcInfoType_t type) {
    resetScreen();
    tftprintf(SpcScreenInfo[type].stringLine1);
    tftprintf(SpcScreenInfo[type].stringLine2);
}

static void Spc_StartupLog()
{
    int i;
 
    resetScreen();
    for (i = 0; i < NUM_ROWS(spcStartupLogOn); i++) {
        tftprintf("%s", spcStartupLogOn[i]);
    }

    osDelay(2000);
    resetScreen();
    for (i = 0; i < NUM_ROWS(spcStartupLogOff); i++) {
        tftprintf("%s", spcStartupLogOff[i]);
    }

    osDelay(2000);
    Spc_ScreenUpdate(SPC_SOFTWARE_VERSION);

    osDelay(2000);
}

//static void Spc_GetTemp(SpcTemperature *temp, uint8_t Channel)
//{
//    
//}

static void Spc_SelfCheck()
{
    Spc_ScreenUpdate(SPC_SELFCHECK);
}

static void SpcTask(void const *arg)
{
    Spc_StartupLog();
    Spc_SelfCheck();

    while (1) {
        osDelay(2000);
    }
}

/*----------------------------------------------------------------------------*/
/* Public functions                                                           */
/*----------------------------------------------------------------------------*/
void SPC_Init(void)
{
    osThreadDef(SpcTaskName, SpcTask, osPriorityBelowNormal, 0, 128);
    SpcTaskHandle = osThreadCreate(osThread(SpcTaskName), NULL);
}
