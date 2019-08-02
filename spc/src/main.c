#include <stdio.h>
#include <stdlib.h>
#include <stdbool.h>
#include <string.h>
#include <termios.h>
#include <unistd.h>
#include <sys/types.h>
#include <sys/time.h>
#include <sys/ioctl.h>

#include "spcinit.h"

static int stdin_fd = -1;
static struct termios original;

SpcValue_t SpcValue = {0};

static SpcKeyType_t Spc_KeyOptProcess(SpcValue_t *SpcValue, uint16_t command);
static const SpcDataTemp_t *SpcGetDataTemp(SpcInfoType_t infoType);
static const SpcStatisticInt_t *SpcGetStatisticInt(SpcInfoType_t infoType);
static const SpcDataInt16_t *SpcGetDataInt16(SpcInfoType_t infoType);
static const SpcDataInt32_t *SpcGetDataInt32(SpcValue_t *SpcValue);
static const SpcDataByte_t *SpcGetDataByte(SpcValue_t *SpcValue);
static const SpcConfDataInt16_t *SpcGetConfInt16(SpcInfoType_t infoType);
static const SpcStringType_t SpcGetDataByteStr(const SpcDataByte_t *element, uint8_t val);
static void SpcShowTemperature(SpcValue_t *SpcValue, int16_t line1, SpcTemperature_t *temp);

static void SpcUpdateDipTemp(SpcTemperature_t *temp, int16_t line1);
static void SpcModifyTemp(SpcTemperature_t *temp, int16_t max, int16_t min, bool increase);
static void SpcTempCorrect(SpcValue_t *SpcValue);

static void SpcConvertTemp(SpcTemperature_t *temp);
static inline int16_t ConvertCtoF(int16_t sourse);
static inline int16_t ConvertFtoC(int16_t sourse);

static void SpcLTempLimit(SpcValue_t *SpcValue, SpcTemperature_t *highTemp);
static void SpcHTempLimit(SpcValue_t *SpcValue, SpcTemperature_t *highTemp);
static void SpcDTempLimit(SpcValue_t *SpcValue, SpcTemperature_t *deadband);

static void SpcUpdateDipInt(SpcConfInt16_t *data, const SpcConfDataInt16_t *element);
static void SpcModifyInt(SpcConfInt16_t *data, SpcInfoType_t infoType, bool increase);
static uint8_t SpcGetConfStatusIndex(const SpcConfIntLimit_t *element, SpcDataStatus_t status);
static const SpcConfIntLimit_t *SpcGetConfIntLimit(SpcInfoType_t infoType);

bool keyPressed(int *character)
{
    // If this is the first time the function is called, change the stdin
    // stream so that we get each character when the keys are pressed and
    // and so that character aren't echoed to the screen when the keys are
    // pressed.
    if (stdin_fd == -1)
    {
        // Get the file descriptor associated with stdin stream.
        stdin_fd = fileno(stdin);

        // Get the terminal (termios) attritubets for stdin so we can
        // modify them and reset them before exiting the program.
        tcgetattr(stdin_fd, &original);

        // Copy the termios attributes so we can modify them.
        struct termios term;
        memcpy(&term, &original, sizeof(term));

        // Unset ICANON and ECHO for stdin. When ICANON is not set the
        // input is in noncanonical mode. In noncanonical mode input is
        // available as each key is pressed. In canonical mode input is
        // only available after the enter key is pressed. Unset ECHO so that
        // the characters aren't echoed to the screen when keys are pressed.
        // See the termios(3) man page for more information.
        term.c_lflag &= ~(ICANON|ECHO);
        tcsetattr(stdin_fd, TCSANOW, &term);

        // Turn off buffering for stdin. We want to get the characters
        // immediately. We don't want the characters to be buffered.
        setbuf(stdin, NULL);
    }

    // Get the number of characters that are waiting to be read.
    int characters_buffered = 0;
    ioctl(stdin_fd, FIONREAD, &characters_buffered);

    // Set the return value to true if there are any characters to be read.
    bool pressed = (characters_buffered != 0);

    if (characters_buffered == 1)
    {
        // There is only one character to be read. Read it in.
        int c = fgetc(stdin);

        // Check if the caller wants the value of character read.
        if (character != NULL)
        {
            *character = c;
        }
    }
    else if (characters_buffered > 1)
    {
        // There is more than one character to be read. This can be key such
        // as the arrow keys or function keys. This code just reads them in
        // and ignores them. The caller will be informed that a key was
        // pressed, but won't get a value for the key.
        while (characters_buffered)
        {
            fgetc(stdin);
            --characters_buffered;
        }
    }

    return pressed;
}

int main()
{
    int command = 0;
    Spc_StartupLog();
    Spc_SystemInit(&SpcValue);
    Spc_SelfCheck(&SpcValue);
    SpcShowDefInfo(&SpcValue);
    SpcSetTestData(&SpcValue);

    while ( 1 ) {
        if (keyPressed(&command)) {
            Spc_KeyOptProcess(&SpcValue, command);
        }
    }
    return 0;
}

