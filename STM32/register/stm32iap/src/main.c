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

    // IO端口B时钟使能
    SET_BIT(RCC->APB2ENR, RCC_APB2ENR_IOPBEN);
    /* Delay after an RCC peripheral clock enabling */
    tmpreg = READ_BIT(RCC->APB2ENR, RCC_APB2ENR_IOPBEN);
    (void)tmpreg;

    // 端口位清除寄存器  清除端口x的位y  1：清除对应的ODRy位为0
    WRITE_REG(Led_GPIO_Port->BRR, Led_Pin);

    // 端口配置低寄存器  CNF 00：通用推挽输出模式  MODE  01：输出模式，最大速度10MHz
    MODIFY_REG(Led_GPIO_Port->CRL, (GPIO_CRL_CNF5 | GPIO_CRL_MODE5), GPIO_CRL_MODE5_0);

    // 端口输出数据寄存器  
    MODIFY_REG(Led_GPIO_Port->ODR, Led_Pin, 0);

    //  11：输出模式，最大速度50MHz
    MODIFY_REG(Led_GPIO_Port->CRL, GPIO_CRL_MODE5, GPIO_CRL_MODE5_1);

    // 00：通用推挽输出模式
    MODIFY_REG(Led_GPIO_Port->CRL, GPIO_CRL_CNF5_0, 0);
}

int main()
{
	  uint32_t cnt = 0;
	
	  RCC_Init();
    GPIO_Init();
	
	  
	  //MODIFY_REG(Led_GPIO_Port->ODR, Led_Pin, GPIO_ODR_ODR5);
	
    while(1) {
		    for (cnt=0;cnt<7200000;cnt++);
			  MODIFY_REG(Led_GPIO_Port->ODR, Led_Pin, GPIO_ODR_ODR5);
			  Led_GPIO_Port->ODR |= GPIO_ODR_ODR5;
			  for (cnt=0;cnt<7200000;cnt++);
			  Led_GPIO_Port->ODR &= ~GPIO_ODR_ODR5;
		}
}
