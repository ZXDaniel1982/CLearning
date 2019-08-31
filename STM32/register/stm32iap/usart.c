#include "stm32f1xx.h"
#include "stm32f103xe.h"
#include "common.h"

void USART_Init()
{
    __IO uint32_t tmpreg;
	
	  // 1： USART1时钟开启。
    SET_BIT(RCC->APB2ENR, RCC_APB2ENR_USART1EN);
    /* Delay after an RCC peripheral clock enabling */
    tmpreg = READ_BIT(RCC->APB2ENR, RCC_APB2ENR_USART1EN);
    (void)tmpreg;

	  // 1： IO端口A时钟开启
    SET_BIT(RCC->APB2ENR, RCC_APB2ENR_IOPAEN);
    /* Delay after an RCC peripheral clock enabling */
    tmpreg = READ_BIT(RCC->APB2ENR, RCC_APB2ENR_IOPAEN);
    (void)tmpreg;

    // 端口配置寄存器  CNF 10：复用功能推挽输出模式  MODE  11：输出模式，最大速度50MHz
    MODIFY_REG(GPIOA->CRH, (GPIO_CRH_CNF9 | GPIO_CRH_MODE9), (GPIO_CRH_CNF9_1 | GPIO_CRH_MODE9));

    // 端口输出数据寄存器  
    MODIFY_REG(GPIOA->ODR, GPIO_BSRR_BS9, 0);

    // 端口配置寄存器  CNF 01：浮空输入模式(复位后的状态)  MODE  00：输入模式(复位后的状态)
    MODIFY_REG(GPIOA->CRH, (GPIO_CRH_CNF10 | GPIO_CRH_MODE10), GPIO_CRH_CNF10_0);

    // 端口输出数据寄存器  
    MODIFY_REG(GPIOA->ODR, GPIO_BSRR_BS10, 0);

    if (READ_BIT(USART1->CR1, USART_CR1_UE) != (USART_CR1_UE)) {
        MODIFY_REG(USART1->CR1,
               (USART_CR1_M | USART_CR1_PCE | USART_CR1_PS | USART_CR1_TE | USART_CR1_RE),
               (USART_CR1_TE |USART_CR1_RE));

        MODIFY_REG(USART1->CR2, USART_CR2_STOP, 0);

        MODIFY_REG(USART1->CR3, USART_CR3_RTSE | USART_CR3_CTSE, 0);

        USART1->BRR = 0x271;
    }
		
		CLEAR_BIT(USART1->CR2, (USART_CR2_LINEN | USART_CR2_CLKEN));
    CLEAR_BIT(USART1->CR3, (USART_CR3_SCEN | USART_CR3_IREN | USART_CR3_HDSEL));
		
		USART1->CR1 |= USART_CR1_UE;
}