void Spc_AlarmRaise(SpcAlarmType_t alarmType)
{
    SpcValue.alarm.alarmMask |= alarmType;
}

void Spc_AlarmClear(SpcAlarmType_t alarmType)
{
    SpcValue.alarm.alarmMask &= ~alarmType;
}

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

SpcKeyType_t SpcEntryShowId(SpcValue_t *SpcValue)
{
    Spc_ScreenUpdateDynamic(SPC_MENU_PROG_HEATID_STR, SpcName(SpcValue));
    return SPC_KEY_NORMAL;
}

SpcKeyType_t SpcEntryShowHeatStatus(SpcValue_t *SpcValue)
{
    SpcRTDStatus_t rtdStatus = (SpcRTDStatus_t) (SpcConf(SpcValue).bytes.rdtStat);
    SpcStringType_t line1 = SpcRtdStatStrPool[rtdStatus].line1;
    SpcStringType_t line2 = SpcRtdStatStrPool[rtdStatus].line2;
    Spc_ScreenUpdateStatic(line1, line2);
    return SPC_KEY_NORMAL;
}

SpcKeyType_t SpcEntryShowHeatTemp(SpcValue_t *SpcValue)
{
    SpcInfoType_t infoType = SpcPosition(SpcValue);
    const SpcDataTemp_t *element = SpcGetDataTemp(infoType);

    if (SpcConfMainTemp(SpcValue).status == SPC_OFF) {
        Spc_ScreenUpdateStatic(element->line1, SPC_BLANK_STR);
    } else {
        SpcShowTemperature(SpcValue, element->line1, element->temp);
    }

    return SPC_KEY_NORMAL;
}

SpcKeyType_t SpcEntryShowInt16(SpcValue_t *SpcValue)
{
    SpcInfoType_t infoType = SpcPosition(SpcValue);
    char buf[SPC_MAX_STR_LEN] = {0};
    const SpcDataInt16_t *element = SpcGetDataInt16(infoType);

    snprintf(buf, SPC_MAX_STR_LEN, "%s%d%s", element->prefix,
        *(element->val), element->suffix);
    Spc_ScreenUpdateDynamic(element->line1, buf);
    return SPC_KEY_NORMAL;
}

SpcKeyType_t SpcEntryShowConfInt16(SpcValue_t *SpcValue)
{
    SpcInfoType_t infoType = SpcPosition(SpcValue);
    const SpcConfDataInt16_t *element = SpcGetConfInt16(infoType);

    if (element->data->status == SPC_DISABLE) {
        Spc_ScreenUpdateStatic(element->line1, SPC_DISABLE_STR);
    } else if (element->data->status == SPC_CONTINUE) {
        Spc_ScreenUpdateStatic(element->line1, SPC_CONTINUE_STR);
    } else if (element->data->status == SPC_OFF) {
        Spc_ScreenUpdateStatic(element->line1, SPC_OFF_STR);
    } else {
        char buf[SPC_MAX_STR_LEN] = {0};
        snprintf(buf, SPC_MAX_STR_LEN, "%s%d%s", element->prefix,
            element->data->val, element->suffix);
        Spc_ScreenUpdateDynamic(element->line1, buf);
    }
    return SPC_KEY_NORMAL;
}

SpcKeyType_t SpcEntryShowInt32(SpcValue_t *SpcValue)
{
    char buf[SPC_MAX_STR_LEN] = {0};
    const SpcDataInt32_t *element = SpcGetDataInt32(SpcValue);

    snprintf(buf, SPC_MAX_STR_LEN, "%s%d%s", element->prefix,
        *(element->val), element->suffix);
    Spc_ScreenUpdateDynamic(element->line1, buf);
    return SPC_KEY_NORMAL;
}

SpcKeyType_t SpcEntryShowByte(SpcValue_t *SpcValue)
{
    uint32_t word = SpcConf(SpcValue).word;
    char buf[SPC_MAX_STR_LEN] = {0};
    const SpcDataByte_t *element = SpcGetDataByte(SpcValue);

    uint8_t val = (uint8_t)((word >> element->offset) & element->field);
    const SpcStringType_t line2 = SpcGetDataByteStr(element, val);
    Spc_ScreenUpdateStatic(element->line1, line2);
    return SPC_KEY_NORMAL;
}

SpcKeyType_t SpcEntryShowSysStatus(SpcValue_t *SpcValue)
{
    char buf[SPC_MAX_STR_LEN] = {0};

    snprintf(buf, sizeof(buf), "%d Alarms", SpcAlarmList(SpcValue).totalNum);
    Spc_ScreenUpdateDynamic(SPC_DEF_SYS_STATUS_STR, buf);
    return SPC_KEY_NORMAL;
}


//=========================================================================================
// Enter reset statistic
//=========================================================================================
SpcKeyType_t SpcPushTempRet(SpcValue_t *SpcValue)
{
    SpcStackPos(SpcValue) = SpcPosition(SpcValue);

    return 63;
}

