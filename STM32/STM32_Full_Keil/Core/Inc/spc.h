#ifndef __spc_H
#define __spc_H
#ifdef __cplusplus
 extern "C" {
#endif

#include "main.h"
#include "cmsis_os.h"

#define SPC_CALIB_WANTED

// SPC related definition
#define SPC_BLANK_STR           "    "
#define SPC_MAX_STR_LEN         ( 20 )
#define SPC_MAX_GFI             ( 20 )

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

typedef enum
{
    SPC_SOFTWARE_VERSION = 0,
    SPC_SELFCHECK,
    SPC_SELFCHKFAIL,

#ifdef SPC_CALIB_WANTED
    SPC_CALIB_NEED,
#endif

    SPC_MAX_INFO_TYPE
} SpcInfoType_t;

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

    SPC_MAX_TEMP_STATUS
} SpcTempStatus_t;

typedef enum
{
    SPC_NORMAL = true,
    SPC_ERROR = false
} SpcStatus_t;

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

#define SpcAlarmEn        ( SPC_NORMAL )
#define SpcAlarmDis       ( SPC_ERROR )
#define SpcAlarmCritical  ( SPC_NORMAL )
#define SpcAlarmNormal    ( SPC_ERROR )
typedef enum
{
    SPC_ALARM_SELFCHKFAIL = 0,
    SPC_MAX_ALARM_TYPE
} SpcAlarmType_t;
#define SpcAlarmMask(x) ( 1 << (x) )

typedef struct
{
    SpcAlarmType_t type;
    bool prio;
} SpcAlarm_t;

typedef struct
{
    SpcInfoType_t infoType;
    char stringLine1[SPC_MAX_STR_LEN];
    char stringLine2[SPC_MAX_STR_LEN];
} SpcScreenInfo_t;

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
    uint32_t spc_units_c:1;
    uint32_t heater_en:1;
    uint32_t man_on:1;
    uint32_t ctl_type:1;
    uint32_t rtd_opr:3;
    uint32_t rtd_fail_mod:1;
    uint32_t password_en:1;
    uint32_t usr_advanced:1;
    uint32_t def_display:2;
    uint32_t baud:3;
    uint32_t gfi_test_mod:2;
    uint32_t heater_type:1;
    uint32_t cable_type:1;
    uint32_t reservd:13;
} SpcAlarmSystemConfigBytes_t;

typedef union
{
    uint32_t word;
    SpcAlarmSystemConfigBytes_t bytes;
} SpcSystemConfig_t;

typedef struct
{
    SpcSystemConfig_t system;
} SpcConfig_t;

// List
#define SPC_MAX_LIST    ( 20 )
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
    SpcMeasure_t measure;
    SpcConfig_t config;
    SpcList_t alarmList;
    uint32_t alarmMask;
} SpcValue_t;

static const SpcScreenInfo_t SpcScreenInfo[SPC_MAX_INFO_TYPE] = {
    {SPC_SOFTWARE_VERSION, "DPC firmware", "Version 1.0"},
    {SPC_SELFCHECK, "System Check...", SPC_BLANK_STR},
    {SPC_SELFCHKFAIL, "Self Check Fail", SPC_BLANK_STR},

#ifdef SPC_CALIB_WANTED
    {SPC_CALIB_NEED, "System Need Cali", SPC_BLANK_STR},
#endif
};

static const SpcAlarm_t SpcAlarmTable[SPC_MAX_ALARM_TYPE] = {
    {SPC_ALARM_SELFCHKFAIL, SpcAlarmCritical}
};

#define SpcTemperature(x)    ( (x)->measure.temp )
#define SpcGfi(x)            ( (x)->measure.gfi )
#define SpcSystemConfig(x)   ( (x)->config.system )
#define SpcAlarmList(x)      ( (x)->alarmList )


// For SPC test 
#define SPC_TEST_TEMP_STATUS    ( SPC_TEMP_NORMAL )
#define SPC_SIMULATE_TEMP_C     ( 20 )
#define SPC_SIMULATE_TEMP_F     ( 20 )
#define SPC_SIMULATE_GFI        ( 10 )

void SPC_Init(void);

#ifdef __cplusplus
}
#endif
#endif /*__spc_H */
