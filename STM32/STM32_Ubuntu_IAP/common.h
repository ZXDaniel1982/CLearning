#ifndef __COMMON_H__
#define __COMMON_H__

#ifdef __cplusplus
 extern "C" {
#endif

#define CDC_LEN_ERASE ( 9 )
#define CDC_LEN_STORE ( 9 + 512 )
#define CDC_LEN_GET_INFO ( 5 )
#define CDC_LEN_REBOOT ( 5 )

typedef enum
{
  CDC_ERROR = 0,
  CDC_SUCCESS,

  CDC_ERROR_HEAD_INVALID,
  CDC_ERROR_LEN_INVALID,

  CDC_ERASE_FAIL,
  CDC_CMD_ERASE,
  CDC_SUCCESS_ERASE,

  CDC_STORE_FAIL,
  CDC_STORE_BUSY,
  CDC_SUCCESS_STORE,
  CDC_CMD_STORE,

  CDC_GET_INFO_FAIL,
  CDC_SUCCESS_GET_INFO,
  CDC_CMD_GET_INFO,

  CDC_SET_INFO_FAIL,
  CDC_SUCCESS_SET_INFO,
  CDC_CMD_SET_INFO,

  CDC_REBOOT_FAIL,
  CDC_SUCCESS_REBOOT,
  CDC_CMD_REBOOT,

  CDC_MAX_COMMAND = 100,
} CDC_COMMANDS;

typedef struct
{
	uint8_t needUpdate;
	uint32_t size;
} appInfo_t;

typedef struct
{
  uint8_t id;
  uint8_t active;
  uint8_t current;
  appInfo_t info[2];
} eepInfo_t;

#ifdef __cplusplus
}
#endif

#endif /* __COMMON_H__ */

/************************ (C) COPYRIGHT STMicroelectronics *****END OF FILE****/
