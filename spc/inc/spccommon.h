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

#define MAX_TEMP_C             ( 500 )
#define MIN_TEMP_C             ( -50 )
#define MAX_TEMP_F             ( 932 )
#define MIN_TEMP_F             ( -58 )

#define MAX_DEADBAND_C         ( 5 )
#define MIN_DEADBAND_C         ( 1 )
#define MAX_DEADBAND_F         ( 10 )
#define MIN_DEADBAND_F         ( 1 )

#define MIN_SPCCURRENT         ( 1 )
#define MAX_SPCCURRENT         ( 300 )
#define MIN_SPCHIGHCURRENT     ( 10 )
#define MAX_SPCLOWCURRENT      ( 290 )
#define MIN_SPCGFIALARM        ( 10 )
#define MAX_SPCGFIALARM        ( 500 )
#define MIN_SPCHIGHGFIALARM    ( 15 )
#define MAX_SPCLOWGFIALARM     ( 495 )
#define MIN_SPCVOLT            ( 85 )
#define MAX_SPCVOLT            ( 280 )
#define MIN_SPCHIGHVOLT        ( 95 )
#define MAX_SPCLOWVOLT         ( 270 )
#define MIN_SPCCURRENTLMT      ( 20 )
#define MAX_SPCCURRENTLMT      ( 100 )
#define MAX_SOFTSTART          ( 999 )
#define MIN_SOFTSTART          ( 10 )
#define MAX_AUTOTEST           ( 720 )
#define MIN_AUTOTEST           ( 1 )
#define MAX_SPCOST             ( 100 )
#define MIN_SPCOST             ( 1 )
#define MAX_TIMEOUT            ( 600 )
#define MIN_TIMEOUT            ( 5 )
#define MAX_SCANSPEED          ( 10 )
#define MIN_SCANSPEED          ( 3 )
#define MAX_MODBUS             ( 255 )
#define MIN_MODBUS             ( 1 )
#define MAX_ALARMOUT           ( 24 )
#define MIN_ALARMOUT           ( 1 )
#define MAX_HEATERTEST         ( 24 )
#define MIN_HEATERTEST         ( 1 )

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
#define SpcPassword(x)         ( (x)->password )

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
#define SpcStackData(x)        ( (x)->stack.data )
#define SpcStackTemp(x)        ( (x)->stack.temp )
#define SpcStackStr(x)         ( (x)->stack.string )
#define SpcStackNewStr(x)      ( (x)->stack.newString )

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
    SPC_NONE_STR,
    SPC_ENABLE_STR,
    SPC_DISABLE_STR,
    SPC_CONTINUE_STR,
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
    SPC_PSW_OLD,
    SPC_PSW_NEW,
    SPC_PSW_NEW_AGAIN,
    SPC_PSW_SUCCESS,
    SPC_PSW_INVALID,
    SPC_PSW_NOT_MATCH,

    // Reset
    SPC_MENU_RESET_CONFIRM_STR,
    SPC_MENU_RESET_FINISH_STR,

    SPC_MAX_STR_TYPE
} SpcStringType_t;

typedef enum
{
    SPC_MENU_ACT_INIT = 0,

    SPC_MAX_INFO_TYPE
} SpcInfoType_t;

typedef enum
{
    SPC_DATA_NORMAL = 0,
    SPC_RTD_SHORT,
    SPC_RTD_OPEN,
    SPC_OUTRANGE,
    SPC_OFF,
    SPC_NONE,
    SPC_DISABLE,
    SPC_CONTINUE,

    SPC_MAX_TEMP_STATUS
} SpcDataStatus_t;

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
    SpcDataStatus_t status;
    int16_t tempf;
    int16_t tempc;
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
    SpcDataStatus_t status;
    int16_t val;
} SpcConfInt16_t;

typedef struct
{
    SpcTemperature_t MaintainTemp;
    SpcTemperature_t LowTemp;
    SpcTemperature_t HighTemp;
    SpcTemperature_t DeadBand;
    SpcConfInt16_t   LowCurrent;
    SpcConfInt16_t   HighCurrent;
    SpcConfInt16_t   GFIAlarm;
    SpcConfInt16_t   GFITrip;
    SpcConfInt16_t   LowVoltage;
    SpcConfInt16_t   HighVoltage;
    SpcConfInt16_t   LimitedCurrent;
    SpcConfInt16_t   SoftStartTime;
    SpcConfInt16_t   AutoTestTime;
    SpcConfInt16_t   DisplayTime;
    SpcConfInt16_t   CostPerKWH;
    SpcConfInt16_t   ScanSpeed;
    SpcConfInt16_t   ModbusAdd;
    SpcConfInt16_t   BaudRate;
    SpcConfInt16_t   AlarmOutTest;
    SpcConfInt16_t   HeaterTest;
    SpcConfInt16_t   GFTest;

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
    uint8_t index;
    uint8_t charIndex;
    char str[SPC_MAX_STR_LEN];
} SpcStrStack_t;

typedef struct
{
    SpcStrStack_t string;
    SpcStrStack_t newString;
    SpcInfoType_t position;
    SpcConfInt16_t data;
    SpcTemperature_t temp;
} SpcStack_t;

typedef struct
{
    char name[SPC_MAX_STR_LEN];
    char password[SPC_MAX_STR_LEN];
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

typedef SpcInfoType_t (*pfnAct)(SpcValue_t *SpcValue);
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
    SpcConfInt16_t *data;
    char prefix[SPC_MAX_UNIT_STR_LEN];
    char suffix[SPC_MAX_UNIT_STR_LEN];
} SpcConfDataInt16_t;