SpcKeyType_t SpcPushIntRet(SpcValue_t *SpcValue)
{
    SpcStackPos(SpcValue) = SpcPosition(SpcValue);

    return 65;
}

SpcKeyType_t SpcPushAllRet(SpcValue_t *SpcValue)
{
    SpcStackPos(SpcValue) = SpcPosition(SpcValue);

    return 67;
}

SpcKeyType_t SpcResetRet(SpcValue_t *SpcValue)
{
    return SpcStackPos(SpcValue);
}

SpcKeyType_t SpcConfirmTemp(SpcValue_t *SpcValue)
{
    SpcInfoType_t infoType = SpcStackPos(SpcValue);
    const SpcDataTemp_t *element = SpcGetDataTemp(infoType);

    memcpy(element->temp, &SpcTemp(SpcValue,SPC_RTD_COMBIN), sizeof(SpcTemperature_t));

    Spc_ScreenUpdateStatic(SPC_MENU_RESET_FINISH_STR, SPC_BLANK_STR);

    sleep(2);

    return SpcStackPos(SpcValue);
}

SpcKeyType_t SpcConfirmInt(SpcValue_t *SpcValue)
{
    SpcInfoType_t infoType = SpcStackPos(SpcValue);
    const SpcDataInt16_t *element = SpcGetDataInt16(infoType);
    const SpcStatisticInt_t *elementStat = SpcGetStatisticInt(infoType);

    memcpy(element->val, elementStat->val, sizeof(int16_t));

    Spc_ScreenUpdateStatic(SPC_MENU_RESET_FINISH_STR, SPC_BLANK_STR);

    sleep(2);

    return SpcStackPos(SpcValue);
}

SpcKeyType_t SpcConfirmAll(SpcValue_t *SpcValue)
{
    memcpy(&SpcMaxTemp(SpcValue), &SpcTemp(SpcValue,SPC_RTD_COMBIN), sizeof(SpcTemperature_t));
    memcpy(&SpcMinTemp(SpcValue), &SpcTemp(SpcValue,SPC_RTD_COMBIN), sizeof(SpcTemperature_t));
    SpcMaxCurrent(SpcValue) = SpcCurrent(SpcValue);
    SpcMaxGFI(SpcValue) = SpcGfi(SpcValue);
    SpcMaxVolt(SpcValue) = SpcVoltage(SpcValue);
    SpcMinVolt(SpcValue) = SpcVoltage(SpcValue);
    SpcUsage(SpcValue) = 0;
    SpcOnPercent(SpcValue) = 0;
    SpcCost(SpcValue) = 0;
    SpcRunTime(SpcValue) = 0;

    Spc_ScreenUpdateStatic(SPC_MENU_RESET_FINISH_STR, SPC_BLANK_STR);

    sleep(2);

    return SpcStackPos(SpcValue);
}

//=========================================================================================
// Enter config temperature
//=========================================================================================
SpcKeyType_t SpcPushTmUp(SpcValue_t *SpcValue)
{
    SpcInfoType_t infoType = SpcPosition(SpcValue);
    const SpcDataTemp_t *element = SpcGetDataTemp(infoType);

    memcpy(&SpcStackTemp(SpcValue), element->temp, sizeof(SpcTemperature_t));

    if (SpcConf(SpcValue).bytes.unit == SpcTempInCelsius) {
        SpcModifyTemp(&SpcStackTemp(SpcValue), MAX_TEMP_C, MIN_TEMP_C, true);
    } else {
        SpcModifyTemp(&SpcStackTemp(SpcValue), MAX_TEMP_F, MIN_TEMP_F, true);
    }

    if (infoType == 24)
        SpcLTempLimit(SpcValue, &SpcStackTemp(SpcValue));

    if (infoType == 25)
        SpcHTempLimit(SpcValue, &SpcStackTemp(SpcValue));

    if (infoType == 37)
        SpcDTempLimit(SpcValue, &SpcStackTemp(SpcValue));

    SpcUpdateDipTemp(&SpcStackTemp(SpcValue), element->line1);

    SpcStackPos(SpcValue) = SpcPosition(SpcValue);

    return 69;
}

SpcKeyType_t SpcPushTmDown(SpcValue_t *SpcValue)
{
    SpcInfoType_t infoType = SpcPosition(SpcValue);
    const SpcDataTemp_t *element = SpcGetDataTemp(infoType);

    memcpy(&SpcStackTemp(SpcValue), element->temp, sizeof(SpcTemperature_t));

    if (SpcConf(SpcValue).bytes.unit == SpcTempInCelsius) {
        SpcModifyTemp(&SpcStackTemp(SpcValue), MAX_TEMP_C, MIN_TEMP_C, false);
    } else {
        SpcModifyTemp(&SpcStackTemp(SpcValue), MAX_TEMP_F, MIN_TEMP_F, false);
    }

    if (infoType == 24)
        SpcLTempLimit(SpcValue, &SpcStackTemp(SpcValue));

    if (infoType == 25)
        SpcHTempLimit(SpcValue, &SpcStackTemp(SpcValue));

    if (infoType == 37)
        SpcDTempLimit(SpcValue, &SpcStackTemp(SpcValue));

    SpcUpdateDipTemp(&SpcStackTemp(SpcValue), element->line1);

    SpcStackPos(SpcValue) = SpcPosition(SpcValue);

    return 69;
}

