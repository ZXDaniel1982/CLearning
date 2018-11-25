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

#define IAP_MAX_COMMAND_NUM 2

#define IAP_FLASH_PRG_ADDR 0x08004000

#define IAP_FLASH_FLG_ADDR 0x0807f800
#define IAP_FLASH_FLG_DATA 0xaaaa5555

void IAP_Init(void);
void IAP_Flash(void);
void IAP_Process(void);

#endif /* __IAP_H__ */
