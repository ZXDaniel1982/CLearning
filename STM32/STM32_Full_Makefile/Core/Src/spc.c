/* Includes ------------------------------------------------------------------*/
#include "spc.h"
#include "FreeRTOS.h"
#include "lcd.h"
#include "cli.h"
#include <string.h>
#include <stdlib.h>

#include "spcconst.h"
#include "spcdef.h"

#define SPC_KEY_MONITOR_TIMEOUT   ( 200 )

osMessageQId SpcKeyQueueHandle;

osThreadId SpcTaskHandle;
static void SpcTask(void const *arg);

SpcValue_t SpcValue;

static void Spc_ScreenUpdateStatic(int16_t line1, int16_t line2);
static void Spc_ScreenUpdateDynamic(int16_t line1, char *buf);
static SpcKeyType_t Spc_KeyOptProcess(SpcValue_t *SpcValue, uint16_t command);

static const SpcDataTemp_t *SpcGetDataTemp(SpcInfoType_t infoType);
static const SpcStatisticInt_t *SpcGetStatisticInt(SpcInfoType_t infoType);
static const SpcDataInt16_t *SpcGetDataInt16(SpcInfoType_t infoType);
static const SpcDataInt32_t *SpcGetDataInt32(SpcValue_t *SpcValue);
static const SpcDataByte_t *SpcGetDataByte(SpcInfoType_t infoType);
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

static inline bool SpcModifyByte(int16_t *val, const SpcDataByte_t *element, bool increase);

static uint8_t SpcGetCharIndex(char c);

static const SpcPasswordStatus_t *SpcGetPswStatus(SpcInfoType_t infoType);



static const char *spcStartupLogOn[] = {
    "Turn on Heater Led",
    "Turn on System Fail Led",
    "Turn on Alarm Led",
    "Turn on Communication Led",
};
static const char *spcStartupLogOff[] = {
    "Turn off Heater Led",
    "Turn off System Fail Led",
    "Turn off Alarm Led",
    "Turn off Communication Led",
};

static const char SpcCharactors[] =
{
  ' ', '0','1','2','3','4','5','6','7','8','9',
  'A','B','C','D','E','F','G','H','I','J','K','L','M',
  'N','O','P','Q','R','S','T','U','V','W','X','Y','Z',
  'a','b','c','d','e','f','g','h','i','j','k','l','m',
  'n','o','p','q','r','s','t','u','v','w','x','y','z'
};

static const SpcRtdStatusStr_t SpcRtdStatStrPool[] = {
    {SPC_RTD_OFF,     SPC_MENU_ACT_HEATSTAT_STR,     SPC_RTD_OFF_STR},
    {SPC_RTD_ON,      SPC_MENU_ACT_HEATSTAT_STR,     SPC_RTD_ON_STR},
    {SPC_RTD_MANOFF,  SPC_MENU_ACT_HEATSTAT_STR,     SPC_RTD_MANOFF_STR},
    {SPC_RTD_MANON,   SPC_MENU_ACT_HEATSTAT_STR,     SPC_RTD_MANON_STR},
};

static SpcStringPool_t SpcStrPool[SPC_MAX_STR_TYPE] = {
    {SPC_BLANK_STR,                  "                 "},
    {SPC_FIRMWARE_NAME_STR,          "SPC firmware"},
    {SPC_FIRMWARE_VER_STR,           "Version 1.0"},
    {SPC_SYSTEMCHK_STR,              "System Check..."},
    {SPC_SELFCHKFAIL_STR,            "Self Check Fail"},

    // menu lin1
    {SPC_MENU_ACT_CATAG_STR,         "Actual"},
    {SPC_MENU_ACT_HEATSTAT_STR,      "Heater Status"},
    {SPC_MENU_ACT_TEMP_STR,          "Temperature"},
    {SPC_MENU_ACT_TEMPA_STR,         "RTD-A Actual"},
    {SPC_MENU_ACT_TMEPB_STR,         "RTD-B Actual"},
    {SPC_MENU_ACT_POW_STR,           "Heater Power"},
    {SPC_MENU_ACT_CURRENT_STR,       "Heater Current"},
    {SPC_MENU_ACT_GFI_STR,           "Gound Fault"},
    {SPC_MENU_ACT_VOLTAGE_STR,       "Heater Voltage"},
    {SPC_MENU_ACT_MAX_TEMP_STR,      "Max Temperature"},
    {SPC_MENU_ACT_MIN_TEMP_STR,      "Min Temperature"},
    {SPC_MENU_ACT_MAX_CURRENT_STR,   "Max Current"},
    {SPC_MENU_ACT_MAX_GFI_STR,       "Max Ground Fault"},
    {SPC_MENU_ACT_MAX_VOLT_STR,      "Max Voltage"},
    {SPC_MENU_ACT_MIN_VOLT_STR,      "Min Voltage"},
    {SPC_MENU_ACT_USAGE_STR,         "Total Energy"},
    {SPC_MENU_ACT_ONTIME_STR,        "Heater On Perc"},
    {SPC_MENU_ACT_COST_STR,          "Total Cost"},
    {SPC_MENU_ACT_RUNTIME_STR,       "Heater On Time"},
    {SPC_MENU_ACT_RESET_STR,         "Reset Statistics"},
    {SPC_MENU_ACT_VERSION_STR,       "Firmware Version"},

    {SPC_MENU_ACT_OPTVAL_STR,        "Operating values"},
    {SPC_MENU_ACT_STATIS_STR,        "Statistics"},

    // menu prog line1
    {SPC_MENU_PROG_CATAG_STR,        "Program"},
    {SPC_MENU_PROG_MAIN_TEMP_STR,    "Maintain Temp"},
    {SPC_MENU_PROG_LOW_TEMP_STR,     "Low Temp Alarm"},
    {SPC_MENU_PROG_HIGH_TEMP_STR,    "High Temp Alarm"},
    {SPC_MENU_PROG_LOW_CURRENT_STR,  "Low Current Alm"},
    {SPC_MENU_PROG_HIGH_CURRENT_STR, "High Current Alm"},
    {SPC_MENU_PROG_GFI_ALARM_STR,    "GFI Alarm"},
    {SPC_MENU_PROG_GFI_TRIP_STR,     "GFI Trip"},
    {SPC_MENU_PROG_LOW_VOLT_STR,     "Low Volt Alarm"},
    {SPC_MENU_PROG_HIGH_VOLT_STR,    "High Volt Alarm"},
    {SPC_MENU_PROG_HEATEN_STR,       "Enable Heater"},
    {SPC_MENU_PROG_HEATID_STR,       "Heater ID"},
    {SPC_MENU_PROG_HEAT_TYPE_STR,    "Sel Heater Type"},
    {SPC_MENU_PROG_MANUAL_STR,       "External Disable"},
    {SPC_MENU_PROG_DEADBAND_STR,     "Deadband"},
    {SPC_MENU_PROG_CTLTYPE_STR,      "Control Type"},
    {SPC_MENU_PROG_CURRENTLTM_STR,   "Power Limiting"},
    {SPC_MENU_PROG_SOFTSTART_STR,    "Soft Start Mode"},
    {SPC_MENU_PROG_AUTOTEST_STR,     "Auto Test Cycle"},
    {SPC_MENU_PROG_RTDMODE_STR,      "RTD Operation"},
    {SPC_MENU_PROG_RTDFAILMODE_STR,  "RTD Failure Mode"},
    {SPC_MENU_PROG_PASSWORDEN_STR,   "Password"},
    {SPC_MENU_PROG_UNIT_STR,         "Units"},
    {SPC_MENU_PROG_PRICE_STR,        "Operational Cost"},
    {SPC_MENU_PROG_DIPMODE_STR,      "Display Mode"},
    {SPC_MENU_PROG_DEFDIP_STR,       "Default Display"},
    {SPC_MENU_PROG_DIPTIMEOUT_STR,   "Display Timeout"},
    {SPC_MENU_PROG_SCANSPEED_STR,    "Scan Speed"},
    {SPC_MENU_PROG_MODBUSADD_STR,    "Modbus Address"},
    {SPC_MENU_PROG_BAUDRATE_STR,     "Baud Rate"},
    {SPC_MENU_PROG_RESET_STR,        "Reset Module"},
    {SPC_MENU_PROG_ALARMOUT_STR,     "Alarm Test"},
    {SPC_MENU_PROG_RTDTEST_STR,      "Heater Test"},
    {SPC_MENU_PROG_GFITEST_STR,      "GFI Test"},

    {SPC_MENU_PROG_SETPOINT_STR,     "Setpoints"},
    {SPC_MENU_PROG_HEATSET_STR,      "Heater setup"},
    {SPC_MENU_PROG_SYSSET_STR,       "System setup"},
    {SPC_MENU_PROG_SYSTEST_STR,      "System test"},

    // Default Information
    {SPC_DEF_HEAT_TEMP_STR,          "Heater Temp"},
    {SPC_DEF_HEAT_STATUS_STR,        "Heater Status"},
    {SPC_DEF_SYS_STATUS_STR,         "System Status"},

    // Substring
    {SPC_NO_STR,                     "no"},
    {SPC_YES_STR,                    "yes"},
    {SPC_ON_STR,                     "On"},
    {SPC_OFF_STR,                    "Off"},
    {SPC_NONE_STR,                   "None"},
    {SPC_ENABLE_STR,                 "Enable"},
    {SPC_DISABLE_STR,                "Disable"},
    {SPC_CONTINUE_STR,               "Continue"},
    {SPC_FIX_RESIS_STR,              "Fix-Res"},
    {SPC_SELF_REG_STR,               "Self-Reg"},
    {SPC_ONOFF_STR,                  "On_off"},
    {SPC_PROPORTIONAL_STR,           "Proportional"},
    {SPC_RTD_SHORT_STR,              "RTD Short"},
    {SPC_RTD_OPEN_STR,               "RTD Open"},
    {SPC_RTD_OFF_STR,                "Heater is Off"},
    {SPC_RTD_ON_STR,                 "Heater is On"},
    {SPC_RTD_MANOFF_STR,             "Heater is ManOn"},
    {SPC_RTD_MANON_STR,              "Heater is ManOff"},
    {SPC_RTD_ONE_MODE_STR,           "One RTD Mode"},
    {SPC_RTD_BACKUP_MODE_STR,        "Backup Mode"},
    {SPC_RTD_AVERAGE_MODE_STR,       "Average Mode"},
    {SPC_RTD_LOWEST_MODE_STR,        "Lowest Mode"},
    {SPC_RTD_HIGHEST_MODE_STR,       "Highest Mode"},
    {SPC_RTD_HIGHTEMPCUT_MODE_STR,   "High Temp Cutoff"},
    {SPC_FAHRENHEIT_STR,             "Fahrenheit"},
    {SPC_CELCIUS_STR,                "Celcius"},
    {SPC_DIP_NORMAL_STR,             "Normal"},
    {SPC_DIP_ADVANCED_STR,           "Advanced"},
    {SPC_AUTO_CYCLE_STR,             "Autotest Cycle"},
    {SPC_NOW_STR,                    "Now"},

    // Buadrate
    {SPC_1200_STR,                   "1200"},
    {SPC_2400_STR,                   "2400"},
    {SPC_4800_STR,                   "4800"},
    {SPC_9600_STR,                   "9600"},
    {SPC_115200_STR,                 "115200"},

    // Password
    {SPC_MENU_PROG_PSWINIT_STR,      "Change password"},
    {SPC_PSW_OLD,                    "Enter Old Psw"},
    {SPC_PSW_NEW,                    "Enter New Psw"},
    {SPC_PSW_NEW_AGAIN,              "Enter Again"},
    {SPC_PSW_SUCCESS,                "Operate success"},
    {SPC_PSW_INVALID,                "Invalid password"},
    {SPC_PSW_NOT_MATCH,              "Not match"},

    // Reset
    {SPC_MENU_RESET_CONFIRM_STR,     "Comfirm Reset?"},
    {SPC_MENU_RESET_FINISH_STR,      "Reset Complete"},
};

