#ifndef __COMMON_H__
#define __COMMON_H__

#ifdef __cplusplus
 extern "C" {
#endif

#define IAP_RETRY_MAX 10

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

  IAP_MAX_COMMAND = 100,
} IAP_COMMANDS;

int set_interface_attribs (int fd, int speed, int parity);
void set_blocking (int fd, int should_block);

#ifdef __cplusplus
}
#endif

#endif /* __COMMON_H__ */

/************************ (C) COPYRIGHT STMicroelectronics *****END OF FILE****/
