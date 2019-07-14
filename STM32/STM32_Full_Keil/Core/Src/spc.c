/* Includes ------------------------------------------------------------------*/
#include "spc.h"
#include "FreeRTOS.h"
#include "lcd.h"
#include <string.h>
#include <stdlib.h>

osThreadId SpcTaskHandle;
static void SpcTask(void const *arg);

SpcValue_t SpcValue = {0};

static void Spc_ScreenUpdate(SpcInfoType_t type);
static void Spc_StartupLog(void);
static SpcStatus_t Spc_TestTemp(SpcValue_t *SpcValue);
static SpcStatus_t Spc_TestGfi(SpcValue_t *SpcValue);
static void Spc_SelfCheck(SpcValue_t *SpcValue);
static void Spc_AlarmRaise(SpcAlarmType_t alarmType);
static void Spc_AlarmClear(SpcAlarmType_t alarmType);
static void Spc_SystemConfigInit(SpcValue_t *SpcValue);
static void Spc_AlarmMgr(SpcList_t * list, SpcAlarmType_t type, bool enable);

static void SpcListInit(SpcList_t * list, uint8_t size);
static SpcItem_t *SpcFreeList(SpcList_t * list);
static SpcStatus_t SpcListInsert(SpcList_t * list, SpcItem_t *itemToAdd);
static SpcStatus_t SpcListRemove(SpcList_t * list, SpcAlarmType_t alarmType);

static inline bool SpcListIsFull(SpcList_t * list);
static inline bool SpcListIsEmpty(SpcList_t * list);
/*----------------------------------------------------------------------------*/
/* Private functions                                                           */
/*----------------------------------------------------------------------------*/

/* SPC related functions */
static void Spc_ScreenUpdate(SpcInfoType_t type) {
    Spc_ResetScreen(SPC_SCREEN_POSITION, SPC_SCREEN_SCALE);
    tftprintf(SpcStrPool[SpcStrLine1(type)]);
    tftprintf(SpcStrPool[SpcStrLine2(type)]);
}

static void Spc_StartupLog()
{
    int i;
 
    for (i = 0; i < NUM_ROWS(spcStartupLogOn); i++) {
        tftprintf("%s", spcStartupLogOn[i]);
    }

    osDelay(2000);
    Spc_ResetScreen(SPC_SCREEN_POSITION, NUM_ROWS(spcStartupLogOn));
    for (i = 0; i < NUM_ROWS(spcStartupLogOff); i++) {
        tftprintf("%s", spcStartupLogOff[i]);
    }

    osDelay(2000);
    Spc_ResetScreen(SPC_SCREEN_POSITION, NUM_ROWS(spcStartupLogOff));
    Spc_ScreenUpdate(SPC_SOFTWARE_VERSION);

    osDelay(2000);
}

static SpcStatus_t Spc_TestTemp(SpcValue_t *SpcValue)
{
    for (uint8_t Channel=SPC_RTD_CHANNEL1; Channel<SPC_MAX_RTD_CHANNEL; Channel++) {
        SpcTemperature(SpcValue)[Channel].tempStatus = SPC_TEST_TEMP_STATUS;
        SpcTemperature(SpcValue)[Channel].tempf = SPC_SIMULATE_TEMP_F;
        SpcTemperature(SpcValue)[Channel].tempc = SPC_SIMULATE_TEMP_C;
    }

    if (SpcTemperature(SpcValue)[SPC_RTD_CHANNEL1].tempStatus != SPC_TEMP_NORMAL) {
        if ((SpcSystemConfig(SpcValue).bytes.rtd_opr == SPC_ONE_RTD_MOD) ||
            (SpcTemperature(SpcValue)[SPC_RTD_CHANNEL2].tempStatus != SPC_TEMP_NORMAL)) {
            return SPC_ERROR;
        }
    }

    return SPC_NORMAL;
}

static SpcStatus_t Spc_TestGfi(SpcValue_t *SpcValue)
{
    SpcStatus_t ret = SPC_NORMAL; 

    for (uint8_t Channel=SPC_GFI_CHANNEL1; Channel<SPC_MAX_GFI_CHANNEL; Channel++) {
        SpcGfi(SpcValue)[Channel].val = SPC_SIMULATE_GFI;
        if (SpcGfi(SpcValue)[Channel].val > SPC_MAX_GFI) {
            SpcGfi(SpcValue)[Channel].gfiStatus = SPC_ERROR;
            ret = SPC_ERROR;
        } else {
            SpcGfi(SpcValue)[Channel].gfiStatus = SPC_NORMAL;
        }
    }

    return ret;
}

