/* Define to prevent recursive inclusion -------------------------------------*/
#ifndef __COMMON_H
#define __COMMON_H

#ifdef __cplusplus
extern "C" {
#endif
	
#include <stdint.h>
#include <stdbool.h>

#define SST_CS_Pin LL_GPIO_PIN_4
#define SST_CS_GPIO_Port GPIOA
#define Led_Pin GPIO_BSRR_BS5
#define Led_GPIO_Port GPIOB
	
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
	
#define FLASH_PAGE_SIZE          0x800U

#define APP_DEFAULT_ADD 0x8005000
typedef  void (*pFunction)(void);
	
typedef enum
{
    IAP_ERROR = 0,
    IAP_SUCCESS,

    IAP_ERROR_HEAD_INVALID,
	
	IAP_CONNECT_FAIL,
	IAP_CMD_CONNECT,
	IAP_CONNECT_SUCCESS,
	
	IAP_INIT_FAIL,
	IAP_CMD_INIT,
	IAP_INIT_SUCCESS,
	
	IAP_DEINIT_FAIL,
	IAP_CMD_DEINIT,
	IAP_DEINIT_SUCCESS,

    IAP_ERASE_FAIL,
    IAP_CMD_ERASE,
    IAP_SUCCESS_ERASE,

    IAP_STORE_FAIL,
    IAP_STORE_BUSY,
    IAP_SUCCESS_STORE,
    IAP_CMD_STORE,

    IAP_REBOOT_FAIL,
    IAP_SUCCESS_REBOOT,
    IAP_CMD_REBOOT,
	
	IAP_JUMP_FAIL,
    IAP_SUCCESS_JUMP,
    IAP_CMD_JUMP,
	
	IAP_INCOMPLETE_FRAME,
	IAP_ERROR_CHKSUM_INVALID,

  IAP_MAX_COMMAND = 100,
} IAP_COMMANDS;

// GPIO
void GPIO_Init(void);

// USART1
void USART_Init(void);
void USART_SendData(uint8_t *data, uint16_t len);

// FLASH
void FLASH_Lock(void);
void FLASH_Unlock(void);
bool FLASH_WaitForFinish(void);
void USART_RxProcess(uint8_t val);
	
#ifdef __cplusplus
}
#endif

#endif /* __COMMON_H */

/************************ (C) COPYRIGHT STMicroelectronics *****END OF FILE****/
