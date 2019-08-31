#include "stm32f1xx.h"
#include "stm32f103xe.h"
#include "common.h"

static void Led_Port_Init()
{
    __IO uint32_t tmpreg;

    // IO端口B时钟使能
    SET_BIT(RCC->APB2ENR, RCC_APB2ENR_IOPBEN);
    /* Delay after an RCC peripheral clock enabling */
    tmpreg = READ_BIT(RCC->APB2ENR, RCC_APB2ENR_IOPBEN);
    (void)tmpreg;

    // 端口位清除寄存器  清除端口x的位y  1：清除对应的ODRy位为0
    WRITE_REG(Led_GPIO_Port->BRR, Led_Pin);

	  // 端口配置低寄存器  CNF 00：通用推挽输出模式  MODE  10 : 输出模式，最大速度2MHz
    MODIFY_REG(Led_GPIO_Port->CRL, (GPIO_CRL_CNF5 | GPIO_CRL_MODE5), GPIO_CRL_MODE5_1);

    // 端口输出数据寄存器  
    MODIFY_REG(Led_GPIO_Port->ODR, Led_Pin, 0);
}

void GPIO_Init()
{
    Led_Port_Init();
}