SpcKeyType_t SpcUpTemp(SpcValue_t *SpcValue)
{
    SpcInfoType_t infoType = SpcStackPos(SpcValue);
    const SpcDataTemp_t *element = SpcGetDataTemp(infoType);

    if (SpcConf(SpcValue).bytes.unit == SpcTempInCelsius) {
        SpcModifyTemp(&SpcStackTemp(SpcValue), MAX_TEMP_C, MIN_TEMP_C, true);
    } else {
        SpcModifyTemp(&SpcStackTemp(SpcValue), MAX_TEMP_F, MIN_TEMP_F, true);
    }

    if (infoType == 24)
        SpcLTempLimit(SpcValue, &SpcStackTemp(SpcValue));

    if (infoType == 25)
        SpcHTempLimit(SpcValue, &SpcStackTemp(SpcValue));

    if (infoType == 37)
        SpcDTempLimit(SpcValue, &SpcStackTemp(SpcValue));

    SpcUpdateDipTemp(&SpcStackTemp(SpcValue), element->line1);

    return SpcPosition(SpcValue);
}

SpcKeyType_t SpcDownTemp(SpcValue_t *SpcValue)
{
    SpcInfoType_t infoType = SpcStackPos(SpcValue);
    const SpcDataTemp_t *element = SpcGetDataTemp(infoType);

    if (SpcConf(SpcValue).bytes.unit == SpcTempInCelsius) {
        SpcModifyTemp(&SpcStackTemp(SpcValue), MAX_TEMP_C, MIN_TEMP_C, false);
    } else {
        SpcModifyTemp(&SpcStackTemp(SpcValue), MAX_TEMP_F, MIN_TEMP_F, false);
    }

    if (infoType == 24)
        SpcLTempLimit(SpcValue, &SpcStackTemp(SpcValue));

    if (infoType == 25)
        SpcHTempLimit(SpcValue, &SpcStackTemp(SpcValue));

    if (infoType == 37)
        SpcDTempLimit(SpcValue, &SpcStackTemp(SpcValue));

    SpcUpdateDipTemp(&SpcStackTemp(SpcValue), element->line1);

    return SpcPosition(SpcValue);
}


SpcKeyType_t SpcPopRight(SpcValue_t *SpcValue)
{
    SpcInfoType_t nextType;
    SpcInfoType_t infoType = SpcStackPos(SpcValue);

    if (SpcRight(infoType).action != NULL) {
        nextType = SpcRight(infoType).action(SpcValue);
    } else {
        nextType = SpcRight(infoType).type;
    }
    return nextType;
}

SpcKeyType_t SpcPopLeft(SpcValue_t *SpcValue)
{
    SpcInfoType_t nextType;
    SpcInfoType_t infoType = SpcStackPos(SpcValue);

    if (SpcLeft(infoType).action != NULL) {
        nextType = SpcLeft(infoType).action(SpcValue);
    } else {
        nextType = SpcLeft(infoType).type;
    }
    return nextType;
}

SpcKeyType_t SpcPopProg(SpcValue_t *SpcValue)
{
    SpcInfoType_t nextType;
    SpcInfoType_t infoType = SpcStackPos(SpcValue);

    if (SpcProg(infoType).action != NULL) {
        nextType = SpcProg(infoType).action(SpcValue);
    } else {
        nextType = SpcProg(infoType).type;
    }
    return nextType;
}

SpcKeyType_t SpcPopTempConf(SpcValue_t *SpcValue)
{
    SpcInfoType_t infoType = SpcStackPos(SpcValue);
    const SpcDataTemp_t *element = SpcGetDataTemp(infoType);
    SpcConvertTemp(&SpcStackTemp(SpcValue));
    memcpy(element->temp, &SpcStackTemp(SpcValue), sizeof(SpcTemperature_t));

    if ((infoType == 23) || (infoType == 37))
        SpcTempCorrect(SpcValue);

    return infoType;
}

//=========================================================================================
// Enter config int
//=========================================================================================
SpcKeyType_t SpcPushIntUp(SpcValue_t *SpcValue)
{
    SpcInfoType_t infoType = SpcPosition(SpcValue);
    const SpcConfDataInt16_t *element = SpcGetConfInt16(infoType);

    memcpy(&SpcStackData(SpcValue), element->data, sizeof(SpcConfInt16_t));

    SpcModifyInt(&SpcStackData(SpcValue), infoType, true);

    SpcUpdateDipInt(&SpcStackData(SpcValue), element);

    SpcStackPos(SpcValue) = SpcPosition(SpcValue);

    return 70;
}

