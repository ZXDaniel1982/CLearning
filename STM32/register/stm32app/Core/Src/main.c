#include "stm32f1xx.h"
#include "stm32f103xe.h"
#include "common.h"

static void Error_Handler(void)
{

}

static void RCC_Init(void)
{
    __IO uint32_t tmpreg;
    // 辅助功能IO时钟使能
    SET_BIT(RCC->APB2ENR, RCC_APB2ENR_AFIOEN);
    /* Delay after an RCC peripheral clock enabling */
    tmpreg = READ_BIT(RCC->APB2ENR, RCC_APB2ENR_AFIOEN);
    (void)tmpreg;

    // 电源接口时钟使能
    // If you don't set the RCC_APB1ENR .PWREN bit,
    // the registers of PWR unit can't be written and reading them returns 0.
    SET_BIT(RCC->APB1ENR, RCC_APB1ENR_PWREN);
    /* Delay after an RCC peripheral clock enabling */
    tmpreg = READ_BIT(RCC->APB1ENR, RCC_APB1ENR_PWREN);
    (void)tmpreg;

    NVIC_SetPriorityGrouping(NVIC_PRIORITYGROUP_4);

    // 通用和复用功能I/O
    CLEAR_BIT(AFIO->MAPR,AFIO_MAPR_SWJ_CFG);  // 000：完全SWJ(JTAG-DP + SW-DP)：复位状态；
    SET_BIT(AFIO->MAPR, AFIO_MAPR_SWJ_CFG_DISABLE); // 100：关闭JTAG-DP，关闭SW-DP；

    // 010：两个等待状态，当 48MHz < SYSCLK ≤ 72MHz
    MODIFY_REG(FLASH->ACR, FLASH_ACR_LATENCY, FLASH_ACR_LATENCY_1);
    if((uint32_t)(READ_BIT(FLASH->ACR, FLASH_ACR_LATENCY)) != FLASH_ACR_LATENCY_1) {
        Error_Handler();  
    }

    // 外部高速时钟使能
    // 1： HSE振荡器开启
    SET_BIT(RCC->CR, RCC_CR_HSEON);
    while(READ_BIT(RCC->CR, RCC_CR_HSERDY) != RCC_CR_HSERDY);

    // PLL输入时钟源  1： PREDIV1输出作为PLL输入时钟
    // PREDIV1分频因子的低位  置0
    // PLL倍频系数  0111： PLL 9倍频输出
    MODIFY_REG(RCC->CFGR, RCC_CFGR_PLLSRC | RCC_CFGR_PLLXTPRE | RCC_CFGR_PLLMULL,
             (RCC_CFGR_PLLSRC & (RCC_CFGR_PLLSRC | RCC_CFGR_PLLXTPRE)) | RCC_CFGR_PLLMULL9);

    // 1： PLL使能。
    SET_BIT(RCC->CR, RCC_CR_PLLON);
    while(READ_BIT(RCC->CR, RCC_CR_PLLRDY) != RCC_CR_PLLRDY);

    // AHB预分频  0xxx： SYSCLK不分频
    MODIFY_REG(RCC->CFGR, RCC_CFGR_HPRE, RCC_CFGR_HPRE_DIV1);
    // 低速APB预分频   100： HCLK 2分频
    MODIFY_REG(RCC->CFGR, RCC_CFGR_PPRE1, RCC_CFGR_PPRE1_DIV2);
    // 高速APB预分频   0xx： HCLK不分频
    MODIFY_REG(RCC->CFGR, RCC_CFGR_PPRE2, RCC_CFGR_PPRE2_DIV1);
    // 系统时钟切换    10： PLL输出作为系统时钟；
    MODIFY_REG(RCC->CFGR, RCC_CFGR_SW, RCC_CFGR_SW_PLL);
    while((uint32_t)(READ_BIT(RCC->CFGR, RCC_CFGR_SWS)) != RCC_CFGR_SWS_PLL);


    SysTick->LOAD  = (uint32_t)((72000000 / 1000U) - 1UL);  // 倒数到0， 重新装载
    SysTick->VAL   = 0UL;   // current值  写入清0
    SysTick->CTRL  = SysTick_CTRL_CLKSOURCE_Msk |      // 1 : 内核时钟源 FCLK
                    SysTick_CTRL_ENABLE_Msk;  // 定时器使能


    SET_BIT(SysTick->CTRL, SysTick_CTRL_CLKSOURCE_Msk);
    SystemCoreClock = 72000000;
} 

