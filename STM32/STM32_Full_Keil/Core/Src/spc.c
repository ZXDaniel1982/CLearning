/* Includes ------------------------------------------------------------------*/
#include "spc.h"
#include "FreeRTOS.h"
#include "lcd.h"
#include "cli.h"
#include <string.h>
#include <stdlib.h>

#define SPC_KEY_MONITOR_TIMEOUT   ( 200 )

osThreadId SpcTaskHandle;
static void SpcTask(void const *arg);

static SpcValue_t SpcValue = {0};

static void Spc_ScreenUpdateStatic(SpcInfoType_t type);
static void Spc_StartupLog(void);
static SpcStatus_t Spc_TestTemp(SpcValue_t *SpcValue);
static SpcStatus_t Spc_TestGfi(SpcValue_t *SpcValue);
static void Spc_SelfCheck(SpcValue_t *SpcValue);
static void Spc_SystemConfigInit(SpcValue_t *SpcValue);
static void Spc_SystemConfigInit(SpcValue_t *SpcValue);


// SPC alarm
void Spc_AlarmRaise(SpcAlarmType_t alarmType)
{
    SpcValue.alarm.alarmMask |= alarmType;
}

void Spc_AlarmClear(SpcAlarmType_t alarmType)
{
    SpcValue.alarm.alarmMask &= ~alarmType;
}

oid SPC_Init(void)
{
    osThreadDef(SpcTaskName, SpcTask, osPriorityBelowNormal, 0, 256);
    SpcTaskHandle = osThreadCreate(osThread(SpcTaskName), NULL);
}

void cliSpcKeyOpt(void *arg)
{
    uint16_t command = *(uint16_t *) arg;
    Spc_KeyOptInput(command);
}

/*----------------------------------------------------------------------------*/
/* Private functions                                                           */
/*----------------------------------------------------------------------------*/
static void Spc_KeyOptInput(command)
{
    int16_t event = Spc_GetKeyEvent();
    Spc_SetNextEvent(SpcMachine, event, NULL);
}

static void SpcTask(void const *arg)
{
    uint16_t nextEvent = 0, nextState = 0;

    Spc_StartupLog();
    Spc_SystemInit(&SpcValue);
    Spc_SelfCheck(&SpcValue);
    Spc_StartMachine(&SpcValue, &SpcMachine);

    while (1) {
        if ((nextEvent = Spc_NextEvent(&SpcMachine, &nextState)) >= 0) {
            Spc_SendEvent(nextEvent, nextState);
        } else {
            Scp_Wait();
        }
    }
}

void Spc_StartMachine(SpcValue_t *SpcValue, SpcMachine_t *SpcMachine)
{
    int16_t state;
    switch (SpcSysConf(SpcValue).bytes.defInfo) {
        case SYSTEM_STATUS_MOD:
            state = SPC_STATUS_DEFINFO_SYS;
            break;
        case HEATER_STATUS_MOD:
            state = SPC_STATUS_DEFINFO_HEAT;
            break;
        case HEATER_TEMP_MOD:
            state = SPC_STATUS_DEFINFO_HEAT_TEMP;
            break;
        default :
            SpcSysConf(SpcValue).bytes.defInfo = HEATER_STATUS_MOD;
            state = SPC_STATUS_DEFINFO_SYS;
            break;
    }
    SpcMachine->eventChange = SPC_NO_EVENT;
    SpcMachine->startEvent = SPC_START_EVENT;

    osMutexDef(SpcMutex);
    SpcMachine->mutex = osMutexCreate(osMutex(SpcMutex));
    osSemaphoreDef(SpcCond);
    SpcMachine->cond = osSemaphoreCreate(osSemaphore(SpcCond), 1);
    Spc_ProcessStateChange(SpcMachine, state);
}

static int16_t Spc_NextEvent(SpcMachine_t * SpcMachine, int16_t *nextState)
{
    int16_t event = 0;
    bool res = false;

    osMutexWait(SpcMachine->mutex, sleepPeriod);  // TODO This is inconsistent with add

    /* No saved events, check main queue */
    res = Spc_GetNewEvent(SpcMachine, &event, nextState);
    osMutexRelease(SpcMachine->mutex);

    if (res) {
        return event;
    } else {
        /* no item available */
        return -1;
    }
}

