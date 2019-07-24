/* Includes ------------------------------------------------------------------*/
#include "spc.h"
#include "FreeRTOS.h"
#include "lcd.h"
#include "cli.h"
#include <string.h>
#include <stdlib.h>

#define SPC_KEY_MONITOR_TIMEOUT   ( 200 )

osMessageQId SpcKeyQueueHandle;

osThreadId SpcTaskHandle;
static void SpcTask(void const *arg);

static SpcValue_t SpcValue = {0};

static void Spc_ScreenUpdateStatic(int16_t line1, int16_t line2);
static void Spc_ScreenUpdateDynamic(int16_t line1, char *buf);
static void Spc_StartupLog(void);
static SpcStatus_t Spc_TestTemp(SpcValue_t *SpcValue);
static SpcStatus_t Spc_TestGfi(SpcValue_t *SpcValue);
static void Spc_SelfCheck(SpcValue_t *SpcValue);
static SpcKeyType_t Spc_KeyOptProcess(SpcValue_t *SpcValue, uint16_t command);

// SPC alarm
void Spc_AlarmRaise(SpcAlarmType_t alarmType)
{
    SpcValue.alarm.alarmMask |= alarmType;
}

void Spc_AlarmClear(SpcAlarmType_t alarmType)
{
    SpcValue.alarm.alarmMask &= ~alarmType;
}

void SPC_Init(void)
{
    osThreadDef(SpcTaskName, SpcTask, osPriorityBelowNormal, 0, 256);
    SpcTaskHandle = osThreadCreate(osThread(SpcTaskName), NULL);

    osMessageQDef(SpcQueueName, 4, uint16_t);
    SpcKeyQueueHandle = osMessageCreate(osMessageQ(SpcQueueName), NULL);
}

void cliSpcKeyOpt(void *arg)
{
    uint16_t command = *(uint16_t *) arg;
    osMessagePut (SpcKeyQueueHandle, command, 100);
}

/*----------------------------------------------------------------------------*/
/* Private functions                                                           */
/*----------------------------------------------------------------------------*/

/* SPC related functions */
static void Spc_ScreenUpdateStatic(int16_t line1, int16_t line2) {
    Spc_ResetScreen(SPC_SCREEN_POSITION, SPC_SCREEN_SCALE);
    tftprintf(SpcStrPool[line1].str);
    tftprintf(SpcStrPool[line2].str);
}

static void Spc_ScreenUpdateDynamic(int16_t line1, char *buf) {
    Spc_ResetScreen(SPC_SCREEN_POSITION, SPC_SCREEN_SCALE);
    tftprintf(SpcStrPool[line1].str);
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
    Spc_ScreenUpdateStatic(SPC_FIRMWARE_NAME_STR, SPC_FIRMWARE_VER_STR);

    osDelay(2000);
}

static void Spc_SystemInit(SpcValue_t *SpcValue)
{
    SpcConf(SpcValue).bytes.manual = SpcManuOptDis;
    SpcConf(SpcValue).bytes.rdtStat = SPC_RTD_OFF;
    SpcConf(SpcValue).bytes.unit = SpcTempInCelsius;
    SpcConf(SpcValue).bytes.defInfo = HEATER_STATUS_MOD;
    SpcConf(SpcValue).bytes.rtdMod = SPC_ONE_RTD_MOD;
    SpcConfTimeout(SpcValue) = 120;
    SpcPercent(SpcValue) = 10;

    SpcListInit(&SpcAlarmList(SpcValue), SPC_MAX_LIST);
}

static void Spc_SelfCheck(SpcValue_t *SpcValue)
{
    Spc_ScreenUpdateStatic(SPC_SYSTEMCHK_STR, SPC_BLANK_STR);

    if ((Spc_TestTemp(SpcValue) == SPC_ERROR) ||
        (Spc_TestGfi(SpcValue) == SPC_ERROR)) {
        Spc_AlarmMgr(&SpcAlarmList(SpcValue), SPC_ALARM_SELFCHKFAIL, SpcAlarmEn);
        Spc_ScreenUpdateStatic(SPC_SELFCHKFAIL_STR, SPC_BLANK_STR);
    }
    osDelay(2000);
}

