#include "stm32f1xx.h"
#include "stm32f103xe.h"
#include "common.h"

static void Led_Port_Init()
{
    __IO uint32_t tmpreg;

    // IO�˿�Bʱ��ʹ��
    SET_BIT(RCC->APB2ENR, RCC_APB2ENR_IOPBEN);
    /* Delay after an RCC peripheral clock enabling */
    tmpreg = READ_BIT(RCC->APB2ENR, RCC_APB2ENR_IOPBEN);
    (void)tmpreg;

    // �˿�λ����Ĵ���  ����˿�x��λy  1�������Ӧ��ODRyλΪ0
    WRITE_REG(Led_GPIO_Port->BRR, Led_Pin);

	  // �˿����õͼĴ���  CNF 00��ͨ���������ģʽ  MODE  10 : ���ģʽ������ٶ�2MHz
    MODIFY_REG(Led_GPIO_Port->CRL, (GPIO_CRL_CNF5 | GPIO_CRL_MODE5), GPIO_CRL_MODE5_1);

    // �˿�������ݼĴ���  
    MODIFY_REG(Led_GPIO_Port->ODR, Led_Pin, 0);
}

void GPIO_Init()
{
    Led_Port_Init();
}