static bool Spc_GetNewEvent(SpcMachine_t * SpcMachine, int16_t *newEvent, int16_t *nextState)
{
    if (SpcMachine->eventChange == SPC_NEW_EVENT) {
        SpcMachine->eventChange = SPC_NO_EVENT;
        *newEvent = SpcMachine->newEvent;
        *nextState = SpcMachine->newState;
        return true;
    } else {
        return false;
    }
}

static void Spc_ProcessStateChange(SpcMachine_t * SpcMachine, uint16_t newState)
{
    SpcStateEntry_t entryElement = { 0 };
    uint16_t nextState = newState;
    int i;

    /*Find if entry function exists */
    for (i = 0; i < SpcMachine->stateMax; i++) {
        entryElement = SpcMachine->stateEntry[i];
        if (entryElement.state == newState) {
            if (entryElement.entry) {
                /*Invoke entry function */
                nextState = entryElement.entry(SpcMachine);
                break;
            }
        }
    }
}

static int Spc_SetNextEvent(SpcMachine_t * SpcMachine, uint16_t nextEvent, int16_t *nextState)
{
    osMutexWait(SpcMachine->mutex, sleepPeriod);

    gsm_AddEvent(SpcMachine, nextEvent, nextState);

    osSemaphoreRelease(SpcMachine->cond); // will wake up thread if sleeping
    osMutexRelease(SpcMachine->mutex);
}

static inline void Spc_AddEvent(SpcMachine_t * SpcMachine, uint16_t newEvent, int16_t *nextState)
{
    SpcMachine->eventChange = SPC_NEW_EVENT;
    SpcMachine->newEvent = newEvent;

    if (nextState != NULL) {
        SpcMachine->newState = *nextState;
    }
}

static void Spc_SendEvent(SpcMachine_t * SpcMachine, int16_t nextEvent, int16_t nextState)
{
    uint16_t state = SpcMachine->gsm_currentState;
    const gsmEventAction *actionElement = NULL;
    int16_t i;
    /* Check for state change event, do the state change first before checking for state change handler */
    if (nextEvent == SpcMachine->startEvent) {
        state = nextState;
        SpcMachine->gsm_currentState = state;
        Spc_ProcessStateChange(SpcMachine, state);
        return -1;
    }

    /*Find action function */
    for (i = 0; i < SpcMachine->gsm_eventActionSize; i++) {
        if ((SpcMachine->gsm_eventAction[i].event == nextEvent)
            && ((SpcMachine->gsm_eventAction[i].state == SpcMachine->gsm_currentState)
             || (SpcMachine->gsm_eventAction[i].state == GSM_STATE_ANY))) {
            actionElement = &SpcMachine->gsm_eventAction[i];
            break;
        }
    }

    // Can't handle the event, so save it until we can
    if (actionElement == NULL) {
        return -1;
    }
    // Handle the event, then free the data
    if (actionElement->action != NULL) {
        state = actionElement->action(SpcMachine);
    }

    /* If next state is different from the current state then queue a state change event for the state machine */
    if (SpcMachine->gsm_currentState != state) {
        /* Got a new state */
        Spc_SetNextEvent(SpcMachine, SpcMachine->startEvent, &state);
    }
    return 0;
}

int16_t SpcShowInfo(SpcMachine_t * SpcMachine)
{
    
}

#if 0

/*----------------------------------------------------------------------------*/
/* Private functions                                                           */
/*----------------------------------------------------------------------------*/

/* SPC related functions */
static void Spc_ScreenUpdateStatic(SpcInfoType_t type) {
    Spc_ResetScreen(SPC_SCREEN_POSITION, SPC_SCREEN_SCALE);
    tftprintf(SpcStrPool[SpcStrLine1(type)].str);
    tftprintf(SpcStrPool[SpcStrLine2(type)].str);
}

static void Spc_ScreenUpdateDynamic(SpcInfoType_t type, char *buf) {
    Spc_ResetScreen(SPC_SCREEN_POSITION, SPC_SCREEN_SCALE);
    tftprintf(SpcStrPool[SpcStrLine1(type)].str);
    tftprintf(buf);
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
    Spc_ScreenUpdateStatic(SPC_SOFTWARE_VERSION);

    osDelay(2000);
}

