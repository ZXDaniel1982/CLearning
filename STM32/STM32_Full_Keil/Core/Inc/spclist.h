#ifndef __spc_list_H
#define __spc_list_H
#ifdef __cplusplus
 extern "C" {
#endif

#include "main.h"

// List
#define SPC_MAX_LIST    ( 20 )
typedef void (*pfnDelete)(SpcAlarmType_t alarmType);
typedef void (*pfnAdd)(SpcAlarmType_t alarmType);
struct xSpcItem_t
{
    SpcAlarmType_t alarmType;
    bool alarmPrio;
    pfnDelete delfunc;
    pfnAdd addfunc;
    struct xSpcItem_t *next;
};
typedef struct xSpcItem_t SpcItem_t;

typedef struct
{
    uint8_t totalNum;
    uint8_t maxSize;
    SpcItem_t item;
} SpcList_t;

void SpcListInit(SpcList_t * list, uint8_t size);
SpcStatus_t SpcListInsert(SpcList_t * list, SpcItem_t *itemToAdd);
SpcStatus_t SpcListRemove(SpcList_t * list, SpcAlarmType_t alarmType);

#ifdef __cplusplus
}
#endif
#endif /*__spc_list_H */
