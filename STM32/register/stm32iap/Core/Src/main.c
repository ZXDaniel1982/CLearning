#include "stm32f1xx.h"
#include "stm32f103xe.h"
#include "common.h"

static void Error_Handler(void)
{

}

static void RCC_Init(void)
{
    __IO uint32_t tmpreg;
    // ��������IOʱ��ʹ��
    SET_BIT(RCC->APB2ENR, RCC_APB2ENR_AFIOEN);
    /* Delay after an RCC peripheral clock enabling */
    tmpreg = READ_BIT(RCC->APB2ENR, RCC_APB2ENR_AFIOEN);
    (void)tmpreg;

    // ��Դ�ӿ�ʱ��ʹ��
    // If you don't set the RCC_APB1ENR .PWREN bit,
    // the registers of PWR unit can't be written and reading them returns 0.
    SET_BIT(RCC->APB1ENR, RCC_APB1ENR_PWREN);
    /* Delay after an RCC peripheral clock enabling */
    tmpreg = READ_BIT(RCC->APB1ENR, RCC_APB1ENR_PWREN);
    (void)tmpreg;

    NVIC_SetPriorityGrouping(NVIC_PRIORITYGROUP_4);

    // ͨ�ú͸��ù���I/O
    CLEAR_BIT(AFIO->MAPR,AFIO_MAPR_SWJ_CFG);  // 000����ȫSWJ(JTAG-DP + SW-DP)����λ״̬��
    SET_BIT(AFIO->MAPR, AFIO_MAPR_SWJ_CFG_DISABLE); // 100���ر�JTAG-DP���ر�SW-DP��

    // 010�������ȴ�״̬���� 48MHz < SYSCLK �� 72MHz
    MODIFY_REG(FLASH->ACR, FLASH_ACR_LATENCY, FLASH_ACR_LATENCY_1);
    if((uint32_t)(READ_BIT(FLASH->ACR, FLASH_ACR_LATENCY)) != FLASH_ACR_LATENCY_1) {
        Error_Handler();  
    }

    // �ⲿ����ʱ��ʹ��
    // 1�� HSE��������
    SET_BIT(RCC->CR, RCC_CR_HSEON);
    while(READ_BIT(RCC->CR, RCC_CR_HSERDY) != RCC_CR_HSERDY);

    // PLL����ʱ��Դ  1�� PREDIV1�����ΪPLL����ʱ��
    // PREDIV1��Ƶ���ӵĵ�λ  ��0
    // PLL��Ƶϵ��  0111�� PLL 9��Ƶ���
    MODIFY_REG(RCC->CFGR, RCC_CFGR_PLLSRC | RCC_CFGR_PLLXTPRE | RCC_CFGR_PLLMULL,
             (RCC_CFGR_PLLSRC & (RCC_CFGR_PLLSRC | RCC_CFGR_PLLXTPRE)) | RCC_CFGR_PLLMULL9);

    // 1�� PLLʹ�ܡ�
    SET_BIT(RCC->CR, RCC_CR_PLLON);
    while(READ_BIT(RCC->CR, RCC_CR_PLLRDY) != RCC_CR_PLLRDY);

    // AHBԤ��Ƶ  0xxx�� SYSCLK����Ƶ
    MODIFY_REG(RCC->CFGR, RCC_CFGR_HPRE, RCC_CFGR_HPRE_DIV1);
    // ����APBԤ��Ƶ   100�� HCLK 2��Ƶ
    MODIFY_REG(RCC->CFGR, RCC_CFGR_PPRE1, RCC_CFGR_PPRE1_DIV2);
    // ����APBԤ��Ƶ   0xx�� HCLK����Ƶ
    MODIFY_REG(RCC->CFGR, RCC_CFGR_PPRE2, RCC_CFGR_PPRE2_DIV1);
    // ϵͳʱ���л�    10�� PLL�����Ϊϵͳʱ�ӣ�
    MODIFY_REG(RCC->CFGR, RCC_CFGR_SW, RCC_CFGR_SW_PLL);
    while((uint32_t)(READ_BIT(RCC->CFGR, RCC_CFGR_SWS)) != RCC_CFGR_SWS_PLL);


    SysTick->LOAD  = (uint32_t)((72000000 / 1000U) - 1UL);  // ������0�� ����װ��
    SysTick->VAL   = 0UL;   // currentֵ  д����0
    SysTick->CTRL  = SysTick_CTRL_CLKSOURCE_Msk |      // 1 : �ں�ʱ��Դ FCLK
                    SysTick_CTRL_ENABLE_Msk;  // ��ʱ��ʹ��


    SET_BIT(SysTick->CTRL, SysTick_CTRL_CLKSOURCE_Msk);
    SystemCoreClock = 72000000;
} 