static const SpcStaticInfo_t SpcStaticInfo[] = {
    {0,  SPC_MENU_ACT_CATAG_STR,     SPC_MENU_ACT_OPTVAL_STR},
    {9,  SPC_MENU_ACT_CATAG_STR,     SPC_MENU_ACT_STATIS_STR},
    {20, SPC_MENU_ACT_RESET_STR,     SPC_NO_STR},
    {21, SPC_MENU_ACT_VERSION_STR,   SPC_FIRMWARE_VER_STR},
    {22, SPC_MENU_PROG_CATAG_STR,    SPC_MENU_PROG_SETPOINT_STR},
    {32, SPC_MENU_PROG_CATAG_STR,    SPC_MENU_PROG_HEATSET_STR},
    {44, SPC_MENU_PROG_CATAG_STR,    SPC_MENU_PROG_SYSSET_STR},
    {46, SPC_MENU_PROG_PSWINIT_STR,  SPC_NO_STR},
    {55, SPC_MENU_PROG_RESET_STR,    SPC_NO_STR},
    {56, SPC_MENU_PROG_CATAG_STR,    SPC_MENU_PROG_SYSTEST_STR},
    {63, SPC_MENU_RESET_CONFIRM_STR, SPC_NO_STR},
    {64, SPC_MENU_RESET_CONFIRM_STR, SPC_YES_STR},
    {65, SPC_MENU_RESET_CONFIRM_STR, SPC_NO_STR},
    {66, SPC_MENU_RESET_CONFIRM_STR, SPC_YES_STR},
    {67, SPC_MENU_RESET_CONFIRM_STR, SPC_NO_STR},
    {68, SPC_MENU_RESET_CONFIRM_STR, SPC_YES_STR},
    {72, SPC_MENU_PROG_PSWINIT_STR,  SPC_NO_STR},
    {73, SPC_MENU_PROG_PSWINIT_STR,  SPC_YES_STR},
};

static const SpcDataTemp_t SpcDataTemp[] = {
    {2,  SPC_MENU_ACT_TEMP_STR,       &SpcTemp(&SpcValue,SPC_RTD_COMBIN)},
    {3,  SPC_MENU_ACT_TEMPA_STR,      &SpcTemp(&SpcValue,SPC_RTD_CHANNEL1)},
    {4,  SPC_MENU_ACT_TMEPB_STR,      &SpcTemp(&SpcValue,SPC_RTD_CHANNEL2)},
    {10, SPC_MENU_ACT_MAX_TEMP_STR,   &SpcMaxTemp(&SpcValue)},
    {11, SPC_MENU_ACT_MIN_TEMP_STR,   &SpcMinTemp(&SpcValue)},
    {23, SPC_MENU_PROG_MAIN_TEMP_STR, &SpcConfMainTemp(&SpcValue)},
    {24, SPC_MENU_PROG_LOW_TEMP_STR,  &SpcConfLowTemp(&SpcValue)},
    {25, SPC_MENU_PROG_HIGH_TEMP_STR, &SpcConfHighTemp(&SpcValue)},
    {37, SPC_MENU_PROG_DEADBAND_STR,  &SpcConfDeadband(&SpcValue)},
    {62, SPC_DEF_HEAT_TEMP_STR,       &SpcTemp(&SpcValue,SPC_RTD_COMBIN)},
};

static const SpcDataInt16_t SpcDataInt16[] = {
    {5,  SPC_MENU_ACT_POW_STR,             &SpcPercent(&SpcValue),    "", " %"},
    {6,  SPC_MENU_ACT_CURRENT_STR,         &SpcCurrent(&SpcValue),    "", " A"},
    {7,  SPC_MENU_ACT_GFI_STR,             &SpcGfi(&SpcValue),        "", " mA"},
    {8,  SPC_MENU_ACT_VOLTAGE_STR,         &SpcVoltage(&SpcValue),    "", " V"},
    {12, SPC_MENU_ACT_MAX_CURRENT_STR,     &SpcMaxCurrent(&SpcValue), "", " A"},
    {13, SPC_MENU_ACT_MAX_GFI_STR,         &SpcMaxGFI(&SpcValue),     "", " mA"},
    {14, SPC_MENU_ACT_MAX_VOLT_STR,        &SpcMaxVolt(&SpcValue),    "", " V"},
    {15, SPC_MENU_ACT_MIN_VOLT_STR,        &SpcMinVolt(&SpcValue),    "", " V"},
    {16, SPC_MENU_ACT_USAGE_STR,           &SpcUsage(&SpcValue),      "", " KWh"},
    {19, SPC_MENU_ACT_ONTIME_STR,          &SpcOnPercent(&SpcValue),  "", " %"},
};

static const SpcConfDataInt16_t SpcConfDataInt16[] = {
    {26, SPC_MENU_PROG_LOW_CURRENT_STR,    &SpcConfLowCurrent(&SpcValue),  "", " A"},
    {27, SPC_MENU_PROG_HIGH_CURRENT_STR,   &SpcConfHighCurrent(&SpcValue),  "", " A"},
    {28, SPC_MENU_PROG_GFI_ALARM_STR,      &SpcConfGFIAlarm(&SpcValue),  "", " mA"},
    {29, SPC_MENU_PROG_GFI_TRIP_STR,       &SpcConfGFITrip(&SpcValue),  "", " mA"},
    {30, SPC_MENU_PROG_LOW_VOLT_STR,       &SpcConfLowVolt(&SpcValue),  "", " V"},
    {31, SPC_MENU_PROG_HIGH_VOLT_STR,      &SpcConfHighVolt(&SpcValue),  "", " V"},
    {39, SPC_MENU_PROG_CURRENTLTM_STR,     &SpcConfCurLmt(&SpcValue),  "", " A"},
    {40, SPC_MENU_PROG_SOFTSTART_STR,      &SpcConfSoftStart(&SpcValue),  "", " Seconds"},
    {41, SPC_MENU_PROG_AUTOTEST_STR,       &SpcConfAutoTest(&SpcValue),  "", " Hours"},
    {48, SPC_MENU_PROG_PRICE_STR,          &SpcConfPrice(&SpcValue),  "$ ", ""},
    {51, SPC_MENU_PROG_DIPTIMEOUT_STR,     &SpcConfTimeout(&SpcValue),  "", " Seconds"},
    {52, SPC_MENU_PROG_SCANSPEED_STR,      &SpcConfScanSpd(&SpcValue),  "", " Seconds"},
    {53, SPC_MENU_PROG_MODBUSADD_STR,      &SpcConfModbusAdd(&SpcValue),  "", ""},
    {57, SPC_MENU_PROG_ALARMOUT_STR,       &SpcConfAlarmOut(&SpcValue),  "", " Hours"},
    {58, SPC_MENU_PROG_RTDTEST_STR,        &SpcConfHeatTest(&SpcValue),  "", " Hours"},
};

static const SpcStatisticInt_t SpcStatisticInt[] = {
    {12, &SpcCurrent(&SpcValue)},
    {13, &SpcGfi(&SpcValue)},
    {14, &SpcVoltage(&SpcValue)},
    {15, &SpcVoltage(&SpcValue)},
};


static const SpcDataInt32_t SpcDataInt32[] = {
    {17, SPC_MENU_ACT_COST_STR,            &SpcCost(&SpcValue),       "", " NZD"},
    {18, SPC_MENU_ACT_RUNTIME_STR,         &SpcRunTime(&SpcValue),    "", " HR"},
};

static const SpcByteStrPool_t SpcHeatEnStr[] = {
    {0, SPC_NO_STR},
    {1, SPC_YES_STR},
};

