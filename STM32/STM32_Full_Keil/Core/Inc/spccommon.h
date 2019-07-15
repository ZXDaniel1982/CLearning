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
    SPC_SOFTWARE_VERSION = 0,
    SPC_SELFCHECK,
    SPC_SELFCHKFAIL,

    SPC_DEFINFO_HEAT_TEMP,
    SPC_DEFINFO_HEAT_STATUS,
    SPC_DEFINFO_SYS_STATUS,

    SPC_MENU_INIT,
    SPC_MENU_RTD_STAT,

#ifdef SPC_CALIB_WANTED
    SPC_CALIB_NEED,
#endif

    SPC_MAX_INFO_TYPE
} SpcInfoType_t;

typedef enum
{
    SPC_BLANK_STR = 0,
    SPC_FIRMWARE_NAME_STR,
    SPC_FIRMWARE_VER_STR,
    SPC_SYSTEMCHK_STR,
    SPC_SELFCHKFAIL_STR,

    // menu
    SPC_MENU_ACT_CATAG_STR,

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

#ifdef SPC_CALIB_WANTED
    SPC_CALIB_NEED_STR,
#endif

    SPC_MAX_STR_TYPE
} SpcStringType_t;

typedef enum
{
    SPC_RTD_CHANNEL1 = 0,
    SPC_RTD_CHANNEL2,

    SPC_MAX_RTD_CHANNEL
} SpcRtdChannel_t;

typedef enum
{
    SPC_GFI_CHANNEL1 = 0,
    SPC_GFI_CHANNEL2,

    SPC_MAX_GFI_CHANNEL
} SpcGfiChannel_t;

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
    SpcStringType_t StrType;
    char str[SPC_MAX_STR_LEN];
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
    SpcGFIMeasure_t gfi[SPC_MAX_GFI_CHANNEL];
} SpcMeasure_t;

typedef struct
{
    uint16_t heater_en:1;
    uint16_t ctl_type:1;
    uint16_t rtdMod:3;
    uint16_t rtd_fail_mod:1;
    uint16_t password_en:1;
    uint16_t usr_advanced:1;
    uint16_t baud:3;
    uint16_t gfi_test_mod:2;
    uint16_t heater_type:1;
    uint16_t cable_type:1;
    uint16_t reservd:1;
} SpcSysConfBytes_t;

typedef union
{
    uint32_t word;
    SpcSysConfBytes_t bytes;
} SpcSysConf_t;

typedef struct
{
    uint8_t manual:1;
    uint8_t unit:1;
    uint8_t defInfo:2;
    uint8_t rdtStat:2;
    uint8_t reservd:2;
} SpcSysConfChnelBytes_t;

typedef union
{
    uint8_t word;
    SpcSysConfChnelBytes_t bytes;
} SpcSysConfIndiv_t;

typedef struct
{
    SpcSysConf_t system;
    uint16_t DisplayTime;

    SpcTemperature_t MaintainTemp[SPC_MAX_RTD_CHANNEL];
    SpcSysConfIndiv_t sysChnel[SPC_MAX_RTD_CHANNEL];
} SpcConfig_t;

typedef struct
{
    SpcInfoType_t position;
    SpcRtdChannel_t channel;
} SpcRunStatus_t;

typedef struct
{
    SpcRunStatus_t runStatus;
    SpcMeasure_t measure;
    SpcConfig_t config;
    SpcAlarm_t alarm;
} SpcValue_t;

typedef void (*pfnInfoDetail)(SpcValue_t *SpcValue);
typedef struct
{
    SpcInfoType_t infoType;
    SpcInfoType_t rightType;
    SpcStringType_t strTypeLine1;
    SpcStringType_t strTypeLine2;
    pfnInfoDetail infoDetail;
} SpcScreenInfo_t;

#define SpcAlarmEn        ( SPC_NORMAL )
#define SpcAlarmDis       ( SPC_ERROR )
#define SpcAlarmCritical  ( SPC_NORMAL )
#define SpcAlarmNormal    ( SPC_ERROR )

SpcStatus_t SpcListInsert(SpcList_t * list, SpcItem_t *itemToAdd);
SpcStatus_t SpcListRemove(SpcList_t * list, SpcAlarmType_t alarmType);
void Spc_AlarmMgr(SpcList_t * list, SpcAlarmType_t type, bool enable);

void Spc_GetHeatTempDetail(SpcValue_t *SpcValue);
void Spc_GetHeatStatusDetail(SpcValue_t *SpcValue);
void Spc_GetSysStatusDetail(SpcValue_t *SpcValue);

void Spc_AlarmRaise(SpcAlarmType_t alarmType);
void Spc_AlarmClear(SpcAlarmType_t alarmType);

void SpcListInit(SpcList_t * list, uint8_t size);

#ifdef __cplusplus
}
#endif
#endif /*__spc_common_H */