SpcKeyType_t SpcPushIntDown(SpcValue_t *SpcValue)
{
    SpcInfoType_t infoType = SpcPosition(SpcValue);
    const SpcConfDataInt16_t *element = SpcGetConfInt16(infoType);

    memcpy(&SpcStackData(SpcValue), element->data, sizeof(SpcConfInt16_t));

    SpcModifyInt(&SpcStackData(SpcValue), infoType, false);

    SpcUpdateDipInt(&SpcStackData(SpcValue), element);

    SpcStackPos(SpcValue) = SpcPosition(SpcValue);

    return 70;
}

SpcKeyType_t SpcUpInt(SpcValue_t *SpcValue)
{
    SpcInfoType_t infoType = SpcStackPos(SpcValue);
    const SpcConfDataInt16_t *element = SpcGetConfInt16(infoType);

    SpcModifyInt(&SpcStackData(SpcValue), infoType, true);

    SpcUpdateDipInt(&SpcStackData(SpcValue), element);

    return SpcPosition(SpcValue);
}

SpcKeyType_t SpcDownInt(SpcValue_t *SpcValue)
{
    SpcInfoType_t infoType = SpcStackPos(SpcValue);
    const SpcConfDataInt16_t *element = SpcGetConfInt16(infoType);

    SpcModifyInt(&SpcStackData(SpcValue), infoType, false);

    SpcUpdateDipInt(&SpcStackData(SpcValue), element);

    return SpcPosition(SpcValue);
}

SpcKeyType_t SpcPopIntConf(SpcValue_t *SpcValue)
{
    SpcInfoType_t infoType = SpcStackPos(SpcValue);
    const SpcConfDataInt16_t *element = SpcGetConfInt16(infoType);
    memcpy(element->data, &SpcStackData(SpcValue), sizeof(SpcConfInt16_t));

    return infoType;
}

//=========================================================================================
// Private Functions
//=========================================================================================
static void SpcShowTemperature(SpcValue_t *SpcValue, int16_t line1, SpcTemperature_t *temp)
{
    if (temp->status == SPC_RTD_SHORT) {
        Spc_ScreenUpdateStatic(line1, SPC_RTD_SHORT_STR);
    } else if (temp->status == SPC_RTD_OPEN) {
        Spc_ScreenUpdateStatic(line1, SPC_RTD_OPEN_STR);
    } else {
        char buf[SPC_MAX_STR_LEN] = {0};
        if (SpcConf(SpcValue).bytes.unit == SpcTempInCelsius)
            snprintf(buf, SPC_MAX_STR_LEN, "%d C", temp->tempc);
        else
            snprintf(buf, SPC_MAX_STR_LEN, "%d F", temp->tempf);
        Spc_ScreenUpdateDynamic(line1, buf);
    }
}

static const SpcDataTemp_t *SpcGetDataTemp(SpcInfoType_t infoType)
{
    for (int16_t i=0; i<NUM_ROWS(SpcDataTemp);i++) {
        if (SpcDataTemp[i].type == infoType) {
            return &SpcDataTemp[i];
        }
    }
}

static const SpcStatisticInt_t *SpcGetStatisticInt(SpcInfoType_t infoType)
{
    for (int16_t i=0; i<NUM_ROWS(SpcStatisticInt);i++) {
        if (SpcStatisticInt[i].type == infoType) {
            return &SpcStatisticInt[i];
        }
    }
}

static const SpcDataInt16_t *SpcGetDataInt16(SpcInfoType_t infoType)
{
    for (int16_t i=0; i<NUM_ROWS(SpcDataInt16);i++) {
        if (SpcDataInt16[i].type == infoType) {
            return &SpcDataInt16[i];
        }
    }
}

static const SpcConfDataInt16_t *SpcGetConfInt16(SpcInfoType_t infoType)
{
    for (int16_t i=0; i<NUM_ROWS(SpcConfDataInt16);i++) {
        if (SpcConfDataInt16[i].type == infoType) {
            return &SpcConfDataInt16[i];
        }
    }
}

static const SpcDataInt32_t *SpcGetDataInt32(SpcValue_t *SpcValue)
{
    SpcInfoType_t infoType = SpcPosition(SpcValue);
    for (int16_t i=0; i<NUM_ROWS(SpcDataInt32);i++) {
        if (SpcDataInt32[i].type == infoType) {
            return &SpcDataInt32[i];
        }
    }
}

static const SpcDataByte_t *SpcGetDataByte(SpcValue_t *SpcValue)
{
    SpcInfoType_t infoType = SpcPosition(SpcValue);
    for (int16_t i=0; i<NUM_ROWS(SpcDataByte);i++) {
        if (SpcDataByte[i].type == infoType) {
            return &SpcDataByte[i];
        }
    }
}

static const SpcStringType_t SpcGetDataByteStr(const SpcDataByte_t *element, uint8_t val)
{
    int16_t num = element->tableSize;
    const SpcByteStrPool_t *table = element->table;
    for (int16_t i=0; i<num;i++) {
        if (table[i].val == val) {
            return table[i].strIndex;
        }
    }
}

