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
        
    SET_BIT(USART1->CR1, USART_CR1_UE);
    SET_BIT(USART1->CR1, (USART_CR1_RXNEIE | USART_CR1_PEIE));
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

static void IAP_EraseProcess(uint32_t Add)
{
    /*if (!FLASH_WaitForFinish()) {
        IAP_SendReply(IAP_ERROR, IAP_ERASE_FAIL);
        return;
    }*/
            
    SET_BIT(FLASH->CR, FLASH_CR_PER);
    WRITE_REG(FLASH->AR, Add);
    SET_BIT(FLASH->CR, FLASH_CR_STRT);
    
    while (FLASH->SR & FLASH_SR_BSY) {}
        
    /*if (!FLASH_WaitForFinish()) {
        IAP_SendReply(IAP_ERROR, IAP_ERASE_FAIL);
        return;
    }*/
        
    CLEAR_BIT(FLASH->CR, FLASH_CR_PER);
    IAP_SendReply(IAP_SUCCESS, IAP_SUCCESS_ERASE);
}

static void IAP_StoreProcess(uint8_t *dest, uint8_t *src)
{
    uint32_t Add = (uint32_t) (dest);
    uint64_t Data = *(uint32_t *) (src);
    uint8_t i;
    
    /*if (!FLASH_WaitForFinish()) {
        IAP_SendReply(IAP_ERROR, IAP_ERASE_FAIL);
        return;
    }*/
        
    for (i=0;i<2;i++) {
        SET_BIT(FLASH->CR, FLASH_CR_PG);
        *(__IO uint16_t*) (Add + 2u * i) = (uint16_t) (Data >> (16u * i));
    }
    
    /*if (!FLASH_WaitForFinish()) {
        IAP_SendReply(IAP_ERROR, IAP_ERASE_FAIL);
        return;
    }*/
    
    CLEAR_BIT(FLASH->CR, FLASH_CR_PG);
    
    if (*(uint32_t *) (src) != *(uint32_t *) (dest)) {
        IAP_SendReply(IAP_ERROR, IAP_STORE_FAIL);
        return;
    }
    
    IAP_SendReply(IAP_SUCCESS, IAP_SUCCESS_STORE);
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

static void IAP_Init(uint8_t *Buf)
{
    if (Buf == NULL) {
        IAP_SendReply(IAP_ERROR, IAP_INIT_FAIL);
        return;
    }
    
    if (Buf[0] != IAP_CMD_INIT) {
        return;
    }
    
    //FLASH_Unlock();
    IAP_SendReply(IAP_SUCCESS, IAP_INIT_SUCCESS);
}

static void IAP_DeInit(uint8_t *Buf)
{
    if (Buf == NULL) {
        IAP_SendReply(IAP_ERROR, IAP_DEINIT_FAIL);
        return;
    }
    
    if (Buf[0] != IAP_CMD_DEINIT) {
        return;
    }
    
    //FLASH_Lock();
    IAP_SendReply(IAP_SUCCESS, IAP_DEINIT_SUCCESS);
}

static void IAP_Erase(uint8_t *Buf)
{
    uint32_t addr;
    
    if (Buf == NULL) {
        IAP_SendReply(IAP_ERROR, IAP_ERASE_FAIL);
        return;
    }
    
    if (Buf[0] != IAP_CMD_ERASE) {
        return;
    }
    
    addr = IAP_CONV_TO_32(&Buf[1]);
    IAP_EraseProcess(addr);
}

static void IAP_Store(uint8_t *Buf)
{
    uint8_t *src = NULL;
    
    if (Buf == NULL) {
        IAP_SendReply(IAP_ERROR, IAP_STORE_FAIL);
        return;
    }
    
    if (Buf[0] != IAP_CMD_STORE) {
        return;
    }
    
    src = (uint8_t *)IAP_CONV_TO_32(&Buf[1]);
    IAP_StoreProcess(src, &Buf[5]);
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

static void USART_Jump()
{

}

static void IAP_Jump(uint8_t* Buf)
{
    if (Buf == NULL) {
        IAP_SendReply(IAP_ERROR, IAP_JUMP_FAIL);
        return;
    }

    if (Buf[0] != IAP_CMD_JUMP) {
        return;
    }

    IAP_SendReply(IAP_SUCCESS, IAP_SUCCESS_JUMP);
        
    USART_Jump();
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
    IAP_Init(&Buf[2]);
    IAP_DeInit(&Buf[2]);
    IAP_Erase(&Buf[2]);
    IAP_Store(&Buf[2]);
    IAP_Reboot(&Buf[2]);
    IAP_Jump(&Buf[2]);
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
        UNUSED(USART_RxProcess);
        while ((USART1->SR &USART_SR_TXE) == 0) {}
        USART1->DR= buf;
    }
}
