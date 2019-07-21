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

static SpcStringPool_t SpcStrPool[SPC_MAX_STR_TYPE] = {
    {SPC_BLANK_STR,                "                 "},
    {SPC_FIRMWARE_NAME_STR,        "SPC firmware"},
    {SPC_FIRMWARE_VER_STR,         "Version 1.0"},
    {SPC_SYSTEMCHK_STR,            "System Check..."},
    {SPC_SELFCHKFAIL_STR,          "Self Check Fail"},

    // menu
    {SPC_MENU_ACT_CATAG_STR,       "Actual"},
    {SPC_MENU_ACT_OPTVAL_STR,      "Operating values"},

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
};

static const SpcRtdStatusStr_t SpcRtdStatStrPool[] = {
    {SPC_RTD_OFF,     SPC_RTD_OFF_STR},
    {SPC_RTD_ON,      SPC_RTD_ON_STR},
    {SPC_RTD_MANOFF,  SPC_RTD_MANOFF_STR},
    {SPC_RTD_MANON,   SPC_RTD_MANON_STR},
};

static const SpcAlarmTable_t SpcAlarmTable[SPC_MAX_ALARM_TYPE] = {
    {SPC_ALARM_SELFCHKFAIL, SpcAlarmCritical},
};

/*
static const SpcChannelPool_t SpcChannelPool[] = {
    {SPC_ACT_RTD_TEMP,    SPC_RTD_COMBIN},
    {SPC_ACT_RTD_TEMP_A,  SPC_RTD_CHANNEL1},
    {SPC_ACT_RTD_TEMP_B,  SPC_RTD_CHANNEL2},
};

static const SpcParamTable_t SpcParamTable[] = {
    {SPC_ACT_RTD_POWER, "", " %",   &SpcPercent(&SpcValue)},
    {SPC_ACT_CURRENT,   "", " A",   &SpcCurrent(&SpcValue)},
    {SPC_ACT_GFI,       "", " mA",  &SpcGfi(&SpcValue)},
    {SPC_ACT_VOLT,      "", " V",   &SpcVoltage(&SpcValue)},
}

static const SpcResetTable_t SpcResetTable[] = {
    {SPC_ACT_RTD_POWER, "", " %",   &SpcPercent(&SpcValue)},
    {SPC_ACT_CURRENT,   "", " A",   &SpcCurrent(&SpcValue)},
    {SPC_ACT_GFI,       "", " mA",  &SpcGfi(&SpcValue)},
    {SPC_ACT_VOLT,      "", " V",   &SpcVoltage(&SpcValue)},
}

static const SpcStateAction_t SpcStateAction[] = {
//    entry                         right      left        up                    down                  act                prog                reset                  enter                alarm   
    {{0,SpcEntryInit},             {1,NULL},  {21,NULL},  {0,NULL},             {0,NULL},             {9,NULL},          {22,NULL},          {0,NULL},              {0,NULL},            {70,NULL}},
    {{1,SpcEntryShowHeatStatus},   {2,NULL},  {0,NULL},   {0,NULL},             {0,NULL},             {9,NULL},          {22,NULL},          {0,NULL},              {0,NULL},            {70,NULL}},
    {{2,SpcEntryShowHeatTemp},     {3,NULL},  {1,NULL},   {0,NULL},             {0,NULL},             {9,NULL},          {22,NULL},          {0,NULL},              {0,NULL},            {70,NULL}},
    {{3,SpcEntryShowHeatTemp},     {4,NULL},  {2,NULL},   {0,NULL},             {0,NULL},             {9,NULL},          {22,NULL},          {0,NULL},              {0,NULL},            {70,NULL}},
    {{4,SpcEntryShowHeatTemp},     {5,NULL},  {3,NULL},   {0,NULL},             {0,NULL},             {9,NULL},          {22,NULL},          {0,NULL},              {0,NULL},            {70,NULL}},
    {{5,SpcEntryShowInt16},        {6,NULL},  {4,NULL},   {0,NULL},             {0,NULL},             {9,NULL},          {22,NULL},          {0,NULL},              {0,NULL},            {70,NULL}},
    {{6,SpcEntryShowInt16},        {7,NULL},  {5,NULL},   {0,NULL},             {0,NULL},             {9,NULL},          {22,NULL},          {0,NULL},              {0,NULL},            {70,NULL}},
    {{7,SpcEntryShowInt16},        {8,NULL},  {6,NULL},   {0,NULL},             {0,NULL},             {9,NULL},          {22,NULL},          {0,NULL},              {0,NULL},            {70,NULL}},
    {{8,SpcEntryShowInt16},        {9,NULL},  {7,NULL},   {0,NULL},             {0,NULL},             {9,NULL},          {22,NULL},          {0,NULL},              {0,NULL},            {70,NULL}},

    {{9,SpcEntryInit},             {10,NULL}, {8,NULL},   {0,NULL},             {0,NULL},             {0,NULL},          {22,NULL},          {0,NULL},              {0,NULL},            {70,NULL}},
    {{10,SpcEntryShowHeatTemp},    {11,NULL}, {9,NULL},   {0,NULL},             {0,NULL},             {0,NULL},          {22,NULL},          {0,NULL},              {60,SpcResetInit},   {70,NULL}},
    {{11,SpcEntryShowHeatTemp},    {12,NULL}, {10,NULL},  {0,NULL},             {0,NULL},             {0,NULL},          {22,NULL},          {0,NULL},              {60,SpcResetInit},   {70,NULL}},
    {{12,SpcEntryShowInt16},       {13,NULL}, {11,NULL},  {0,NULL},             {0,NULL},             {0,NULL},          {22,NULL},          {0,NULL},              {60,SpcResetInit},   {70,NULL}},
    {{13,SpcEntryShowInt16},       {14,NULL}, {12,NULL},  {0,NULL},             {0,NULL},             {0,NULL},          {22,NULL},          {0,NULL},              {60,SpcResetInit},   {70,NULL}},
    {{14,SpcEntryShowInt16},       {15,NULL}, {13,NULL},  {0,NULL},             {0,NULL},             {0,NULL},          {22,NULL},          {0,NULL},              {60,SpcResetInit},   {70,NULL}},
    {{15,SpcEntryShowInt16},       {16,NULL}, {14,NULL},  {0,NULL},             {0,NULL},             {0,NULL},          {22,NULL},          {0,NULL},              {60,SpcResetInit},   {70,NULL}},
    {{16,SpcEntryShowInt16},       {17,NULL}, {15,NULL},  {0,NULL},             {0,NULL},             {0,NULL},          {22,NULL},          {0,NULL},              {0,NULL},            {70,NULL}},
    {{17,SpcEntryShowInt32},       {18,NULL}, {16,NULL},  {0,NULL},             {0,NULL},             {0,NULL},          {22,NULL},          {0,NULL},              {0,NULL},            {70,NULL}},
    {{18,SpcEntryShowInt32},       {19,NULL}, {17,NULL},  {0,NULL},             {0,NULL},             {0,NULL},          {22,NULL},          {0,NULL},              {0,NULL},            {70,NULL}},
    {{19,SpcEntryShowInt16},       {20,NULL}, {18,NULL},  {0,NULL},             {0,NULL},             {0,NULL},          {22,NULL},          {0,NULL},              {0,NULL},            {70,NULL}},
    {{20,SpcEntryShowInt16},       {21,NULL}, {19,NULL},  {0,NULL},             {0,NULL},             {0,NULL},          {22,NULL},          {0,NULL},              {0,NULL},            {70,NULL}},
    {{21,SpcEntryInit},            {0,NULL},  {20,NULL},  {0,NULL},             {0,NULL},             {0,NULL},          {22,NULL},          {0,NULL},              {0,NULL},            {70,NULL}},

    {{22,SpcEntryInit},            {23,NULL}, {59,NULL},  {0,NULL},             {0,NULL},             {0,NULL},          {32,NULL},          {0,NULL},              {0,NULL},            {70,NULL}},
    {{23,SpcEntryShowHeatTemp},    {24,NULL}, {22,NULL},  {63,SpcConfTempInit}, {63,SpcConfTempInit}, {0,NULL},          {32,NULL},          {0,NULL},              {0,NULL},            {70,NULL}},
    {{24,SpcEntryShowHeatTemp},    {25,NULL}, {23,NULL},  {63,SpcConfTempInit}, {63,SpcConfTempInit}, {0,NULL},          {32,NULL},          {0,NULL},              {0,NULL},            {70,NULL}},
    {{25,SpcEntryShowHeatTemp},    {26,NULL}, {24,NULL},  {63,SpcConfTempInit}, {63,SpcConfTempInit}, {0,NULL},          {32,NULL},          {0,NULL},              {0,NULL},            {70,NULL}},
    {{26,SpcEntryShowInt16},       {27,NULL}, {25,NULL},  {0,SpcConfIntInit},   {0,SpcConfIntInit},   {0,NULL},          {32,NULL},          {0,NULL},              {0,NULL},            {70,NULL}},
    {{27,SpcEntryShowInt16},       {28,NULL}, {26,NULL},  {0,SpcConfIntInit},   {0,SpcConfIntInit},   {0,NULL},          {32,NULL},          {0,NULL},              {0,NULL},            {70,NULL}},
    {{28,SpcEntryShowInt16},       {29,NULL}, {27,NULL},  {0,SpcConfIntInit},   {0,SpcConfIntInit},   {0,NULL},          {32,NULL},          {0,NULL},              {0,NULL},            {70,NULL}},
    {{29,SpcEntryShowInt16},       {30,NULL}, {28,NULL},  {0,SpcConfIntInit},   {0,SpcConfIntInit},   {0,NULL},          {32,NULL},          {0,NULL},              {0,NULL},            {70,NULL}},
    {{30,SpcEntryShowInt16},       {31,NULL}, {29,NULL},  {0,SpcConfIntInit},   {0,SpcConfIntInit},   {0,NULL},          {32,NULL},          {0,NULL},              {0,NULL},            {70,NULL}},
    {{31,SpcEntryShowInt16},       {32,NULL}, {30,NULL},  {0,SpcConfIntInit},   {0,SpcConfIntInit},   {0,NULL},          {32,NULL},          {0,NULL},              {0,NULL},            {70,NULL}},

    {{32,SpcEntryInit},            {33,NULL}, {31,NULL},  {0,NULL},             {0,NULL},             {0,NULL},          {44,NULL},          {0,NULL},              {0,NULL},            {70,NULL}},
    {{33,SpcEntryShowByte},        {34,NULL}, {32,NULL},  {0,NULL},             {0,NULL},             {0,NULL},          {44,NULL},          {0,NULL},              {0,NULL},            {70,NULL}},
    {{34,NULL},                    {35,NULL}, {33,NULL},  {0,NULL},             {0,NULL},             {0,NULL},          {44,NULL},          {0,NULL},              {0,NULL},            {70,NULL}},
    {{35,SpcEntryShowByte},        {36,NULL}, {34,NULL},  {0,NULL},             {0,NULL},             {0,NULL},          {44,NULL},          {0,NULL},              {0,NULL},            {70,NULL}},
    {{36,SpcEntryShowByte},        {37,NULL}, {35,NULL},  {0,NULL},             {0,NULL},             {0,NULL},          {44,NULL},          {0,NULL},              {0,NULL},            {70,NULL}},
    {{37,SpcEntryShowHeatTemp},    {38,NULL}, {36,NULL},  {0,NULL},             {0,NULL},             {0,NULL},          {44,NULL},          {0,NULL},              {0,NULL},            {70,NULL}},
    {{38,SpcEntryShowByte},        {39,NULL}, {37,NULL},  {0,NULL},             {0,NULL},             {0,NULL},          {44,NULL},          {0,NULL},              {0,NULL},            {70,NULL}},
    {{39,SpcEntryShowInt16},       {40,NULL}, {38,NULL},  {0,NULL},             {0,NULL},             {0,NULL},          {44,NULL},          {0,NULL},              {0,NULL},            {70,NULL}},
    {{40,SpcEntryShowInt16},       {41,NULL}, {39,NULL},  {0,NULL},             {0,NULL},             {0,NULL},          {44,NULL},          {0,NULL},              {0,NULL},            {70,NULL}},
    {{41,SpcEntryShowInt16},       {42,NULL}, {40,NULL},  {0,NULL},             {0,NULL},             {0,NULL},          {44,NULL},          {0,NULL},              {0,NULL},            {70,NULL}},
    {{42,SpcEntryShowByte},        {43,NULL}, {41,NULL},  {0,NULL},             {0,NULL},             {0,NULL},          {44,NULL},          {0,NULL},              {0,NULL},            {70,NULL}},
    {{43,SpcEntryShowByte},        {44,NULL}, {42,NULL},  {0,NULL},             {0,NULL},             {0,NULL},          {44,NULL},          {0,NULL},              {0,NULL},            {70,NULL}},

    {{44,SpcEntryInit},            {45,NULL}, {43,NULL},  {0,NULL},             {0,NULL},             {0,NULL},          {56,NULL},          {0,NULL},              {0,NULL},            {70,NULL}},
    {{45,NULL},                    {46,NULL}, {44,NULL},  {0,NULL},             {0,NULL},             {0,NULL},          {56,NULL},          {0,NULL},              {0,NULL},            {70,NULL}},
    {{46,NULL},                    {47,NULL}, {45,NULL},  {0,NULL},             {0,NULL},             {0,NULL},          {56,NULL},          {0,NULL},              {0,NULL},            {70,NULL}},
    {{47,SpcEntryShowByte},        {48,NULL}, {46,NULL},  {0,NULL},             {0,NULL},             {0,NULL},          {56,NULL},          {0,NULL},              {0,NULL},            {70,NULL}},
    {{48,SpcEntryShowInt16},       {49,NULL}, {47,NULL},  {0,NULL},             {0,NULL},             {0,NULL},          {56,NULL},          {0,NULL},              {0,NULL},            {70,NULL}},
    {{49,SpcEntryShowByte},        {50,NULL}, {48,NULL},  {0,NULL},             {0,NULL},             {0,NULL},          {56,NULL},          {0,NULL},              {0,NULL},            {70,NULL}},
    {{50,SpcEntryShowByte},        {51,NULL}, {49,NULL},  {0,NULL},             {0,NULL},             {0,NULL},          {56,NULL},          {0,NULL},              {0,NULL},            {70,NULL}},
    {{51,SpcEntryShowInt16},       {52,NULL}, {50,NULL},  {0,NULL},             {0,NULL},             {0,NULL},          {56,NULL},          {0,NULL},              {0,NULL},            {70,NULL}},
    {{52,SpcEntryShowInt16},       {53,NULL}, {51,NULL},  {0,NULL},             {0,NULL},             {0,NULL},          {56,NULL},          {0,NULL},              {0,NULL},            {70,NULL}},
    {{53,SpcEntryShowInt16},       {54,NULL}, {52,NULL},  {0,NULL},             {0,NULL},             {0,NULL},          {56,NULL},          {0,NULL},              {0,NULL},            {70,NULL}},
    {{54,SpcEntryShowByte},        {55,NULL}, {53,NULL},  {0,NULL},             {0,NULL},             {0,NULL},          {56,NULL},          {0,NULL},              {0,NULL},            {70,NULL}},
    {{55,NULL},                    {56,NULL}, {54,NULL},  {0,NULL},             {0,NULL},             {0,NULL},          {56,NULL},          {0,NULL},              {0,NULL},            {70,NULL}},

    {{56,SpcEntryInit},            {57,NULL}, {55,NULL},  {0,NULL},             {0,NULL},             {0,NULL},          {22,NULL},          {0,NULL},              {0,NULL},            {70,NULL}},
    {{57,SpcShowInfo},             {58,NULL}, {56,NULL},  {0,NULL},             {0,NULL},             {0,NULL},          {22,NULL},          {0,NULL},              {0,NULL},            {70,NULL}},
    {{58,SpcShowInfo},             {59,NULL}, {57,NULL},  {0,NULL},             {0,NULL},             {0,NULL},          {22,NULL},          {0,NULL},              {0,NULL},            {70,NULL}},
    {{59,SpcShowInfo},             {22,NULL}, {58,NULL},  {0,NULL},             {0,NULL},             {0,NULL},          {22,NULL},          {0,NULL},              {0,NULL},            {70,NULL}},

    {{60,SpcEntryInit},            {60,NULL}, {60,NULL},  {61,NULL},            {60,NULL},            {0,SpcResetExit},  {22,SpcResetExit},  {60,NULL},             {0,SpcResetExit},    {70,NULL}},
    {{61,SpcEntryInit},            {61,NULL}, {61,NULL},  {61,NULL},            {60,NULL},            {0,SpcResetExit},  {22,SpcResetExit},  {60,NULL},             {62,SpcResetIntOpt}, {70,NULL}},
    {{62,SpcEntryInit},            {62,NULL}, {62,NULL},  {63,NULL},            {62,NULL},            {0,SpcResetExit},  {22,SpcResetExit},  {62,NULL},             {0,SpcResetExit},    {70,NULL}},
    {{63,SpcEntryInit},            {63,NULL}, {63,NULL},  {63,NULL},            {62,NULL},            {0,SpcResetExit},  {22,SpcResetExit},  {62,NULL},             {63,SpcResetTempOpt},{70,NULL}},

    {{64,SpcEntryConfTemp},        {64,NULL}, {64,NULL},  {64,SpcConfTempUp},   {64,SpcConfTempDown}, {0,SpcResetExit},  {22,SpcResetExit},  {0,SpcConfTempReset},  {63,SpcResetTempOpt},{70,NULL}},
    {{65,SpcEntryConfInt},         {65,NULL}, {65,NULL},  {65,SpcConfIntUp},    {65,SpcConfIntDown},  {0,SpcResetExit},  {22,SpcResetExit},  {0,SpcConfIntReset},   {63,SpcResetIntOpt}, {70,NULL}},
};*/

static const SpcStateAction_t SpcStateAction[] = {
//    entry                         right      left        up                    down                  act                prog                reset                  enter                alarm   
    {{0,SpcEntryInit},             {0,NULL},  {0,NULL},   {0,NULL},             {0,NULL},             {0,NULL},          {0,NULL},           {0,NULL},              {0,NULL},            {0,NULL}},
};

static const SpcStaticInfo_t SpcStaticInfo[] = {
    {0, SPC_MENU_ACT_CATAG_STR, SPC_MENU_ACT_OPTVAL_STR},
}

#ifdef __cplusplus
}
#endif
#endif /*__spc_const_H */
