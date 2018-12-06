/**
  ******************************************************************************
  * @file           : iap.h
  * @brief          : Header for iap.c file.
  *                   This file contains the common defines of the application.
  */

#ifndef __IAP_H__
#define __IAP_H__

#define IAP_INIT_MSG "Start testing flash function\r\n"
#define IAP_TIMEOUT 100

#define IAP_MAX_COMMAND_NUM 3

#define IAP_FLASH_PRG_ADDR 0x08004000
#define IAP_FLASH_PRG_SIZE 2048

#define IAP_FLASH_WRITE_BYTES 8

typedef enum
{
    IAP_ERR_NONE = 0,
    IAP_ERR_INIT,
    IAP_ERR_PRG,
    IAP_ERR_VALID
} IAP_ERR_t;

typedef  void (*pFunction)(void);

//void IAP_Flash(void);
uint16_t IAP_Process(void);

#endif /* __IAP_H__ */
