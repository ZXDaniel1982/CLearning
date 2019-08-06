//#include "spcalarm.h"
#include "spcconst.h"
#include "FreeRTOS.h"

static const SpcAlarmTable_t SpcAlarmTable[SPC_MAX_ALARM_TYPE] = {
    {SPC_ALARM_SELFCHKFAIL, SpcAlarmCritical},
};

void Spc_AlarmMgr(SpcList_t * list, SpcAlarmType_t type, bool enable)
{
    if (enable) {
        SpcItem_t *item = (SpcItem_t *) pvPortMalloc(sizeof(SpcItem_t));
        if (item == NULL) {
            return;
        }
        item->alarmType = type;
        item->alarmPrio = SpcAlarmTable[item->alarmType].prio;
        item->delfunc = Spc_AlarmClear;
        item->addfunc = Spc_AlarmRaise;
        item->next = NULL;

        SpcListInsert(list, item);
    } else {
        SpcListRemove(list, type);
    }
}