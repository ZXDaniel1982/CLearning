#include "stm32f1xx.h"
#include "stm32f103xe.h"
#include "common.h"

static void Error_Handler(void)
{

}

static void RCC_Init(void)
{
    __IO uint32_t tmpreg;

    FLASH->ACR |= FLASH_ACR_PRFTBE;
    NVIC_SetPriorityGrouping(NVIC_PRIORITYGROUP_4);

    NVIC_SetPriority(TIM1_UP_IRQn, NVIC_EncodePriority(NVIC_GetPriorityGrouping(), (uint32_t)0, 0));
    NVIC_EnableIRQ(TIM1_UP_IRQn);

    SET_BIT(RCC->APB2ENR, RCC_APB2ENR_TIM1EN);
    /* Delay after an RCC peripheral clock enabling */
    tmpreg = READ_BIT(RCC->APB2ENR, RCC_APB2ENR_TIM1EN);
    UNUSED(tmpreg);

    uint32_t uwTimclock = (SystemCoreClock >> APBPrescTable[(RCC->CFGR & RCC_CFGR_PPRE2) >> RCC_CFGR_PPRE2_Pos]);
    uint32_t uwPrescalerValue = (uint32_t) ((uwTimclock / 1000000) - 1);

    uint32_t tmpcr1;
    tmpcr1 = TIM1->CR1;
    tmpcr1 &= ~(TIM_CR1_DIR | TIM_CR1_CMS | TIM_CR1_CKD);
    MODIFY_REG(tmpcr1, TIM_CR1_ARPE, 0);

    TIM1->CR1 = tmpcr1;
    TIM1->ARR = (uint32_t)((1000000 / 1000) - 1) ;
    TIM1->PSC = uwPrescalerValue;
    TIM1->RCR = 0;
    TIM1->EGR = TIM_EGR_UG;

    TIM1->DIER |= TIM_DIER_UIE;
    TIM1->CR1 |= TIM_CR1_CEN;

    // ¸¨Öú¹¦ÄÜIOÊ±ÖÓÊ¹ÄÜ
    SET_BIT(RCC->APB2ENR, RCC_APB2ENR_AFIOEN);
    /* Delay after an RCC peripheral clock enabling */
    tmpreg = READ_BIT(RCC->APB2ENR, RCC_APB2ENR_AFIOEN);
    UNUSED(tmpreg);

    // µçÔ´½Ó¿ÚÊ±ÖÓÊ¹ÄÜ
    // If you don't set the RCC_APB1ENR .PWREN bit,
    // the registers of PWR unit can't be written and reading them returns 0.
    SET_BIT(RCC->APB1ENR, RCC_APB1ENR_PWREN);
    /* Delay after an RCC peripheral clock enabling */
    tmpreg = READ_BIT(RCC->APB1ENR, RCC_APB1ENR_PWREN);
    UNUSED(tmpreg);

    // Í¨ÓÃºÍ¸´ÓÃ¹¦ÄÜI/O
    CLEAR_BIT(AFIO->MAPR,AFIO_MAPR_SWJ_CFG);  // 000£ºÍêÈ«SWJ(JTAG-DP + SW-DP)£º¸´Î»×´Ì¬£»
    SET_BIT(AFIO->MAPR, AFIO_MAPR_SWJ_CFG_DISABLE); // 100£º¹Ø±ÕJTAG-DP£¬¹Ø±ÕSW-DP£»

    // 010£ºÁ½¸öµÈ´ý×´Ì¬£¬µ± 48MHz < SYSCLK ¡Ü 72MHz
    MODIFY_REG(FLASH->ACR, FLASH_ACR_LATENCY, FLASH_ACR_LATENCY_1);
    if((uint32_t)(READ_BIT(FLASH->ACR, FLASH_ACR_LATENCY)) != FLASH_ACR_LATENCY_1) {
        Error_Handler();  
    }

    // Íâ²¿¸ßËÙÊ±ÖÓÊ¹ÄÜ
    // 1£º HSEÕñµ´Æ÷¿ªÆô
    SET_BIT(RCC->CR, RCC_CR_HSEON);
    while(READ_BIT(RCC->CR, RCC_CR_HSERDY) != RCC_CR_HSERDY);

    SET_BIT(PWR->CR, PWR_CR_DBP);
    SET_BIT(RCC->BDCR, RCC_BDCR_BDRST);
    CLEAR_BIT(RCC->BDCR, RCC_BDCR_BDRST);

    SET_BIT(RCC->BDCR, RCC_BDCR_LSEON);
    while(READ_BIT(RCC->BDCR, RCC_BDCR_LSERDY) != RCC_BDCR_LSERDY);

    MODIFY_REG(RCC->BDCR, RCC_BDCR_RTCSEL, RCC_BDCR_RTCSEL_0);
    SET_BIT(RCC->BDCR, RCC_BDCR_RTCEN);

    // PLLÊäÈëÊ±ÖÓÔ´  1£º PREDIV1Êä³ö×÷ÎªPLLÊäÈëÊ±ÖÓ
    // PREDIV1·ÖÆµÒò×ÓµÄµÍÎ»  ÖÃ0
    // PLL±¶ÆµÏµÊý  0111£º PLL 9±¶ÆµÊä³ö
    MODIFY_REG(RCC->CFGR, RCC_CFGR_PLLSRC | RCC_CFGR_PLLXTPRE | RCC_CFGR_PLLMULL,
             (RCC_CFGR_PLLSRC & (RCC_CFGR_PLLSRC | RCC_CFGR_PLLXTPRE)) | RCC_CFGR_PLLMULL9);

    // 1£º PLLÊ¹ÄÜ¡£
    SET_BIT(RCC->CR, RCC_CR_PLLON);
    while(READ_BIT(RCC->CR, RCC_CR_PLLRDY) != RCC_CR_PLLRDY);

    // AHBÔ¤·ÖÆµ  0xxx£º SYSCLK²»·ÖÆµ
    MODIFY_REG(RCC->CFGR, RCC_CFGR_HPRE, RCC_CFGR_HPRE_DIV1);
    // µÍËÙAPBÔ¤·ÖÆµ   100£º HCLK 2·ÖÆµ
    MODIFY_REG(RCC->CFGR, RCC_CFGR_PPRE1, RCC_CFGR_PPRE1_DIV2);
    // ¸ßËÙAPBÔ¤·ÖÆµ   0xx£º HCLK²»·ÖÆµ
    MODIFY_REG(RCC->CFGR, RCC_CFGR_PPRE2, RCC_CFGR_PPRE2_DIV1);
    // ÏµÍ³Ê±ÖÓÇÐ»»    10£º PLLÊä³ö×÷ÎªÏµÍ³Ê±ÖÓ£»
    MODIFY_REG(RCC->CFGR, RCC_CFGR_SW, RCC_CFGR_SW_PLL);
    while((uint32_t)(READ_BIT(RCC->CFGR, RCC_CFGR_SWS)) != RCC_CFGR_SWS_PLL);

    SystemCoreClock = 72000000;

    MODIFY_REG(RCC->CFGR, RCC_CFGR_ADCPRE, RCC_CFGR_ADCPRE_DIV6);
} 

int main()
{
    uint32_t i;

    RCC_Init();
    GPIO_Init();
    //RTC_Init();
    //TIMER_Init();
    //USART_Init();
    //SPI_Init();
    FSMC_Init();
    LCD_Init();

    for (i=0;i<7200000;++i) {}

    //ShowEEPROMInfo();
    tftprintf("Hello world");

    //MODIFY_REG(Led_GPIO_Port->ODR, Led_Pin, Led_Pin);
    
    while(1) {
        for (i=0;i<7200000;++i) {}
        MODIFY_REG(Led_GPIO_Port->ODR, Led_Pin, Led_Pin);
        tftprintf("Hello world");
        for (i=0;i<7200000;++i) {}
        MODIFY_REG(Led_GPIO_Port->ODR, Led_Pin, 0);
        tftprintf("Hello world");
    }
}
