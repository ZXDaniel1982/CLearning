#ifndef __spc_common_H
#define __spc_common_H

#include <stdbool.h>
#include <stdint.h>

#define clear() printf("\033[H\033[J")
#define NUM_ROWS(ARRAY) (sizeof(ARRAY) / sizeof(ARRAY[0]))

#define SPC_SCREEN_POSITION    ( 4 )
#define SPC_SCREEN_SCALE       ( 2 )
#define SPC_MAX_STR_LEN        ( 30 )
#define SPC_MAX_UNIT_STR_LEN   ( 10 )
#define SPC_MAX_GFI            ( 20 )
#define SPC_MAX_LIST           ( 20 )

typedef enum
{
    SPC_NORMAL = true,
    SPC_ERROR = false
} SpcStatus_t;

#define SpcManuOptEn           ( SPC_NORMAL )
#define SpcManuOptDis          ( SPC_ERROR )
#define SpcTempInCelsius       ( SPC_NORMAL )
#define SpcTempInFahren        ( SPC_ERROR )
#define SpcAlarmEn             ( SPC_NORMAL )
#define SpcAlarmDis            ( SPC_ERROR )
#define SpcAlarmCritical       ( SPC_NORMAL )
#define SpcAlarmNormal         ( SPC_ERROR )

#define SpcName(x)             ( (x)->name )

#define SpcTemp(x,y)           ( (x)->measure.temp[y] )
#define SpcGfi(x)              ( (x)->measure.gfi )
#define SpcPercent(x)          ( (x)->measure.PowerPercent )
#define SpcCurrent(x)          ( (x)->measure.Current )
#define SpcVoltage(x)          ( (x)->measure.Voltage )

#define SpcMaxTemp(x)          ( (x)->status.maxTemp )
#define SpcMinTemp(x)          ( (x)->status.minTemp )
#define SpcMaxCurrent(x)       ( (x)->status.MaxCurrent )
#define SpcMaxGFI(x)           ( (x)->status.MaxGFCurrent )
#define SpcMaxVolt(x)          ( (x)->status.MaxVoltage )
#define SpcMinVolt(x)          ( (x)->status.MinVoltage )
#define SpcUsage(x)            ( (x)->status.EnergyUsed )
#define SpcOnPercent(x)        ( (x)->status.HeaterOnTime )
#define SpcCost(x)             ( (x)->status.EnergyCost )
#define SpcRunTime(x)          ( (x)->status.RunTime )

#define SpcConf(x)             ( (x)->config.system )
#define SpcConfMainTemp(x)     ( (x)->config.MaintainTemp )
#define SpcConfLowTemp(x)      ( (x)->config.LowTemp )
#define SpcConfHighTemp(x)     ( (x)->config.HighTemp )
#define SpcConfDeadband(x)     ( (x)->config.DeadBand )
#define SpcConfTimeout(x)      ( (x)->config.DisplayTime )
#define SpcConfScanSpd(x)      ( (x)->config.ScanSpeed )
#define SpcConfModbusAdd(x)    ( (x)->config.ModbusAdd )
#define SpcConfAlarmOut(x)     ( (x)->config.AlarmOutTest )
#define SpcConfHeatTest(x)     ( (x)->config.HeaterTest )

#define SpcConfLowCurrent(x)   ( (x)->config.LowCurrent )
#define SpcConfHighCurrent(x)  ( (x)->config.HighCurrent )
#define SpcConfGFIAlarm(x)     ( (x)->config.GFIAlarm )
#define SpcConfGFITrip(x)      ( (x)->config.GFITrip )
#define SpcConfLowVolt(x)      ( (x)->config.LowVoltage )
#define SpcConfHighVolt(x)     ( (x)->config.HighVoltage )
#define SpcConfCurLmt(x)       ( (x)->config.LimitedCurrent )
#define SpcConfSoftStart(x)    ( (x)->config.SoftStartTime )
#define SpcConfAutoTest(x)     ( (x)->config.AutoTestTime )
#define SpcConfPrice(x)        ( (x)->config.CostPerKWH )

#define SpcAlarmList(x)        ( (x)->alarm.alarmList )
#define SpcAlarmMask(x)        ( (x)->alarm.alarmMask )

#define SpcPosition(x)         ( (x)->runStatus.position )

#define SpcStackPos(x)         ( (x)->stack.position )
#define SpcStackVal(x)         ( (x)->stack.val )
#define SpcStackTemp(x)        ( (x)->stack.temp )

