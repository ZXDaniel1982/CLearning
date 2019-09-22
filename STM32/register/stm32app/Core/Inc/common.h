/* Define to prevent recursive inclusion -------------------------------------*/
#ifndef __COMMON_H
#define __COMMON_H

#ifdef __cplusplus
extern "C" {
#endif
    
#include <stdint.h>
#include <stdbool.h>

#include "stm32f103xe.h"

#define VERSION    ((uint32_t) 1)

#define UNUSED(x) (void)x
#define NUM_ROWS(ARRAY) (sizeof(ARRAY) / sizeof(ARRAY[0]))

#define SST_CS_Pin GPIO_BSRR_BS4
#define SST_CS_GPIO_Port GPIOA
#define Key_Pin GPIO_BSRR_BS15
#define Key_GPIO_Port GPIOB
#define Key_EXTI_IRQn EXTI15_10_IRQn
#define LCD_Light_Pin GPIO_BSRR_BS13
#define LCD_Light_GPIO_Port GPIOD
#define Led_Pin GPIO_BSRR_BS5
#define Led_GPIO_Port GPIOB
#define LCD_Rst_Pin GPIO_BSRR_BS1
#define LCD_Rst_GPIO_Port GPIOE
    
#define NVIC_PRIORITYGROUP_0         ((uint32_t)0x00000007) /*!< 0 bit  for pre-emption priority,
                                                                 4 bits for subpriority */
#define NVIC_PRIORITYGROUP_1         ((uint32_t)0x00000006) /*!< 1 bit  for pre-emption priority,
                                                                 3 bits for subpriority */
#define NVIC_PRIORITYGROUP_2         ((uint32_t)0x00000005) /*!< 2 bits for pre-emption priority,
                                                                 2 bits for subpriority */
#define NVIC_PRIORITYGROUP_3         ((uint32_t)0x00000004) /*!< 3 bits for pre-emption priority,
                                                                 1 bit  for subpriority */
#define NVIC_PRIORITYGROUP_4         ((uint32_t)0x00000003) /*!< 4 bits for pre-emption priority,
                                                                 0 bit  for subpriority */
    
#define FLASH_PAGE_SIZE          ( 0x800U )
#define EEPROM_SECTOR_SIZE       ( 4096 )
#define EEPROM_BUF_SIZE          ( 128 )

#define APP_DEFAULT_ADD 0x8005000
typedef  void (*pFunction)(void);
    
typedef enum
{
    IAP_ERROR = 0,
    IAP_SUCCESS,

    IAP_ERROR_HEAD_INVALID,
    IAP_ERROR_FRAME_INVALID,
    IAP_ERROR_CHKSUM_INVALID,
    
    // common
    IAP_CMD_CONNECT,
    IAP_CONNECT_SUCCESS,
    IAP_CONNECT_FAIL,
    
    // flash programming
    IAP_CMD_INIT,
    IAP_INIT_SUCCESS,
    IAP_INIT_FAIL,
    
    IAP_CMD_DEINIT,
    IAP_DEINIT_SUCCESS,
    IAP_DEINIT_FAIL,

    IAP_CMD_ERASE,
    IAP_ERASE_SUCCESS,
    IAP_ERASE_FAIL,

    IAP_CMD_STORE,
    IAP_STORE_SUCCESS,
    IAP_STORE_FAIL,
    IAP_STORE_BUSY,

    IAP_CMD_JUMP,
    IAP_JUMP_SUCCESS,
    IAP_JUMP_FAIL,

    // eeprom programming
    IAP_CMD_VERSION,
    IAP_VERSION_SUCCESS,
    IAP_VERSION_FAIL,

    IAP_CMD_GETINFO,
    IAP_GETINFO_SUCCESS,
    IAP_GETINFO_FAIL,

    IAP_CMD_SETINFO,
    IAP_SETINFO_SUCCESS,
    IAP_SETINFO_FAIL,

    IAP_CMD_BUFFER,
    IAP_BUFFER_SUCCESS,
    IAP_BUFFER_FAIL,

    IAP_CMD_CLEAR,
    IAP_CLEAR_SUCCESS,
    IAP_CLEAR_FAIL,

    IAP_CMD_SAVE,
    IAP_SAVE_SUCCESS,
    IAP_SAVE_FAIL,

    IAP_CMD_REBOOT,
    IAP_REBOOT_SUCCESS,
    IAP_REBOOT_FAIL,
    
    IAP_MAX_COMMAND = 100,
} IAP_COMMANDS;

typedef struct
{
    GPIO_TypeDef *port;
    uint32_t pin;
    uint32_t clear;
    uint32_t set;
} GPIO_PINS_t;

typedef struct
{
    uint16_t header;
    uint16_t update;
    uint32_t size;
    uint16_t tail;
} IapInfo_t;

// GPIO
void GPIO_Init(void);
void GPIOxL_Init(GPIO_TypeDef *GPIOx, uint32_t pin, uint32_t clear, uint32_t set);
void GPIOxH_Init(GPIO_TypeDef *GPIOx, uint32_t pin, uint32_t clear, uint32_t set);

// TIMER
void TIMER_Init(void);

// USART1
void USART_Init(void);
void USART_SendData(uint8_t *data, uint16_t len);

// FLASH
void FLASH_Lock(void);
void FLASH_Unlock(void);
bool FLASH_WaitForFinish(void);
void FLASH_Erase(uint32_t Add);
bool FLASH_Program(uint8_t *dest, uint8_t *src, uint32_t len);

// SPI
void SPI_Init(void);
uint8_t SPI_Transmit(uint8_t *data, uint16_t size);
uint8_t SPI_TransmitReceive(uint8_t *txData, uint8_t *rxData, uint16_t size);

// EEPROM
void EEPROM_Init(void);
void EEProm_SectorErrase(uint32_t addr);
void EEPROM_Write(uint32_t addr, uint8_t * buf, uint16_t len);
void EEPROM_Read(uint32_t addr, uint8_t *buf, uint16_t len);

// FSMC
void FSMC_Init(void);

// LCD
void LCD_Init(void);
void tftprintf(const char* fmt, ...);

// RTC
void RTC_Init(void);

// ADC
void ADC_Init(void);

// SD
void SDIOEx_Init(void);
void SD_Init(void);

// Interrupt
void TIM1_UP_IRQHandler(void);
void TIM2_IRQHandler(void);
void TIM3_IRQHandler(void);
void TIM4_IRQHandler(void);
void TIM5_IRQHandler(void);
void TIM6_IRQHandler(void);
void TIM7_IRQHandler(void);
void TIM8_UP_IRQHandler(void);
void USART1_IRQHandler(void);

// error
void Error_Handle(void);

extern uint8_t SST25_buffer[EEPROM_BUF_SIZE];
extern uint8_t SST25_vbuffer[EEPROM_BUF_SIZE];
    
#ifdef __cplusplus
}
#endif

#endif /* __COMMON_H */

/************************ (C) COPYRIGHT STMicroelectronics *****END OF FILE****/
