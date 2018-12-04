/**
  ******************************************************************************
  * @file           : main.c
  * @brief          : Main program body
  ******************************************************************************
  */

/* Includes ------------------------------------------------------------------*/
#include <string.h>
#include "gpio.h"
#include "usart.h"
#include "iap.h"

#include "stm32f1xx_hal.h"

pFunction JumpToApplication;
uint32_t JumpAddress;

static uint8_t command[IAP_MAX_COMMAND_NUM][2] = {
    {0x21, 0x31},
    {0x22, 0x32},
    {0x23, 0x33},
};
/**
  * @brief  The application entry point.
  *
  * @retval None
  */
#if 0
void IAP_Flash()
{
    uint32_t writeFlashData = 0x55555555;
    uint32_t addr = 0x08007000;

    HAL_FLASH_Unlock();

    f.TypeErase = FLASH_TYPEERASE_PAGES;
    f.PageAddress = IAP_FLASH_PRG_ADDR;
    f.NbPages = 1;

    uint32_t PageError = 0;
    HAL_FLASHEx_Erase(&f, &PageError);

    HAL_FLASH_Program(FLASH_TYPEPROGRAM_WORD, addr, writeFlashData);

    uint32_t temp = *(__IO uint32_t *) (addr);
    uint8_t msg[100] = { 0 };
    snprintf((char *) msg, 100, "addr:0x%x, data:0x%x\r\n", addr, temp);
    MX_Uart_Transmit(msg, strlen((char *) msg) + 1, IAP_TIMEOUT);


    f.TypeErase = FLASH_TYPEERASE_PAGES;
    f.PageAddress = IAP_FLASH_PRG_ADDR;
    f.NbPages = 1;

    PageError = 0;
    HAL_FLASHEx_Erase(&f, &PageError);

    writeFlashData = 0xaaaaaaaa;
    HAL_FLASH_Program(FLASH_TYPEPROGRAM_WORD, addr, writeFlashData);

    temp = *(__IO uint32_t *) (addr);
    memset(msg, 0, 100);
    snprintf((char *) msg, 100, "addr:0x%x, data:0x%x\r\n", addr, temp);
    MX_Uart_Transmit(msg, strlen((char *) msg) + 1, IAP_TIMEOUT);
}
#endif

void IAP_Process()
{
    uint32_t preProgFlag = 0;

    MX_Led_On();
    if (MX_Key_Read() != GPIO_PIN_SET) {
        // Key is not pushed down
        if (((*(__IO uint32_t*)IAP_FLASH_PRG_ADDR) & 0x2FFE0000 ) == 0x20000000) {
            // Existing previous programming, Do jumping
            JumpAddress = *(__IO uint32_t*) (IAP_FLASH_PRG_ADDR + 4);
            JumpToApplication = (pFunction) JumpAddress;
            /* Initialize user application's Stack Pointer */
            __set_MSP(*(__IO uint32_t*) IAP_FLASH_PRG_ADDR);
            JumpToApplication();
            return;
        }
    }

//======================================================================================
//   Start Programming
//======================================================================================
    /***********************************************************
     * Negotiate sequence
     * send       0x21 0x31
     * receive    0x22 0x32
     * send       0x22 0x32
     * receive    0x23 0x33
     ***********************************************************/
    uint16_t commandSeq = 0;
    MX_Uart_Transmit(command[commandSeq], 2, IAP_TIMEOUT);  // send 0x21, 0x31
    commandSeq++;

    uint8_t recBuf[2] = { 0 };
    MX_Uart_Receive(recBuf, 2, 100000);
    if ((recBuf[0] != 0x22) || (recBuf[1] != 0x32)) {   // rev 0x22, 0x32
        return;
    }

    HAL_Delay(50);
    MX_Uart_Transmit(command[commandSeq], 2, IAP_TIMEOUT);  // send 0x22, 0x32
    commandSeq++;

    MX_Uart_Receive(recBuf, 2, 100000);    // rev 0x23, 0x33
    if ((recBuf[0] != 0x23) || (recBuf[1] != 0x33)) {
        return;
    }

    /***********************************************************
     * recevie total bytes of data
     * send data back
     ***********************************************************/
    uint8_t totalBytesBuf[4] = { 0 };
    MX_Uart_Receive(recBuf, 4, 100000);    // rev  total number
    uint32_t totalBytes = recBuf[0] * 0x1000000 + recBuf[1] * 0x10000 +
                            recBuf[2] * 0x100 + recBuf[3];

    HAL_Delay(50);
    MX_Uart_Transmit(recBuf, 2, IAP_TIMEOUT);   // send 0x22, 0x32

    /***********************************************************
     * Unlock flash  --- calculate total blocks  ---  erase flash
     ***********************************************************/
    HAL_FLASH_Unlock();

    uint32_t block = 0;
    block = totalBytes / IAP_FLASH_PRG_SIZE;
    if ((totalBytes % IAP_FLASH_PRG_SIZE) > 0)
        block++;

    FLASH_EraseInitTypeDef f;
    f.TypeErase = FLASH_TYPEERASE_PAGES;
    f.PageAddress = IAP_FLASH_PRG_ADDR;
    f.NbPages = block;
    HAL_FLASHEx_Erase(&f, &PageError);

    /***********************************************************
     * Recieve data ---  program flash
     * Note : totalBytes should be 8 multiplied
     ***********************************************************/
    uint32_t dataIndex = totalBytes / IAP_FLASH_WRITE_BYTES;
    uint32_t addr = IAP_FLASH_PRG_ADDR;
    uint32_t i;
    uint8_t dataBuf[8] = { 0xff };
    for (i=0; i<dataIndex; i++) {
        MX_Uart_Receive(dataBuf, 8, 100000);
        HAL_Delay(50);
        MX_Uart_Transmit(dataBuf, 8, IAP_TIMEOUT);
        HAL_FLASH_Program(FLASH_TYPEPROGRAM_DOUBLEWORD, addr, dataBuf);
        addr += IAP_FLASH_WRITE_BYTES;
    }

    /***********************************************************
     * Finish sequence
     * send     0x23  0x33
     * receive  0x24 0x34
     ***********************************************************/
    HAL_Delay(50);
    MX_Uart_Transmit(command[commandSeq], 2, IAP_TIMEOUT);  // send 0x23, 0x33

    MX_Led_Off();
}
