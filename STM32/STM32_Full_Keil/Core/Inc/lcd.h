/* Define to prevent recursive inclusion -------------------------------------*/
#ifndef __lcd_H
#define __lcd_H
#ifdef __cplusplus
 extern "C" {
#endif

/* Includes ------------------------------------------------------------------*/
#include "main.h"

/* USER CODE BEGIN Prototypes */
#define Bank1_LCD_D    ((uint32_t)0x60020000)    //???????
#define Bank1_LCD_C    ((uint32_t)0x60000000)    //???????

#define LCD_LEN 240
#define LCD_WID 320
#define LCD_CHAR_LEN 6
#define LCD_CHAR_WID 12
#define LCD_STR_LEN_MAX ((LCD_LEN-4) / (LCD_CHAR_LEN))
#define LCD_STR_NUM_MAX (((LCD_WID-4) / (LCD_CHAR_WID+2)) - 1)

#define LCD_CLR_COL ((LCD_LEN) / (LCD_CHAR_LEN))
#define LCD_CLR_ROW ((LCD_WID) / (LCD_CHAR_WID))

#define MAX_CHAR_POSX (LCD_LEN - 6)
#define MAX_CHAR_POSY (LCD_WID - 14)

#define RED   0XF800
#define GREEN 0X07E0
#define BLUE  0X001F
#define BRED  0XF81F
#define GRED  0XFFE0
#define GBLUE 0X07FF;
#define BLACK 0;

#define LCD_BLAND_STR "    "

void LCD_Init(void);
void resetScreen(void);
void Spc_ResetScreen(uint8_t SpcScreenPos, uint8_t SpcScreeScale);
void tftprintf(const char* fmt, ...);

void MonitorDefTask(void);
void MonitorMyTask(void);
/* USER CODE END Prototypes */

#ifdef __cplusplus
}
#endif
#endif /*__lcd_H */

/**
  * @}
  */

/**
  * @}
  */

/************************ (C) COPYRIGHT STMicroelectronics *****END OF FILE****/