static void GPIO_Init()
{
    __IO uint32_t tmpreg;

    // IO端口C时钟使能
    SET_BIT(RCC->APB2ENR, RCC_APB2ENR_IOPCEN);
    /* Delay after an RCC peripheral clock enabling */
    tmpreg = READ_BIT(RCC->APB2ENR, RCC_APB2ENR_IOPCEN);
    (void)tmpreg;

    // IO端口A时钟使能
    SET_BIT(RCC->APB2ENR, RCC_APB2ENR_IOPAEN);
    /* Delay after an RCC peripheral clock enabling */
    tmpreg = READ_BIT(RCC->APB2ENR, RCC_APB2ENR_IOPAEN);
    (void)tmpreg;

    // IO端口B时钟使能
    SET_BIT(RCC->APB2ENR, RCC_APB2ENR_IOPBEN);
    /* Delay after an RCC peripheral clock enabling */
    tmpreg = READ_BIT(RCC->APB2ENR, RCC_APB2ENR_IOPBEN);
    (void)tmpreg;

    // 端口位清除寄存器  清除端口x的位y  1：清除对应的ODRy位为0
    WRITE_REG(GPIOA->BRR, GPIO_BSRR_BS4);
    WRITE_REG(GPIOB->BRR, GPIO_BSRR_BS5);

    // 端口配置低寄存器  CNF 00：通用推挽输出模式  MODE  01：输出模式，最大速度10MHz
    MODIFY_REG(GPIOA->CRL, (GPIO_CRL_CNF4 | GPIO_CRL_MODE4), GPIO_CRL_MODE4_0);

    // 端口输出数据寄存器  
    MODIFY_REG(GPIOA->ODR, GPIO_BSRR_BS4, 0);

    //  11：输出模式，最大速度50MHz
    MODIFY_REG(GPIOA->CRL, GPIO_CRL_MODE4, GPIO_CRL_MODE4);

    // 00：通用推挽输出模式
    MODIFY_REG(GPIOA->CRL, GPIO_CRL_CNF4_0, 0);

    // 端口配置低寄存器  CNF 00：通用推挽输出模式  MODE  01：输出模式，最大速度10MHz
    MODIFY_REG(GPIOB->CRL, (GPIO_CRL_CNF5 | GPIO_CRL_MODE5), GPIO_CRL_MODE5_0);

    // 端口输出数据寄存器  
    MODIFY_REG(GPIOB->ODR, GPIO_BSRR_BS5, 0);

    //  11：输出模式，最大速度50MHz
    MODIFY_REG(GPIOB->CRL, GPIO_CRL_MODE5, GPIO_CRL_MODE5_1);

    // 00：通用推挽输出模式
    MODIFY_REG(GPIOB->CRL, GPIO_CRL_CNF5_0, 0);
}

