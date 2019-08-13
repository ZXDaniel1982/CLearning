#ifndef __eeprom_H
#define __eeprom_H
#ifdef __cplusplus
 extern "C" {
#endif

#include "main.h"

typedef struct
{
	uint8_t needUpdate;
	uint32_t size;
} appInfo_t;

typedef struct
{
	uint8_t id;
	uint8_t active;
	appInfo_t info[2];
} eepInfo_t;

uint8_t EEPROMIsValid(void);
uint8_t EEPROMGetInfo(eepInfo_t *info);
void SST25_W_BLOCK(uint32_t addr, uint8_t * readbuff,
              uint16_t BlockSize);
void SST25_R_BLOCK(unsigned long addr, unsigned char *readbuff,
              unsigned int BlockSize);

extern eepInfo_t eepInfo;
extern uint8_t SST25_buffer[4096];

#ifdef __cplusplus
}
#endif
#endif /*__eeprom_H */
