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

uint16_t IAP_Process()
{
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
            return IAP_ERR_NONE;
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
    MX_Uart_Receive(recBuf, 2);
    if ((recBuf[0] != 0x22) || (recBuf[1] != 0x32)) {   // rev 0x22, 0x32
        return IAP_ERR_INIT;
    }

    HAL_Delay(500);
    MX_Uart_Transmit(command[commandSeq], 2, IAP_TIMEOUT);  // send 0x22, 0x32
    commandSeq++;

    MX_Uart_Receive(recBuf, 2);    // rev 0x23, 0x33
    if ((recBuf[0] != 0x23) || (recBuf[1] != 0x33)) {
        return IAP_ERR_INIT;
    }

    /***********************************************************
     * recevie total bytes of data
     * send data back
     ***********************************************************/
    uint8_t totalBytesBuf[4] = { 0 };
    MX_Uart_Receive(totalBytesBuf, 4);    // rev  total number
    uint32_t totalBytes = totalBytesBuf[0] * 0x1000000 + totalBytesBuf[1] * 0x10000 +
                            totalBytesBuf[2] * 0x100 + totalBytesBuf[3];

    HAL_Delay(500);
    MX_Uart_Transmit(totalBytesBuf, 4, IAP_TIMEOUT);   // send total number

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
		uint32_t PageError = 0;
    HAL_FLASHEx_Erase(&f, &PageError);

    /***********************************************************
     * Recieve data ---  program flash
     * Note : totalBytes should be 8 multiplied
     ***********************************************************/
    uint32_t dataIndex = totalBytes / IAP_FLASH_WRITE_BYTES;
    uint32_t addr = IAP_FLASH_PRG_ADDR;
    volatile uint32_t value, temp1, temp2;
		volatile uint64_t dataVal;
    uint32_t i;
    uint8_t dataBuf[8] = { 0xff };
    for (i=0; i<dataIndex; i++) {
        MX_Uart_Receive(dataBuf, 8);
        HAL_Delay(1000);
        MX_Uart_Transmit(dataBuf, 8, IAP_TIMEOUT);
			  dataVal =   (uint64_t)dataBuf[0] * 0x100000000000000 + (uint64_t)dataBuf[1] * 0x1000000000000 +
			              (uint64_t)dataBuf[2] * 0x10000000000 + (uint64_t)dataBuf[3] * 0x100000000 +
			              (uint64_t)dataBuf[4] * 0x1000000 + (uint64_t)dataBuf[5] * 0x10000 +
                    (uint64_t)dataBuf[6] * 0x100 + (uint64_t)dataBuf[7];
        if (HAL_FLASH_Program(FLASH_TYPEPROGRAM_DOUBLEWORD, addr, dataVal) != HAL_OK) {
            return IAP_ERR_PRG;
        }
#if 0
        value = dataBuf[0] * 0x1000000 + dataBuf[1] * 0x10000 +
                            dataBuf[2] * 0x100 + dataBuf[3];
				temp1 = *(__IO uint32_t *)addr;
        if (temp1 != (value)) {
            return IAP_ERR_VALID;
        }
				HAL_Delay(50);
        value = dataBuf[4] * 0x1000000 + dataBuf[5] * 0x10000 +
                            dataBuf[6] * 0x100 + dataBuf[7];
				temp2 = *(__IO uint32_t *)(addr+4);
        if (temp2 != (value)) {
            return IAP_ERR_VALID;
        }
#endif
        addr += IAP_FLASH_WRITE_BYTES;
    }
    HAL_FLASH_Lock();

    /***********************************************************
     * Finish sequence
     * send     0x23  0x33
     * receive  0x24 0x34
     ***********************************************************/
    HAL_Delay(500);
    MX_Uart_Transmit(command[commandSeq], 2, IAP_TIMEOUT);  // send 0x23, 0x33

    MX_Led_Off();
    return IAP_ERR_NONE;
}
