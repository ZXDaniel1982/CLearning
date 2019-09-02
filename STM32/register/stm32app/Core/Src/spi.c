#include <stddef.h>

#include "stm32f1xx.h"
#include "stm32f103xe.h"
#include "common.h"

void SPI_Init()
{
    __IO uint32_t tmpreg;

    SET_BIT(RCC->APB2ENR, RCC_APB2ENR_SPI1EN);
    /* Delay after an RCC peripheral clock enabling */
    tmpreg = READ_BIT(RCC->APB2ENR, RCC_APB2ENR_SPI1EN);
    UNUSED(tmpreg);

    SET_BIT(RCC->APB2ENR, RCC_APB2ENR_IOPAEN);
    /* Delay after an RCC peripheral clock enabling */
    tmpreg = READ_BIT(RCC->APB2ENR, RCC_APB2ENR_IOPAEN);
    UNUSED(tmpreg);

    // 端口配置寄存器  CNF 10：复用功能推挽输出模式  MODE  11：输出模式，最大速度50MHz
    MODIFY_REG(GPIOA->CRL, (GPIO_CRL_CNF5 | GPIO_CRL_MODE5), (GPIO_CRL_CNF5_1 | GPIO_CRL_MODE5));

    // 端口输出数据寄存器  
    MODIFY_REG(GPIOA->ODR, GPIO_BSRR_BS5, 0);

    // 端口配置寄存器  CNF 10：复用功能推挽输出模式  MODE  11：输出模式，最大速度50MHz
    MODIFY_REG(GPIOA->CRL, (GPIO_CRL_CNF7 | GPIO_CRL_MODE7), (GPIO_CRL_CNF7_1 | GPIO_CRL_MODE7));

    // 端口输出数据寄存器  
    MODIFY_REG(GPIOA->ODR, GPIO_BSRR_BS7, 0);

    // 端口配置寄存器  CNF 01：浮空输入模式(复位后的状态)  MODE  00：输入模式(复位后的状态)
    MODIFY_REG(GPIOA->CRL, (GPIO_CRL_CNF6 | GPIO_CRL_MODE6), GPIO_CRL_CNF6_0);

    // 端口输出数据寄存器  
    MODIFY_REG(GPIOA->ODR, GPIO_BSRR_BS6, 0);

    /* Disble the selected SPI peripheral */
    SPI1->CR1 &= (~SPI_CR1_SPE);

    /*----------------------- SPIx CR1 & CR2 Configuration ---------------------*/
    /* Configure : SPI Mode, Communication Mode, Data size, Clock polarity and phase, NSS management,
        Communication speed, First bit and CRC calculation state */
    WRITE_REG(SPI1->CR1, (SPI_CR1_MSTR | SPI_CR1_SSI | SPI_CR1_CPOL |
                SPI_CR1_CPHA | SPI_CR1_SSM | SPI_CR1_BR_1));

    /* Configure : NSS management */
    WRITE_REG(SPI1->CR2, ((SPI_CR1_SSM >> 16U) & SPI_CR2_SSOE));

    /*---------------------------- SPIx CRCPOLY Configuration ------------------*/
    /* Configure : CRC Polynomial */
    WRITE_REG(SPI1->CRCPR, 7);

    CLEAR_BIT(SPI1->I2SCFGR, SPI_I2SCFGR_I2SMOD);

    /* Enable SPI peripheral */
    SPI1->CR1 |= SPI_CR1_SPE;
}

uint8_t SPI_Transmit(uint8_t *data, uint16_t size)
{
    if((data == NULL) || (size == 0U)) {
        return 0;
    }

    uint16_t i;
    for (i=0;i<size;i++) {
        while (!(SPI1->SR & SPI_SR_TXE)) {}
        *((__IO uint8_t*) &(SPI1->DR)) = data[i];
    }

    while (!(SPI1->SR & SPI_SR_TXE)) {}
    while (SPI1->SR & SPI_SR_BSY) {}

    __IO uint32_t tmpreg_ovr = 0x00U;
    tmpreg_ovr = SPI1->DR;
    tmpreg_ovr = SPI1->SR;
    UNUSED(tmpreg_ovr);

    return 1;
}

uint8_t SPI_TransmitReceive(uint8_t *txData, uint8_t *rxData, uint16_t size)
{
    if((txData == NULL) || (rxData == NULL ) || (size == 0U)) {
        return 0;
    }

    uint16_t i;
    for (i=0;i<size;i++) {
        while (!(SPI1->SR & SPI_SR_TXE)) {}
        *((__IO uint8_t*) &(SPI1->DR)) = txData[i];

        while (!(SPI1->SR & SPI_SR_RXNE)) {}
        rxData[i] = SPI1->DR;
    }

    while (!(SPI1->SR & SPI_SR_TXE)) {}
    while (SPI1->SR & SPI_SR_BSY) {}

    __IO uint32_t tmpreg_ovr = 0x00U;
    tmpreg_ovr = SPI1->DR;
    tmpreg_ovr = SPI1->SR;
    UNUSED(tmpreg_ovr);

    return 1;
}