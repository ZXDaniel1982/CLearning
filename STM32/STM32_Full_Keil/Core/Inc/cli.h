#ifndef __cli_H
#define __cli_H
#ifdef __cplusplus
 extern "C" {
#endif

#include "main.h"
#include "cmsis_os.h"
	 
extern osMessageQId CliQueueHandle;

void Cli_Init(void);

#ifdef __cplusplus
}
#endif
#endif /*__cli_H */