static void TIMER_Init(TIM_TypeDef *TIMx, uint32_t Periphs, IRQn_Type IRQn)
{
	/*
		SET_BIT(RCC->APB1ENR, RCC_APB1ENR_TIM2EN);
		NVIC_SetPriority(TIM2_IRQn, NVIC_EncodePriority(NVIC_GetPriorityGrouping(),0, 0));
    NVIC_EnableIRQ(TIM2_IRQn);

    WRITE_REG(TIM2->ARR, 2000-(TIM_CCMR1_IC1F_0 << 16U));
    WRITE_REG(TIM2->PSC, 36000-(TIM_CCMR1_IC1F_0 << 16U));

    //tftprintf("EGR %08x", TIM2->EGR);
    //SET_BIT(TIMx->EGR, TIM_EGR_UG);
    //tftprintf("EGR %08x", TIM2->EGR);

    CLEAR_BIT(TIM2->CR1, TIM_CR1_OPM);
    SET_BIT(TIM2->CR1, TIM_CR1_URS);
	  CLEAR_BIT(TIM2->SMCR, TIM_SMCR_MSM);

    SET_BIT(TIM2->DIER, TIM_DIER_UIE);

    SET_BIT(TIM2->CR1, TIM_CR1_CEN);*/
	//����������ʱ��6��TIM6����ʱ��
		SET_BIT(RCC->APB1ENR, Periphs);
 
    /*��ռ�������ֵ*/
    WRITE_REG(TIMx->CNT, 0);
    WRITE_REG(TIMx->ARR, 2000-(TIM_CCMR1_IC1F_0 << 16U));
    WRITE_REG(TIMx->PSC, 36000-(TIM_CCMR1_IC1F_0 << 16U));

    WRITE_REG(TIMx->CR1, 0); //�����ƼĴ���1���

    SET_BIT(TIMx->CR1, TIM_CR1_URS); //�����¼���������Դ

    /*�����޻��幦��*/
    CLEAR_BIT(TIMx->CR1, TIM_CR1_ARPE);

    /*����ѭ��ģʽ*/
    CLEAR_BIT(TIMx->CR1, TIM_CR1_OPM);

    /*��������ж�ʹ��*/
    SET_BIT(TIMx->DIER, TIM_DIER_UIE);

    /*ʹ�ܻ�����ʱ���ж�*/
    NVIC_EnableIRQ(IRQn);

    /*����������ʹ��*/
    SET_BIT(TIMx->CR1, TIM_CR1_CEN);

}

int main()
{
	  uint8_t buf = 0;
	
	  RCC_Init();
    GPIO_Init();
	  USART_Init();
	  TIMER_Init(TIM2, RCC_APB1ENR_TIM2EN, TIM2_IRQn);
	
    while(1) {
				if((USART1->SR & USART_CR1_RXNEIE) != 0) {
				    buf = USART1->DR;
					  USART_RxProcess(buf);
				}
		}
}

void TIM2_IRQHandler(void)
{
    static uint8_t flag = 0;
		if(TIM2->SR & (1<<0))      //����ж�
    {
        TIM2->SR &= ~(1<<0);  //����жϱ�־λ
        //ִ����Ӧ����
        if (flag) {
						flag = 0;
						MODIFY_REG(Led_GPIO_Port->ODR, Led_Pin, Led_Pin);
				} else {
						MODIFY_REG(Led_GPIO_Port->ODR, Led_Pin, 0);
						flag = 1;
				}
    }


}
