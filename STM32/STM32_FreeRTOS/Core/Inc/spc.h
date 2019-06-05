#ifndef __spc_H
#define __spc_H
#ifdef __cplusplus
 extern "C" {
#endif

#include "main.h"
#include "cmsis_os.h"

extern osMessageQId myQueue01Handle;
extern osTimerId sTimer;

void SpcMainLoop(void const * argument);

#ifdef __cplusplus
}
#endif
#endif /*__spc_H */