static void Spc_SelfCheck(SpcValue_t *SpcValue)
{
    Spc_ScreenUpdate(SPC_SELFCHECK);

    if ((Spc_TestTemp(SpcValue) == SPC_ERROR) ||
        (Spc_TestGfi(SpcValue) == SPC_ERROR)) {
        Spc_AlarmMgr(&SpcAlarmList(SpcValue), SPC_ALARM_SELFCHKFAIL, SpcAlarmEn);
        Spc_ScreenUpdate(SPC_SELFCHKFAIL);
    }
    osDelay(2000);
}

static void Spc_AlarmMgr(SpcList_t * list, SpcAlarmType_t type, bool enable)
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

static void Spc_AlarmRaise(SpcAlarmType_t alarmType)
{
    SpcValue.alarmMask |= alarmType;
}

static void Spc_AlarmClear(SpcAlarmType_t alarmType)
{
    SpcValue.alarmMask &= ~alarmType;
}

static void Spc_SystemConfigInit(SpcValue_t *SpcValue)
{
    SpcSystemConfig(SpcValue).bytes.rtd_opr = SPC_ONE_RTD_MOD;
    SpcListInit(&SpcAlarmList(SpcValue), SPC_MAX_LIST);
}

#ifdef SPC_CALIB_WANTED
static void Spc_Calibration()
{
    Spc_ScreenUpdate(SPC_CALIB_NEED);
    osDelay(2000);
}
#endif

static void SpcTask(void const *arg)
{
    Spc_StartupLog();
    Spc_SystemConfigInit(&SpcValue);
    Spc_SelfCheck(&SpcValue);

#ifdef SPC_CALIB_WANTED
    Spc_Calibration();
#endif

    while (1) {
        osDelay(2000);
    }
}

/* List functions */
static void SpcListInit(SpcList_t * list, uint8_t size)
{
    list->totalNum = 0;
    list->maxSize = size;

    SpcItem_t *item = &(list->item);
    item->alarmType = SPC_MAX_ALARM_TYPE;
    item->alarmPrio = SpcAlarmCritical;
    item->delfunc = NULL;
    item->addfunc = NULL;
    item->next = NULL;
}

static SpcItem_t *SpcFreeList(SpcList_t * list)
{
    SpcItem_t *itemToDel = NULL;
    SpcItem_t *itemIndex = &(list->item);
    while ((itemIndex->next) != NULL) {
        if (itemIndex->next->alarmPrio == SpcAlarmNormal) {
            itemToDel = itemIndex->next;
            itemIndex->next = itemIndex->next->next;
            return itemToDel;
        }
    }

    return NULL;
}

static SpcStatus_t SpcListInsert(SpcList_t * list, SpcItem_t *itemToAdd)
{
    if (SpcListIsFull(list)) {
        SpcItem_t *itemToDel = NULL;
        itemToDel = SpcFreeList(list);
        if (itemToDel == NULL) return SPC_ERROR;
        if (itemToDel->delfunc != NULL) itemToDel->delfunc(itemToDel->alarmType);
        vPortFree(itemToDel);
        itemToDel = NULL;
        list->totalNum--;
    }

    SpcItem_t *itemIndex = &(list->item);
    while ((itemIndex->next) != NULL) itemIndex = itemIndex->next;

    itemIndex->next = itemToAdd;
    list->totalNum++;
    if (itemToAdd->addfunc != NULL) itemToAdd->addfunc(itemToAdd->alarmType);
    return SPC_NORMAL;
}

static SpcStatus_t SpcListRemove(SpcList_t * list, SpcAlarmType_t alarmType)
{
    if (SpcListIsEmpty(list)) return SPC_ERROR;

    SpcItem_t *itemToDel = NULL;
    SpcItem_t *itemIndex = &(list->item);
    while ((itemIndex->next) != NULL) {
        if (itemIndex->next->alarmType == alarmType) {
            itemToDel = itemIndex->next;
            itemIndex->next = itemIndex->next->next;
            if (itemToDel->delfunc != NULL) itemToDel->delfunc(itemToDel->alarmType);
            vPortFree(itemToDel);
            itemToDel = NULL;
            return SPC_NORMAL;
        }
    }
    return SPC_ERROR;
}

static inline bool SpcListIsFull(SpcList_t * list)
{
    return list->totalNum >= list->maxSize;
}

static inline bool SpcListIsEmpty(SpcList_t * list)
{
    return list->totalNum == 0;
}

/*----------------------------------------------------------------------------*/
/* Public functions                                                           */
/*----------------------------------------------------------------------------*/
void SPC_Init(void)
{
    osThreadDef(SpcTaskName, SpcTask, osPriorityBelowNormal, 0, 256);
    SpcTaskHandle = osThreadCreate(osThread(SpcTaskName), NULL);
}
