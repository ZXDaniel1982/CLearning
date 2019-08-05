#include <stdio.h>
#include <stdlib.h>
#include <string.h>
#include <unistd.h>

#include "spcinit.h"

static SpcStatus_t Spc_TestTemp(SpcValue_t *SpcValue);
static SpcStatus_t Spc_TestGfi(SpcValue_t *SpcValue);

void Spc_StartupLog(void)
{
	int i;
 
    for (i = 0; i < NUM_ROWS(spcStartupLogOn); i++) {
        printf("%s\n", spcStartupLogOn[i]);
    }

    sleep(2);
    clear();
    for (i = 0; i < NUM_ROWS(spcStartupLogOff); i++) {
        printf("%s\n", spcStartupLogOff[i]);
    }

    sleep(2);
    Spc_ScreenUpdateStatic(SPC_FIRMWARE_NAME_STR, SPC_FIRMWARE_VER_STR);

    sleep(2);
}

void Spc_SystemInit(SpcValue_t *SpcValue)
{
    SpcConf(SpcValue).bytes.manual = SpcManuOptDis;
    SpcConf(SpcValue).bytes.rdtStat = SPC_RTD_OFF;
    SpcConf(SpcValue).bytes.unit = SpcTempInCelsius;
    SpcConf(SpcValue).bytes.defInfo = HEATER_STATUS_MOD;
    SpcConf(SpcValue).bytes.rtdMod = SPC_ONE_RTD_MOD;

    SpcConfMainTemp(SpcValue).status = SPC_DATA_NORMAL;

    SpcListInit(&SpcAlarmList(SpcValue), SPC_MAX_LIST);
}

void Spc_SelfCheck(SpcValue_t *SpcValue)
{
	Spc_ScreenUpdateStatic(SPC_SYSTEMCHK_STR, SPC_BLANK_STR);

    if ((Spc_TestTemp(SpcValue) == SPC_ERROR) ||
        (Spc_TestGfi(SpcValue) == SPC_ERROR)) {
        Spc_AlarmMgr(&SpcAlarmList(SpcValue), SPC_ALARM_SELFCHKFAIL, SpcAlarmEn);
        Spc_ScreenUpdateStatic(SPC_SELFCHKFAIL_STR, SPC_BLANK_STR);
    }

    sleep(2);
}

void SpcShowDefInfo(SpcValue_t *SpcValue)
{
    switch (SpcConf(SpcValue).bytes.defInfo) {
    case SYSTEM_STATUS_MOD:
        SpcPosition(SpcValue) = 60;
        break;
    case HEATER_STATUS_MOD:
        SpcPosition(SpcValue) = 61;
        break;
    case HEATER_TEMP_MOD:
        SpcPosition(SpcValue) = 62;
        break;
    }

    SpcInfoType_t infoType = SpcPosition(SpcValue);
    SpcInitEntry(infoType).action(SpcValue);
}

void SpcSetTestData(SpcValue_t *SpcValue)
{
    SpcTemp(SpcValue, SPC_RTD_COMBIN).status = SPC_TEST_TEMP_STATUS;
    SpcTemp(SpcValue, SPC_RTD_COMBIN).tempf = SPC_SIMULATE_TEMP_F;
    SpcTemp(SpcValue, SPC_RTD_COMBIN).tempc = SPC_SIMULATE_TEMP_C;

    SpcTemp(SpcValue, SPC_RTD_CHANNEL1).status = SPC_RTD_SHORT;
    SpcTemp(SpcValue, SPC_RTD_CHANNEL1).tempf = SPC_SIMULATE_TEMP_F;
    SpcTemp(SpcValue, SPC_RTD_CHANNEL1).tempc = SPC_SIMULATE_TEMP_C;

    SpcTemp(SpcValue, SPC_RTD_CHANNEL2).status = SPC_RTD_OPEN;
    SpcTemp(SpcValue, SPC_RTD_CHANNEL2).tempf = SPC_SIMULATE_TEMP_F;
    SpcTemp(SpcValue, SPC_RTD_CHANNEL2).tempc = SPC_SIMULATE_TEMP_C;

    SpcConf(SpcValue).bytes.unit = SpcTempInCelsius;
    SpcConf(SpcValue).bytes.heater_en = 1;
    SpcConf(SpcValue).bytes.ctl_type = 1;

    SpcConfTimeout(SpcValue).status = SPC_DATA_NORMAL;
    SpcConfTimeout(SpcValue).val = 120;
    SpcPercent(SpcValue) = 10;
    SpcCurrent(SpcValue) = 30;
    SpcVoltage(SpcValue) = 110;

    SpcConfLowCurrent(SpcValue).status = SPC_OFF;
    SpcConfHighCurrent(SpcValue).status = SPC_OFF;

    strncpy(SpcName(SpcValue), "My Spc           ", SPC_MAX_STR_LEN);
    strncpy(SpcPassword(SpcValue), "1234", SPC_MAX_STR_LEN);
}

static SpcStatus_t Spc_TestTemp(SpcValue_t *SpcValue)
{
    uint8_t Channel;
    for (Channel=SPC_RTD_CHANNEL1; Channel<SPC_MAX_RTD_CHANNEL; Channel++) {
        SpcTemp(SpcValue, Channel).status = SPC_TEST_TEMP_STATUS;
        SpcTemp(SpcValue, Channel).tempf = SPC_SIMULATE_TEMP_F;
        SpcTemp(SpcValue, Channel).tempc = SPC_SIMULATE_TEMP_C;
    }

    if (SpcTemp(SpcValue, SPC_RTD_CHANNEL1).status != SPC_DATA_NORMAL) {
        if ((SpcConf(SpcValue).bytes.rtdMod == SPC_ONE_RTD_MOD) ||
            (SpcTemp(SpcValue, SPC_RTD_CHANNEL2).status != SPC_DATA_NORMAL)) {
            return SPC_ERROR;
        }
    }

    return SPC_NORMAL;
}

static SpcStatus_t Spc_TestGfi(SpcValue_t *SpcValue)
{
    SpcStatus_t ret = SPC_NORMAL; 

    SpcGfi(SpcValue) = SPC_SIMULATE_GFI;
    if (SpcGfi(SpcValue) > SPC_MAX_GFI) {
        ret = SPC_ERROR;
    }

    return ret;
}