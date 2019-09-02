#include "stm32f1xx.h"
#include "stm32f103xe.h"
#include "common.h"

static void TIMER1_Init()
{
    NVIC_SetPriority(TIM1_UP_IRQn, NVIC_EncodePriority(NVIC_GetPriorityGrouping(), 0, 0));
    NVIC_EnableIRQ(TIM1_UP_IRQn);

    __IO uint32_t tmpreg;

    SET_BIT(RCC->APB2ENR, RCC_APB2ENR_TIM1EN);
    /* Delay after an RCC peripheral clock enabling */
    tmpreg = READ_BIT(RCC->APB2ENR, RCC_APB2ENR_TIM1EN);
    UNUSED(tmpreg);

    TIM1->CR1 &= ~(TIM_CR1_DIR | TIM_CR1_CMS);
    TIM1->CR1 &= ~TIM_CR1_CKD;
    MODIFY_REG(TIM1->CR1, TIM_CR1_ARPE, 0);

    /* Set the Autoreload value */
    TIM1->ARR = (uint32_t)((1000000 / 1000) - 1);

    /* Set the Prescaler value */
    TIM1->PSC = (uint32_t) ((72000000 / 1000000) - 1);

    /* Set the Repetition Counter value */
    TIM1->RCR = 0;

    TIM1->EGR = TIM_EGR_UG;

    TIM1->DIER |= TIM_DIER_UIE;

    TIM1->CR1 |= TIM_CR1_CEN;
}

static void TIMERx_Init(TIM_TypeDef *TIMx, uint32_t Periphs, IRQn_Type IRQn)
{
    __IO uint32_t tmpreg;

    SET_BIT(RCC->APB2ENR, Periphs);
    /* Delay after an RCC peripheral clock enabling */
    tmpreg = READ_BIT(RCC->APB2ENR, Periphs);
    UNUSED(tmpreg);

    NVIC_SetPriority(IRQn, NVIC_EncodePriority(NVIC_GetPriorityGrouping(),0, 0));
    NVIC_EnableIRQ(IRQn);

    MODIFY_REG(TIMx->CR1, (TIM_CR1_DIR | TIM_CR1_CMS), 0);
    MODIFY_REG(TIMx->CR1, TIM_CR1_CKD, 0);

    WRITE_REG(TIMx->ARR, 0);
    WRITE_REG(TIMx->PSC, 36000-(TIM_CCMR1_IC1F_0 << 16U));

    if (TIMx == TIM8) {
        WRITE_REG(TIMx->RCR, 0);
    }

    SET_BIT(TIMx->EGR, TIM_EGR_UG);

    CLEAR_BIT(TIMx->CR1, TIM_CR1_ARPE);
    MODIFY_REG(TIMx->SMCR, TIM_SMCR_SMS | TIM_SMCR_ECE, 0);
    MODIFY_REG(TIMx->CR2, TIM_CR2_MMS, 0);
    CLEAR_BIT(TIMx->SMCR, TIM_SMCR_MSM);

    TIMx->DIER |= TIM_DIER_UIE;
    TIMx->CR1 |= TIM_CR1_CEN;
}

void TIMER_Init()
{
    TIMER1_Init();
    TIMERx_Init(TIM2, RCC_APB1ENR_TIM2EN, TIM2_IRQn);
    TIMERx_Init(TIM3, RCC_APB1ENR_TIM3EN, TIM3_IRQn);
    TIMERx_Init(TIM4, RCC_APB1ENR_TIM4EN, TIM4_IRQn);
    TIMERx_Init(TIM5, RCC_APB1ENR_TIM5EN, TIM5_IRQn);
}

void TIM1_UP_IRQHandler(void)
{
    if ((TIM1->SR & TIM_DIER_UIE) && (TIM1->DIER & TIM_DIER_BIE)) {
        TIM1->SR = ~TIM_DIER_BIE;
    }
}

void TIM2_IRQHandler(void)
{
    if ((TIM2->SR & TIM_DIER_UIE) && (TIM2->DIER & TIM_DIER_BIE)) {
        TIM2->SR = ~TIM_DIER_BIE;
    }
}

void TIM3_IRQHandler(void)
{
    if ((TIM3->SR & TIM_DIER_UIE) && (TIM3->DIER & TIM_DIER_BIE)) {
        TIM3->SR = ~TIM_DIER_BIE;
    }
}

void TIM4_IRQHandler(void)
{
    if ((TIM4->SR & TIM_DIER_UIE) && (TIM4->DIER & TIM_DIER_BIE)) {
        TIM4->SR = ~TIM_DIER_BIE;
    }
}

void TIM5_IRQHandler(void)
{
    if ((TIM5->SR & TIM_DIER_UIE) && (TIM5->DIER & TIM_DIER_BIE)) {
        TIM5->SR = ~TIM_DIER_BIE;
    }
}
