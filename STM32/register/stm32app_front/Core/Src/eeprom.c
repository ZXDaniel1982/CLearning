#include <stdio.h>
#include <stddef.h>
#include <string.h>

#include "stm32f1xx.h"
#include "stm32f103xe.h"
#include "common.h"

/*
 *   Remember how to use it
 *
 *   unsigned char SST25_buffer[4096];
 *   SST25_W_BLOCK(0, SST25_buffer,4096);  //将册数数据写入到SST25VF016B的0页里
 *   SST25_R_BLOCK(0, SST25_buffer,4096);  //从SST25VF016B的0页里读出数据
 */

/* Select SPI FLASH: ChipSelect pin low  */
#define Select_Flash()     MODIFY_REG(SST_CS_GPIO_Port->ODR, SST_CS_Pin, 0)
/* Deselect SPI FLASH: ChipSelect pin high */
#define NotSelect_Flash()  MODIFY_REG(SST_CS_GPIO_Port->ODR, SST_CS_Pin, SST_CS_Pin)

static void wip(void);
static void wsr(void);
static void wen(void);
static void wdis(void);
static uint8_t rdsr(void);
static uint16_t SPI_Flash_ReadID(void);
static void EEPRom_SendByte(uint8_t byte);
static void EEProm_SectorErrase(unsigned long a1);
static void SST25_W_BLOCK(uint32_t addr, uint8_t * readbuff,
              uint16_t BlockSize);

uint8_t SST25_buffer[4096];
uint8_t SST25_buffer_valid[4096];
/*----------------------------------------------------------------------------*/
/* Private functions                                                           */
/*----------------------------------------------------------------------------*/
static void EEPRom_SendByte(uint8_t byte)
{
    uint8_t val = byte;
    SPI_Transmit(&val, 1);
}

static uint16_t SPI_Flash_ReadID(void)
{
    uint8_t Temp = 0;
    uint8_t Ret = 0;
    uint16_t id = 0;
    Select_Flash();

    //????ID??    
    Temp = 0xAB;
    SPI_TransmitReceive(&Temp, &Ret, 1);

    Temp = 0x00;
    SPI_TransmitReceive(&Temp, &Ret, 1);

    Temp = 0x00;
    SPI_TransmitReceive(&Temp, &Ret, 1);

    Temp = 0x00;
    SPI_TransmitReceive(&Temp, &Ret, 1);

    //?????16??    
    Temp = 0xFF;
    SPI_TransmitReceive(&Temp, &Ret, 1);
    id = ((uint16_t) Ret) << 8;

    Temp = 0xFF;
    SPI_TransmitReceive(&Temp, &Ret, 1);
    id += (uint16_t) Ret;

    NotSelect_Flash();

    return id;
}

static uint8_t rdsr(void)
{
    uint8_t busy;

    Select_Flash();
    EEPRom_SendByte(0x05);
    SPI_TransmitReceive(&busy, &busy, 1);
    NotSelect_Flash();
    return (busy);
}

static void wip(void)
{
    uint8_t a = 1;
    while ((a & 0x01) == 1) a = rdsr();
}

static void wsr(void)
{
    Select_Flash();
    EEPRom_SendByte(0x50);
    NotSelect_Flash();

    Select_Flash();
    EEPRom_SendByte(0x01);
    EEPRom_SendByte(0x00);
    NotSelect_Flash();

    wip();
}

static void wen(void)
{
    Select_Flash();
    EEPRom_SendByte(0x06);
    NotSelect_Flash();
}

static void EEProm_SectorErrase(unsigned long a1)
{
    wsr();
    wen();

    Select_Flash();
    EEPRom_SendByte(0x20);
    EEPRom_SendByte((uint8_t) ((a1 & 0xffffff) >> 16)); //addh
    EEPRom_SendByte((uint8_t) ((a1 & 0xffff) >> 8));    //addl 
    EEPRom_SendByte((uint8_t) (a1 & 0xff)); //wtt
    NotSelect_Flash();

    wip();
}

static void wdis(void)
{
    Select_Flash();
    EEPRom_SendByte(0x04);
    NotSelect_Flash();

    wip();
}

