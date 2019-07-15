#ifndef __spc_list_H
#define __spc_list_H
#ifdef __cplusplus
 extern "C" {
#endif

#include "main.h"

// List
#define SPC_MAX_LIST    ( 20 )

void SpcListInit(SpcList_t * list, uint8_t size);

#ifdef __cplusplus
}
#endif
#endif /*__spc_list_H */