#define SpcInitEntry(x)        ( SpcStateAction[(x)].initEntry )
#define SpcRight(x)            ( SpcStateAction[(x)].rightEntry )
#define SpcLeft(x)             ( SpcStateAction[(x)].leftEntry )
#define SpcUp(x)               ( SpcStateAction[(x)].upEntry )
#define SpcDown(x)             ( SpcStateAction[(x)].downEntry )
#define SpcAct(x)              ( SpcStateAction[(x)].actEntry )
#define SpcProg(x)             ( SpcStateAction[(x)].progEntry )
#define SpcAlarm(x)            ( SpcStateAction[(x)].alarmEntry )
#define SpcReset(x)            ( SpcStateAction[(x)].resetEntry )
#define SpcEnter(x)            ( SpcStateAction[(x)].enterEntry )

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
    SYSTEM_STATUS_MOD = 0,
    HEATER_STATUS_MOD,
    HEATER_TEMP_MOD,
    SPC_MAX_DEF_INFO
} SpcDefalutInfo_t;

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
    SPC_RTD_CHANNEL1 = 0,
    SPC_RTD_CHANNEL2,
    SPC_RTD_COMBIN,

    SPC_MAX_RTD_CHANNEL
} SpcRtdChannel_t;

typedef enum
{
    SPC_ALARM_SELFCHKFAIL = 0,
    SPC_MAX_ALARM_TYPE
} SpcAlarmType_t;