static void SST25_W_BLOCK(uint32_t addr, uint8_t * readbuff,
              uint16_t BlockSize)
{
    uint16_t i = 0, a2;

    EEProm_SectorErrase(addr);  //删除页       
    wsr();
    wen();
    Select_Flash();
    EEPRom_SendByte(0xad);
    EEPRom_SendByte((uint8_t) ((addr & 0xffffff) >> 16));
    EEPRom_SendByte((uint8_t) ((addr & 0xffff) >> 8));
    EEPRom_SendByte((uint8_t) (addr & 0xff));
    EEPRom_SendByte(readbuff[0]);
    EEPRom_SendByte(readbuff[1]);
    NotSelect_Flash();

    i = 2;
    while (i < BlockSize) {
        a2 = 120;
        while (a2 > 0) a2--;

        Select_Flash();
        EEPRom_SendByte(0xad);
        EEPRom_SendByte(readbuff[i]);
        i++;
        EEPRom_SendByte(readbuff[i]);
        i++;
        NotSelect_Flash();
    }

    a2 = 100;
    while (a2 > 0) a2--;

    wdis();
    Select_Flash();
    wip();
}

static void SST25_R_BLOCK(unsigned long addr, unsigned char *readbuff,
              unsigned int BlockSize)
{
    uint16_t i = 0;

    Select_Flash();
    EEPRom_SendByte(0x0b);
    EEPRom_SendByte((uint8_t) ((addr & 0xffffff) >> 16));
    EEPRom_SendByte((uint8_t) ((addr & 0xffff) >> 8));
    EEPRom_SendByte((uint8_t) (addr & 0xff));
    EEPRom_SendByte(0);

    while (i < BlockSize) {
        SPI_TransmitReceive(&(readbuff[i]), &(readbuff[i]), 1);
        i++;
    }
    NotSelect_Flash();
}

/*----------------------------------------------------------------------------*/
/* Public functions                                                           */
/*----------------------------------------------------------------------------*/
#define EEPROM_ID 0x4f90
#define IAP_HEADER 0x2233
#define IAP_TAIL 0x4455
#define IAP_IDLE 0
#define IAP_JUMP 1

void EEPROM_Init()
{
    uint8_t dummyRead;
    uint16_t id;
    uint32_t delayCnt;
    for (dummyRead=0;dummyRead<5;++dummyRead) {
        for (delayCnt=0;delayCnt<7200000;++delayCnt) {}
        id = SPI_Flash_ReadID();
    }

    if (EEPROM_ID != id) {
        return;
    }
}

void EEPROM_Buffer(uint32_t index, uint8_t *data, uint16_t Len)
{
    memcpy(&SST25_buffer[index], data, Len);
}

uint8_t EEPROM_Save(uint32_t index)
{
    uint8_t retry;
    for (retry=0;retry<5;++retry) {
        SST25_W_BLOCK(index, SST25_buffer, 4096);
        SST25_R_BLOCK(index, SST25_buffer_valid, 4096);

        if (memcmp(SST25_buffer, SST25_buffer_valid, 4096) == 0) {
            memset(SST25_buffer, 0xff, 4096);
            return 1;
        }
    }

    memset(SST25_buffer, 0xff, 4096);
    return 0;
}

void EEPROM_SetJump(uint32_t filesize)
{
    IAP_Info_t IAP_Info;

    memset(SST25_buffer, 0xff, 4096);

    IAP_Info.header = IAP_HEADER;
    IAP_Info.tail = IAP_TAIL;
    IAP_Info.cmd = IAP_JUMP;
    IAP_Info.size = filesize;
    memcpy(SST25_buffer, &IAP_Info, sizeof(IAP_Info_t));

    uint8_t retry;
    for (retry=0;retry<5;++retry) {
        SST25_W_BLOCK(0, SST25_buffer, 4096);
        SST25_R_BLOCK(0, SST25_buffer_valid, 4096);

        if (memcmp(SST25_buffer, SST25_buffer_valid, 4096) == 0) {
            memset(SST25_buffer, 0xff, 4096);
            break;
        }
    }
}