static void SpcModifyTemp(SpcTemperature_t *temp, int16_t max, int16_t min, bool increase)
{
    int16_t *val = NULL;
   
    if (SpcConf(&SpcValue).bytes.unit == SpcTempInCelsius) {
        val = &(temp->tempc);
    } else {
        val = &(temp->tempf);
    }
    if (increase) {
        if (temp->status == SPC_OFF) {
            return;
        } else if (temp->status == SPC_NONE) {
            temp->status = SPC_OFF;
        } else if (*val == max) {
            temp->status = SPC_NONE;
        } else {
            (*val)++;
        }
    } else {
        if (temp->status == SPC_OFF) {
            temp->status = SPC_NONE;
        } else if (temp->status == SPC_NONE) {
            temp->status = SPC_DATA_NORMAL;
            *val = max;
        } else if (*val > min) {
            (*val)--;
        }
    }
}

static void SpcUpdateDipTemp(SpcTemperature_t *temp, int16_t line1)
{
    if (temp->status == SPC_OFF) {
        Spc_ScreenUpdateStatic(line1, SPC_OFF_STR);
    } else if (temp->status == SPC_NONE) {
        Spc_ScreenUpdateStatic(line1, SPC_NONE_STR);
    } else {
        char buf[SPC_MAX_STR_LEN] = {0};

        if (SpcConf(&SpcValue).bytes.unit == SpcTempInCelsius) {
            snprintf(buf, SPC_MAX_STR_LEN, "%d C", temp->tempc);
        } else {
            snprintf(buf, SPC_MAX_STR_LEN, "%d F", temp->tempf);
        }
        Spc_ScreenUpdateDynamic(line1, buf);
    }
}

static void SpcTempCorrect(SpcValue_t *SpcValue)
{
    int16_t max;
    int16_t min;

    if (SpcConfMainTemp(SpcValue).status != SPC_DATA_NORMAL) {
        return;
    }

    if (SpcConf(SpcValue).bytes.ctl_type) {
        if (SpcConf(SpcValue).bytes.unit == SpcTempInCelsius) {
            max = SpcConfMainTemp(SpcValue).tempc - 1;
            min = SpcConfMainTemp(SpcValue).tempc + 1;
        } else {
            max = SpcConfMainTemp(SpcValue).tempf - 1;
            min = SpcConfMainTemp(SpcValue).tempf + 1;
        }
    } else {
        if (SpcConf(SpcValue).bytes.unit == SpcTempInCelsius) {
            max = SpcConfMainTemp(SpcValue).tempc - SpcConfDeadband(SpcValue).tempc - 1;
            min = SpcConfMainTemp(SpcValue).tempc + SpcConfDeadband(SpcValue).tempc + 1;
        } else {
            max = SpcConfMainTemp(SpcValue).tempf - SpcConfDeadband(SpcValue).tempf - 1;
            min = SpcConfMainTemp(SpcValue).tempf + SpcConfDeadband(SpcValue).tempf + 1;
        }
    }

    if (SpcConfLowTemp(SpcValue).status != SPC_DATA_NORMAL) {
        if (SpcConf(SpcValue).bytes.unit == SpcTempInCelsius) {
            if (SpcConfLowTemp(SpcValue).tempc > max) {
                SpcConfLowTemp(SpcValue).tempc = max;
                SpcConvertTemp(&SpcConfLowTemp(SpcValue));
            }
        } else {
            if (SpcConfLowTemp(SpcValue).tempf > max) {
                SpcConfLowTemp(SpcValue).tempf = max;
                SpcConvertTemp(&SpcConfLowTemp(SpcValue));
            }
        }
    }

    if (SpcConfHighTemp(SpcValue).status != SPC_DATA_NORMAL) {
        if (SpcConf(SpcValue).bytes.unit == SpcTempInCelsius) {
            if (SpcConfHighTemp(SpcValue).tempc < min) {
                SpcConfHighTemp(SpcValue).tempc = min;
                SpcConvertTemp(&SpcConfHighTemp(SpcValue));
            }
        } else {
            if (SpcConfHighTemp(SpcValue).tempf > min) {
                SpcConfHighTemp(SpcValue).tempf = min;
                SpcConvertTemp(&SpcConfHighTemp(SpcValue));
            }
        }
    }
}

