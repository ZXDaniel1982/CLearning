/* Includes ------------------------------------------------------------------*/
#include "spc.h"
#include "FreeRTOS.h"
#include "lcd.h"
#include <string.h>
#include <stdlib.h>

#define SPC_KEY_MONITOR_TIMEOUT   ( 200 )

osThreadId SpcTaskHandle;
static void SpcTask(void const *arg);

osMessageQId SpcKeyQueueHandle;

SpcValue_t SpcValue = {0};

static void Spc_ScreenUpdateStatic(SpcInfoType_t type);
static void Spc_StartupLog(void);
static SpcStatus_t Spc_TestTemp(SpcValue_t *SpcValue);
static SpcStatus_t Spc_TestGfi(SpcValue_t *SpcValue);
static void Spc_SelfCheck(SpcValue_t *SpcValue);
static void Spc_SystemConfigInit(SpcValue_t *SpcValue);
static void Spc_SystemConfigInit(SpcValue_t *SpcValue);

/*----------------------------------------------------------------------------*/
/* Private functions                                                           */
/*----------------------------------------------------------------------------*/

/* SPC related functions */
static void Spc_ScreenUpdateStatic(SpcInfoType_t type) {
    Spc_ResetScreen(SPC_SCREEN_POSITION, SPC_SCREEN_SCALE);
    tftprintf(SpcStrPool[SpcStrLine1(type)]);
    tftprintf(SpcStrPool[SpcStrLine2(type)]);
}

