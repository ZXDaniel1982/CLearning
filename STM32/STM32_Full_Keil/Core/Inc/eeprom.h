#ifndef __eeprom_H
#define __eeprom_H
#ifdef __cplusplus
 extern "C" {
#endif

#include "main.h"
#include "cmsis_os.h"
	 
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

void cliShowEEPROMInfo(void *arg);
uint8_t EEPROMIsValid(void);
uint8_t IAP_GotoBackup(void);

extern eepInfo_t eepInfo;
extern uint8_t SST25_buffer[4096];

#ifdef __cplusplus
}
#endif
#endif /*__eeprom_H */