static const SpcByteStrPool_t SpcHeatTypeStr[] = {
    {0, SPC_FIX_RESIS_STR},
    {1, SPC_SELF_REG_STR},
};

static const SpcByteStrPool_t SpcManualStr[] = {
    {0, SPC_OFF_STR},
    {1, SPC_ON_STR},
};

static const SpcByteStrPool_t SpcCtlTypeStr[] = {
    {0, SPC_ONOFF_STR},
    {1, SPC_PROPORTIONAL_STR},
};

static const SpcByteStrPool_t SpcRtdModeStr[] = {
    {0, SPC_RTD_ONE_MODE_STR},
    {1, SPC_RTD_BACKUP_MODE_STR},
    {2, SPC_RTD_AVERAGE_MODE_STR},
    {3, SPC_RTD_LOWEST_MODE_STR},
    {4, SPC_RTD_HIGHEST_MODE_STR},
    {5, SPC_RTD_HIGHTEMPCUT_MODE_STR},
};

static const SpcByteStrPool_t SpcRtdFailModeStr[] = {
    {0, SPC_OFF_STR},
    {1, SPC_ON_STR},
};

static const SpcByteStrPool_t SpcPasswordEnStr[] = {
    {0, SPC_DISABLE_STR},
    {1, SPC_ENABLE_STR},
};

static const SpcByteStrPool_t SpcUnitStr[] = {
    {0, SPC_FAHRENHEIT_STR},
    {1, SPC_CELCIUS_STR},
};

static const SpcByteStrPool_t SpcDipModeStr[] = {
    {0, SPC_DIP_NORMAL_STR},
    {1, SPC_DIP_ADVANCED_STR},
};

static const SpcByteStrPool_t SpcDefDipStr[] = {
    {0, SPC_DEF_SYS_STATUS_STR},
    {1, SPC_DEF_HEAT_STATUS_STR},
    {2, SPC_DEF_HEAT_TEMP_STR},
};

static const SpcByteStrPool_t SpcBaudrateStr[] = {
    {0, SPC_1200_STR},
    {1, SPC_2400_STR},
    {2, SPC_4800_STR},
    {3, SPC_9600_STR},
    {4, SPC_115200_STR},
};

static const SpcByteStrPool_t SpcGfiTestStr[] = {
    {0, SPC_AUTO_CYCLE_STR},
    {1, SPC_NOW_STR},
    {2, SPC_DISABLE_STR},
};

static const SpcByteStrPool_t SpcRTDStatStr[] = {
    {0, SPC_RTD_OFF_STR},
    {1, SPC_RTD_ON_STR},
    {2, SPC_RTD_MANOFF_STR},
    {3, SPC_RTD_MANON_STR},
};

static const SpcDataByte_t SpcDataByte[] = {
    {33, SPC_MENU_PROG_HEATEN_STR,      1,   0x00000001, 2,  SpcHeatEnStr},
    {35, SPC_MENU_PROG_HEAT_TYPE_STR,   19,  0x00000001, 2,  SpcHeatTypeStr},
    {36, SPC_MENU_PROG_MANUAL_STR,      2,   0x00000001, 2,  SpcManualStr},
    {38, SPC_MENU_PROG_CTLTYPE_STR,     3,   0x00000001, 2,  SpcCtlTypeStr},
    {42, SPC_MENU_PROG_RTDMODE_STR,     4,   0x00000007, 6,  SpcRtdModeStr},
    {43, SPC_MENU_PROG_RTDFAILMODE_STR, 7,   0x00000001, 2,  SpcRtdFailModeStr},
    {45, SPC_MENU_PROG_PASSWORDEN_STR,  8,   0x00000001, 2,  SpcPasswordEnStr},
    {47, SPC_MENU_PROG_UNIT_STR,        0,   0x00000001, 2,  SpcUnitStr},
    {49, SPC_MENU_PROG_DIPMODE_STR,     13,  0x00000001, 2,  SpcDipModeStr},
    {50, SPC_MENU_PROG_DEFDIP_STR,      9,   0x00000003, 3,  SpcDefDipStr},
    {54, SPC_MENU_PROG_BAUDRATE_STR,    14,  0x00000007, 5,  SpcBaudrateStr},
    {59, SPC_MENU_PROG_GFITEST_STR,     17,  0x00000003, 3,  SpcGfiTestStr},
    {61, SPC_DEF_HEAT_STATUS_STR,       11,  0x00000003, 2,  SpcRTDStatStr},
};

static const SpcDataStatus_t SpcNorIntStatus[] = {
    SPC_OFF,
};

static const SpcDataStatus_t SpcTestIntStatus[] = {
    SPC_DISABLE_STR,
    SPC_CONTINUE_STR,
};

static const SpcConfIntLimit_t SpcConfIntLimit[] = {
    {26, MAX_SPCLOWCURRENT, MIN_SPCCURRENT, &SpcConfHighCurrent(&SpcValue), NULL, 1, SpcNorIntStatus},
    {27, MAX_SPCCURRENT, MIN_SPCHIGHCURRENT, NULL, &SpcConfLowCurrent(&SpcValue), 1, SpcNorIntStatus},
    {28, MAX_SPCLOWGFIALARM, MIN_SPCGFIALARM, &SpcConfGFITrip(&SpcValue), NULL, 1, SpcNorIntStatus},
    {29, MAX_SPCGFIALARM, MIN_SPCHIGHGFIALARM, NULL, &SpcConfGFIAlarm(&SpcValue), 1, SpcNorIntStatus},
    {30, MAX_SPCLOWVOLT, MIN_SPCVOLT, &SpcConfHighVolt(&SpcValue), NULL, 1, SpcNorIntStatus},
    {31, MAX_SPCVOLT, MIN_SPCHIGHVOLT, NULL, &SpcConfLowVolt(&SpcValue), 1, SpcNorIntStatus},
    {39, MAX_SPCCURRENTLMT, MIN_SPCCURRENTLMT, NULL, NULL, 1, SpcNorIntStatus},
    {40, MAX_SOFTSTART, MIN_SOFTSTART, NULL, NULL, 1, SpcNorIntStatus},
    {41, MAX_AUTOTEST, MIN_AUTOTEST, NULL, NULL, 1, SpcNorIntStatus},
    {48, MAX_SPCOST, MIN_SPCOST, NULL, NULL, 0, NULL},
    {51, MAX_TIMEOUT, MIN_TIMEOUT, NULL, NULL, 1, SpcNorIntStatus},
    {52, MAX_SCANSPEED, MIN_SCANSPEED, NULL, NULL, 0, NULL},
    {53, MAX_MODBUS, MIN_MODBUS, NULL, NULL, 0, NULL},
    {57, MAX_ALARMOUT, MIN_ALARMOUT, NULL, NULL, 2, SpcTestIntStatus},
    {58, MAX_HEATERTEST, MIN_HEATERTEST, NULL, NULL, 2, SpcTestIntStatus},
};

static const SpcPasswordStatus_t SpcPasswordStatus[] = {
    {74, SPC_PSW_OLD,        &SpcStackStr(&SpcValue)},
    {75, SPC_PSW_NEW,        &SpcStackStr(&SpcValue)},
    {76, SPC_PSW_NEW_AGAIN,  &SpcStackNewStr(&SpcValue)},
};