static void UART_Init()
{
    __IO uint32_t tmpreg;
    SET_BIT(RCC->APB2ENR, RCC_APB2ENR_USART1EN);
    /* Delay after an RCC peripheral clock enabling */
    tmpreg = READ_BIT(RCC->APB2ENR, RCC_APB2ENR_USART1EN);
    (void)tmpreg;

    tmpreg;
    SET_BIT(RCC->APB2ENR, RCC_APB2ENR_IOPAEN);
    /* Delay after an RCC peripheral clock enabling */
    tmpreg = READ_BIT(RCC->APB2ENR, RCC_APB2ENR_IOPAEN);
    (void)tmpreg;

    // 端口配置低寄存器  CNF 00：通用推挽输出模式  MODE  01：输出模式，最大速度10MHz
    MODIFY_REG(GPIOA->CRH, (GPIO_CRH_CNF9 | GPIO_CRH_MODE9), (GPIO_CRH_CNF9_1 | GPIO_CRH_MODE9_0));

    // 端口输出数据寄存器  
    MODIFY_REG(GPIOA->ODR, GPIO_BSRR_BS9, 0);

    //  11：输出模式，最大速度50MHz
    MODIFY_REG(GPIOA->CRH, GPIO_CRH_MODE9, GPIO_CRH_MODE9);

    // 00：通用推挽输出模式
    MODIFY_REG(GPIOA->CRH, GPIO_CRH_CNF9_0, 0);

    // 端口配置低寄存器  CNF 00：通用推挽输出模式  MODE  01：输出模式，最大速度10MHz
    MODIFY_REG(GPIOA->CRH, (GPIO_CRH_CNF10 | GPIO_CRH_MODE10), GPIO_CRH_CNF10_0);

    // 端口输出数据寄存器  
    MODIFY_REG(GPIOA->ODR, GPIO_BSRR_BS10, 0);

    //  11：输出模式，最大速度50MHz
    MODIFY_REG(GPIOA->CRH, GPIO_CRH_MODE10, 0);

    // 00：通用推挽输出模式
    MODIFY_REG(GPIOA->CRH, GPIO_CRL_CNF10_0, 0);

    if (READ_BIT(USART1->CR1, USART_CR1_UE) != (USART_CR1_UE)) {
        MODIFY_REG(USART1->CR1,
               (USART_CR1_M | USART_CR1_PCE | USART_CR1_PS | USART_CR1_TE | USART_CR1_RE),
               (USART_CR1_TE |USART_CR1_RE));

        MODIFY_REG(USART1->CR2, USART_CR2_STOP, 0);

        MODIFY_REG(USART1->CR3, USART_CR3_RTSE | USART_CR3_CTSE, 0);

        periphclk = HSE_VALUE / (LL_RCC_PLL_GetPrediv() + 1U);
        __LL_RCC_CALC_PLLCLK_FREQ(pllinputfreq, LL_RCC_PLL_GetMultiplicator());
        if ((periphclk != LL_RCC_PERIPH_FREQUENCY_NO)
        && (USART_InitStruct->BaudRate != 0U)) {
            USART1->BRR = (uint16_t)(__LL_USART_DIV_SAMPLING16(PeriphClk, BaudRate));
        }
    }
}

static void SPI_Init()
{
    __IO uint32_t tmpreg;
    SET_BIT(RCC->APB2ENR, RCC_APB2ENR_SPI1EN);
    /* Delay after an RCC peripheral clock enabling */
    tmpreg = READ_BIT(RCC->APB2ENR, RCC_APB2ENR_SPI1EN);
    (void)tmpreg;

    tmpreg;
    SET_BIT(RCC->APB2ENR, RCC_APB2ENR_IOPAEN);
    /* Delay after an RCC peripheral clock enabling */
    tmpreg = READ_BIT(RCC->APB2ENR, RCC_APB2ENR_IOPAEN);
    (void)tmpreg;

    if (((READ_BIT(SPIx->CR1, SPI_CR1_SPE) == (SPI_CR1_SPE)) ? 1UL : 0UL) == 0x00000000U) {
        MODIFY_REG(SPIx->CR1,
               SPI_CR1_CLEAR_MASK,
               SPI_InitStruct->TransferDirection | SPI_InitStruct->Mode | SPI_InitStruct->DataWidth |
               SPI_InitStruct->ClockPolarity | SPI_InitStruct->ClockPhase |
               SPI_InitStruct->NSS | SPI_InitStruct->BaudRate |
               SPI_InitStruct->BitOrder | SPI_InitStruct->CRCCalculation);

        MODIFY_REG(SPIx->CR2, SPI_CR2_SSOE, (SPI_InitStruct->NSS >> 16U));

        CLEAR_BIT(SPIx->I2SCFGR, SPI_I2SCFGR_I2SMOD);
    }
}

int main()
{
    RCC_Init();
    GPIO_Init();
    UART_Init();
    SPI_Init();

    while (1) {
        
    }
}