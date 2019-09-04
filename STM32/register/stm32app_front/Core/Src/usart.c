#include <stdio.h>
#include <stddef.h>
#include <string.h>

#include "stm32f1xx.h"
#include "stm32f103xe.h"
#include "common.h"

#define USART_MAX_LEN 255
#define USART_PROTOCOL_LEN 20

uint8_t txBuf[USART_PROTOCOL_LEN] = {0};
uint8_t rxBuf[USART_MAX_LEN] = {0};
uint8_t rxCnt = 0;

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

    NVIC_SetPriority(USART1_IRQn, NVIC_EncodePriority(NVIC_GetPriorityGrouping(),0, 0));
    NVIC_EnableIRQ(USART1_IRQn);

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

static uint32_t IAP_CONV_TO_32(uint8_t *buf)
{
    uint32_t ret = 0;
    ret = (*buf) << 24;
    ret += *(buf+1) << 16;
    ret += *(buf+2) << 8;
    ret += *(buf+3);
    return ret;
}

static void IAP_SendReply(uint8_t replyType, uint8_t replyDetail)
{
    memset(txBuf, 0, USART_PROTOCOL_LEN);
    txBuf[0] = 0x33;
    txBuf[1] = 0x44;
    txBuf[2] = replyType;
    txBuf[3] = replyDetail;

    USART_SendData(txBuf,USART_PROTOCOL_LEN);
}

static uint8_t IAP_HeaderIsValid(uint8_t* Buf)
{
    if (Buf == NULL) return 0;

    if ((Buf[0] != 0x22) || (Buf[1] != 0x33)) {
        return 0;
    }

    return 1;
}

static uint8_t IAP_ChecksumIsValid(uint8_t* Buf)
{
    uint8_t i;
    uint16_t RxChksum = 0;
    uint16_t Checksum = 0;
    
    if (Buf == NULL) return 0;
    
    Checksum = Buf[16] * 256 + Buf[17];
    for (i=0;i<(USART_PROTOCOL_LEN-4);i++) {
        RxChksum += Buf[i];
    }
        
    if (Checksum == RxChksum) return 1;
    else return 0;
}

static void IAP_Connect(uint8_t *Buf)
{
    if (Buf == NULL) {
        IAP_SendReply(IAP_ERROR, IAP_CONNECT_FAIL);
        return;
    }
    
    if (Buf[0] != IAP_CMD_CONNECT) {
        return;
    }
    
    IAP_SendReply(IAP_SUCCESS, IAP_CONNECT_SUCCESS);
}

static void IAP_SetJump(uint8_t *Buf)
{
    uint32_t filesize = 0;
    
    if (Buf == NULL) {
        IAP_SendReply(IAP_ERROR, IAP_SETJUMP_FAIL);
        return;
    }
    
    if (Buf[0] != IAP_CMD_SETJUMP) {
        return;
    }
    
    filesize = IAP_CONV_TO_32(&Buf[1]);
    EEPROM_SetJump(filesize);
    IAP_SendReply(IAP_SUCCESS, IAP_SETJUMP_SUCCESS);

    NVIC_SystemReset();
}

static void IAP_Buffer(uint8_t *Buf)
{
    uint32_t index = 0;
    
    if (Buf == NULL) {
        IAP_SendReply(IAP_ERROR, IAP_BUFFER_FAIL);
        return;
    }
    
    if (Buf[0] != IAP_CMD_BUFFER) {
        return;
    }
    
    index = IAP_CONV_TO_32(&Buf[1]);
    EEPROM_Buffer(index, &Buf[5], 4);
    IAP_SendReply(IAP_SUCCESS, IAP_BUFFER_SUCCESS);
}

static void IAP_Save(uint8_t *Buf)
{
    uint32_t index = 0;
    
    if (Buf == NULL) {
        IAP_SendReply(IAP_ERROR, IAP_SAVE_FAIL);
        return;
    }
    
    if (Buf[0] != IAP_CMD_SAVE) {
        return;
    }
    
    index = IAP_CONV_TO_32(&Buf[1]);
    if (EEPROM_Save(index)) {
        IAP_SendReply(IAP_SUCCESS, IAP_SAVE_SUCCESS);
    } else {
        IAP_SendReply(IAP_SUCCESS, IAP_SAVE_SUCCESS);
    }
}

static void IAP_Reboot(uint8_t* Buf)
{
    if (Buf == NULL) {
        IAP_SendReply(IAP_ERROR, IAP_REBOOT_FAIL);
        return;
    }

    if (Buf[0] != IAP_CMD_REBOOT) {
        return;
    }

    IAP_SendReply(IAP_SUCCESS, IAP_SUCCESS_REBOOT);

    NVIC_SystemReset();
}

static void USART_DataProcess(uint8_t *Buf)
{
    if (IAP_HeaderIsValid(Buf) == 0) {
        IAP_SendReply(IAP_ERROR, IAP_ERROR_HEAD_INVALID);
        return;
    }
        
    if (IAP_ChecksumIsValid(Buf) == 0) {
        IAP_SendReply(IAP_ERROR, IAP_ERROR_CHKSUM_INVALID);
        return;
    }

    IAP_Connect(&Buf[2]);
    IAP_Reboot(&Buf[2]);
    IAP_SetJump(&Buf[2]);
    IAP_Buffer(&Buf[2]);
    IAP_Save(&Buf[2]);
}

static void USART_RxProcess(uint8_t val)
{
    if (rxCnt >= USART_MAX_LEN) {
        memset(rxBuf, 0, USART_MAX_LEN);
        rxCnt = 0;
    }
    
    rxBuf[rxCnt] = val;
    rxCnt++;
        
    if (rxCnt >= 2) {
        if ((rxBuf[rxCnt-2] == 0x44) && (rxBuf[rxCnt-1] == 0x55)) {
            if (rxCnt >= USART_PROTOCOL_LEN) {
                USART_DataProcess(&rxBuf[rxCnt-USART_PROTOCOL_LEN]);
            } else {
                IAP_SendReply(IAP_ERROR, IAP_INCOMPLETE_FRAME);
            }
            memset(rxBuf, 0, USART_MAX_LEN);
            rxCnt = 0;
        }
    }
        
    if (rxCnt >= USART_MAX_LEN) {
        memset(rxBuf, 0, USART_MAX_LEN);
        rxCnt = 0;
    }
}

void USART_SendData(uint8_t *data, uint16_t len)
{
    uint16_t i;
    
    for (i=0;i<len;i++) {
        while ((USART1->SR &USART_SR_TXE) == 0) {}
        USART1->DR= data[i];
    }
}

void USART1_IRQHandler(void)
{
    uint8_t buf;
    if((USART1->SR & USART_CR1_RXNEIE) != 0) {
        buf = USART1->DR;
        USART_RxProcess(buf);
    }
}