static void SpcLTempLimit(SpcValue_t *SpcValue, SpcTemperature_t *lowTemp)
{
    int16_t max;

    if (SpcConfMainTemp(SpcValue).status != SPC_DATA_NORMAL) {
        if (SpcConfHighTemp(SpcValue).status == SPC_OFF) {
            if (SpcConf(SpcValue).bytes.unit == SpcTempInCelsius)
                max = MAX_TEMP_C - 1;
            else
                max = MAX_TEMP_F - 1;
        } else {
            if (SpcConf(SpcValue).bytes.unit == SpcTempInCelsius)
                max = SpcConfHighTemp(SpcValue).tempc - 1;
            else
                max = SpcConfHighTemp(SpcValue).tempf - 1;
        }
    } else {
        if (SpcConf(SpcValue).bytes.ctl_type) {
            if (SpcConf(SpcValue).bytes.unit == SpcTempInCelsius) {
                max = SpcConfMainTemp(SpcValue).tempc - 1;
            } else {
                max = SpcConfMainTemp(SpcValue).tempf - 1;
            }
        } else {
            if (SpcConf(SpcValue).bytes.unit == SpcTempInCelsius) {
                max = SpcConfMainTemp(SpcValue).tempc - SpcConfDeadband(SpcValue).tempc - 1;
            } else {
                max = SpcConfMainTemp(SpcValue).tempf - SpcConfDeadband(SpcValue).tempf - 1;
            }
        }
    }

    if (lowTemp->status == SPC_OFF)
        return;

    if (lowTemp->status == SPC_NONE) {
        lowTemp->status = SPC_OFF;
        return;
    }

    if (SpcConf(SpcValue).bytes.unit == SpcTempInCelsius) {
        if (lowTemp->tempc > max) lowTemp->tempc = max;
    } else {
        if (lowTemp->tempf > max) lowTemp->tempf = max;
    }
}

static void SpcHTempLimit(SpcValue_t *SpcValue, SpcTemperature_t *highTemp)
{
    int16_t min;

    if (SpcConfMainTemp(SpcValue).status != SPC_DATA_NORMAL) {
        if (SpcConfLowTemp(SpcValue).status == SPC_OFF) {
            if (SpcConf(SpcValue).bytes.unit == SpcTempInCelsius)
                min = MIN_TEMP_C + 1;
            else
                min = MIN_TEMP_F + 1;
        } else {
            if (SpcConf(SpcValue).bytes.unit == SpcTempInCelsius)
                min = SpcConfLowTemp(SpcValue).tempc + 1;
            else
                min = SpcConfLowTemp(SpcValue).tempf + 1;
        }
    } else {
        if (SpcConf(SpcValue).bytes.ctl_type) {
            if (SpcConf(SpcValue).bytes.unit == SpcTempInCelsius) {
                min = SpcConfMainTemp(SpcValue).tempc + 1;
            } else {
                min = SpcConfMainTemp(SpcValue).tempf + 1;
            }
        } else {
            if (SpcConf(SpcValue).bytes.unit == SpcTempInCelsius) {
                min = SpcConfMainTemp(SpcValue).tempc + SpcConfDeadband(SpcValue).tempc + 1;
            } else {
                min = SpcConfMainTemp(SpcValue).tempf + SpcConfDeadband(SpcValue).tempf + 1;
            }
        }
    }

    if (highTemp->status == SPC_OFF)
        return;

    if (highTemp->status == SPC_NONE) {
        highTemp->status = SPC_OFF;
        return;
    }
    
    if (SpcConf(SpcValue).bytes.unit == SpcTempInCelsius) {
        if (highTemp->tempc < min) highTemp->tempc = min;
    } else {
        if (highTemp->tempf < min) highTemp->tempf = min;
    }
}

static void SpcDTempLimit(SpcValue_t *SpcValue, SpcTemperature_t *deadband)
{
    if (deadband->status != SPC_DATA_NORMAL) {
        deadband->status = SPC_DATA_NORMAL;
    }
    
    if (SpcConf(SpcValue).bytes.unit == SpcTempInCelsius) {
        if (deadband->tempc < MIN_DEADBAND_C) deadband->tempc = MIN_DEADBAND_C;
        if (deadband->tempc > MAX_DEADBAND_C) deadband->tempc = MAX_DEADBAND_C;
    } else {
        if (deadband->tempf < MIN_DEADBAND_F) deadband->tempf = MIN_DEADBAND_F;
        if (deadband->tempf > MAX_DEADBAND_F) deadband->tempf = MAX_DEADBAND_F;
    }
}

// config int
static void SpcModifyInt(SpcConfInt16_t *data, SpcInfoType_t infoType, bool increase)
{
    const SpcConfIntLimit_t *element = SpcGetConfIntLimit(infoType);
    SpcConfInt16_t *tmpData = NULL;
    uint8_t index = 0; 
    int16_t max, min;

    if (element->maxPtr == NULL) {
        max = element->max;
    } else {
        tmpData = element->maxPtr;
        if (tmpData->status != SPC_DATA_NORMAL) {
            max = element->max;
        } else {
            max = tmpData->val;
        }
    }

    if (element->minPtr == NULL) {
        min = element->min;
    } else {
        tmpData = element->minPtr;
        if (tmpData->status != SPC_DATA_NORMAL) {
            min = element->min;
        } else {
            min = tmpData->val;
        }
    }

    if (increase) {
        if (data->status != SPC_DATA_NORMAL) {
            if (element->size == 0) return;
            else {
                index = SpcGetConfStatusIndex(element, data->status);
                if (index < (element->size - 1)) {
                    index++;
                    data->status = element->status[index];
                }
            }
        } else {
            if (data->val >= max) {
                if (element->size >= 0) {
                    index = 0;
                    data->status = element->status[index];
                }
            } else {
                (data->val)++;
            }
        }
    } else {
        if (data->status != SPC_DATA_NORMAL) {
            if (element->size == 0) return; // should not come here
            else {
                index = SpcGetConfStatusIndex(element, data->status);
                if (index <= 0) {
                    data->status = SPC_DATA_NORMAL;
                    data->val = max;
                } else {
                    index--;
                    data->status = element->status[index];
                }
            }
        } else {
            if (data->val > min) {
                (data->val)--;
            }
        }
    }
}