static SpcStatus_t Spc_TestTemp(SpcValue_t *SpcValue)
{
    uint8_t Channel;
    for (Channel=SPC_RTD_CHANNEL1; Channel<SPC_MAX_RTD_CHANNEL; Channel++) {
        SpcTemp(SpcValue, Channel).tempStatus = SPC_TEST_TEMP_STATUS;
        SpcTemp(SpcValue, Channel).tempf = SPC_SIMULATE_TEMP_F;
        SpcTemp(SpcValue, Channel).tempc = SPC_SIMULATE_TEMP_C;
    }

    if (SpcTemp(SpcValue, SPC_RTD_CHANNEL1).tempStatus != SPC_TEMP_NORMAL) {
        if ((SpcConf(SpcValue).bytes.rtdMod == SPC_ONE_RTD_MOD) ||
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
    /*
    switch (SpcConf(SpcValue).bytes.defInfo) {
        case SYSTEM_STATUS_MOD:
            SpcPosition(SpcValue) = 0;
            break;
        case HEATER_STATUS_MOD:
            SpcPosition(SpcValue) = 1;
            break;
        case HEATER_TEMP_MOD:
            SpcPosition(SpcValue) = 2;
            break;
        default :
            SpcConf(SpcValue).bytes.defInfo = HEATER_STATUS_MOD;
            SpcPosition(SpcValue) = 1;
            break;
    }*/

    SpcPosition(SpcValue) = 0;
    SpcEntryInit(SpcValue);
}

//========================================================================================
// menu common
//========================================================================================

//========================================================================================
// menu function
//========================================================================================
/*
void SpcShowTemperature(temp_t *temperature, int16_t line1)
{
    if (temperature->tempStatus == SPC_TEMP_RTD_SHORT) {
        Spc_ScreenUpdateStatic(line1, SPC_RTD_SHORT_STR);
    } else if (temperature->tempStatus == SPC_TEMP_RTD_OPEN) {
        Spc_ScreenUpdateStatic(line1, SPC_TEMP_RTD_OPEN);
    } else {
        char buf[SPC_MAX_STR_LEN] = {0};
        if (SpcConf(SpcValue).bytes.unit == SpcTempInCelsius)
            snprintf(buf, SPC_MAX_STR_LEN, "%d C", temperature->tempc);
        else
            snprintf(buf, SPC_MAX_STR_LEN, "%d F", temperature->tempf);
        Spc_ScreenUpdateDynamic(line1, buf);
    }
}

SpcKeyType_t SpcEntryShowHeatTemp(SpcValue_t *SpcValue)
{
    const SpcDataTemp_t *element = NULL;

    SpcGetDataTemp(SpcValue, element);
    if (SpcConfMainTemp(SpcValue).tempStatus == SPC_TEMP_OFF) {
        Spc_ScreenUpdateStatic(element.line1, SPC_BLANK_STR);
    } else {
        SpcShowTemperature(element.line1, element);
    }

    return SPC_KEY_NORMAL;
}

SpcKeyType_t SpcEntryShowHeatStatus(SpcValue_t *SpcValue, uint16_t *command)
{
    const SpcDataInt_t *element = NULL;

    SpcRTDStatus_t rtdStatus = (SpcRTDStatus_t) (SpcConf(SpcValue).bytes.rdtStat);
    SpcStringType_t strType = SpcRtdStatStrPool[rtdStatus].strType;
    SpcGetDataInt(SpcValue, element);
    Spc_ScreenUpdateStatic(element.line1, strType);
    return SPC_KEY_NORMAL;
}

SpcKeyType_t SpcEntryShowSysStatus(SpcValue_t *SpcValue)
{
    char buf[SPC_MAX_STR_LEN] = {0};
    const SpcDataInt_t *element = NULL;

    SpcGetDataInt(SpcValue, element);
    snprintf(buf, sizeof(buf), "%d Alarms", SpcAlarmList(SpcValue).totalNum);
    Spc_ScreenUpdateDynamic(element.line1, buf);
    return SPC_KEY_NORMAL;
}*/

SpcKeyType_t SpcEntryInit(SpcValue_t *SpcValue)
{
    int16_t i;
    SpcInfoType_t infoType = SpcPosition(SpcValue);
    for (i=0; i<NUM_ROWS(SpcStaticInfo);i++) {
        if (SpcStaticInfo[i].type == infoType) {
            Spc_ScreenUpdateStatic(SpcStaticInfo[i].line1, SpcStaticInfo[i].line2);
            return SPC_KEY_NORMAL;
        }
    }
    return SPC_KEY_NORMAL;
}

#if 0
SpcKeyType_t SpcEntryShowByte(SpcValue_t *SpcValue)
{
    uint8_t val;
    SpcStringType_t line2;
    const SpcDataInt_t *element = NULL;
    
    SpcGetDataByte(SpcValue, element);
    val = (uint8_t)((element.val >> element.offset) & element.field);
    line2 = SpcGetDataByteStr(SpcValue, val);
    Spc_ScreenUpdateStatic(element.line1, line2);
    return SPC_KEY_NORMAL;
}

SpcKeyType_t SpcEntryShowInt16(SpcValue_t *SpcValue)
{
    char buf[SPC_MAX_STR_LEN] = {0};
    const SpcDataInt_t *element = NULL;

    SpcGetDataInt16(SpcValue, element);
    snprintf(buf, SPC_MAX_STR_LEN, "%s%d%s", element.prefix,
        element.val, element.suffix);
    Spc_ScreenUpdateDynamic(element.line1, buf);
    return SPC_KEY_NORMAL;
}

SpcKeyType_t SpcEntryShowInt32(SpcValue_t *SpcValue)
{
    char buf[SPC_MAX_STR_LEN] = {0};
    const SpcDataInt_t *element = NULL;

    SpcGetDataInt32(SpcValue, element);
    snprintf(buf, SPC_MAX_STR_LEN, "%s%d%s", element.prefix,
        element.val, element.suffix);
    Spc_ScreenUpdateDynamic(element.line1, buf);
    return SPC_KEY_NORMAL;
}

static SpcKeyType_t SpcGetDataByte(SpcValue_t *SpcValue, const SpcDataByte_t *element)
{
    SpcInfoType_t infoType = SpcPosition(SpcValue);
    for (int16_t i=0; i<NUM_ROWS(SpcDataByte);i++) {
        if (SpcDataByte[i].type == infoType) {
            element = &SpcDataByte[i];
            return SPC_KEY_NORMAL;
        }
    }
}

static SpcKeyType_t SpcGetDataInt16(SpcValue_t *SpcValue, const SpcDataInt16_t *element)
{
    SpcInfoType_t infoType = SpcPosition(SpcValue);
    for (int16_t i=0; i<NUM_ROWS(SpcDataInt16);i++) {
        if (SpcDataInt16[i].type == infoType) {
            element = &SpcDataInt16[i];
            return SPC_KEY_NORMAL;
        }
    }
}

static SpcKeyType_t SpcGetDataInt32(SpcValue_t *SpcValue, const SpcDataInt32_t *element)
{
    SpcInfoType_t infoType = SpcPosition(SpcValue);
    for (int16_t i=0; i<NUM_ROWS(SpcDataInt32);i++) {
        if (SpcDataInt32[i].type == infoType) {
            element = &SpcDataInt32[i];
            return SPC_KEY_NORMAL;
        }
    }
}

static SpcKeyType_t SpcGetDataTemp(SpcValue_t *SpcValue, const SpcDataTemp_t *element)
{
    SpcInfoType_t infoType = SpcPosition(SpcValue);
    for (int16_t i=0; i<NUM_ROWS(SpcDataTemp);i++) {
        if (SpcDataTemp[i].type == infoType) {
            element = &SpcDataTemp[i];
            return SPC_KEY_NORMAL;
        }
    }
}


SpcKeyType_t SpcResetInit(SpcValue_t *SpcValue)
{
    // Now is going to reset single statistic
    SpcInfoType_t infoType = SpcPosition(SpcValue);
    SpcResetStorePos(SpcValue) = infoType;
    return 60;
}

SpcKeyType_t SpcResetExit(SpcValue_t *SpcValue)
{
    // Now is going back to normal
    return SpcResetStorePos(SpcValue);
}

SpcKeyType_t SpcResetIntOpt(SpcValue_t *SpcValue)
{
    // Now is going back to normal
    const SpcStatisInt_t *element = NULL;
    SpcInfoType_t preType = SpcResetStorePos(SpcValue);
    
    SpcGetStaticInt(SpcValue, element);
    element.val = element.source;
    Spc_ScreenUpdateStatic(SPC_RESET_STR, SPC_RESET_COMP_STR);

    osDelay(2000);

    return SpcResetStorePos(SpcValue);
}

static SpcKeyType_t SpcGetStaticInt(SpcValue_t *SpcValue, const SpcDataInt32_t *element)
{
    SpcInfoType_t preType = SpcResetStorePos(SpcValue);
    for (int16_t i=0; i<NUM_ROWS(SpcStatisInt);i++) {
        if (SpcStatisInt[i].type == infoType) {
            element = &SpcStatisInt[i];
            return SPC_KEY_NORMAL;
        }
    }
}

SpcKeyType_t SpcResetTempOpt(SpcValue_t *SpcValue)
{
    // Now is going back to normal
    const SpcStatisTemp_t *element = NULL;
    SpcInfoType_t preType = SpcResetStorePos(SpcValue);
    
    SpcGetStaticTemp(SpcValue, element);
    element.val = element.source;
    Spc_ScreenUpdateStatic(SPC_RESET_STR, SPC_RESET_COMP_STR);

    osDelay(2000);

    return SpcResetStorePos(SpcValue);
}

static SpcKeyType_t SpcGetStaticTemp(SpcValue_t *SpcValue, const SpcDataInt32_t *element)
{
    SpcInfoType_t preType = SpcResetStorePos(SpcValue);
    for (int16_t i=0; i<NUM_ROWS(SpcStatisTemp);i++) {
        if (SpcStatisTemp[i].type == infoType) {
            element = &SpcStatisTemp[i];
            return SPC_KEY_NORMAL;
        }
    }
}

SpcKeyType_t SpcConfTempInit(SpcValue_t *SpcValue)
{
    // Now is going to config temp
    SpcInfoType_t infoType = SpcPosition(SpcValue);
    SpcResetStorePos(SpcValue) = infoType;

    const SpcDataTemp_t *element = NULL;
    SpcGetDataTemp(SpcValue, element);
    memcpy(&SpcStoreTemp(SpcValue), &(element->temp), sizeof(temp));
    return 63;
}

SpcKeyType_t SpcEntryConfTemp(SpcValue_t *SpcValue)
{
    if (SpcStoreTemp(SpcValue).tempStatus == SPC_TEMP_RTD_SHORT) {
        Spc_ScreenUpdateStatic(element.line1, SPC_RTD_SHORT_STR);
    } else if (SpcStoreTemp(SpcValue).tempStatus == SPC_TEMP_RTD_OPEN) {
        Spc_ScreenUpdateStatic(element.line1, SPC_TEMP_RTD_OPEN);
    } else {
        char buf[SPC_MAX_STR_LEN] = {0};
        if (SpcConf(SpcValue).bytes.unit == SpcTempInCelsius)
            snprintf(buf, SPC_MAX_STR_LEN, "%d C", SpcStoreTemp(SpcValue).tempc);
        else
            snprintf(buf, SPC_MAX_STR_LEN, "%d F", SpcStoreTemp(SpcValue).tempf);
        Spc_ScreenUpdateDynamic(element.line1, buf);
    }
    return SPC_KEY_NORMAL;
}

SpcKeyType_t SpcConfTempUp(SpcValue_t *SpcValue)
{
    SpcInfoType_t infoType = SpcPosition(SpcValue);

    uint8_t val;
    SpcStringType_t line2;

    const SpcDataTemp_t *element = NULL;
    SpcGetDataTemp(SpcValue, element);
    if (SpcStoreTemp(SpcValue).tempStatus == SPC_SYSTEMVALUE_NONE){
        SpcStoreTemp(SpcValue).tempStatus = SPC_SYSTEMVALUE_OFF;
        Spc_ScreenUpdateStatic(element.line1, SPC_RTD_NONE_STR);
    } else{
        char buf[SPC_MAX_STR_LEN] = {0};
        if (SpcConf(SpcValue).bytes.unit == SpcTempInCelsius) {
            SpcStoreTemp(SpcValue).tempc++;
            if (SpcStoreTemp(SpcValue).tempc > MAX_C) {
                SpcStoreTemp(SpcValue).tempc = MAX_C;
                SpcStoreTemp(SpcValue).tempStatus = SPC_SYSTEMVALUE_NONE;
                Spc_ScreenUpdateStatic(element.line1, SPC_RTD_NONE_STR);
                return;
            } else {
                snprintf(buf, SPC_MAX_STR_LEN, "%d C", SpcStoreTemp(SpcValue).tempc);
            }
        } else {
            SpcStoreTemp(SpcValue).tempf++;
            if (SpcStoreTemp(SpcValue).tempf > MAX_F) {
                SpcStoreTemp(SpcValue).tempf = MAX_F;
                SpcStoreTemp(SpcValue).tempStatus = SPC_SYSTEMVALUE_NONE;
                Spc_ScreenUpdateStatic(element.line1, SPC_RTD_NONE_STR);
                return;
            } else {
                snprintf(buf, SPC_MAX_STR_LEN, "%d F", SpcStoreTemp(SpcValue).tempf);
            }
        }
        Spc_ScreenUpdateDynamic(element.line1, buf);
    }
    return 63;
}

SpcKeyType_t SpcConfTempDown(SpcValue_t *SpcValue)
{
    SpcInfoType_t infoType = SpcPosition(SpcValue);

    uint8_t val;
    SpcStringType_t line2;

    const SpcDataTemp_t *element = NULL;
    SpcGetDataTemp(SpcValue, element);
    if (SpcStoreTemp(SpcValue).tempStatus == SPC_SYSTEMVALUE_OFF){
        SpcStoreTemp(SpcValue).tempStatus = SPC_SYSTEMVALUE_NONE;
        Spc_ScreenUpdateStatic(element.line1, SPC_RTD_NONE_STR);
    } else if (SpcStoreTemp(SpcValue).tempStatus == SPC_SYSTEMVALUE_NONE) {
        char buf[SPC_MAX_STR_LEN] = {0};
        SpcStoreTemp(SpcValue).tempStatus = SPC_NORMAL;
        SpcStoreTemp(SpcValue).tempc = MAX_C;
        SpcStoreTemp(SpcValue).tempf = MAX_F;
        if (SpcConf(SpcValue).bytes.unit == SpcTempInCelsius)
            snprintf(buf, SPC_MAX_STR_LEN, "%d C", MAX_C);
        else
            snprintf(buf, SPC_MAX_STR_LEN, "%d F", MAX_F);
        Spc_ScreenUpdateDynamic(element.line1, buf);
    } else {
        char buf[SPC_MAX_STR_LEN] = {0};
        if (SpcConf(SpcValue).bytes.unit == SpcTempInCelsius) {
            SpcStoreTemp(SpcValue).tempc--;
            if (SpcStoreTemp(SpcValue).tempc < MIN_C) SpcStoreTemp(SpcValue).tempc = MIN_C;
            snprintf(buf, SPC_MAX_STR_LEN, "%d C", SpcStoreTemp(SpcValue).tempc);
        } else {
            SpcStoreTemp(SpcValue).tempf--;
            if (SpcStoreTemp(SpcValue).tempf < MIN_F) SpcStoreTemp(SpcValue).tempf = MIN_F;
            snprintf(buf, SPC_MAX_STR_LEN, "%d F", SpcStoreTemp(SpcValue).tempf);
        }
        Spc_ScreenUpdateDynamic(element.line1, buf);
    }
    return 63;
}

SpcKeyType_t SpcConfTempReset(SpcValue_t *SpcValue)
{
    // Now is going to config temp
    SpcConfTempInit(SpcValue);
    SpcEntryConfTemp(SpcValue);
    return 63;
}

SpcKeyType_t SpcConfTempEnter(SpcValue_t *SpcValue)
{
        // Now is going to config temp
    SpcInfoType_t infoType = SpcPosition(SpcValue);
    SpcResetStorePos(SpcValue) = infoType;

    const SpcDataTemp_t *element = NULL;
    SpcGetDataTemp(SpcValue, element);


    if (SpcStoreTemp(SpcValue).tempStatus != SPC_NORMAL) {
        if (SpcConf(SpcValue).bytes.unit == SpcTempInCelsius) {
            SpcStoreTemp(SpcValue).tempf = convCF(SpcStoreTemp(SpcValue).tempc);
        } else {
            SpcStoreTemp(SpcValue).tempc = convCF(SpcStoreTemp(SpcValue).tempf);
        }
    }
    memcpy(&(element->temp), &SpcStoreTemp(SpcValue), sizeof(temp));
    SpcShowTemperature(element.line1, element);
    return SpcResetStorePos(SpcValue);
}
#endif
/*----------------------------------------------------------------------------*/
/* Public functions                                                           */
/*----------------------------------------------------------------------------*/
static void SpcTask(void const *arg)
{
    osEvent event;
    uint16_t command = 0;

    Spc_StartupLog();
    Spc_SystemInit(&SpcValue);
    Spc_SelfCheck(&SpcValue);
    SpcShowDefInfo(&SpcValue);

    while (1) {
        event = osMessageGet(SpcKeyQueueHandle, SPC_KEY_MONITOR_TIMEOUT);
        if (event.status == osEventMessage) {
            command = event.value.v;
            Spc_KeyOptProcess(&SpcValue, command);
        }
    }
}

static SpcKeyType_t Spc_KeyOptProcess(SpcValue_t *SpcValue, uint16_t command)
{
    SpcInfoType_t infoType = SpcPosition(SpcValue);
    SpcInfoType_t nextType = infoType;
    switch(command) {
        case SPC_KEY_RIGHT:
            if (SpcRight(infoType).action != NULL) {
                nextType = SpcRight(infoType).action(SpcValue);
            } else {
                nextType = SpcRight(infoType).type;
            }
            break;
        case SPC_KEY_LEFT:
            if (SpcLeft(infoType).action != NULL) {
                nextType = SpcLeft(infoType).action(SpcValue);
            } else {
                nextType = SpcLeft(infoType).type;
            }
            break;
        case SPC_KEY_UP:
            if (SpcUp(infoType).action != NULL) {
                nextType = SpcUp(infoType).action(SpcValue);
            } else {
                nextType = SpcUp(infoType).type;
            }
            break;
        case SPC_KEY_DOWN:
            if (SpcDown(infoType).action != NULL) {
                nextType = SpcDown(infoType).action(SpcValue);
            } else {
                nextType = SpcDown(infoType).type;
            }
            break;
        case SPC_KEY_ACT:
            if (SpcAct(infoType).action != NULL) {
                nextType = SpcAct(infoType).action(SpcValue);
            } else {
                nextType = SpcAct(infoType).type;
            }
            break;
        case SPC_KEY_PROG:
            if (SpcProg(infoType).action != NULL) {
                nextType = SpcProg(infoType).action(SpcValue);
            } else {
                nextType = SpcProg(infoType).type;
            }
            break;
        case SPC_KEY_RESET:
            if (SpcReset(infoType).action != NULL) {
                nextType = SpcReset(infoType).action(SpcValue);
            } else {
                nextType = SpcReset(infoType).type;
            }
            break;
        case SPC_KEY_ENTER:
            if (SpcEnter(infoType).action != NULL) {
                nextType = SpcEnter(infoType).action(SpcValue);
            } else {
                nextType = SpcEnter(infoType).type;
            }
            break;
        case SPC_KEY_ALARM:
            if (SpcAlarm(infoType).action != NULL) {
                nextType = SpcAlarm(infoType).action(SpcValue);
            } else {
                nextType = SpcAlarm(infoType).type;
            }
            break;
    }

    if (nextType != infoType) {
        SpcPosition(SpcValue) = nextType;
        SpcInitEntry(nextType).action(SpcValue);
    }
    return SPC_KEY_NORMAL;
}