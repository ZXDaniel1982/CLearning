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
static const SpcDataTemp_t *SpcGetDataTemp(SpcValue_t *SpcValue);
static const SpcDataInt16_t *SpcGetDataInt16(SpcValue_t *SpcValue);
static const SpcDataInt32_t *SpcGetDataInt32(SpcValue_t *SpcValue);
static const SpcDataByte_t *SpcGetDataByte(SpcValue_t *SpcValue);
static const SpcStringType_t SpcGetDataByteStr(const SpcDataByte_t *element, uint8_t val);
static void SpcShowTemperature(SpcValue_t *SpcValue, int16_t line1, SpcTemperature_t *temp);

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
    const SpcDataTemp_t *element = SpcGetDataTemp(SpcValue);

    if (SpcConfMainTemp(SpcValue).tempStatus == SPC_TEMP_OFF) {
        Spc_ScreenUpdateStatic(element->line1, SPC_BLANK_STR);
    } else {
        SpcShowTemperature(SpcValue, element->line1, element->temp);
    }

    return SPC_KEY_NORMAL;
}

SpcKeyType_t SpcEntryShowInt16(SpcValue_t *SpcValue)
{
    char buf[SPC_MAX_STR_LEN] = {0};
    const SpcDataInt16_t *element = SpcGetDataInt16(SpcValue);

    snprintf(buf, SPC_MAX_STR_LEN, "%s%d%s", element->prefix,
        *(element->val), element->suffix);
    Spc_ScreenUpdateDynamic(element->line1, buf);
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
SpcKeyType_t SpcPushTempReset(SpcValue_t *SpcValue)
{
    SpcStackPos(SpcValue) = SpcPosition(SpcValue);

    return 63;
}

SpcKeyType_t SpcPushInt16Reset(SpcValue_t *SpcValue)
{
    SpcStackPos(SpcValue) = SpcPosition(SpcValue);

    return 65;
}

SpcKeyType_t SpcResetRet(SpcValue_t *SpcValue)
{
    return SpcStackPos(SpcValue)
}

SpcKeyType_t SpcConfirmTemp(SpcValue_t *SpcValue)
{
    
}

//=========================================================================================
// Private Functions
//=========================================================================================
static void SpcShowTemperature(SpcValue_t *SpcValue, int16_t line1, SpcTemperature_t *temp)
{
    if (temp->tempStatus == SPC_TEMP_RTD_SHORT) {
        Spc_ScreenUpdateStatic(line1, SPC_RTD_SHORT_STR);
    } else if (temp->tempStatus == SPC_TEMP_RTD_OPEN) {
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

static const SpcDataTemp_t *SpcGetDataTemp(SpcValue_t *SpcValue)
{
    SpcInfoType_t infoType = SpcPosition(SpcValue);
    for (int16_t i=0; i<NUM_ROWS(SpcDataTemp);i++) {
        if (SpcDataTemp[i].type == infoType) {
            return &SpcDataTemp[i];
        }
    }
}

static const SpcDataInt16_t *SpcGetDataInt16(SpcValue_t *SpcValue)
{
    SpcInfoType_t infoType = SpcPosition(SpcValue);
    for (int16_t i=0; i<NUM_ROWS(SpcDataInt16);i++) {
        if (SpcDataInt16[i].type == infoType) {
            return &SpcDataInt16[i];
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