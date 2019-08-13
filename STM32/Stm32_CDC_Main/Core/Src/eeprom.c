/*
 *   Remember how to use it
 *
 *   unsigned char SST25_buffer[4096];
 *   SST25_W_BLOCK(0, SST25_buffer,4096);  //????????SST25VF016B?0??
 *   SST25_R_BLOCK(0, SST25_buffer,4096);  //?SST25VF016B?0??????
 */

/* Includes ------------------------------------------------------------------*/
#include <string.h>
#include <stdlib.h>

//#include "lcd.h"
#include "spi.h"
//#include "usart.h"
//#include "fatfs.h"
#include "eeprom.h"
//#include "cmsis_os.h"
//#include "FreeRTOS.h"

/* Select SPI FLASH: ChipSelect pin low  */
#define Select_Flash()     HAL_GPIO_WritePin(SST_CS_GPIO_Port, SST_CS_Pin, GPIO_PIN_RESET);
/* Deselect SPI FLASH: ChipSelect pin high */
#define NotSelect_Flash()    HAL_GPIO_WritePin(SST_CS_GPIO_Port, SST_CS_Pin, GPIO_PIN_SET);

uint8_t SST25_buffer[4096];
eepInfo_t eepInfo;

static void wip(void);
static void wsr(void);
static void wen(void);
static void wdis(void);
static uint8_t rdsr(void);
static uint16_t SPI_Flash_ReadID(void);
static void EEPRom_SendByte(uint8_t byte);
static void EEProm_SectorErrase(unsigned long a1);

/*----------------------------------------------------------------------------*/
/* Private functions                                                           */
/*----------------------------------------------------------------------------*/
static void EEPRom_SendByte(uint8_t byte)
{
    uint8_t val = byte;
    HAL_SPI_Transmit(&hspi1, &val, 1, 100);
}

static uint16_t SPI_Flash_ReadID(void)
{
    uint8_t Temp = 0;
    uint8_t Ret = 0;
    uint16_t id = 0;
    Select_Flash();

    //????ID??    
    Temp = 0xAB;
    HAL_SPI_TransmitReceive(&hspi1, &Temp, &Ret, 1, 1000);

    Temp = 0x00;
    HAL_SPI_TransmitReceive(&hspi1, &Temp, &Ret, 1, 1000);

    Temp = 0x00;
    HAL_SPI_TransmitReceive(&hspi1, &Temp, &Ret, 1, 1000);

    Temp = 0x00;
    HAL_SPI_TransmitReceive(&hspi1, &Temp, &Ret, 1, 1000);

    //?????16??    
    Temp = 0xFF;
    HAL_SPI_TransmitReceive(&hspi1, &Temp, &Ret, 1, 1000);
    //uartprintf("High value is %x\r\n", Ret);
    //id = ((uint16_t) Ret) << 8;

    Temp = 0xFF;
    HAL_SPI_TransmitReceive(&hspi1, &Temp, &Ret, 1, 1000);
    //uartprintf("Low value is %x\r\n", Ret);
    //id += (uint16_t) Ret;

    NotSelect_Flash();

    return id;
}

static uint8_t rdsr(void)
{
    uint8_t busy;

    Select_Flash();
    EEPRom_SendByte(0x05);
    HAL_SPI_Receive(&hspi1, &busy, 1, 300);
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

void SST25_W_BLOCK(uint32_t addr, uint8_t * readbuff,
              uint16_t BlockSize)
{
    uint16_t i = 0, a2;

    EEProm_SectorErrase(addr);  //???       
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

void SST25_R_BLOCK(unsigned long addr, unsigned char *readbuff,
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
        HAL_SPI_Receive(&hspi1, &(readbuff[i]), 1, 300);
        i++;
    }
    NotSelect_Flash();
}

/*----------------------------------------------------------------------------*/
/* Public functions                                                           */
/*----------------------------------------------------------------------------*/
#define SST25VF016B_ID 0xBF41
uint8_t EEPROMIsValid()
{
    if (SST25VF016B_ID == SPI_Flash_ReadID()) return 1;
    else return 0;
}

uint8_t EEPROMGetInfo(eepInfo_t *info)
{
    if (info == NULL) return 0;

    SST25_R_BLOCK(1, (unsigned char *)info, sizeof(eepInfo_t));

    if (info->id == 0xab) return 1;
    else return 0;
}
