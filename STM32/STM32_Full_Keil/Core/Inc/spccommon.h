#ifndef __spc_common_H
#define __spc_common_H
#ifdef __cplusplus
 extern "C" {
#endif

#include "main.h"
	 
#define SPC_SCREEN_POSITION    ( 4 )
#define SPC_SCREEN_SCALE       ( 2 )
#define SPC_MAX_STR_LEN        ( 30 )
#define SPC_MAX_GFI            ( 20 )
#define SPC_MAX_LIST           ( 20 )

typedef enum
{
    SPC_NORMAL = true,
    SPC_ERROR = false
} SpcStatus_t;

typedef enum
{
    SPC_ALARM_SELFCHKFAIL = 0,
    SPC_MAX_ALARM_TYPE
} SpcAlarmType_t;

typedef enum
{
    SPC_MENU_ACT_INIT = 0,

    SPC_MAX_INFO_TYPE
} SpcInfoType_t;

typedef enum
{
    SPC_BLANK_STR = 0,
    SPC_FIRMWARE_NAME_STR,
    SPC_FIRMWARE_VER_STR,
    SPC_SYSTEMCHK_STR,
    SPC_SELFCHKFAIL_STR,

    // menu actual
    SPC_MENU_ACT_CATAG_STR,
    SPC_MENU_ACT_OPTVAL_STR,

    // Default Info
    SPC_DEF_HEAT_TEMP_STR,
    SPC_DEF_HEAT_STATUS_STR,
    SPC_DEF_SYS_STATUS_STR,

    // Substring
    SPC_RTD_SHORT_STR,
    SPC_RTD_OPEN_STR,
    SPC_RTD_OFF_STR,
    SPC_RTD_ON_STR,
    SPC_RTD_MANOFF_STR,
    SPC_RTD_MANON_STR,

    SPC_MAX_STR_TYPE
} SpcStringType_t;

typedef enum
{
    SPC_RTD_CHANNEL1 = 0,
    SPC_RTD_CHANNEL2,
    SPC_RTD_COMBIN,

    SPC_MAX_RTD_CHANNEL
} SpcRtdChannel_t;

typedef enum
{
    SPC_TEMP_NORMAL = 0,
    SPC_TEMP_RTD_SHORT,
    SPC_TEMP_RTD_OPEN,
    SPC_TEMP_OUTRANGE,
    SPC_TEMP_OFF,

    SPC_MAX_TEMP_STATUS
} SpcTempStatus_t;

typedef enum
{
    SPC_ONE_RTD_MOD = 0,
    SPC_BACKUP_MOD,
    SPC_AVERAGE_MOD,
    SPC_LOWEST_MOD,
    SPC_HIGHEST_MOD,
    SPC_HIGHTEMPCUTOFF_MOD,
    SPC_MAX_RTD_OPT_MOD
} SpcRTDOptMode_t;

typedef enum
{
    SYSTEM_STATUS_MOD = 0,
    HEATER_STATUS_MOD,
    HEATER_TEMP_MOD,
    SPC_MAX_DEF_INFO
} SpcDefalutInfo_t;

typedef enum
{
    SPC_RTD_OFF = 0,
    SPC_RTD_ON,
    SPC_RTD_MANOFF,
    SPC_RTD_MANON,
    SPC_MAX_RTD_STATUS
} SpcRTDStatus_t;

typedef enum
{
    SPC_KEY_NORMAL = 0,
    SPC_KEY_TIMEOUT,
    SPC_KEY_NEXT,
    SPC_KEY_RESETCANCLE,
    SPC_KEY_RESETCOMPLETE,
    SPC_MAX_KEY_INPUT
} SpcKeyType_t;

typedef void (*pfnDelete)(SpcAlarmType_t alarmType);
typedef void (*pfnAdd)(SpcAlarmType_t alarmType);
struct xSpcItem_t
{
    SpcAlarmType_t alarmType;
    bool alarmPrio;
    pfnDelete delfunc;
    pfnAdd addfunc;
    struct xSpcItem_t *next;
};
typedef struct xSpcItem_t SpcItem_t;

typedef struct
{
    uint8_t totalNum;
    uint8_t maxSize;
    SpcItem_t item;
} SpcList_t;

typedef struct
{
    uint32_t alarmMask;
    SpcList_t alarmList;
} SpcAlarm_t;

typedef struct
{
    SpcAlarmType_t type;
    bool prio;
} SpcAlarmTable_t;

typedef struct
{
    SpcRTDStatus_t status;
    SpcStringType_t strType;
} SpcRtdStatusStr_t;

typedef struct
{
    const SpcStringType_t StrType;
    const char str[SPC_MAX_STR_LEN];
} SpcStringPool_t;

typedef struct
{
    SpcTempStatus_t tempStatus;
    int8_t tempf;
    int8_t tempc;
} SpcTemperature_t;

typedef struct
{
    bool gfiStatus;
    uint8_t val;
} SpcGFIMeasure_t;

typedef struct
{
    SpcTemperature_t temp[SPC_MAX_RTD_CHANNEL];
    SpcGFIMeasure_t gfi;
    int32_t PowerPercent;
    int32_t Current;
    int32_t Voltage;
} SpcMeasure_t;

typedef struct
{
    uint32_t unit:1;
    uint32_t heater_en:1;
    uint32_t manual:1;
    uint32_t ctl_type:1;
    uint32_t rtdMod:3;
    uint32_t rtd_fail_mod:1;
    uint32_t password_en:1;
    uint32_t defInfo:2;
    uint32_t rdtStat:2;
    uint32_t usr_advanced:1;
    uint32_t baud:3;
    uint32_t gfi_test_mod:2;
    uint32_t heater_type:1;
    uint32_t cable_type:1;
    uint32_t reservd:11;
} SpcSysConfBytes_t;

typedef union
{
    uint32_t word;
    SpcSysConfBytes_t bytes;
} SpcSysConf_t;

typedef struct
{
    SpcSysConf_t system;
    uint16_t DisplayTime;

    SpcTemperature_t MaintainTemp;
} SpcConfig_t;

typedef struct
{
    SpcInfoType_t position;
} SpcRunStatus_t;

typedef struct
{
    SpcTemperature_t maxTemp;
    SpcTemperature_t minTemp;
    int32_t   MaxCurrent;           //16
    int32_t   MaxGFCurrent;         //17
    int32_t   MaxVoltage;           //18
    int32_t   MinVoltage;           //19
    int32_t   EnergyUsed;               //20
    int32_t   EnergyCost;               //21
    int32_t   RunTime;                  //22
    int32_t   HeaterOnTime;             //24
    int32_t   Version;                  //25
} SpcStatistic_t;

typedef struct
{
    SpcRunStatus_t runStatus;
    SpcMeasure_t measure;
    SpcConfig_t config;
    SpcStatistic_t status;
    SpcAlarm_t alarm;
} SpcValue_t;

typedef struct
{
    SpcInfoType_t type;
    SpcRtdChannel_t channel;
} SpcChannelPool_t;

typedef struct
{
    SpcInfoType_t type;
    char prefix[SPC_MAX_STR_LEN];
    char suffix[SPC_MAX_STR_LEN];
    int32_t val;
} SpcParamTable_t;

typedef struct {
    SpcInfoType_t type;
    int16_t line1;
    int16_t line2;
} SpcStaticInfo_t;

typedef SpcKeyType_t (*pfnAct)(SpcValue_t *SpcValue);
typedef struct {
    SpcInfoType_t type;
    pfnAct action;
} SpcInfoEntry_t;
typedef struct
{
    SpcInfoEntry_t initEntry;
    SpcInfoEntry_t rightEntry;
    SpcInfoEntry_t leftEntry;
    SpcInfoEntry_t upEntry;
    SpcInfoEntry_t downEntry;
    SpcInfoEntry_t actEntry;
    SpcInfoEntry_t progEntry;
    SpcInfoEntry_t resetEntry;
    SpcInfoEntry_t enterEntry;
    SpcInfoEntry_t alarmEntry;
} SpcStateAction_t;

#define SpcAlarmEn        ( SPC_NORMAL )
#define SpcAlarmDis       ( SPC_ERROR )
#define SpcAlarmCritical  ( SPC_NORMAL )
#define SpcAlarmNormal    ( SPC_ERROR )

SpcStatus_t SpcListInsert(SpcList_t * list, SpcItem_t *itemToAdd);
SpcStatus_t SpcListRemove(SpcList_t * list, SpcAlarmType_t alarmType);
void Spc_AlarmMgr(SpcList_t * list, SpcAlarmType_t type, bool enable);

void Spc_GetHeatTempDetail(SpcValue_t *SpcValue, uint16_t *command);
void Spc_GetHeatStatusDetail(SpcValue_t *SpcValue, uint16_t *command);
void Spc_GetSysStatusDetail(SpcValue_t *SpcValue, uint16_t *command);
void Spc_GetSysPercent(SpcValue_t *SpcValue, uint16_t *command);

void Spc_AlarmRaise(SpcAlarmType_t alarmType);
void Spc_AlarmClear(SpcAlarmType_t alarmType);

void SpcListInit(SpcList_t * list, uint8_t size);
SpcKeyType_t SpcEntryInit(SpcValue_t *SpcValue);

#ifdef __cplusplus
}
#endif
#endif /*__spc_common_H */
