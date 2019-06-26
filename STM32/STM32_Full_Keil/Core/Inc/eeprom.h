#ifndef __eeprom_H
#define __eeprom_H
#ifdef __cplusplus
 extern "C" {
#endif

#include "main.h"
#include "cmsis_os.h"

void EEPRom_Init(void);
void cliShowEEPROMInfo(void *arg);

#ifdef __cplusplus
}
#endif
#endif /*__eeprom_H */