static void SpcUpdateDipInt(SpcConfInt16_t *data, const SpcConfDataInt16_t *element)
{
    if (data->status == SPC_DISABLE) {
        Spc_ScreenUpdateStatic(element->line1, SPC_DISABLE_STR);
    } else if (data->status == SPC_CONTINUE) {
        Spc_ScreenUpdateStatic(element->line1, SPC_CONTINUE_STR);
    } else if (data->status == SPC_OFF) {
        Spc_ScreenUpdateStatic(element->line1, SPC_OFF_STR);
    } else {
        char buf[SPC_MAX_STR_LEN] = {0};
        snprintf(buf, SPC_MAX_STR_LEN, "%s%d%s", element->prefix,
            data->val, element->suffix);
        Spc_ScreenUpdateDynamic(element->line1, buf);
    }
}

static const SpcConfIntLimit_t *SpcGetConfIntLimit(SpcInfoType_t infoType)
{
    for (int16_t i=0; i<NUM_ROWS(SpcConfIntLimit);i++) {
        if (SpcConfIntLimit[i].type == infoType) {
            return &SpcConfIntLimit[i];
        }
    }
}

static uint8_t SpcGetConfStatusIndex(const SpcConfIntLimit_t *element, SpcDataStatus_t status)
{
    uint8_t index = 0;
    for (index=0; index<element->size; index++) {
        if (element->status[index] == status) {
            return index;
        } 
    }
}




// Temperature convert
static void SpcConvertTemp(SpcTemperature_t *temp)
{
    if (SpcConf(&SpcValue).bytes.unit == SpcTempInCelsius) {
        temp->tempf = ConvertCtoF(temp->tempc);
    } else {
        temp->tempc = ConvertFtoC(temp->tempf);
    }
}

static inline int16_t ConvertCtoF(int16_t sourse)
{

  return (int16_t)(32 + ((int32_t)sourse * 18) / 10);
}

static inline int16_t ConvertFtoC(int16_t sourse)
{
  return (int16_t)(((int32_t)(sourse - 32)*10) / 18);
}



// Key opt
static SpcKeyType_t Spc_KeyOptProcess(SpcValue_t *SpcValue, uint16_t command)
{
    SpcInfoType_t infoType = SpcPosition(SpcValue);
    SpcInfoType_t nextType = infoType;
    switch(command) {
        case 54:
            if (SpcRight(infoType).action != NULL) {
                nextType = SpcRight(infoType).action(SpcValue);
            } else {
                nextType = SpcRight(infoType).type;
            }
            break;
        case 52:
            if (SpcLeft(infoType).action != NULL) {
                nextType = SpcLeft(infoType).action(SpcValue);
            } else {
                nextType = SpcLeft(infoType).type;
            }
            break;
        case 56:
            if (SpcUp(infoType).action != NULL) {
                nextType = SpcUp(infoType).action(SpcValue);
            } else {
                nextType = SpcUp(infoType).type;
            }
            break;
        case 50:
            if (SpcDown(infoType).action != NULL) {
                nextType = SpcDown(infoType).action(SpcValue);
            } else {
                nextType = SpcDown(infoType).type;
            }
            break;
        case 97:
            if (SpcAct(infoType).action != NULL) {
                nextType = SpcAct(infoType).action(SpcValue);
            } else {
                nextType = SpcAct(infoType).type;
            }
            break;
        case 112:
            if (SpcProg(infoType).action != NULL) {
                nextType = SpcProg(infoType).action(SpcValue);
            } else {
                nextType = SpcProg(infoType).type;
            }
            break;
        case 114:
            if (SpcReset(infoType).action != NULL) {
                nextType = SpcReset(infoType).action(SpcValue);
            } else {
                nextType = SpcReset(infoType).type;
            }
            break;
        case 53:
            if (SpcEnter(infoType).action != NULL) {
                nextType = SpcEnter(infoType).action(SpcValue);
            } else {
                nextType = SpcEnter(infoType).type;
            }
            break;
        case 48:
            if (SpcAlarm(infoType).action != NULL) {
                nextType = SpcAlarm(infoType).action(SpcValue);
            } else {
                nextType = SpcAlarm(infoType).type;
            }
            break;
        default:
            return SPC_KEY_NORMAL;
    }

    if (nextType != infoType) {
        SpcPosition(SpcValue) = nextType;
        SpcInitEntry(nextType).action(SpcValue);
    }
    return SPC_KEY_NORMAL;
}