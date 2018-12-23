/* Includes ------------------------------------------------------------------*/
#include "lcd.h"

static uint16_t lcd_ReadReg(uint8_t Reg)
{
    TFT_LCD->REG = Reg;
    return (TFT_LCD->RAM);
}

void lcd_GetLCDID()
{
    uint16_t id;
    uint8_t rxBuf[2];
    uint8_t txBuf[2];

    id = lcd_ReadReg(0x00);
    while (HAL_UART_GetState(&huart1) != HAL_UART_STATE_READY) {}

}