static const SpcStateAction_t SpcStateAction[] = {
//    entry                         right                  left                  up                    down                  act                prog                reset                  enter                alarm   
    {{0,SpcEntryInit},             {1,NULL},              {21,NULL},            {0,NULL},             {0,NULL},             {9,NULL},          {22,NULL},          {0,NULL},              {0,NULL},            {0,NULL}},
    {{1,SpcEntryShowHeatStatus},   {2,NULL},              {0,NULL},             {1,NULL},             {1,NULL},             {9,NULL},          {22,NULL},          {1,NULL},              {1,NULL},            {0,NULL}},
    {{2,SpcEntryShowHeatTemp},     {3,NULL},              {1,NULL},             {2,NULL},             {2,NULL},             {9,NULL},          {22,NULL},          {2,NULL},              {2,NULL},            {0,NULL}},
    {{3,SpcEntryShowHeatTemp},     {4,NULL},              {2,NULL},             {3,NULL},             {3,NULL},             {9,NULL},          {22,NULL},          {3,NULL},              {3,NULL},            {0,NULL}},
    {{4,SpcEntryShowHeatTemp},     {5,NULL},              {3,NULL},             {4,NULL},             {4,NULL},             {9,NULL},          {22,NULL},          {4,NULL},              {4,NULL},            {0,NULL}},
    {{5,SpcEntryShowInt16},        {6,NULL},              {4,NULL},             {5,NULL},             {5,NULL},             {9,NULL},          {22,NULL},          {5,NULL},              {5,NULL},            {0,NULL}},
    {{6,SpcEntryShowInt16},        {7,NULL},              {5,NULL},             {6,NULL},             {6,NULL},             {9,NULL},          {22,NULL},          {6,NULL},              {6,NULL},            {0,NULL}},
    {{7,SpcEntryShowInt16},        {8,NULL},              {6,NULL},             {7,NULL},             {7,NULL},             {9,NULL},          {22,NULL},          {7,NULL},              {7,NULL},            {0,NULL}},
    {{8,SpcEntryShowInt16},        {9,NULL},              {7,NULL},             {8,NULL},             {8,NULL},             {9,NULL},          {22,NULL},          {8,NULL},              {8,NULL},            {0,NULL}},

    {{9,SpcEntryInit},             {10,NULL},             {8,NULL},             {9,NULL},             {9,NULL},             {0,NULL},          {22,NULL},          {9,NULL},              {9,NULL},            {9,NULL}},
    {{10,SpcEntryShowHeatTemp},    {11,NULL},             {9,NULL},             {10,NULL},            {10,NULL},            {0,NULL},          {22,NULL},          {10,NULL},             {10,SpcPushTempRet}, {9,NULL}},
    {{11,SpcEntryShowHeatTemp},    {12,NULL},             {10,NULL},            {11,NULL},            {11,NULL},            {0,NULL},          {22,NULL},          {11,NULL},             {11,SpcPushTempRet}, {9,NULL}},
    {{12,SpcEntryShowInt16},       {13,NULL},             {11,NULL},            {12,NULL},            {12,NULL},            {0,NULL},          {22,NULL},          {12,NULL},             {12,SpcPushIntRet},  {9,NULL}},
    {{13,SpcEntryShowInt16},       {14,NULL},             {12,NULL},            {13,NULL},            {13,NULL},            {0,NULL},          {22,NULL},          {13,NULL},             {13,SpcPushIntRet},  {9,NULL}},
    {{14,SpcEntryShowInt16},       {15,NULL},             {13,NULL},            {14,NULL},            {14,NULL},            {0,NULL},          {22,NULL},          {14,NULL},             {14,SpcPushIntRet},  {9,NULL}},
    {{15,SpcEntryShowInt16},       {16,NULL},             {14,NULL},            {15,NULL},            {15,NULL},            {0,NULL},          {22,NULL},          {15,NULL},             {15,SpcPushIntRet},  {9,NULL}},
    {{16,SpcEntryShowInt16},       {17,NULL},             {15,NULL},            {16,NULL},            {16,NULL},            {0,NULL},          {22,NULL},          {16,NULL},             {16,NULL},           {9,NULL}},
    {{17,SpcEntryShowInt32},       {18,NULL},             {16,NULL},            {17,NULL},            {17,NULL},            {0,NULL},          {22,NULL},          {17,NULL},             {17,NULL},           {9,NULL}},
    {{18,SpcEntryShowInt32},       {19,NULL},             {17,NULL},            {18,NULL},            {18,NULL},            {0,NULL},          {22,NULL},          {18,NULL},             {18,NULL},           {9,NULL}},
    {{19,SpcEntryShowInt16},       {20,NULL},             {18,NULL},            {19,NULL},            {19,NULL},            {0,NULL},          {22,NULL},          {19,NULL},             {19,NULL},           {9,NULL}},
    {{20,SpcEntryInit},            {21,NULL},             {19,NULL},            {20,NULL},            {20,NULL},            {0,NULL},          {22,NULL},          {20,NULL},             {20,SpcPushAllRet},  {9,NULL}},
    {{21,SpcEntryInit},            {0,NULL},              {20,NULL},            {21,NULL},            {21,NULL},            {0,NULL},          {22,NULL},          {21,NULL},             {21,NULL},           {9,NULL}},

    {{22,SpcEntryInit},            {23,NULL},             {59,NULL},            {22,NULL},            {22,NULL},            {0,NULL},          {32,NULL},          {22,NULL},             {22,NULL},           {9,NULL}},
    {{23,SpcEntryShowHeatTemp},    {24,NULL},             {22,NULL},            {23,SpcPushTmUp},     {23,SpcPushTmDown},   {0,NULL},          {32,NULL},          {23,NULL},             {23,NULL},           {9,NULL}},
    {{24,SpcEntryShowHeatTemp},    {25,NULL},             {23,NULL},            {24,SpcPushTmUp},     {24,SpcPushTmDown},   {0,NULL},          {32,NULL},          {24,NULL},             {24,NULL},           {9,NULL}},
    {{25,SpcEntryShowHeatTemp},    {26,NULL},             {24,NULL},            {25,SpcPushTmUp},     {25,SpcPushTmDown},   {0,NULL},          {32,NULL},          {25,NULL},             {25,NULL},           {9,NULL}},
    {{26,SpcEntryShowConfInt16},   {27,NULL},             {25,NULL},            {26,SpcPushIntUp},    {26,SpcPushIntDown},  {0,NULL},          {32,NULL},          {26,NULL},             {26,NULL},           {9,NULL}},
    {{27,SpcEntryShowConfInt16},   {28,NULL},             {26,NULL},            {27,SpcPushIntUp},    {27,SpcPushIntDown},  {0,NULL},          {32,NULL},          {27,NULL},             {27,NULL},           {9,NULL}},
    {{28,SpcEntryShowConfInt16},   {29,NULL},             {27,NULL},            {28,SpcPushIntUp},    {28,SpcPushIntDown},  {0,NULL},          {32,NULL},          {28,NULL},             {28,NULL},           {9,NULL}},
    {{29,SpcEntryShowConfInt16},   {30,NULL},             {28,NULL},            {29,SpcPushIntUp},    {29,SpcPushIntDown},  {0,NULL},          {32,NULL},          {29,NULL},             {29,NULL},           {9,NULL}},
    {{30,SpcEntryShowConfInt16},   {31,NULL},             {29,NULL},            {30,SpcPushIntUp},    {30,SpcPushIntDown},  {0,NULL},          {32,NULL},          {30,NULL},             {30,NULL},           {9,NULL}},
    {{31,SpcEntryShowConfInt16},   {32,NULL},             {30,NULL},            {31,SpcPushIntUp},    {31,SpcPushIntDown},  {0,NULL},          {32,NULL},          {31,NULL},             {31,NULL},           {9,NULL}},

    {{32,SpcEntryInit},            {33,NULL},             {31,NULL},            {32,NULL},            {32,NULL},            {0,NULL},          {44,NULL},          {32,NULL},             {32,NULL},           {70,NULL}},
    {{33,SpcEntryShowByte},        {34,NULL},             {32,NULL},            {33,SpcPushByteUp},   {33,SpcPushByteDown}, {0,NULL},          {44,NULL},          {33,NULL},             {33,NULL},           {70,NULL}},
    {{34,SpcEntryShowId},          {35,NULL},             {33,NULL},            {34,SpcIdUp},         {34,SpcIdDown},       {0,NULL},          {44,NULL},          {34,SpcEntryShowId},   {34,SpcIdConf},      {70,NULL}},
    {{35,SpcEntryShowByte},        {36,NULL},             {34,NULL},            {35,SpcPushByteUp},   {35,SpcPushByteDown}, {0,NULL},          {44,NULL},          {35,NULL},             {35,NULL},           {70,NULL}},
    {{36,SpcEntryShowByte},        {37,NULL},             {35,NULL},            {36,SpcPushByteUp},   {36,SpcPushByteDown}, {0,NULL},          {44,NULL},          {36,NULL},             {36,NULL},           {70,NULL}},
    {{37,SpcEntryShowHeatTemp},    {38,NULL},             {36,NULL},            {37,SpcPushTmUp},     {37,SpcPushTmDown},   {0,NULL},          {44,NULL},          {37,NULL},             {37,NULL},           {70,NULL}},
    {{38,SpcEntryShowByte},        {39,NULL},             {37,NULL},            {38,SpcPushByteUp},   {38,SpcPushByteDown}, {0,NULL},          {44,NULL},          {38,NULL},             {38,NULL},           {70,NULL}},
    {{39,SpcEntryShowConfInt16},   {40,NULL},             {38,NULL},            {39,SpcPushIntUp},    {39,SpcPushIntDown},  {0,NULL},          {44,NULL},          {39,NULL},             {39,NULL},           {70,NULL}},
    {{40,SpcEntryShowConfInt16},   {41,NULL},             {39,NULL},            {40,SpcPushIntUp},    {40,SpcPushIntDown},  {0,NULL},          {44,NULL},          {40,NULL},             {40,NULL},           {70,NULL}},
    {{41,SpcEntryShowConfInt16},   {42,NULL},             {40,NULL},            {41,SpcPushIntUp},    {41,SpcPushIntDown},  {0,NULL},          {44,NULL},          {41,NULL},             {41,NULL},           {70,NULL}},
    {{42,SpcEntryShowByte},        {43,NULL},             {41,NULL},            {42,SpcPushByteUp},   {42,SpcPushByteDown}, {0,NULL},          {44,NULL},          {42,NULL},             {42,NULL},           {70,NULL}},
    {{43,SpcEntryShowByte},        {44,NULL},             {42,NULL},            {43,SpcPushByteUp},   {43,SpcPushByteDown}, {0,NULL},          {44,NULL},          {43,NULL},             {43,NULL},           {70,NULL}},

    {{44,SpcEntryInit},            {45,NULL},             {43,NULL},            {44,NULL},            {44,NULL},            {0,NULL},          {56,NULL},          {44,NULL},             {44,NULL},           {70,NULL}},
    {{45,SpcEntryShowByte},        {46,NULL},             {44,NULL},            {45,SpcPushByteUp},   {45,SpcPushByteDown}, {0,NULL},          {56,NULL},          {45,NULL},             {45,NULL},           {70,NULL}},
    {{46,SpcEntryInit},            {47,NULL},             {45,NULL},            {46,SpcPswInitUp},    {46,SpcPswInitDown},  {0,NULL},          {56,NULL},          {46,NULL},             {46,NULL},           {70,NULL}},
    {{47,SpcEntryShowByte},        {48,NULL},             {46,NULL},            {47,SpcPushByteUp},   {47,SpcPushByteDown}, {0,NULL},          {56,NULL},          {47,NULL},             {47,NULL},           {70,NULL}},
    {{48,SpcEntryShowConfInt16},   {49,NULL},             {47,NULL},            {48,SpcPushIntUp},    {48,SpcPushIntDown},  {0,NULL},          {56,NULL},          {48,NULL},             {48,NULL},           {70,NULL}},
    {{49,SpcEntryShowByte},        {50,NULL},             {48,NULL},            {49,SpcPushByteUp},   {49,SpcPushByteDown}, {0,NULL},          {56,NULL},          {49,NULL},             {49,NULL},           {70,NULL}},
    {{50,SpcEntryShowByte},        {51,NULL},             {49,NULL},            {50,SpcPushByteUp},   {50,SpcPushByteDown}, {0,NULL},          {56,NULL},          {50,NULL},             {50,NULL},           {70,NULL}},
    {{51,SpcEntryShowConfInt16},   {52,NULL},             {50,NULL},            {51,SpcPushIntUp},    {51,SpcPushIntDown},  {0,NULL},          {56,NULL},          {51,NULL},             {51,NULL},           {70,NULL}},
    {{52,SpcEntryShowConfInt16},   {53,NULL},             {51,NULL},            {52,SpcPushIntUp},    {52,SpcPushIntDown},  {0,NULL},          {56,NULL},          {52,NULL},             {52,NULL},           {70,NULL}},
    {{53,SpcEntryShowConfInt16},   {54,NULL},             {52,NULL},            {53,SpcPushIntUp},    {53,SpcPushIntDown},  {0,NULL},          {56,NULL},          {53,NULL},             {53,NULL},           {70,NULL}},
    {{54,SpcEntryShowByte},        {55,NULL},             {53,NULL},            {54,SpcPushByteUp},   {54,SpcPushByteDown}, {0,NULL},          {56,NULL},          {54,NULL},             {54,NULL},           {70,NULL}},
    {{55,SpcEntryInit},            {56,NULL},             {54,NULL},            {55,NULL},            {55,NULL},            {0,NULL},          {56,NULL},          {55,NULL},             {55,NULL},           {70,NULL}},

    {{56,SpcEntryInit},            {57,NULL},             {55,NULL},            {56,NULL},            {56,NULL},            {0,NULL},          {22,NULL},          {56,NULL},             {56,NULL},           {70,NULL}},
    {{57,SpcEntryShowConfInt16},   {58,NULL},             {56,NULL},            {57,SpcPushIntUp},    {57,SpcPushIntDown},  {0,NULL},          {22,NULL},          {57,NULL},             {57,NULL},           {70,NULL}},
    {{58,SpcEntryShowConfInt16},   {59,NULL},             {57,NULL},            {58,SpcPushIntUp},    {58,SpcPushIntDown},  {0,NULL},          {22,NULL},          {58,NULL},             {58,NULL},           {70,NULL}},
    {{59,SpcEntryShowByte},        {22,NULL},             {58,NULL},            {59,SpcPushByteUp},   {59,SpcPushByteDown}, {0,NULL},          {22,NULL},          {59,NULL},             {59,NULL},           {70,NULL}},

// Default display
    {{60,SpcEntryShowSysStatus},   {60,NULL},             {60,NULL},            {60,NULL},            {60,NULL},            {0,NULL},          {22,NULL},          {60,NULL},             {60,NULL},           {60,NULL}},
    {{61,SpcEntryShowByte},        {61,NULL},             {61,NULL},            {61,NULL},            {61,NULL},            {0,NULL},          {22,NULL},          {61,NULL},             {61,NULL},           {61,NULL}},
    {{62,SpcEntryShowHeatTemp},    {62,NULL},             {62,NULL},            {62,NULL},            {62,NULL},            {0,NULL},          {22,NULL},          {62,NULL},             {62,NULL},           {62,NULL}},

// Statistic reset
    {{63,SpcEntryInit},            {63,NULL},             {63,NULL},            {64,NULL},            {63,NULL},            {0,NULL},          {22,NULL},          {63,SpcResetRet},      {63,SpcResetRet},    {63,NULL}},
    {{64,SpcEntryInit},            {64,NULL},             {64,NULL},            {64,NULL},            {63,NULL},            {0,NULL},          {22,NULL},          {64,SpcResetRet},      {64,SpcConfirmTemp}, {64,NULL}},
    {{65,SpcEntryInit},            {65,NULL},             {65,NULL},            {66,NULL},            {65,NULL},            {0,NULL},          {22,NULL},          {65,SpcResetRet},      {65,SpcResetRet},    {65,NULL}},
    {{66,SpcEntryInit},            {66,NULL},             {66,NULL},            {66,NULL},            {65,NULL},            {0,NULL},          {22,NULL},          {66,SpcResetRet},      {66,SpcConfirmInt},  {66,NULL}},
    {{67,SpcEntryInit},            {67,NULL},             {67,NULL},            {68,NULL},            {67,NULL},            {0,NULL},          {22,NULL},          {67,SpcResetRet},      {67,SpcResetRet},    {67,NULL}},
    {{68,SpcEntryInit},            {68,NULL},             {68,NULL},            {68,NULL},            {67,NULL},            {0,NULL},          {22,NULL},          {68,SpcResetRet},      {68,SpcConfirmAll},  {68,NULL}},

// Config
    {{69,SpcEntryInit},            {69,SpcPopRight},      {69,SpcPopLeft},      {69,SpcUpTemp},       {69,SpcDownTemp},     {0,NULL},          {69,SpcPopProg},    {69,SpcResetRet},      {69,SpcPopTempConf}, {69,NULL}},
    {{70,SpcEntryInit},            {70,SpcPopRight},      {70,SpcPopLeft},      {70,SpcUpInt},        {70,SpcDownInt},      {0,NULL},          {70,SpcPopProg},    {70,SpcResetRet},      {70,SpcPopIntConf},  {70,NULL}},
    {{71,SpcEntryInit},            {71,SpcPopRight},      {71,SpcPopLeft},      {71,SpcUpByte},       {71,SpcDownByte},     {0,NULL},          {71,SpcPopProg},    {71,SpcResetRet},      {71,SpcPopByteConf}, {71,NULL}},

// Password
    {{72,SpcEntryInit},            {72,NULL},             {72,NULL},            {73,NULL},            {72,NULL},            {0,NULL},          {22,NULL},          {72,SpcResetRet},      {72,SpcResetRet},    {72,NULL}},
    {{73,SpcEntryInit},            {73,NULL},             {73,NULL},            {73,NULL},            {72,NULL},            {0,NULL},          {22,NULL},          {73,SpcResetRet},      {73,SpcPswStart},    {73,NULL}},
    {{74,SpcEntryInit},            {74,SpcPswRight},      {74,NULL},            {74,SpcPswUp},        {74,SpcPswDown},      {0,NULL},          {22,NULL},          {74,SpcResetRet},      {74,SpcOldPswEnter}, {74,NULL}},
    {{75,SpcEntryInit},            {75,SpcPswRight},      {75,NULL},            {75,SpcPswUp},        {75,SpcPswDown},      {0,NULL},          {22,NULL},          {75,SpcResetRet},      {75,SpcPswNew},      {75,NULL}},
    {{76,SpcEntryInit},            {76,SpcPswRight},      {76,NULL},            {76,SpcPswUp},        {76,SpcPswDown},      {0,NULL},          {22,NULL},          {76,SpcResetRet},      {76,SpcPswNewAgain}, {76,NULL}},

};




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
    memset(&SpcValue, 0, sizeof(SpcValue_t));

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
/* Spc Menu                                                                   */
/*----------------------------------------------------------------------------*/
SpcInfoType_t SpcEntryInit(SpcValue_t *SpcValue)
{
    int16_t i;
    SpcInfoType_t infoType = SpcPosition(SpcValue);
    for (i=0; i<NUM_ROWS(SpcStaticInfo);i++) {
        if (SpcStaticInfo[i].type == infoType) {
            Spc_ScreenUpdateStatic(SpcStaticInfo[i].line1, SpcStaticInfo[i].line2);
            return infoType;
        }
    }
    return infoType;
}

