#include "stm32f1xx.h"
#include "stm32f103xe.h"
#include "common.h"
#include "FreeRTOS.h"
#include "task.h"
#include "ff.h"
#include "diskio.h"

const uint8_t buff[] = "My test for SD card write\n";
const TCHAR path[] = "0:/";

static void OutPutFile(void)
{
    FATFS fs;
    FIL fsrc;
    UINT wcnt = 0;

    disk_initialize(0);
    if (f_mount(&fs, path, 0)) {
        tftprintf("Failed to mount file");
        return;
    }

    if (f_open(&fsrc, "mybook.txt", FA_CREATE_ALWAYS | FA_WRITE) != FR_OK) {
        tftprintf("Failed to create file");
        return;
    }

    if (f_write(&fsrc, buff, sizeof(buff), &wcnt)) {
        tftprintf("Failed to write file");
        f_close(&fsrc);
        return;
    }
    tftprintf("success write bytes %d", wcnt);
    f_close(&fsrc);
    return;
}

static void SDInitTsk(void *arg)
{
    SDIOEx_Init();
    //OutPutFile();

    while (1) {
        vTaskDelay(1000);
    }
}

void SD_Init()
{
    xTaskCreate(SDInitTsk, "SD Init", 128, NULL, 0, NULL);
}
