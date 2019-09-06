#include "stm32f1xx.h"
#include "stm32f103xe.h"
#include "common.h"

typedef struct
{
    GPIO_TypeDef *port;
    uint32_t pin;
    uint32_t clear;
    uint32_t set;
} GPIO_PINS_t;
static const GPIO_PINS_t GPIO_PINS_L[] = {
    {Led_GPIO_Port, Led_Pin, (GPIO_CRL_CNF5 | GPIO_CRL_MODE5), GPIO_CRL_MODE5_1},
    {SST_CS_GPIO_Port, SST_CS_Pin, (GPIO_CRL_CNF4 | GPIO_CRL_MODE4), GPIO_CRL_MODE4},

    // spi1
    {GPIOA, GPIO_BSRR_BS5, (GPIO_CRL_CNF5 | GPIO_CRL_MODE5), (GPIO_CRL_CNF5_1 | GPIO_CRL_MODE5)},
    {GPIOA, GPIO_BSRR_BS6, (GPIO_CRL_CNF6 | GPIO_CRL_MODE6), GPIO_CRL_CNF6_0},
    {GPIOA, GPIO_BSRR_BS7, (GPIO_CRL_CNF7 | GPIO_CRL_MODE7), (GPIO_CRL_CNF7_1 | GPIO_CRL_MODE7)},
};
static const GPIO_PINS_t GPIO_PINS_H[] = {
    // usart1
    {GPIOA, GPIO_BSRR_BS9, (GPIO_CRH_CNF9 | GPIO_CRH_MODE9), (GPIO_CRH_CNF9_1 | GPIO_CRH_MODE9)},
    {GPIOA, GPIO_BSRR_BS10, (GPIO_CRH_CNF10 | GPIO_CRH_MODE10), GPIO_CRH_CNF10_0},
};

static void GPIOxL_Init(GPIO_TypeDef *GPIOx, uint32_t pin, uint32_t clear, uint32_t set)
{
    // ¶Ë¿ÚÎ»Çå³ý¼Ä´æÆ÷  Çå³ý¶Ë¿ÚxµÄÎ»y  1£ºÇå³ý¶ÔÓ¦µÄODRyÎ»Îª0
    WRITE_REG(GPIOx->BRR, pin);

      // ¶Ë¿ÚÅäÖÃµÍ¼Ä´æÆ÷  CNF 00£ºÍ¨ÓÃÍÆÍìÊä³öÄ£Ê½  MODE  10 : Êä³öÄ£Ê½£¬×î´óËÙ¶È2MHz
    MODIFY_REG(GPIOx->CRL, clear, set);

    // ¶Ë¿ÚÊä³öÊý¾Ý¼Ä´æÆ÷  
    MODIFY_REG(GPIOx->ODR, pin, 0);
}

static void GPIOxH_Init(GPIO_TypeDef *GPIOx, uint32_t pin, uint32_t clear, uint32_t set)
{
    // ¶Ë¿ÚÎ»Çå³ý¼Ä´æÆ÷  Çå³ý¶Ë¿ÚxµÄÎ»y  1£ºÇå³ý¶ÔÓ¦µÄODRyÎ»Îª0
    WRITE_REG(GPIOx->BRR, pin);

      // ¶Ë¿ÚÅäÖÃµÍ¼Ä´æÆ÷  CNF 00£ºÍ¨ÓÃÍÆÍìÊä³öÄ£Ê½  MODE  10 : Êä³öÄ£Ê½£¬×î´óËÙ¶È2MHz
    MODIFY_REG(GPIOx->CRH, clear, set);

    // ¶Ë¿ÚÊä³öÊý¾Ý¼Ä´æÆ÷  
    MODIFY_REG(GPIOx->ODR, pin, 0);
}

void GPIO_Init()
{
    uint8_t i;

    for (i=0;i<NUM_ROWS(GPIO_PINS_L);++i) {
        GPIOxL_Init(GPIO_PINS_L[i].port, GPIO_PINS_L[i].pin, GPIO_PINS_L[i].clear, GPIO_PINS_L[i].set);
    }
    for (i=0;i<NUM_ROWS(GPIO_PINS_H);++i) {
        GPIOxH_Init(GPIO_PINS_H[i].port, GPIO_PINS_H[i].pin, GPIO_PINS_H[i].clear, GPIO_PINS_H[i].set);
    }
}
