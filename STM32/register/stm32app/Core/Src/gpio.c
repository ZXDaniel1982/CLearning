#include "stm32f1xx.h"
#include "stm32f103xe.h"
#include "common.h"

static void Led_Port_Init()
{
    __IO uint32_t tmpreg;

    // IO¶Ë¿ÚBÊ±ÖÓÊ¹ÄÜ
    SET_BIT(RCC->APB2ENR, RCC_APB2ENR_IOPBEN);
    /* Delay after an RCC peripheral clock enabling */
    tmpreg = READ_BIT(RCC->APB2ENR, RCC_APB2ENR_IOPBEN);
    (void)tmpreg;

    // ¶Ë¿ÚÎ»Çå³ý¼Ä´æÆ÷  Çå³ý¶Ë¿ÚxµÄÎ»y  1£ºÇå³ý¶ÔÓ¦µÄODRyÎ»Îª0
    WRITE_REG(Led_GPIO_Port->BRR, Led_Pin);

	  // ¶Ë¿ÚÅäÖÃµÍ¼Ä´æÆ÷  CNF 00£ºÍ¨ÓÃÍÆÍìÊä³öÄ£Ê½  MODE  10 : Êä³öÄ£Ê½£¬×î´óËÙ¶È2MHz
    MODIFY_REG(Led_GPIO_Port->CRL, (GPIO_CRL_CNF5 | GPIO_CRL_MODE5), GPIO_CRL_MODE5_1);

    // ¶Ë¿ÚÊä³öÊý¾Ý¼Ä´æÆ÷  
    MODIFY_REG(Led_GPIO_Port->ODR, Led_Pin, 0);
}

void GPIO_Init()
{
    Led_Port_Init();
}