static void Spc_SystemInit(SpcValue_t *SpcValue)
{
    SpcSysConf(SpcValue).bytes.manual = SpcManuOptDis;
    SpcSysConf(SpcValue).bytes.rdtStat = SPC_RTD_OFF;
    SpcSysConf(SpcValue).bytes.unit = SpcTempInCelsius;
    SpcSysConf(SpcValue).bytes.defInfo = HEATER_STATUS_MOD;
    SpcSysConf(SpcValue).bytes.rtdMod = SPC_ONE_RTD_MOD;
    SpcConfTimeout(SpcValue) = 120;
    SpcPercent(SpcValue) = 10;

    SpcListInit(&SpcAlarmList(SpcValue), SPC_MAX_LIST);
}

static void Spc_SelfCheck(SpcValue_t *SpcValue)
{
    Spc_ScreenUpdateStatic(SPC_SELFCHECK);

    if ((Spc_TestTemp(SpcValue) == SPC_ERROR) ||
        (Spc_TestGfi(SpcValue) == SPC_ERROR)) {
        Spc_AlarmMgr(&SpcAlarmList(SpcValue), SPC_ALARM_SELFCHKFAIL, SpcAlarmEn);
        Spc_ScreenUpdateStatic(SPC_SELFCHKFAIL);
    }
    osDelay(2000);
}

static SpcStatus_t Spc_TestTemp(SpcValue_t *SpcValue)
{
    for (uint8_t Channel=SPC_RTD_CHANNEL1; Channel<SPC_MAX_RTD_CHANNEL; Channel++) {
        SpcTemp(SpcValue, Channel).tempStatus = SPC_TEST_TEMP_STATUS;
        SpcTemp(SpcValue, Channel).tempf = SPC_SIMULATE_TEMP_F;
        SpcTemp(SpcValue, Channel).tempc = SPC_SIMULATE_TEMP_C;
    }

    if (SpcTemp(SpcValue, SPC_RTD_CHANNEL1).tempStatus != SPC_TEMP_NORMAL) {
        if ((SpcSysConf(SpcValue).bytes.rtdMod == SPC_ONE_RTD_MOD) ||
            (SpcTemp(SpcValue, SPC_RTD_CHANNEL2).tempStatus != SPC_TEMP_NORMAL)) {
            return SPC_ERROR;
        }
    }

    return SPC_NORMAL;
}

static SpcStatus_t Spc_TestGfi(SpcValue_t *SpcValue)
{
    SpcStatus_t ret = SPC_NORMAL; 

    SpcGfi(SpcValue).val = SPC_SIMULATE_GFI;
    if (SpcGfi(SpcValue).val > SPC_MAX_GFI) {
        SpcGfi(SpcValue).gfiStatus = SPC_ERROR;
        ret = SPC_ERROR;
    } else {
        SpcGfi(SpcValue).gfiStatus = SPC_NORMAL;
    }

    return ret;
}

static void SpcShowDefInfo(SpcValue_t *SpcValue)
{
    switch (SpcSysConf(SpcValue).bytes.defInfo) {
        case SYSTEM_STATUS_MOD:
            SpcPosition(SpcValue) = SPC_DEFINFO_SYS_STATUS;
            break;
        case HEATER_STATUS_MOD:
            SpcPosition(SpcValue) = SPC_DEFINFO_HEAT_STATUS;
            break;
        case HEATER_TEMP_MOD:
            SpcPosition(SpcValue) = SPC_DEFINFO_HEAT_TEMP;
            break;
        default :
            SpcSysConf(SpcValue).bytes.defInfo = HEATER_STATUS_MOD;
            SpcPosition(SpcValue) = SPC_DEFINFO_HEAT_STATUS;
            break;
    }

    SpcInfoType_t type = SpcPosition(SpcValue);
    if (SpcStrDetail(type) != NULL) {
        SpcStrDetail(type)(SpcValue, NULL);
    } else {
        Spc_ScreenUpdateStatic(type);
    }
}

//========================================================================================
// menu common
//========================================================================================

static void Spc_ShowNextInfo(SpcValue_t *SpcValue, SpcInfoType_t nextType, uint16_t command)
{
    uint16_t nextCmd = command;
    SpcPosition(SpcValue) = nextType;
    if (SpcStrDetail(nextType) != NULL) {
        while (SpcStrDetail(nextType)(SpcValue, &nextCmd) == SPC_KEY_NEXT);
    } else {
        Spc_ScreenUpdateStatic(nextType);
    }
}