SpcInfoType_t SpcEntryShowId(SpcValue_t *SpcValue)
{
    SpcInfoType_t infoType = SpcPosition(SpcValue);
    memset(SpcStackStr(SpcValue).str, 0, SPC_MAX_STR_LEN);
    strncpy(SpcStackStr(SpcValue).str, SpcName(SpcValue), SPC_MAX_STR_LEN);
    SpcStackStr(SpcValue).index = 0;
    SpcStackStr(SpcValue).charIndex = SpcGetCharIndex(SpcStackStr(SpcValue).str[0]);
    Spc_ScreenUpdateDynamic(SPC_MENU_PROG_HEATID_STR, SpcName(SpcValue));
    return infoType;
}

SpcInfoType_t SpcIdUp(SpcValue_t *SpcValue)
{
    SpcInfoType_t infoType = SpcPosition(SpcValue);
    uint8_t index = 0, charIndex = 0;
    if (SpcStackStr(SpcValue).charIndex < NUM_ROWS(SpcCharactors)) {
        SpcStackStr(SpcValue).charIndex++;

        index = SpcStackStr(SpcValue).index;
        charIndex = SpcStackStr(SpcValue).charIndex;
        SpcStackStr(SpcValue).str[index] = SpcCharactors[charIndex];
        Spc_ScreenUpdateDynamic(SPC_MENU_PROG_HEATID_STR, SpcStackStr(SpcValue).str);
    }

    return infoType;
}

SpcInfoType_t SpcIdDown(SpcValue_t *SpcValue)
{
    SpcInfoType_t infoType = SpcPosition(SpcValue);
    uint8_t index = 0, charIndex = 0;
    if (SpcStackStr(SpcValue).charIndex > 0) {
        SpcStackStr(SpcValue).charIndex--;

        index = SpcStackStr(SpcValue).index;
        charIndex = SpcStackStr(SpcValue).charIndex;
        SpcStackStr(SpcValue).str[index] = SpcCharactors[charIndex];
        Spc_ScreenUpdateDynamic(SPC_MENU_PROG_HEATID_STR, SpcStackStr(SpcValue).str);
    }

    return infoType;
}

