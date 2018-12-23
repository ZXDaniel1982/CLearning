/* Define to prevent recursive inclusion -------------------------------------*/
#ifndef __gpio_H
#define __gpio_H
#ifdef __cplusplus
 extern "C" {
#endif

/* Includes ------------------------------------------------------------------*/
#include "main.h"

typedef struct
{
    __IO uint16_t REG;
    __IO uint16_t RAM;
} TFT_LCD_TypeDef;

#define TFT_LCD_BASE           FSMC_BANK1_1
#define TFT_LCD                ((TFT_LCD_TypeDef *) TFT_LCD_BASE)

typedef struct
{
    void     (*Init)(void);
    uint16_t (*ReadID)(void);
}LCD_DrvTypeDef;    

#ifdef __cplusplus
}
#endif
#endif /*__ pinoutConfig_H */