static bool Spc_GetActParamTable(SpcInfoType_t type, SpcParamTable_t *param)
{
    for (uint8_t i=0; i<NUM_ROWS(SpcParamTable); i++) {
        if (SpcParamTable[i].type == type) {
            memcpy(param, &SpcParamTable[i]);
            return true;
        }
    }
    return false;
}

static void SpcGetTempStr(char *buf, uint8_t len, SpcValue_t *SpcValue)
{
    SpcInfoType_t type = SpcPosition(SpcValue);
    SpcRtdChannel_t channel = SpcGetChannel(type);

    if (SpcTemp(SpcValue, channel).tempStatus == SPC_TEMP_RTD_SHORT) {
        strncpy(buf, SpcStrPool[SPC_RTD_SHORT_STR].str, len);
    } else if (SpcTemp(SpcValue, channel).tempStatus == SPC_TEMP_RTD_OPEN) {
        strncpy(buf, SpcStrPool[SPC_RTD_OPEN_STR].str, len);
    } else {
        if (SpcSysConf(SpcValue).bytes.unit == SpcTempInCelsius)
            snprintf(buf, len, "%d C", SpcTemp(SpcValue, channel).tempc);
        else
            snprintf(buf, len, "%d F", SpcTemp(SpcValue, channel).tempf);
    }
}

//========================================================================================
// menu function
//========================================================================================
SpcKeyType_t Spc_GetHeatTempDetail(SpcValue_t *SpcValue, uint16_t *command)
{
    char buf[SPC_MAX_STR_LEN] = {0};
    SpcInfoType_t type = SpcPosition(SpcValue);

    if (SpcSysConfMainTemp(SpcValue).tempStatus == SPC_TEMP_OFF) {
        strncpy(buf, SpcStrPool[SPC_BLANK_STR].str, sizeof(buf));
    } else {
        SpcGetTempStr(buf, sizeof(buf), SpcValue);
    }

    Spc_ScreenUpdateDynamic(type, buf);
    return SPC_KEY_NORMAL;
}

SpcKeyType_t Spc_GetHeatStatusDetail(SpcValue_t *SpcValue, uint16_t *command)
{
    char buf[SPC_MAX_STR_LEN] = {0};
    SpcRTDStatus_t rtdStatus = (SpcRTDStatus_t) (SpcSysConf(SpcValue).bytes.rdtStat);
    SpcStringType_t strType = SpcRtdStatStrPool[rtdStatus].strType;
    SpcInfoType_t infoType = SpcPosition(SpcValue);

    strncpy(buf, SpcStrPool[strType].str, sizeof(buf));
    Spc_ScreenUpdateDynamic(infoType, buf);
    return SPC_KEY_NORMAL;
}

SpcKeyType_t Spc_GetSysStatusDetail(SpcValue_t *SpcValue, uint16_t *command)
{
    char buf[SPC_MAX_STR_LEN] = {0};
    SpcInfoType_t infoType = SpcPosition(SpcValue);

    snprintf(buf, sizeof(buf), "%d Alarms", SpcAlarmList(SpcValue).totalNum);
    Spc_ScreenUpdateDynamic(infoType, buf);
    return SPC_KEY_NORMAL;
}

SpcKeyType_t Spc_GetActValue(SpcValue_t *SpcValue, uint16_t *command)
{
    char buf[SPC_MAX_STR_LEN] = {0};
    SpcInfoType_t infoType = SpcPosition(SpcValue);
    SpcParamTable_t SpcParam;

    if ((*command == SPC_KEY_RIGHT) || (*command == SPC_KEY_LEFT)) {
        if (Spc_GetActParamTable(infoType, &SpcParam)) {
            snprintf(buf, sizeof(buf), "%s%d%s", SpcParam.prefix, SpcParam.val, SpcParam.suffix);
            Spc_ScreenUpdateDynamic(infoType, buf);
        }
    }
    return SPC_KEY_NORMAL;
}