SpcInfoType_t SpcIdConf(SpcValue_t *SpcValue)
{
    SpcInfoType_t infoType = SpcPosition(SpcValue);
    uint8_t index = 0;

    if (SpcStackStr(SpcValue).index >= 16) {
        memset(SpcName(SpcValue), 0, SPC_MAX_STR_LEN);
        strncpy(SpcName(SpcValue), SpcStackStr(SpcValue).str, SPC_MAX_STR_LEN);

        SpcStackStr(SpcValue).index = 0;
        SpcStackStr(SpcValue).charIndex = SpcGetCharIndex(SpcStackStr(SpcValue).str[0]);
        Spc_ScreenUpdateDynamic(SPC_MENU_PROG_HEATID_STR, SpcName(SpcValue));
    } else {
        SpcStackStr(SpcValue).index++;
        index = SpcStackStr(SpcValue).index;
        SpcStackStr(SpcValue).charIndex = SpcGetCharIndex(SpcStackStr(SpcValue).str[index]);
        Spc_ScreenUpdateDynamic(SPC_MENU_PROG_HEATID_STR, SpcStackStr(SpcValue).str);
    }

    return infoType;
}

SpcInfoType_t SpcEntryShowHeatStatus(SpcValue_t *SpcValue)
{
    SpcInfoType_t infoType = SpcPosition(SpcValue);
    SpcRTDStatus_t rtdStatus = (SpcRTDStatus_t) (SpcConf(SpcValue).bytes.rdtStat);
    SpcStringType_t line1 = SpcRtdStatStrPool[rtdStatus].line1;
    SpcStringType_t line2 = SpcRtdStatStrPool[rtdStatus].line2;
    Spc_ScreenUpdateStatic(line1, line2);
    return infoType;
}

SpcInfoType_t SpcEntryShowHeatTemp(SpcValue_t *SpcValue)
{
    SpcInfoType_t infoType = SpcPosition(SpcValue);
    const SpcDataTemp_t *element = SpcGetDataTemp(infoType);

    if (SpcConfMainTemp(SpcValue).status == SPC_OFF) {
        Spc_ScreenUpdateStatic(element->line1, SPC_BLANK_STR);
    } else {
        SpcShowTemperature(SpcValue, element->line1, element->temp);
    }

    return infoType;
}

SpcInfoType_t SpcEntryShowInt16(SpcValue_t *SpcValue)
{
    SpcInfoType_t infoType = SpcPosition(SpcValue);
    char buf[SPC_MAX_STR_LEN] = {0};
    const SpcDataInt16_t *element = SpcGetDataInt16(infoType);

    snprintf(buf, SPC_MAX_STR_LEN, "%s%d%s", element->prefix,
        *(element->val), element->suffix);
    Spc_ScreenUpdateDynamic(element->line1, buf);
    return infoType;
}

SpcInfoType_t SpcEntryShowConfInt16(SpcValue_t *SpcValue)
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
    return infoType;
}

SpcInfoType_t SpcEntryShowInt32(SpcValue_t *SpcValue)
{
    SpcInfoType_t infoType = SpcPosition(SpcValue);
    char buf[SPC_MAX_STR_LEN] = {0};
    const SpcDataInt32_t *element = SpcGetDataInt32(SpcValue);

    snprintf(buf, SPC_MAX_STR_LEN, "%s%ld%s", element->prefix,
        *(element->val), element->suffix);
    Spc_ScreenUpdateDynamic(element->line1, buf);
    return infoType;
}

SpcInfoType_t SpcEntryShowByte(SpcValue_t *SpcValue)
{
    SpcInfoType_t infoType = SpcPosition(SpcValue);
    uint32_t word = SpcConf(SpcValue).word;
    const SpcDataByte_t *element = SpcGetDataByte(infoType);

    uint8_t val = (uint8_t)((word >> element->offset) & element->field);
    const SpcStringType_t line2 = SpcGetDataByteStr(element, val);
    Spc_ScreenUpdateStatic(element->line1, line2);
    return infoType;
}

SpcInfoType_t SpcEntryShowSysStatus(SpcValue_t *SpcValue)
{
    SpcInfoType_t infoType = SpcPosition(SpcValue);
    char buf[SPC_MAX_STR_LEN] = {0};

    snprintf(buf, sizeof(buf), "%d Alarms", SpcAlarmList(SpcValue).totalNum);
    Spc_ScreenUpdateDynamic(SPC_DEF_SYS_STATUS_STR, buf);
    return infoType;
}

//=========================================================================================
// Enter reset statistic
//=========================================================================================
SpcInfoType_t SpcPushTempRet(SpcValue_t *SpcValue)
{
    SpcStackPos(SpcValue) = SpcPosition(SpcValue);

    return 63;
}

SpcInfoType_t SpcPushIntRet(SpcValue_t *SpcValue)
{
    SpcStackPos(SpcValue) = SpcPosition(SpcValue);

    return 65;
}

SpcInfoType_t SpcPushAllRet(SpcValue_t *SpcValue)
{
    SpcStackPos(SpcValue) = SpcPosition(SpcValue);

    return 67;
}

SpcInfoType_t SpcResetRet(SpcValue_t *SpcValue)
{
    return SpcStackPos(SpcValue);
}

SpcInfoType_t SpcConfirmTemp(SpcValue_t *SpcValue)
{
    SpcInfoType_t infoType = SpcStackPos(SpcValue);
    const SpcDataTemp_t *element = SpcGetDataTemp(infoType);

    memcpy(element->temp, &SpcTemp(SpcValue,SPC_RTD_COMBIN), sizeof(SpcTemperature_t));

    Spc_ScreenUpdateStatic(SPC_MENU_RESET_FINISH_STR, SPC_BLANK_STR);

    osDelay(2000);

    return SpcStackPos(SpcValue);
}

SpcInfoType_t SpcConfirmInt(SpcValue_t *SpcValue)
{
    SpcInfoType_t infoType = SpcStackPos(SpcValue);
    const SpcDataInt16_t *element = SpcGetDataInt16(infoType);
    const SpcStatisticInt_t *elementStat = SpcGetStatisticInt(infoType);

    memcpy(element->val, elementStat->val, sizeof(int16_t));

    Spc_ScreenUpdateStatic(SPC_MENU_RESET_FINISH_STR, SPC_BLANK_STR);

    osDelay(2000);

    return SpcStackPos(SpcValue);
}

SpcInfoType_t SpcConfirmAll(SpcValue_t *SpcValue)
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

    osDelay(2000);

    return SpcStackPos(SpcValue);
}

//=========================================================================================
// Enter config temperature
//=========================================================================================
SpcInfoType_t SpcPushTmUp(SpcValue_t *SpcValue)
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

SpcInfoType_t SpcPushTmDown(SpcValue_t *SpcValue)
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

SpcInfoType_t SpcUpTemp(SpcValue_t *SpcValue)
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

SpcInfoType_t SpcDownTemp(SpcValue_t *SpcValue)
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


SpcInfoType_t SpcPopRight(SpcValue_t *SpcValue)
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

SpcInfoType_t SpcPopLeft(SpcValue_t *SpcValue)
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

SpcInfoType_t SpcPopProg(SpcValue_t *SpcValue)
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

SpcInfoType_t SpcPopTempConf(SpcValue_t *SpcValue)
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
SpcInfoType_t SpcPushIntUp(SpcValue_t *SpcValue)
{
    SpcInfoType_t infoType = SpcPosition(SpcValue);
    const SpcConfDataInt16_t *element = SpcGetConfInt16(infoType);

    memcpy(&SpcStackData(SpcValue), element->data, sizeof(SpcConfInt16_t));

    SpcModifyInt(&SpcStackData(SpcValue), infoType, true);

    SpcUpdateDipInt(&SpcStackData(SpcValue), element);

    SpcStackPos(SpcValue) = SpcPosition(SpcValue);

    return 70;
}

SpcInfoType_t SpcPushIntDown(SpcValue_t *SpcValue)
{
    SpcInfoType_t infoType = SpcPosition(SpcValue);
    const SpcConfDataInt16_t *element = SpcGetConfInt16(infoType);

    memcpy(&SpcStackData(SpcValue), element->data, sizeof(SpcConfInt16_t));

    SpcModifyInt(&SpcStackData(SpcValue), infoType, false);

    SpcUpdateDipInt(&SpcStackData(SpcValue), element);

    SpcStackPos(SpcValue) = SpcPosition(SpcValue);

    return 70;
}

SpcInfoType_t SpcUpInt(SpcValue_t *SpcValue)
{
    SpcInfoType_t infoType = SpcStackPos(SpcValue);
    const SpcConfDataInt16_t *element = SpcGetConfInt16(infoType);

    SpcModifyInt(&SpcStackData(SpcValue), infoType, true);

    SpcUpdateDipInt(&SpcStackData(SpcValue), element);

    return SpcPosition(SpcValue);
}

SpcInfoType_t SpcDownInt(SpcValue_t *SpcValue)
{
    SpcInfoType_t infoType = SpcStackPos(SpcValue);
    const SpcConfDataInt16_t *element = SpcGetConfInt16(infoType);

    SpcModifyInt(&SpcStackData(SpcValue), infoType, false);

    SpcUpdateDipInt(&SpcStackData(SpcValue), element);

    return SpcPosition(SpcValue);
}

