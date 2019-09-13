#include "stm32f1xx.h"
#include "stm32f103xe.h"
#include "common.h"
#include "FreeRTOS.h"
#include "task.h"

static void SDInitTsk(void *arg)
{
    SDIO_Init();
}

void SD_Init()
{
	xTaskCreate(SDInitTsk, "SD Init", 128, NULL, 0, NULL);
}