/*----------------------------------------------------------------------------*/
/* Public functions                                                           */
/*----------------------------------------------------------------------------*/
static SpcRtdChannel_t SpcGetChannel(SpcInfoType_t type)
{
    SpcChannelPool_t *channelPool = NULL;

    for (uint8_t i=0; i<NUM_ROWS(SpcChannelPool); i++) {
        if (SpcChannelPool[i].type == type) {
            return SpcChannelPool[i].channel;
        }
    }
}

static bool Spc_GetActParamTable(SpcInfoType_t type, SpcParamTable_t *param)
{
    for (uint8_t i=0; i<NUM_ROWS(SpcParamTable); i++) {
        if (SpcParamTable[i].type == type) {
            memcpy(param, &SpcParamTable[i]);
            return true;
        }
    }
    return false;
}

static void SpcTask(void const *arg)
{
    osEvent event;
    uint16_t command = 0, nextCmd = 0;

    Spc_StartupLog();
    Spc_SystemInit(&SpcValue);
    Spc_SelfCheck(&SpcValue);
    SpcShowDefInfo(&SpcValue);

    while (1) {
        event = osMessageGet(SpcKeyQueueHandle, SPC_KEY_MONITOR_TIMEOUT);
        if (event.status == osEventMessage) {
            command = event.value.v;
            while (Spc_KeyOptProcess(&SpcValue, command, &nextCmd) == SPC_KEY_NEXT) {
                command = nextCmd;
            }
        }
    }
}

static SpcKeyType_t Spc_KeyOptProcess(SpcValue_t *SpcValue, uint16_t command, uint16_t *nextCmd)
{
    SpcInfoType_t infoType = SpcPosition(SpcValue);
    SpcInfoType_t nextType;
    switch(command) {
        case SPC_KEY_RIGHT:
            if (infoType == SpcRightType(infoType)) return SPC_KEY_NORMAL;
            break;
        case SPC_KEY_LEFT:
            if (infoType == SpcLeftType(infoType)) return SPC_KEY_NORMAL;
            break;
        case SPC_KEY_ACT:
            nextType = SpcActType(infoType);
            Spc_ShowNextInfo(SpcValue, nextType);
            return SpcActualProcess(SpcValue, nextCmd);
        case SPC_KEY_PROG:
            nextType = SpcProgType(infoType);
            Spc_ShowNextInfo(SpcValue, nextType);
            return SpcProgProcess(SpcValue, nextCmd);
    }
    return SPC_KEY_NORMAL;
}

static SpcKeyType_t SpcActualProcess(SpcValue_t *SpcValue, uint16_t *nextCmd)
{
    osEvent event;
    uint16_t command = 0;
    uint32_t startTime, curTime;

    startTime = spctick;
    while (1) {
        event = osMessageGet(SpcKeyQueueHandle, SPC_KEY_MONITOR_TIMEOUT);
        if (event.status == osEventMessage) {
            command = event.value.v;
            startTime = curTime;
            if (SpcActSubProcess(SpcValue, command) == SPC_KEY_NEXT) {
                *nextCmd = command;
                return SPC_KEY_NEXT;
            }
        }
        curTime = spctick;
        if ((curTime - startTime) >= SpcConfTimeout(SpcValue)) {
            SpcShowDefInfo(SpcValue);
            return SPC_KEY_TIMEOUT;
        }
    }
}

static SpcKeyType_t SpcProgProcess(SpcValue_t *SpcValue, uint16_t *nextCmd)
{
    osEvent event;
    uint16_t command = 0;
    uint32_t startTime, curTime;

    startTime = spctick;
    while (1) {
        event = osMessageGet(SpcKeyQueueHandle, SPC_KEY_MONITOR_TIMEOUT);
        if (event.status == osEventMessage) {
            command = event.value.v;
            startTime = curTime;
            if (SpcProgSubProcess(SpcValue, command) == SPC_KEY_NEXT) {
                *nextCmd = command;
                return SPC_KEY_NEXT;
            }
        }
        curTime = spctick;
        if ((curTime - startTime) >= SpcConfTimeout(SpcValue)) {
            SpcShowDefInfo(SpcValue);
            return SPC_KEY_TIMEOUT;
        }
    }
}