SpcInfoType_t SpcPopIntConf(SpcValue_t *SpcValue)
{
    SpcInfoType_t infoType = SpcStackPos(SpcValue);
    const SpcConfDataInt16_t *element = SpcGetConfInt16(infoType);
    memcpy(element->data, &SpcStackData(SpcValue), sizeof(SpcConfInt16_t));

    return infoType;
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

#define SPC_SIMULATE_TEMP_C       ( 20 )
#define SPC_SIMULATE_TEMP_F       ( 20 )
static void Spc_SystemInit(SpcValue_t *SpcValue)
{
    // Actual
    SpcTemp(SpcValue, SPC_RTD_COMBIN).status = SPC_DATA_NORMAL;
    SpcTemp(SpcValue, SPC_RTD_COMBIN).tempf = SPC_SIMULATE_TEMP_F;
    SpcTemp(SpcValue, SPC_RTD_COMBIN).tempc = SPC_SIMULATE_TEMP_C;

    SpcTemp(SpcValue, SPC_RTD_CHANNEL1).status = SPC_RTD_SHORT;
    SpcTemp(SpcValue, SPC_RTD_CHANNEL1).tempf = SPC_SIMULATE_TEMP_F;
    SpcTemp(SpcValue, SPC_RTD_CHANNEL1).tempc = SPC_SIMULATE_TEMP_C;

    SpcTemp(SpcValue, SPC_RTD_CHANNEL2).status = SPC_RTD_OPEN;
    SpcTemp(SpcValue, SPC_RTD_CHANNEL2).tempf = SPC_SIMULATE_TEMP_F;
    SpcTemp(SpcValue, SPC_RTD_CHANNEL2).tempc = SPC_SIMULATE_TEMP_C;

    SpcPercent(SpcValue) = 10;
    SpcCurrent(SpcValue) = 30;
    SpcVoltage(SpcValue) = 110;

    // config
    SpcConf(SpcValue).bytes.manual = SpcManuOptDis;
    SpcConf(SpcValue).bytes.rdtStat = SPC_RTD_OFF;
    SpcConf(SpcValue).bytes.unit = SpcTempInCelsius;
    SpcConf(SpcValue).bytes.defInfo = HEATER_STATUS_MOD;
    SpcConf(SpcValue).bytes.rtdMod = SPC_ONE_RTD_MOD;
    SpcConf(SpcValue).bytes.unit = SpcTempInCelsius;
    SpcConf(SpcValue).bytes.heater_en = 1;
    SpcConf(SpcValue).bytes.ctl_type = 0;
    SpcConf(SpcValue).bytes.baud = 4;
    SpcConf(SpcValue).bytes.rtd_fail_mod = 0;
    SpcConf(SpcValue).bytes.usr_advanced = 1;
    SpcConf(SpcValue).bytes.gfi_test_mod = 2;
    SpcConf(SpcValue).bytes.heater_type = 1;

    SpcConfTimeout(SpcValue).status = SPC_DATA_NORMAL;
    SpcConfTimeout(SpcValue).val = 120;

    SpcConfMainTemp(SpcValue).status = SPC_DATA_NORMAL;
    SpcConfMainTemp(SpcValue).tempc = MAINTAINTEMP_DEF_C;
    SpcConfMainTemp(SpcValue).tempf = MAINTAINTEMP_DEF_F;
    SpcConfLowTemp(SpcValue).status = SPC_DATA_NORMAL;
    SpcConfLowTemp(SpcValue).tempc = LOWTEMPALARM_DEF_C;
    SpcConfLowTemp(SpcValue).tempf = LOWTEMPALARM_DEF_F;
    SpcConfHighTemp(SpcValue).status = SPC_OFF;
    SpcConfDeadband(SpcValue).status = SPC_DATA_NORMAL;
    SpcConfDeadband(SpcValue).tempc = DEADBAND_DEF_C;
    SpcConfDeadband(SpcValue).tempf = DEADBAND_DEF_F;

    SpcConfLowCurrent(SpcValue).status = SPC_OFF;
    SpcConfHighCurrent(SpcValue).status = SPC_OFF;
    SpcConfGFIAlarm(SpcValue).status = SPC_DATA_NORMAL;
    SpcConfGFIAlarm(SpcValue).val = GFI_ALARM_DEF;
    SpcConfGFITrip(SpcValue).status = SPC_DATA_NORMAL;
    SpcConfGFITrip(SpcValue).val = GFI_TRIP_DEF;

    SpcConfLowVolt(SpcValue).status = SPC_OFF;
    SpcConfHighVolt(SpcValue).status = SPC_OFF;
    SpcConfCurLmt(SpcValue).status = SPC_OFF;
    SpcConfSoftStart(SpcValue).status = SPC_OFF;

    SpcConfAutoTest(SpcValue).status = SPC_DATA_NORMAL;
    SpcConfAutoTest(SpcValue).val = AUTOTESTCYCLE_DEF;
    SpcConfTimeout(SpcValue).status = SPC_DATA_NORMAL;
    SpcConfTimeout(SpcValue).val = DISPLAY_TIME_DEF;
    SpcConfPrice(SpcValue).status = SPC_DATA_NORMAL;
    SpcConfPrice(SpcValue).val = COSTPERKWH_DEF;
    SpcConfScanSpd(SpcValue).status = SPC_DATA_NORMAL;
    SpcConfScanSpd(SpcValue).val = SCANSPEED_LOW;
    SpcConfModbusAdd(SpcValue).status = SPC_DATA_NORMAL;
    SpcConfModbusAdd(SpcValue).val = MODBUSADD_LOW;

    SpcConfAlarmOut(SpcValue).status = SPC_DISABLE;
    SpcConfHeatTest(SpcValue).status = SPC_DISABLE;
    SpcConfGfiTest(SpcValue).status = SPC_DISABLE;

    strncpy(SpcName(SpcValue), "My Spc           ", SPC_MAX_STR_LEN);
    strncpy(SpcPassword(SpcValue), "1234", SPC_MAX_STR_LEN);


    SpcListInit(&SpcAlarmList(SpcValue), SPC_MAX_LIST);
}

static void SpcShowDefInfo(SpcValue_t *SpcValue)
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

/*----------------------------------------------------------------------------*/
/* Enter config byte                                                         */
/*----------------------------------------------------------------------------*/
static inline bool SpcModifyByte(int16_t *val, const SpcDataByte_t *element, bool increase)
{
    uint8_t size = element->tableSize;

    if (increase) {
        if (*val < (size-1)) {
            (*val)++;
            return true;
        } else {
            return false;
        }
    } else {
        if (*val > 0) {
            (*val)--;
            return true;
        } else {
            return false;
        }
    }
}

SpcInfoType_t SpcPushByteUp(SpcValue_t *SpcValue)
{
    SpcInfoType_t infoType = SpcPosition(SpcValue);
    const SpcDataByte_t *element = SpcGetDataByte(infoType);

    uint32_t word = SpcConf(SpcValue).word;
    int16_t val = (int16_t)((word >> element->offset) & element->field);

    SpcStackData(SpcValue).val = val;

    if (SpcModifyByte(&(SpcStackData(SpcValue).val), element, true)) {
        const SpcStringType_t line2 = SpcGetDataByteStr(element, SpcStackData(SpcValue).val);
        Spc_ScreenUpdateStatic(element->line1, line2);
    }

    SpcStackPos(SpcValue) = SpcPosition(SpcValue);

    return 71;
}

SpcInfoType_t SpcPushByteDown(SpcValue_t *SpcValue)
{
    SpcInfoType_t infoType = SpcPosition(SpcValue);
    const SpcDataByte_t *element = SpcGetDataByte(infoType);

    uint32_t word = SpcConf(SpcValue).word;
    int16_t val = (int16_t)((word >> element->offset) & element->field);

    SpcStackData(SpcValue).val = val;

    if (SpcModifyByte(&(SpcStackData(SpcValue).val), element, false)) {
        const SpcStringType_t line2 = SpcGetDataByteStr(element, SpcStackData(SpcValue).val);
        Spc_ScreenUpdateStatic(element->line1, line2);
    }

    SpcStackPos(SpcValue) = SpcPosition(SpcValue);

    return 71;
}

SpcInfoType_t SpcUpByte(SpcValue_t *SpcValue)
{
    SpcInfoType_t infoType = SpcStackPos(SpcValue);
    const SpcDataByte_t *element = SpcGetDataByte(infoType);

    if (SpcModifyByte(&(SpcStackData(SpcValue).val), element, true)) {
        const SpcStringType_t line2 = SpcGetDataByteStr(element, SpcStackData(SpcValue).val);
        Spc_ScreenUpdateStatic(element->line1, line2);
    }

    return SpcPosition(SpcValue);
}

SpcInfoType_t SpcDownByte(SpcValue_t *SpcValue)
{
    SpcInfoType_t infoType = SpcStackPos(SpcValue);
    const SpcDataByte_t *element = SpcGetDataByte(infoType);

    if (SpcModifyByte(&(SpcStackData(SpcValue).val), element, false)) {
        const SpcStringType_t line2 = SpcGetDataByteStr(element, SpcStackData(SpcValue).val);
        Spc_ScreenUpdateStatic(element->line1, line2);
    }

    return SpcPosition(SpcValue);
}

SpcInfoType_t SpcPopByteConf(SpcValue_t *SpcValue)
{
    SpcInfoType_t infoType = SpcStackPos(SpcValue);
    const SpcDataByte_t *element = SpcGetDataByte(infoType);
    uint32_t mask = ~(element->field << element->offset);
    uint32_t val = ((uint32_t) (SpcStackData(SpcValue).val)) << element->offset;

    SpcConf(SpcValue).word = (SpcConf(SpcValue).word & mask) | val;

    return infoType;
}

//=========================================================================================
// Password
//=========================================================================================
static const SpcPasswordStatus_t *SpcGetPswStatus(SpcInfoType_t infoType)
{
    uint8_t i;
    for (i=0; i<NUM_ROWS(SpcPasswordStatus); i++) {
        if (SpcPasswordStatus[i].type == infoType) {
            return &SpcPasswordStatus[i];
        }
    }
    return NULL;
}

SpcInfoType_t SpcPswInitUp(SpcValue_t *SpcValue)
{
    Spc_ScreenUpdateStatic(SPC_MENU_PROG_PSWINIT_STR, SPC_YES_STR);

    SpcStackPos(SpcValue) = SpcPosition(SpcValue);

    return 73;
}

SpcInfoType_t SpcPswInitDown(SpcValue_t *SpcValue)
{
    Spc_ScreenUpdateStatic(SPC_MENU_PROG_PSWINIT_STR, SPC_NO_STR);

    SpcStackPos(SpcValue) = SpcPosition(SpcValue);

    return 72;
}

SpcInfoType_t SpcPswStart(SpcValue_t *SpcValue)
{
    memset(SpcStackStr(SpcValue).str, 0, SPC_MAX_STR_LEN);
    SpcStackStr(SpcValue).index = 0;
    SpcStackStr(SpcValue).charIndex = 1;
    SpcStackStr(SpcValue).str[0] = SpcCharactors[1];
    Spc_ScreenUpdateDynamic(SPC_PSW_OLD, SpcStackStr(SpcValue).str);

    return 74;
}

SpcInfoType_t SpcPswUp(SpcValue_t *SpcValue)
{
    SpcInfoType_t infoType = SpcPosition(SpcValue);
    const SpcPasswordStatus_t *element = SpcGetPswStatus(infoType);
    SpcStrStack_t *stack = element->stack;
    uint8_t index = 0, charIndex = 0, i;
    if (stack->charIndex < NUM_ROWS(SpcCharactors)) {
        stack->charIndex++;

        index = stack->index;
        charIndex = stack->charIndex;
        stack->str[index] = SpcCharactors[charIndex];

        char buf[SPC_MAX_STR_LEN] = {0};
        strncpy(buf, stack->str, SPC_MAX_STR_LEN);

        for (i=0; i<index; i++) buf[i] = '*';
        Spc_ScreenUpdateDynamic(element->line1, buf);
    }

    return infoType;
}

SpcInfoType_t SpcPswDown(SpcValue_t *SpcValue)
{
    SpcInfoType_t infoType = SpcPosition(SpcValue);
    const SpcPasswordStatus_t *element = SpcGetPswStatus(infoType);
    SpcStrStack_t *stack = element->stack;
    uint8_t index = 0, charIndex = 0, i;
    if (stack->charIndex > 1) {
        stack->charIndex--;

        index = stack->index;
        charIndex = stack->charIndex;
        stack->str[index] = SpcCharactors[charIndex];

        char buf[SPC_MAX_STR_LEN] = {0};
        strncpy(buf, stack->str, SPC_MAX_STR_LEN);

        for (i=0; i<index; i++) buf[i] = '*';
        Spc_ScreenUpdateDynamic(element->line1, stack->str);
    }

    return infoType;
}

SpcInfoType_t SpcPswRight(SpcValue_t *SpcValue)
{
    SpcInfoType_t infoType = SpcPosition(SpcValue);
    const SpcPasswordStatus_t *element = SpcGetPswStatus(infoType);
    SpcStrStack_t *stack = element->stack;
    uint8_t index = 0, charIndex = 0, i;

    stack->index++;
    stack->charIndex = 1;

    index = stack->index;
    charIndex = stack->charIndex;
    stack->str[index] = SpcCharactors[charIndex];

    char buf[SPC_MAX_STR_LEN] = {0};
    strncpy(buf, stack->str, SPC_MAX_STR_LEN);

    for (i=0; i<index; i++) buf[i] = '*';
    Spc_ScreenUpdateDynamic(element->line1, buf);

    return infoType;
}

SpcInfoType_t SpcOldPswEnter(SpcValue_t *SpcValue)
{
    SpcInfoType_t infoType = SpcPosition(SpcValue);
    SpcInfoType_t nextType = SpcStackPos(SpcValue);
    const SpcPasswordStatus_t *element = SpcGetPswStatus(infoType);
    SpcStrStack_t *stack = element->stack;

    if (strncmp(stack->str, SpcPassword(SpcValue), SPC_MAX_STR_LEN) == 0) {
        const SpcPasswordStatus_t *nextEle = SpcGetPswStatus(75);
        SpcStrStack_t *nextStack = nextEle->stack;

        memset(nextStack->str, 0, SPC_MAX_STR_LEN);
        nextStack->index = 0;
        nextStack->charIndex = 1;
        nextStack->str[0] = SpcCharactors[1];
        Spc_ScreenUpdateDynamic(nextEle->line1, nextStack->str);

        return 75;
    } else {
        Spc_ScreenUpdateStatic(SPC_PSW_INVALID, SPC_BLANK_STR);
        osDelay(2000);

        return nextType;
    }
}

SpcInfoType_t SpcPswNew(SpcValue_t *SpcValue)
{
    SpcInfoType_t infoType = SpcPosition(SpcValue);
    SpcInfoType_t nextType = SpcStackPos(SpcValue);
    const SpcPasswordStatus_t *element = SpcGetPswStatus(infoType);
    SpcStrStack_t *stack = element->stack;

    if (stack->index < 3) {
        Spc_ScreenUpdateStatic(SPC_PSW_INVALID, SPC_BLANK_STR);
        osDelay(2000);

        return nextType;
    } else {
        const SpcPasswordStatus_t *nextEle = SpcGetPswStatus(76);
        SpcStrStack_t *nextStack = nextEle->stack;

        memset(nextStack->str, 0, SPC_MAX_STR_LEN);
        nextStack->index = 0;
        nextStack->charIndex = 1;
        nextStack->str[0] = SpcCharactors[1];
        Spc_ScreenUpdateDynamic(nextEle->line1, nextStack->str);

        return 76;
    }
}

SpcInfoType_t SpcPswNewAgain(SpcValue_t *SpcValue)
{
    SpcInfoType_t nextType = SpcStackPos(SpcValue);
    const SpcPasswordStatus_t *element = SpcGetPswStatus(75);
    const SpcPasswordStatus_t *NewEle = SpcGetPswStatus(76);
    SpcStrStack_t *stack = element->stack;
    SpcStrStack_t *newStack = NewEle->stack;

    if (strncmp(stack->str, newStack->str, SPC_MAX_STR_LEN) == 0) {
        strncpy(SpcPassword(SpcValue), newStack->str, SPC_MAX_STR_LEN);
        Spc_ScreenUpdateStatic(SPC_PSW_SUCCESS, SPC_BLANK_STR);
        osDelay(2000);
    } else {
        Spc_ScreenUpdateStatic(SPC_PSW_NOT_MATCH, SPC_BLANK_STR);
        osDelay(2000);
    }
    return nextType;
}

/*----------------------------------------------------------------------------*/
/* Private functions                                                           */
/*----------------------------------------------------------------------------*/
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
    int16_t i;
    for (i=0; i<NUM_ROWS(SpcDataTemp);i++) {
        if (SpcDataTemp[i].type == infoType) {
            return &SpcDataTemp[i];
        }
    }
    return NULL;
}