typedef enum
{
    SPC_BLANK_STR = 0,
    SPC_FIRMWARE_NAME_STR,
    SPC_FIRMWARE_VER_STR,
    SPC_SYSTEMCHK_STR,
    SPC_SELFCHKFAIL_STR,

    // menu actual line1
    SPC_MENU_ACT_CATAG_STR,
    SPC_MENU_ACT_HEATSTAT_STR,
    SPC_MENU_ACT_TEMP_STR,
    SPC_MENU_ACT_TEMPA_STR,
    SPC_MENU_ACT_TMEPB_STR,
    SPC_MENU_ACT_POW_STR,
    SPC_MENU_ACT_CURRENT_STR,
    SPC_MENU_ACT_GFI_STR,
    SPC_MENU_ACT_VOLTAGE_STR,
    SPC_MENU_ACT_MAX_TEMP_STR,
    SPC_MENU_ACT_MIN_TEMP_STR,
    SPC_MENU_ACT_MAX_CURRENT_STR,
    SPC_MENU_ACT_MAX_GFI_STR,
    SPC_MENU_ACT_MAX_VOLT_STR,
    SPC_MENU_ACT_MIN_VOLT_STR,
    SPC_MENU_ACT_USAGE_STR,
    SPC_MENU_ACT_ONTIME_STR,
    SPC_MENU_ACT_COST_STR,
    SPC_MENU_ACT_RUNTIME_STR,
    SPC_MENU_ACT_RESET_STR,
    SPC_MENU_ACT_VERSION_STR,

    SPC_MENU_ACT_OPTVAL_STR,
    SPC_MENU_ACT_STATIS_STR,

    // menu prog line1
    SPC_MENU_PROG_CATAG_STR,
    SPC_MENU_PROG_MAIN_TEMP_STR,
    SPC_MENU_PROG_LOW_TEMP_STR,
    SPC_MENU_PROG_HIGH_TEMP_STR,
    SPC_MENU_PROG_LOW_CURRENT_STR,
    SPC_MENU_PROG_HIGH_CURRENT_STR,
    SPC_MENU_PROG_GFI_ALARM_STR,
    SPC_MENU_PROG_GFI_TRIP_STR,
    SPC_MENU_PROG_LOW_VOLT_STR,
    SPC_MENU_PROG_HIGH_VOLT_STR,
    SPC_MENU_PROG_HEATEN_STR,
    SPC_MENU_PROG_HEATID_STR,
    SPC_MENU_PROG_HEAT_TYPE_STR,
    SPC_MENU_PROG_MANUAL_STR,
    SPC_MENU_PROG_DEADBAND_STR,
    SPC_MENU_PROG_CTLTYPE_STR,
    SPC_MENU_PROG_CURRENTLTM_STR,
    SPC_MENU_PROG_SOFTSTART_STR,
    SPC_MENU_PROG_AUTOTEST_STR,
    SPC_MENU_PROG_RTDMODE_STR,
    SPC_MENU_PROG_RTDFAILMODE_STR,
    SPC_MENU_PROG_PASSWORDEN_STR,
    SPC_MENU_PROG_UNIT_STR,
    SPC_MENU_PROG_PRICE_STR,
    SPC_MENU_PROG_DIPMODE_STR,
    SPC_MENU_PROG_DEFDIP_STR,
    SPC_MENU_PROG_DIPTIMEOUT_STR,
    SPC_MENU_PROG_SCANSPEED_STR,
    SPC_MENU_PROG_MODBUSADD_STR,
    SPC_MENU_PROG_BAUDRATE_STR,
    SPC_MENU_PROG_RESET_STR,
    SPC_MENU_PROG_ALARMOUT_STR,
    SPC_MENU_PROG_RTDTEST_STR,
    SPC_MENU_PROG_GFITEST_STR,

    SPC_MENU_PROG_SETPOINT_STR,
    SPC_MENU_PROG_HEATSET_STR,
    SPC_MENU_PROG_SYSSET_STR,
    SPC_MENU_PROG_SYSTEST_STR,

    // Default Info
    SPC_DEF_HEAT_TEMP_STR,
    SPC_DEF_HEAT_STATUS_STR,
    SPC_DEF_SYS_STATUS_STR,

    // Substring
    SPC_NO_STR,
    SPC_YES_STR,
    SPC_ON_STR,
    SPC_OFF_STR,
    SPC_ENABLE_STR,
    SPC_DISABLE_STR,
    SPC_FIX_RESIS_STR,
    SPC_SELF_REG_STR,
    SPC_ONOFF_STR,
    SPC_PROPORTIONAL_STR,
    SPC_RTD_SHORT_STR,
    SPC_RTD_OPEN_STR,
    SPC_RTD_OFF_STR,
    SPC_RTD_ON_STR,
    SPC_RTD_MANOFF_STR,
    SPC_RTD_MANON_STR,
    SPC_RTD_ONE_MODE_STR,
    SPC_RTD_BACKUP_MODE_STR,
    SPC_RTD_AVERAGE_MODE_STR,
    SPC_RTD_LOWEST_MODE_STR,
    SPC_RTD_HIGHEST_MODE_STR,
    SPC_RTD_HIGHTEMPCUT_MODE_STR,
    SPC_FAHRENHEIT_STR,
    SPC_CELCIUS_STR,
    SPC_DIP_NORMAL_STR,
    SPC_DIP_ADVANCED_STR,
    SPC_AUTO_CYCLE_STR,
    SPC_NOW_STR,

    //Baudrate
    SPC_1200_STR,
    SPC_2400_STR,
    SPC_4800_STR,
    SPC_9600_STR,
    SPC_115200_STR,

    // Password
    SPC_MENU_PROG_PSWINIT_STR,

    // Reset
    SPC_MENU_RESET_CONFIRM_STR,

    SPC_MAX_STR_TYPE
} SpcStringType_t;

typedef enum
{
    SPC_MENU_ACT_INIT = 0,

    SPC_MAX_INFO_TYPE
} SpcInfoType_t;

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
    SPC_KEY_NORMAL = 0,
    SPC_KEY_TIMEOUT,
    SPC_KEY_NEXT,
    SPC_KEY_RESETCANCLE,
    SPC_KEY_RESETCOMPLETE,
    SPC_MAX_KEY_INPUT
} SpcKeyType_t;

typedef struct
{
    const SpcStringType_t StrType;
    const char str[SPC_MAX_STR_LEN];
} SpcStringPool_t;

typedef struct
{
    SpcInfoType_t position;
} SpcRunStatus_t;

typedef struct
{
    SpcTempStatus_t tempStatus;
    int8_t tempf;
    int8_t tempc;
} SpcTemperature_t;

typedef struct
{
    SpcTemperature_t temp[SPC_MAX_RTD_CHANNEL];
    int16_t gfi;
    int16_t PowerPercent;
    int16_t Current;
    int16_t Voltage;
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
    uint32_t reservd:12;
} SpcSysConfBytes_t;

typedef union
{
    uint32_t word;
    SpcSysConfBytes_t bytes;
} SpcSysConf_t;