static SpcKeyType_t SpcActSubProcess(SpcValue_t *SpcValue, uint16_t command)
{
    SpcInfoType_t curType = SpcPosition(SpcValue);
    SpcInfoType_t nextType;
    switch (command) {
        case SPC_KEY_ACT:
            nextType = SpcActType(curType);
            break;
        case SPC_KEY_RIGHT:
            nextType = SpcRightType(curType);
            break;
        case SPC_KEY_LEFT:
            nextType = SpcLeftType(curType);
            break;
        case SPC_KEY_UP:
        case SPC_KEY_DOWN:
            return SPC_KEY_NORMAL;
        case SPC_KEY_ENTER:
            return Spc_ResetStatSingle(SpcValue);
        default:
            return SPC_KEY_NEXT;
    }
    if (curType == nextType) {
        return SPC_KEY_NORMAL;
    }
    Spc_ShowNextInfo(SpcValue, nextType, command);
    return SPC_KEY_NORMAL;
}

static SpcKeyType_t SpcProgSubProcess(SpcValue_t *SpcValue, uint16_t command)
{
    SpcInfoType_t curType = SpcPosition(SpcValue);
    SpcInfoType_t nextType;
    switch (command) {
        case SPC_KEY_PROG:
            nextType = SpcProgType(curType);
            break;
        case SPC_KEY_RIGHT:
            nextType = SpcRightType(curType);
            break;
        case SPC_KEY_LEFT:
            nextType = SpcLeftType(curType);
            break;
        default:
            return SPC_KEY_NEXT;
    }
    if (curType == nextType) {
        return SPC_KEY_NORMAL;
    }
    Spc_ShowNextInfo(SpcValue, nextType);
    return SPC_KEY_NORMAL;
}

static SpcKeyType_t Spc_ResetStatSingle(SpcValue_t *SpcValue)
{
    osEvent event;
    SpcInfoType_t infoType = SpcPosition(SpcValue);
    SpcKeyType_t ret;
    uint16_t command = 0, ResetStatus = 1;
    uint32_t startTime, curTime;

    SpcParamTable_t SpcParam;
    if (!Spc_GetActParamTable(infoType, &SpcParam)) {
        return SPC_KEY_NORMAL;
    }

    SpcInfoType_t resetType = SPC_RESET_STAT_NO;

    Spc_ScreenUpdateStatic(resetType);

    startTime = spctick;
    while (1) {
        event = osMessageGet(SpcKeyQueueHandle, SPC_KEY_MONITOR_TIMEOUT);
        if (event.status == osEventMessage) {
            command = event.value.v;
            startTime = curTime;
            ret = SpcResetStatProcess(SpcValue, command, &SpcParam, &resetType);
            if (ret == SPC_KEY_RESETCOMPLETE) {
                osDelay(2000);
                Spc_ShowNextInfo(SpcValue, infoType);
                break;
            } else if (ret == SPC_KEY_RESETCANCLE) {
                Spc_ShowNextInfo(SpcValue, infoType);
                break;
            }
        }
        curTime = spctick;
        if ((curTime - startTime) >= SpcConfTimeout(SpcValue)) {
            SpcShowDefInfo(SpcValue);
            return SPC_KEY_TIMEOUT;
        }
    }
}

static SpcKeyType_t SpcResetStatProcess(SpcValue_t *SpcValue, uint16_t command,
    SpcParamTable_t *SpcParam, SpcInfoType_t *resetType)
{
    SpcInfoType_t infoType = *resetType;
    SpcKeyType_t ret;
    switch (command) {
        case SPC_KEY_UP:
            *resetType = SpcRightType(*resetType);
            break;
        case SPC_KEY_DOWN:
            *resetType = SpcLeftType(*resetType);
            break;
        case SPC_KEY_ENTER:
            *resetType = SpcEnterType(*resetType);
            if (*resetType == SPC_RESET_STAT_COMPLETE) {
                SpcParam->val = 0;
                ret = SPC_KEY_RESETCOMPLETE;
            } else {
                return SPC_KEY_RESETCANCLE;
            }
            break;
        case SPC_KEY_RESET:
            return SPC_KEY_RESETCANCLE;
        default:
            return SPC_KEY_NEXT;
    }
    if (infoType == *resetType) {
        return SPC_KEY_NORMAL;
    }
    Spc_ScreenUpdateStatic(resetType);
    return SPC_KEY_NORMAL;
}
#endif