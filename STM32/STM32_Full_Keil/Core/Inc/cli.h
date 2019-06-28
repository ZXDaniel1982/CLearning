#ifndef __cli_H
#define __cli_H
#ifdef __cplusplus
 extern "C" {
#endif

#include "main.h"
#include "cmsis_os.h"
#include "eeprom.h"
#include "sdio.h"
	 
enum CLI_COMMAND {
	INVALID_CLI_COMMAND = 0,
  READ_EEPROM_INFO = 1,
	READ_SD_FILE_LIST,
	MAX_CLI_COMMAND
};

typedef void (*func_t)(void *arg);

typedef struct qCliCommand_t{
  uint16_t index;
	func_t   func;
} CliCommand_t;

#define ARRY_NUM(x) ((sizeof(x)) / (sizeof(x[0])))
#define ISVALID(x) (((x)>INVALID_CLI_COMMAND)&&((x)<MAX_CLI_COMMAND))

#define BLANK_STR "\r\n"
	 
extern osMessageQId CliQueueHandle;

void Cli_Init(void);

#ifdef __cplusplus
}
#endif
#endif /*__cli_H */
