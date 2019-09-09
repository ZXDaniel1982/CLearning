#ifndef __COMMON_H__
#define __COMMON_H__

#ifdef __cplusplus
 extern "C" {
#endif

#define IAP_RETRY_MAX            ( 10 )
#define FLASH_PAGE_SIZE          ( 0x800U )
#define EEPROM_SECTOR_SIZE       ( 4096 )
#define EEPROM_BUF_SIZE          ( 128 )

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

/*typedef enum
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
} IAP_COMMANDS;*/

typedef struct
{
    uint16_t header;
    uint16_t update;
    uint32_t size;
    uint16_t tail;
} IapInfo_t;

int set_interface_attribs (int fd, int speed, int parity);
void set_blocking (int fd, int should_block);

#ifdef __cplusplus
}
#endif

#endif /* __COMMON_H__ */

/************************ (C) COPYRIGHT STMicroelectronics *****END OF FILE****/
