#ifndef __spc_list_H
#define __spc_list_H
#ifdef __cplusplus
 extern "C" {
#endif

#include "main.h"
#include "spclist.h"

#define SpcAlarmEn        ( SPC_NORMAL )
#define SpcAlarmDis       ( SPC_ERROR )
#define SpcAlarmCritical  ( SPC_NORMAL )
#define SpcAlarmNormal    ( SPC_ERROR )

#define SpcAlarmMask(x)   ( 1 << (x) )
typedef enum
{
    SPC_ALARM_SELFCHKFAIL = 0,
    SPC_MAX_ALARM_TYPE
} SpcAlarmType_t;

typedef struct
{
    SpcAlarmType_t type;
    bool prio;
} SpcAlarmTable_t;

typedef struct
{
    uint32_t alarmMask;
    SpcList_t alarmList;
} SpcAlarm_t;

void Spc_AlarmMgr(SpcList_t * list, SpcAlarmType_t type, bool enable);

#ifdef __cplusplus
}
#endif
#endif /*__spc_list_H */
