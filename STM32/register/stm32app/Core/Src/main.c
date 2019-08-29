#include "stm32f1xx.h"
#include "stm32f103xe.h"
#include "common.h"

static void Error_Handler(void)
{

}

static void RCC_Init(void)
{
    __IO uint32_t tmpreg;
    SET_BIT(RCC->APB2ENR, RCC_APB2ENR_AFIOEN);
    /* Delay after an RCC peripheral clock enabling */
    tmpreg = READ_BIT(RCC->APB2ENR, RCC_APB2ENR_AFIOEN);
    (void)tmpreg;

    SET_BIT(RCC->APB1ENR, RCC_APB1ENR_PWREN);
    /* Delay after an RCC peripheral clock enabling */
    tmpreg = READ_BIT(RCC->APB1ENR, RCC_APB1ENR_PWREN);
    (void)tmpreg;

    NVIC_SetPriorityGrouping(NVIC_PRIORITYGROUP_4);

    CLEAR_BIT(AFIO->MAPR,AFIO_MAPR_SWJ_CFG);
    SET_BIT(AFIO->MAPR, AFIO_MAPR_SWJ_CFG_DISABLE);

    MODIFY_REG(FLASH->ACR, FLASH_ACR_LATENCY, FLASH_ACR_LATENCY_1);

    if((uint32_t)(READ_BIT(FLASH->ACR, FLASH_ACR_LATENCY)) != FLASH_ACR_LATENCY_1) {
        Error_Handler();  
    }

    SET_BIT(RCC->CR, RCC_CR_HSEON);

    while(READ_BIT(RCC->CR, RCC_CR_HSERDY) != RCC_CR_HSERDY);

    MODIFY_REG(RCC->CFGR, RCC_CFGR_PLLSRC | RCC_CFGR_PLLXTPRE | RCC_CFGR_PLLMULL,
             (RCC_CFGR_PLLSRC & (RCC_CFGR_PLLSRC | RCC_CFGR_PLLXTPRE)) | RCC_CFGR_PLLMULL9);

    SET_BIT(RCC->CR, RCC_CR_PLLON);

    while(READ_BIT(RCC->CR, RCC_CR_PLLRDY) != RCC_CR_PLLRDY);

    MODIFY_REG(RCC->CFGR, RCC_CFGR_HPRE, RCC_CFGR_HPRE_DIV1);
    MODIFY_REG(RCC->CFGR, RCC_CFGR_PPRE1, RCC_CFGR_PPRE1_DIV2);
    MODIFY_REG(RCC->CFGR, RCC_CFGR_PPRE2, RCC_CFGR_PPRE2_DIV1);
    MODIFY_REG(RCC->CFGR, RCC_CFGR_SW, RCC_CFGR_SW_PLL);

    while((uint32_t)(READ_BIT(RCC->CFGR, RCC_CFGR_SWS)) != RCC_CFGR_SWS_PLL);

    SysTick->LOAD  = (uint32_t)((72000000 / 1000U) - 1UL);  /* set reload register */
    SysTick->VAL   = 0UL;                                       /* Load the SysTick Counter Value */
    SysTick->CTRL  = SysTick_CTRL_CLKSOURCE_Msk |
                    SysTick_CTRL_ENABLE_Msk;                   /* Enable the Systick Timer */


    SET_BIT(SysTick->CTRL, SysTick_CTRL_CLKSOURCE_Msk);
    SystemCoreClock = 72000000;
} 

static void GPIO_Init()
{
    __IO uint32_t tmpreg;
    SET_BIT(RCC->APB2ENR, RCC_APB2ENR_IOPEEN);
    /* Delay after an RCC peripheral clock enabling */
    tmpreg = READ_BIT(RCC->APB2ENR, RCC_APB2ENR_IOPEEN);
    (void)tmpreg;

    SET_BIT(RCC->APB2ENR, RCC_APB2ENR_IOPCEN);
    /* Delay after an RCC peripheral clock enabling */
    tmpreg = READ_BIT(RCC->APB2ENR, RCC_APB2ENR_IOPCEN);
    (void)tmpreg;

    SET_BIT(RCC->APB2ENR, RCC_APB2ENR_IOPAEN);
    /* Delay after an RCC peripheral clock enabling */
    tmpreg = READ_BIT(RCC->APB2ENR, RCC_APB2ENR_IOPAEN);
    (void)tmpreg;

    SET_BIT(RCC->APB2ENR, RCC_APB2ENR_IOPBEN);
    /* Delay after an RCC peripheral clock enabling */
    tmpreg = READ_BIT(RCC->APB2ENR, RCC_APB2ENR_IOPBEN);
    (void)tmpreg;

    SET_BIT(RCC->APB2ENR, RCC_APB2ENR_IOPDEN);
    /* Delay after an RCC peripheral clock enabling */
    tmpreg = READ_BIT(RCC->APB2ENR, RCC_APB2ENR_IOPDEN);
    (void)tmpreg;

    WRITE_REG(GPIOA->BRR, (((GPIO_BSRR_BS4  << 8U) | 0x00000010U) >> 8U) & 0x0000FFFFU);
    WRITE_REG(GPIOB->BRR, (((GPIO_BSRR_BS5  << 8U) | 0x00000010U) >> 8U) & 0x0000FFFFU);

    register uint32_t *pReg = (uint32_t *)((uint32_t)(&GPIOA->CRL) + (Pin >> 24));
    MODIFY_REG(*pReg, ((GPIO_CRL_CNF0 | GPIO_CRL_MODE0) << (POSITION_VAL(Pin) * 4U)), (Mode << (POSITION_VAL(Pin) * 4U)));

}

int main()
{
    RCC_Init();
    GPIO_Init();

    while (1) {
        
    }
}