static const SpcStatisticInt_t *SpcGetStatisticInt(SpcInfoType_t infoType)
{
    int16_t i;
    for (i=0; i<NUM_ROWS(SpcStatisticInt);i++) {
        if (SpcStatisticInt[i].type == infoType) {
            return &SpcStatisticInt[i];
        }
    }
    return NULL;
}

static const SpcDataInt16_t *SpcGetDataInt16(SpcInfoType_t infoType)
{
    int16_t i;
    for (i=0; i<NUM_ROWS(SpcDataInt16);i++) {
        if (SpcDataInt16[i].type == infoType) {
            return &SpcDataInt16[i];
        }
    }
    return NULL;
}

static const SpcConfDataInt16_t *SpcGetConfInt16(SpcInfoType_t infoType)
{
    int16_t i;
    for (i=0; i<NUM_ROWS(SpcConfDataInt16);i++) {
        if (SpcConfDataInt16[i].type == infoType) {
            return &SpcConfDataInt16[i];
        }
    }
    return NULL;
}

static const SpcDataInt32_t *SpcGetDataInt32(SpcValue_t *SpcValue)
{
    SpcInfoType_t infoType = SpcPosition(SpcValue);
    int16_t i;
    for (i=0; i<NUM_ROWS(SpcDataInt32);i++) {
        if (SpcDataInt32[i].type == infoType) {
            return &SpcDataInt32[i];
        }
    }
    return NULL;
}

static const SpcDataByte_t *SpcGetDataByte(SpcInfoType_t infoType)
{
    int16_t i;
    for (i=0; i<NUM_ROWS(SpcDataByte);i++) {
        if (SpcDataByte[i].type == infoType) {
            return &SpcDataByte[i];
        }
    }
    return NULL;
}

static const SpcStringType_t SpcGetDataByteStr(const SpcDataByte_t *element, uint8_t val)
{
    int16_t num = element->tableSize;
    const SpcByteStrPool_t *table = element->table;
    int16_t i;
    for (i=0; i<num;i++) {
        if (table[i].val == val) {
            return table[i].strIndex;
        }
    }
    return 0;
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
    int16_t i;
    for (i=0; i<NUM_ROWS(SpcConfIntLimit);i++) {
        if (SpcConfIntLimit[i].type == infoType) {
            return &SpcConfIntLimit[i];
        }
    }
    return NULL;
}

static uint8_t SpcGetConfStatusIndex(const SpcConfIntLimit_t *element, SpcDataStatus_t status)
{
    uint8_t index = 0;
    for (index=0; index<element->size; index++) {
        if (element->status[index] == status) {
            return index;
        } 
    }
    return 0;
}

// id config
static uint8_t SpcGetCharIndex(char c)
{
    uint8_t charIndex = 0;

    for (charIndex=0; charIndex<NUM_ROWS(SpcCharactors); charIndex++) {
        if (SpcCharactors[charIndex] == c)
            return charIndex;
    }
    return 0;
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

/*----------------------------------------------------------------------------*/
/* Private functions                                                           */
/*----------------------------------------------------------------------------*/
static void SpcTask(void const *arg)
{
    osEvent event;
    uint16_t command = 0;

    UNUSED(spcStartupLogOn);
    UNUSED(spcStartupLogOff);
    Spc_SystemInit(&SpcValue);
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