typedef struct
{
    SpcTemperature_t MaintainTemp;
    SpcTemperature_t LowTemp;
    SpcTemperature_t HighTemp;
    SpcTemperature_t DeadBand;
    int16_t   LowCurrent;
    int16_t   HighCurrent;
    int16_t   GFIAlarm;
    int16_t   GFITrip;
    int16_t   LowVoltage;
    int16_t   HighVoltage;
    int16_t   LimitedCurrent;
    int16_t   SoftStartTime;
    int16_t   AutoTestTime;
    int16_t   DisplayTime;
    int16_t   CostPerKWH;
    int16_t   ScanSpeed;
    int16_t   ModbusAdd;
    int16_t   BaudRate;
    int16_t   AlarmOutTest;
    int16_t   HeaterTest;
    int16_t   GFTest;

    SpcSysConf_t system;
} SpcConfig_t;

typedef struct
{
    SpcTemperature_t maxTemp;
    SpcTemperature_t minTemp;
    int16_t   MaxCurrent;
    int16_t   MaxGFCurrent;
    int16_t   MaxVoltage;
    int16_t   MinVoltage;
    int16_t   EnergyUsed;
    int16_t   HeaterOnTime;
    int32_t   EnergyCost;
    int32_t   RunTime;
} SpcStatistic_t;

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
    SpcInfoType_t position;
    int16_t val;
    SpcTemperature_t temp;
} SpcStack_t;

typedef struct
{
    char name[SPC_MAX_STR_LEN];
    SpcRunStatus_t runStatus;
    SpcMeasure_t measure;
    SpcConfig_t config;
    SpcStatistic_t status;
    SpcAlarm_t alarm;
    SpcStack_t stack;
} SpcValue_t;

typedef struct
{
    SpcAlarmType_t type;
    bool prio;
} SpcAlarmTable_t;

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

typedef struct
{
    SpcRTDStatus_t status;
    SpcStringType_t line1;
    SpcStringType_t line2;
} SpcRtdStatusStr_t;

typedef struct
{
    SpcInfoType_t type;
    SpcStringType_t line1;
    SpcTemperature_t *temp;
} SpcDataTemp_t;

typedef struct
{
    SpcInfoType_t type;
    SpcStringType_t line1;
    int16_t *val;
    char prefix[SPC_MAX_UNIT_STR_LEN];
    char suffix[SPC_MAX_UNIT_STR_LEN];
} SpcDataInt16_t;

typedef struct
{
    SpcInfoType_t type;
    SpcStringType_t line1;
    int32_t *val;
    char prefix[SPC_MAX_UNIT_STR_LEN];
    char suffix[SPC_MAX_UNIT_STR_LEN];
} SpcDataInt32_t;

typedef struct
{
    uint8_t val;
    SpcStringType_t strIndex;
} SpcByteStrPool_t;

typedef struct
{
    SpcInfoType_t type;
    SpcStringType_t line1;
    uint8_t offset;
    uint32_t field;
    uint8_t tableSize;
    const SpcByteStrPool_t *table;
} SpcDataByte_t;

extern SpcValue_t SpcValue;

void Spc_ScreenUpdateStatic(int16_t line1, int16_t line2);
void Spc_ScreenUpdateDynamic(int16_t line1, char *buf);

void Spc_AlarmMgr(SpcList_t * list, SpcAlarmType_t type, bool enable);
void SpcListInit(SpcList_t * list, uint8_t size);
SpcStatus_t SpcListInsert(SpcList_t * list, SpcItem_t *itemToAdd);
SpcStatus_t SpcListRemove(SpcList_t * list, SpcAlarmType_t alarmType);

void Spc_AlarmRaise(SpcAlarmType_t alarmType);
void Spc_AlarmClear(SpcAlarmType_t alarmType);

SpcKeyType_t SpcEntryInit(SpcValue_t *SpcValue);
SpcKeyType_t SpcEntryShowId(SpcValue_t *SpcValue);
SpcKeyType_t SpcEntryShowHeatStatus(SpcValue_t *SpcValue);
SpcKeyType_t SpcEntryShowHeatTemp(SpcValue_t *SpcValue);
SpcKeyType_t SpcEntryShowInt16(SpcValue_t *SpcValue);
SpcKeyType_t SpcEntryShowInt32(SpcValue_t *SpcValue);
SpcKeyType_t SpcEntryShowByte(SpcValue_t *SpcValue);
SpcKeyType_t SpcEntryShowSysStatus(SpcValue_t *SpcValue);

#endif // __spc_common_H