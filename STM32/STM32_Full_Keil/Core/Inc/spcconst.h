#ifndef __spc_const_H
#define __spc_const_H
#ifdef __cplusplus
 extern "C" {
#endif

#include "main.h"
#include "spccommon.h"

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

static const SpcScreenInfo_t SpcScreenInfo[SPC_MAX_INFO_TYPE] = {
    {SPC_SOFTWARE_VERSION,    SPC_MAX_INFO_TYPE,        SPC_FIRMWARE_NAME_STR,    SPC_FIRMWARE_VER_STR,
        NULL},
    {SPC_SELFCHECK,           SPC_MAX_INFO_TYPE,        SPC_SYSTEMCHK_STR,        SPC_BLANK_STR,
        NULL},
    {SPC_SELFCHKFAIL,         SPC_MAX_INFO_TYPE,        SPC_SELFCHKFAIL_STR,      SPC_BLANK_STR, 
        NULL},

    // default display
    {SPC_DEFINFO_HEAT_TEMP,   SPC_DEFINFO_HEAT_TEMP,    SPC_DEF_HEAT_TEMP_STR,    SPC_MAX_STR_TYPE,
        Spc_GetHeatTempDetail},
    {SPC_DEFINFO_HEAT_STATUS, SPC_DEFINFO_HEAT_STATUS,  SPC_DEF_HEAT_STATUS_STR,  SPC_MAX_STR_TYPE,
        Spc_GetHeatStatusDetail},
    {SPC_DEFINFO_SYS_STATUS,  SPC_DEFINFO_SYS_STATUS,   SPC_DEF_SYS_STATUS_STR,   SPC_MAX_STR_TYPE,
        Spc_GetSysStatusDetail},

    // menu actual
    {SPC_MENU_INIT,           SPC_MENU_RTD_STAT,        SPC_MENU_ACT_CATAG_STR,   SPC_MAX_STR_TYPE,
        Spc_GetSysStatusDetail},

#ifdef SPC_CALIB_WANTED
    {SPC_CALIB_NEED,       SPC_CALIB_NEED_STR,          SPC_BLANK_STR},
#endif
};

static SpcStringPool_t SpcStrPool[SPC_MAX_STR_TYPE] = {
    {SPC_BLANK_STR,                "                 "},
    {SPC_FIRMWARE_NAME_STR,        "SPC firmware"},
    {SPC_FIRMWARE_VER_STR,         "Version 1.0"},
    {SPC_SYSTEMCHK_STR,            "System Check..."},
    {SPC_SELFCHKFAIL_STR,          "Self Check Fail"},

    // menu
    {SPC_MENU_ACT_CATAG_STR,       "Actual"},

    // Default Information
    {SPC_DEF_HEAT_TEMP_STR,        "Heater Temp"},
    {SPC_DEF_HEAT_STATUS_STR,      "Heater Status"},
    {SPC_DEF_SYS_STATUS_STR,       "Heater Temp"},

    // Substring
    {SPC_RTD_SHORT_STR,            "RTD Short"},
    {SPC_RTD_OPEN_STR,             "RTD Open"},
    {SPC_RTD_OFF_STR,              "Heater is Off"},
    {SPC_RTD_ON_STR,               "Heater is On"},
    {SPC_RTD_MANOFF_STR,           "Heater is ManOn"},
    {SPC_RTD_MANON_STR,            "Heater is ManOff"},

#ifdef SPC_CALIB_WANTED
    {SPC_CALIB_NEED_STR,    "System Need Cali"},
#endif
};

static const SpcRtdStatusStr_t SpcRtdStatStrPool[] = {
    {SPC_RTD_OFF,     SPC_RTD_OFF_STR},
    {SPC_RTD_ON,      SPC_RTD_ON_STR},
    {SPC_RTD_MANOFF,  SPC_RTD_MANOFF_STR},
    {SPC_RTD_MANON,   SPC_RTD_MANON_STR},
};

static const SpcAlarmTable_t SpcAlarmTable[SPC_MAX_ALARM_TYPE] = {
    {SPC_ALARM_SELFCHKFAIL, SpcAlarmCritical}
};

#ifdef __cplusplus
}
#endif
#endif /*__spc_const_H */