typedef struct
{
    SpcInfoType_t type;
    int16_t *val;
} SpcStatisticInt_t;

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

typedef struct
{
    SpcInfoType_t type;
    int16_t max;
    int16_t min;
    SpcConfInt16_t *maxPtr;
    SpcConfInt16_t *minPtr;
    uint8_t size;
    const SpcDataStatus_t *status;
} SpcConfIntLimit_t;

typedef struct
{
    SpcInfoType_t type;
    SpcStringType_t line1;
    SpcStrStack_t *stack;
} SpcPasswordStatus_t;

extern SpcValue_t SpcValue;

void Spc_ScreenUpdateStatic(int16_t line1, int16_t line2);
void Spc_ScreenUpdateDynamic(int16_t line1, char *buf);

void Spc_AlarmMgr(SpcList_t * list, SpcAlarmType_t type, bool enable);
void SpcListInit(SpcList_t * list, uint8_t size);
SpcStatus_t SpcListInsert(SpcList_t * list, SpcItem_t *itemToAdd);
SpcStatus_t SpcListRemove(SpcList_t * list, SpcAlarmType_t alarmType);

void Spc_AlarmRaise(SpcAlarmType_t alarmType);
void Spc_AlarmClear(SpcAlarmType_t alarmType);

SpcInfoType_t SpcEntryInit(SpcValue_t *SpcValue);
SpcInfoType_t SpcEntryShowId(SpcValue_t *SpcValue);
SpcInfoType_t SpcIdUp(SpcValue_t *SpcValue);
SpcInfoType_t SpcIdDown(SpcValue_t *SpcValue);
SpcInfoType_t SpcIdConf(SpcValue_t *SpcValue);
SpcInfoType_t SpcEntryShowHeatStatus(SpcValue_t *SpcValue);
SpcInfoType_t SpcEntryShowHeatTemp(SpcValue_t *SpcValue);
SpcInfoType_t SpcEntryShowInt16(SpcValue_t *SpcValue);
SpcInfoType_t SpcEntryShowInt32(SpcValue_t *SpcValue);
SpcInfoType_t SpcEntryShowByte(SpcValue_t *SpcValue);
SpcInfoType_t SpcEntryShowSysStatus(SpcValue_t *SpcValue);
SpcInfoType_t SpcEntryShowConfInt16(SpcValue_t *SpcValue);

SpcInfoType_t SpcPushTempRet(SpcValue_t *SpcValue);
SpcInfoType_t SpcPushIntRet(SpcValue_t *SpcValue);
SpcInfoType_t SpcPushAllRet(SpcValue_t *SpcValue);
SpcInfoType_t SpcResetRet(SpcValue_t *SpcValue);
SpcInfoType_t SpcConfirmTemp(SpcValue_t *SpcValue);
SpcInfoType_t SpcConfirmInt(SpcValue_t *SpcValue);
SpcInfoType_t SpcConfirmAll(SpcValue_t *SpcValue);

SpcInfoType_t SpcPushTmUp(SpcValue_t *SpcValue);
SpcInfoType_t SpcPushTmDown(SpcValue_t *SpcValue);
SpcInfoType_t SpcUpTemp(SpcValue_t *SpcValue);
SpcInfoType_t SpcDownTemp(SpcValue_t *SpcValue);
SpcInfoType_t SpcPopRight(SpcValue_t *SpcValue);
SpcInfoType_t SpcPopLeft(SpcValue_t *SpcValue);
SpcInfoType_t SpcPopProg(SpcValue_t *SpcValue);
SpcInfoType_t SpcPopTempConf(SpcValue_t *SpcValue);

SpcInfoType_t SpcPushIntUp(SpcValue_t *SpcValue);
SpcInfoType_t SpcPushIntDown(SpcValue_t *SpcValue);
SpcInfoType_t SpcUpInt(SpcValue_t *SpcValue);
SpcInfoType_t SpcDownInt(SpcValue_t *SpcValue);
SpcInfoType_t SpcPopIntConf(SpcValue_t *SpcValue);

SpcInfoType_t SpcPushByteUp(SpcValue_t *SpcValue);
SpcInfoType_t SpcPushByteDown(SpcValue_t *SpcValue);
SpcInfoType_t SpcUpByte(SpcValue_t *SpcValue);
SpcInfoType_t SpcDownByte(SpcValue_t *SpcValue);
SpcInfoType_t SpcPopByteConf(SpcValue_t *SpcValue);

SpcInfoType_t SpcPswInitUp(SpcValue_t *SpcValue);
SpcInfoType_t SpcPswInitDown(SpcValue_t *SpcValue);
SpcInfoType_t SpcPswStart(SpcValue_t *SpcValue);
SpcInfoType_t SpcPswUp(SpcValue_t *SpcValue);
SpcInfoType_t SpcPswDown(SpcValue_t *SpcValue);
SpcInfoType_t SpcPswRight(SpcValue_t *SpcValue);
SpcInfoType_t SpcOldPswEnter(SpcValue_t *SpcValue);
SpcInfoType_t SpcPswNew(SpcValue_t *SpcValue);
SpcInfoType_t SpcPswNewAgain(SpcValue_t *SpcValue);

#endif // __spc_common_H