static void Spc_ScreenUpdateDynamic(SpcInfoType_t type, char *buf) {
    Spc_ResetScreen(SPC_SCREEN_POSITION, SPC_SCREEN_SCALE);
    tftprintf(SpcStrPool[SpcStrLine1(type)]);
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

static SpcStatus_t Spc_TestTemp(SpcValue_t *SpcValue)
{
    for (uint8_t Channel=SPC_RTD_CHANNEL1; Channel<SPC_MAX_RTD_CHANNEL; Channel++) {
        SpcTemp(SpcValue, Channel).tempStatus = SPC_TEST_TEMP_STATUS;
        SpcTemp(SpcValue, Channel).tempf = SPC_SIMULATE_TEMP_F;
        SpcTemp(SpcValue, Channel).tempc = SPC_SIMULATE_TEMP_C;
    }

    if (SpcTemp(SpcValue)[SPC_RTD_CHANNEL1].tempStatus != SPC_TEMP_NORMAL) {
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

    for (uint8_t Channel=SPC_GFI_CHANNEL1; Channel<SPC_MAX_GFI_CHANNEL; Channel++) {
        SpcGfi(SpcValue)[Channel].val = SPC_SIMULATE_GFI;
        if (SpcGfi(SpcValue, Channel).val > SPC_MAX_GFI) {
            SpcGfi(SpcValue, Channel).gfiStatus = SPC_ERROR;
            ret = SPC_ERROR;
        } else {
            SpcGfi(SpcValue, Channel).gfiStatus = SPC_NORMAL;
        }
    }

    return ret;
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

static void Spc_SystemConfigInit(SpcValue_t *SpcValue)
{
    for (uint8_t Channel=SPC_RTD_CHANNEL1; Channel<SPC_MAX_RTD_CHANNEL; Channel++) {
        SpcSysConfChn(SpcValue, Channel).bytes.manual = SpcManuOptDis;
        SpcSysConfChn(SpcValue, Channel).bytes.rdtStat = SPC_RTD_OFF;
    }

    SpcSysConf(SpcValue).bytes.rtdMod = SPC_ONE_RTD_MOD;
    SpcSysConf(SpcValue).bytes.defInfo = HEATER_STATUS_MOD;
    SpcSysConf(SpcValue).bytes.unit = SpcTempInCelsius;
    SpcConfTimeout(SpcValue) = 120;
    SpcChannel(SpcValue) = SPC_RTD_CHANNEL1;

    SpcListInit(&SpcAlarmList(SpcValue), SPC_MAX_LIST);
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
    if (SpcStrMode(type) == SpcScreenDynamic) {
        SpcStrDetail(type)(SpcValue);
    } else {
        Spc_ScreenUpdateStatic(type);
    }
}

#ifdef SPC_CALIB_WANTED
static void Spc_Calibration()
{
    Spc_ScreenUpdateStatic(SPC_CALIB_NEED);
    osDelay(2000);
}
#endif

static void SpcActualProcess(SpcValue_t *SpcValue)
{
    SpcRtdChannel_t channel = SpcChannel(SpcValue);
    SpcInfoType_t infoType = SpcPosition(SpcValue);

    uint32_t startTime, curTime;

    startTime = spctick;

    while (1) {
        event = osMessageGet(SpcKeyQueueHandle, SPC_KEY_MONITOR_TIMEOUT);
        if (event.status == osEventMessage) {
            command = event.value.v;
            Spc_KeyOptProcess(&SpcValue, command);
        }
        curTime = spctick;
        if ((curTime - startTime) >= SpcConfTimeout(x)) {
            SpcShowDefInfo();
            break;
        }
    }
}

static void Spc_KeyOptProcess(SpcValue_t *SpcValue, uint16_t command)
{
    SpcRtdChannel_t channel = SpcChannel(SpcValue);
    SpcInfoType_t infoType = SpcPosition(SpcValue);
    switch(command) {
        case SPC_KEY_RIGHT:
            if (infoType == SpcRightType(infoType)) return;
            break;
        case SPC_KEY_LEFT:
            if (infoType == SpcRightType(infoType)) return;
            break;
        case SPC_KEY_ACT:
            SpcActualProcess(SpcValue);
            break;
    }
    return;
}

static void SpcTask(void const *arg)
{
    osEvent event;
    uint16_t command = 0;

    Spc_StartupLog();
    Spc_SystemConfigInit(&SpcValue);
    Spc_SelfCheck(&SpcValue);

#ifdef SPC_CALIB_WANTED
    Spc_Calibration();
#endif

    SpcShowDefInfo(&SpcValue)

    while (1) {
        event = osMessageGet(SpcKeyQueueHandle, SPC_KEY_MONITOR_TIMEOUT);
        if (event.status == osEventMessage) {
            command = event.value.v;
            Spc_KeyOptProcess(&SpcValue, command);
        }
    }
}

static void SpcGetTempStr(char *buf, uint8_t len, SpcValue_t *SpcValue)
{
    SpcRtdChannel_t channel = SpcChannel(SpcValue);

    if (SpcTemp(SpcValue, channel).tempStatus == SPC_TEMP_RTD_SHORT) {
        strncpy(buf, SpcStrPool[SPC_RTD_SHORT_STR], len);
    } else if (SpcTemp(SpcValue, channel).tempStatus == SPC_TEMP_RTD_OPEN) {
        strncpy(buf, SpcStrPool[SPC_RTD_OPEN_STR], len);
    } else {
        if (SpcSysConf(SpcValue).bytes.unit == SpcTempInCelsius)
            snprintf(buf, len, "%d C", SpcTemp(SpcValue, channel).tempc);
        else
            snprintf(buf, len, "%d F", SpcTemp(SpcValue, channel).tempc);
    }
}

/*----------------------------------------------------------------------------*/
/* Public functions                                                           */
/*----------------------------------------------------------------------------*/
void SPC_Init(void)
{
    osThreadDef(SpcTaskName, SpcTask, osPriorityBelowNormal, 0, 256);
    SpcTaskHandle = osThreadCreate(osThread(SpcTaskName), NULL);

    osMessageQDef(SpcKeyQueueName, 4, uint16_t);
    SpcKeyQueueHandle = osMessageCreate(osMessageQ(SpcKeyQueueName), NULL);
}

void cliSpcKeyOpt(void *arg)
{
    uint16_t command = *(uint16_t *) arg;
    osMessagePut (SpcKeyQueueHandle, command, 400);
}

void Spc_GetHeatTempDetail(SpcValue_t *SpcValue)
{
    char buf[SPC_MAX_STR_LEN] = {0};

    if (SpcSysConfMainTemp(SpcValue, SpcChannel(SpcValue)).tempStatus ==
            SPC_TEMP_OFF) {
        strncpy(buf, SpcStrPool[SPC_BLANK_STR], sizeof(buf));
    } else {
        SpcGetTempStr(buf, sizeof(buf), SpcValue);
    }

    SpcInfoType_t type = SpcPosition(SpcValue);
    Spc_ScreenUpdateDynamic(type, buf);
}

void Spc_GetHeatStatusDetail(SpcValue_t *SpcValue)
{
    char buf[SPC_MAX_STR_LEN] = {0};
    SpcRtdChannel_t channel = SpcChannel(SpcValue);
    SpcRTDStatus_t rtdStatus = SpcSysConfChn(SpcValue, Channel).bytes.rdtStat;
    SpcStringType_t strType = SpcRtdStatStrPool[rtdStatus];
    SpcInfoType_t infoType = SpcPosition(SpcValue);

    strncpy(buf, SpcStrPool[strType], sizeof(buf))
    Spc_ScreenUpdateDynamic(infoType, buf);
}

void Spc_GetSysStatusDetail(SpcValue_t *SpcValue)
{
    char buf[SPC_MAX_STR_LEN] = {0};
    SpcInfoType_t infoType = SpcPosition(SpcValue);

    snprintf(buf, sizeof(buf), "%d Alarms", SpcAlarmList(x).totalNum);
    Spc_ScreenUpdateDynamic(infoType, buf);
}
