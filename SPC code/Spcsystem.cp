#line 1 "D:/MyProject/SPC code1/SPC code/Spcsystem.c"
#line 1 "d:/myproject/spc code1/spc code/systemvalue.h"
#line 15 "d:/myproject/spc code1/spc code/systemvalue.h"
sbit LCD_RW at LATF6_bit;
sbit LCD_RW_Direction at TRISF6_bit;

sbit LCD_RS at LATF5_bit;
sbit LCD_EN at LATF7_bit;
sbit LCD_D4 at LATE4_bit;
sbit LCD_D5 at LATE5_bit;
sbit LCD_D6 at LATE6_bit;
sbit LCD_D7 at LATE7_bit;

sbit LCD_RS_Direction at TRISF5_bit;
sbit LCD_EN_Direction at TRISF7_bit;
sbit LCD_D4_Direction at TRISE4_bit;
sbit LCD_D5_Direction at TRISE5_bit;
sbit LCD_D6_Direction at TRISE6_bit;
sbit LCD_D7_Direction at TRISE7_bit;
#line 844 "d:/myproject/spc code1/spc code/systemvalue.h"
typedef unsigned char UCHAR;
typedef unsigned int UINT;
typedef unsigned long ULONG;

typedef struct tagUCHAR_BIT
{
 UCHAR bit0:1;
 UCHAR bit1:1;
 UCHAR bit2:1;
 UCHAR bit3:1;
 UCHAR bit4:1;
 UCHAR bit5:1;
 UCHAR bit6:1;
 UCHAR bit7:1;
}UCHAR_BIT;

typedef union tagUCHAR_BYTE
{
 UCHAR byte;
 UCHAR_BIT bite;
}UCHAR_BYTE;

typedef union tagUINT16
{
 UCHAR byte[2];
 UINT word;
}UINT16;

typedef union tagUINT32
{
 UCHAR byte[4];
 UINT inte[2];
 ULONG word;
}UINT32;

typedef struct tagSPCTRING
{
 UCHAR SPCtring[20];
}SPCTRING;

typedef struct tagSYSTEM_FLAG_INT
{
 ULONG keypushed:1;
 ULONG meas_VT_reach:2;
 ULONG freq_en:1;
 ULONG lcd_line1_needupdate:1;
 ULONG lcd_line2_needupdate:1;
 ULONG mainmenuroll:1;
 ULONG alarm_displayed:1;
 ULONG alarm_actived:1;
 ULONG log_displayed:1;
 ULONG default_diaped:1;
 ULONG char_actived:1;
 ULONG modebus_rx:1;
 ULONG scantime_en:2;
 ULONG flashing_en:1;
 ULONG flashing_reach:1;
 ULONG flashing_state:1;
 ULONG temp_err:1;
 ULONG temp_update:1;
 ULONG load_forceop:2;
 ULONG alarmssr_forceop:1;
 ULONG alarmssr_stat:1;
 ULONG alarmtest_cmd:2;
 ULONG heatest_reach:1;
 ULONG heatest_req:1;
 ULONG autotest_req:2;
 ULONG char_flash:1;
 ULONG stat_update:1;
}SYSTEM_FLAG_INT;

typedef union tagSYSTEM_FLAG
{
 ULONG word;
 SYSTEM_FLAG_INT bite;
}SYSTEM_FLAG;

typedef struct tagTEMPERATURE
{
 int Temperature_F;
 int Temperature_C;
}TEMPERATURE;

typedef struct tagSYSTEM_VALUE_SHORT
{


 ULONG spc_units_c:1;
 ULONG heater_en:1;
 ULONG man_on:1;
 ULONG ctl_type:1;
 ULONG rtd_opr:3;


 ULONG rtd_fail_mod:1;
 ULONG password_en:1;
 ULONG usr_advanced:1;
 ULONG def_display:2;

 ULONG baud:3;
 ULONG gfi_test_mod:2;

 ULONG heater_type:1;

 ULONG cable_type:1;
 ULONG reservd:13;
}SYSTEM_VALUE_SHORT;

typedef union tagSYSTEM_VALUEB
{
 ULONG word;
 SYSTEM_VALUE_SHORT bite;
}SYSTEM_VALUEB;

typedef struct tagSPCSETPIONTS
{

 TEMPERATURE MaintainTemp;
 TEMPERATURE LowTemp;
 TEMPERATURE HighTemp;
 TEMPERATURE DeadBand;

 int LowCurrent;
 int HighCurrent;

 int GFIAlarm;
 int GFITrip;

 int LowVoltage;
 int HighVoltage;


 int LimitedCurrent;

 int SoftStartTime;
 int AutoTestTime;

 int DisplayTime;

 int CostPerKWH;
 int ScanSpeed;
 int ModbusAdd;
 int BaudRate;

 int AlarmOutTest;
 int HeaterTest;
 int GFTest;

 char HeaterName[16];
 char Password[16];
 char CharacNum;
 char StringNum;

 SYSTEM_VALUEB system_valueb;
}SPCSETPIONTS;

typedef struct tagSTATISTICS
{

 TEMPERATURE MaximumTemp;
 TEMPERATURE MinimumTemp;
 int MaximumCurrent;
 int MaximumGFCurrent;
 int MaximumVoltage;
 int MinimumVoltage;
 int EnergyUsed;
 ULONG EnergyCost;
 ULONG RunTime;
 int HeaterOnTime;
 int Version;
}STATISTICS;

typedef struct tagSPCACTUAL
{

 TEMPERATURE Temperature;
 TEMPERATURE TemperatureA;
 TEMPERATURE TemperatureB;
 int HeaterPow;
 int Current;
 int Current_RMS;
 int GFICurrent;
 int Voltage;
 int HeaterStatus;
}SPCACTUAL;

typedef struct tagSPCVALUE
{
 SPCACTUAL SPCActual;
 STATISTICS SPCStatistics;
 SPCSETPIONTS SPCSetPoints;
} SPCVALUE;

typedef struct tagSPCMENUFLAG_BIT
{
 UCHAR menu_active:1;
 UCHAR advanced_req:1;
 UCHAR maintainnone_conflict:1;
 UCHAR maintainoff_conflict:1;
 UCHAR proportional_conflict:1;
 UCHAR SelfRegula_conflict:1;
 UCHAR FoxResis_conflict:1;
 UCHAR reservd:1;
}SPCMENUFLAG_BIT;

typedef union tagSPCMENUFLAG
{
 UCHAR word;
 SPCMENUFLAG_BIT bite;
}SPCMENUFLAG;

typedef struct tagSPCCOUNT
{
 unsigned int secout;
 unsigned int toutT;
 unsigned int Timeout_count;
 unsigned int modbus_count;
 unsigned int scanT;
 char meas_VT_count;
 char meas_CG_count[2];
 unsigned int freq_count;
 char AlarmOutTest_count;
 char HeaterTest_count;
 unsigned int AutoTest_count;
 unsigned int AutoTest_last_count;
 char KeyValue_count;
}SPCCOUNT;

typedef struct tagSPCALARM
{
 UCHAR num_alarms;
 unsigned long alarm_typ[20];
}SPCALARM;

typedef struct tagSPCLOG
{
 UCHAR num_logs;
 unsigned long log_typ[20];
}SPCLOG;

typedef struct tagSPCALARMBOX
{
 SPCALARM spcalarms;
 SPCLOG spclogs;
}SPCALARMBOX;

typedef struct tagACCUMULATE
{
 ULONG Current_acc;
 ULONG GFI_acc;
 ULONG Volt_acc;
}ACCUMULATE;

typedef struct tagSPCTIME
{
 char second;
 char minute;
 ULONG hour;
}SPCTIME;
#line 1126 "d:/myproject/spc code1/spc code/systemvalue.h"
typedef struct tagSETPSHADE
{
 unsigned char chare;
 int inte;
}SETPSHADE;

typedef struct tagSPCSSR
{
 char SSR_cmd;
 char SSR_stat;
 char SSR_actual_stat;
}SPCSSR;

typedef struct tagSOFTSTART
{
 char SOFTSTART_cmd;
 char SOFTSTART_stat;
 char SOFTSTART_reach;
 unsigned int SOFTSTART_count;
}SOFTSTART;

typedef struct tagPWMCOUNT
{
 char shift_count;
 char duty_count;
 unsigned int element_count;
 unsigned int meas_forbid_count;
 unsigned int meas_count;
}PWMCOUNT;

typedef struct tagSPCPWM
{
 char pwm_cmd;
 char duty_point;
 char meas_cmd;
 PWMCOUNT pwm_count;
}SPCPWM;

typedef struct tagVALUEACC
{
 unsigned char num;
 unsigned long acc;
}VALUEACC;

typedef struct tagCLIBRATIONBOX
{
 char index;
 char subindex;
}CLIBRATIONBOX;

typedef struct tagCLIBRATIONCMD
{
 char enable;
 char index;
 char command;
}CLIBRATIONCMD;

extern SYSTEM_FLAG spc_system_flag;
extern SPCVALUE pSPCValue[2];
extern char Cable_Channel;
extern UCHAR Menustat;
extern SPCPWM Spcpwm[2];
extern SPCSSR Spcssr[2];
extern SOFTSTART SpcSstart[2];
extern ACCUMULATE SpcAcc[2];



extern UCHAR Info_Line1[ 16 ];
extern UCHAR Info_Line2[ 16 ];
extern UCHAR Info_Line1_shape[ 16 ];
extern UCHAR Info_Line2_shape[ 16 ];

extern UCHAR Alarmstat,Alarmtype[19];
extern UCHAR ALARM_NUM[2];
extern SETPSHADE SetP_shade1;
extern SPCSETPIONTS SetP_shade;
extern SPCCOUNT spc_count;
extern SPCALARMBOX pSPCAlarm;
extern UCHAR Passwordbuff[16];

extern SPCTIME SYS_On_time;
extern SPCTIME Heat_On_time[2];

extern unsigned long ActivedAlarms;

extern UINT KeyHoldStep;
extern UINT KeyHoldDelay;
extern char Keyactived,Keyhold;
extern char bUpdate;
extern char LCDext;

extern UCHAR Statis_flag[2];

extern signed int temp_val_old[2];

extern unsigned int pwm_duty[2],duty_index[2];

extern UINT freqency;
extern UINT freq_pori;
extern char char_flash_loca;

extern char reset_psw_en;

extern CLIBRATIONCMD Cali_cmd;

extern VALUEACC Volt_acc[2];
extern VALUEACC Current_acc[2];

extern char ADC_busy[2];

extern char Actural_disp_str[38][17];
extern ULONG SystemUpdate;
extern char freq_en;

extern int Cali_value[4];

extern unsigned int DataUpdate;

extern char forceop_level;
extern char KeyEn;

extern unsigned char ForceSSRONCondition[2];
extern unsigned char ForceSSROFFCondition[2];
#line 1 "d:/myproject/spc code1/spc code/pic18f6622.h"
#line 1 "d:/myproject/spc code1/spc code/spcsystem.h"
#line 85 "d:/myproject/spc code1/spc code/spcsystem.h"
void SPCSystemInitialize(void);
UCHAR MainTainTempDisable(char ChannelNum);
UCHAR ProCtlEnable(char ChannelNum);
UCHAR SelfRegulaEnable(char ChannelNum);
void SetSystemToDefault(void);
void SetSystemFromEEP(void);
void Savedata(UINT flash_lacl, UINT len, UCHAR *ptr, char cmd);

void Para_Flag_Set(UCHAR direct, UCHAR cmd);
void Para_int_Set(UCHAR direct, UCHAR cmd);
void Para_char_Set(UCHAR direct, UCHAR cmd);

void Para_show(UCHAR direct, UCHAR cmd);
void ResetSPCSet(UCHAR direct, UCHAR cmd);
void PasswordEidtorSet(UCHAR direct, UCHAR cmd);
void HeaterIDSet(UCHAR direct, UCHAR cmd);
void HighTempAlarmSet(UCHAR direct, UCHAR cmd);
void LowTempAlarmSet(UCHAR direct, UCHAR cmd);
void DeadbandSet(UCHAR direct, UCHAR cmd);
void ChannelConfig(UCHAR direct, UCHAR cmd);
void MaintainTempSet(UCHAR direct, UCHAR cmd);
void TitleSet(UCHAR direct, UCHAR cmd);
void DisablePSWInputing(void);
void Authority_Set(UCHAR direct, UCHAR cmd);
void Version_show(UCHAR direct, UCHAR cmd);

void FromIntToStr(long ValueResoure, char *StringTarget, signed char offset);
void storage(void);
void ConflictCorrection(void);

void Reset_PSW(UCHAR direct, UCHAR cmd);
char getStringNum(void);

extern char ParametersChanged;
extern char PasswordNeed;
extern char FirstTempCheck;
#line 1 "d:/myproject/spc code1/spc code/eeprom.h"



void EEPROM_get(UINT EEPROM_READ_ADDRESS,UCHAR Len,UCHAR *readbuffer);
void EEPROM_set(UINT EEPROM_WRITE_ADDRESS,UCHAR Len,UCHAR *writebuffer);


UCHAR SPCIfFirstRun(void);
#line 1 "d:/myproject/spc code1/spc code/menuoperation.h"
#line 22 "d:/myproject/spc code1/spc code/menuoperation.h"
void AlarmRoll(UINT Forward,UINT Alarmcmd);
void MenuRoll(UCHAR Forward,UCHAR Para,UCHAR Level);
void CaliRoll(UCHAR Forward,UCHAR Level);
void LCDUpdate(void);
void SPCMenuOperation(void);
ULONG keyboard_get_value(void);
void set_alarm_info(UCHAR AlarmIndex);
void set_menu_info(UCHAR direction,UCHAR command);
UINT GetAlarmType(UCHAR index, char cmd);
void rightkey_func(void);

extern unsigned int KeyDetectCount;
extern unsigned int KeyValidCount;
extern char KeyHoldCount;
extern char KeyDetectStat;
extern ULONG KeyValueshape;
extern char KeyValidEn;
extern char KeyHoldEn;
extern char KeyBusy;
extern unsigned int ResetPasswordCount;
extern char ResetPasswordStep;
extern char ChannelSelStat;
#line 1 "d:/myproject/spc code1/spc code/spcvalue.h"
#line 1 "d:/myproject/spc code1/spc code/spcsystem.h"
#line 85 "d:/myproject/spc code1/spc code/spcsystem.h"
void SPCSystemInitialize(void);
UCHAR MainTainTempDisable(char ChannelNum);
UCHAR ProCtlEnable(char ChannelNum);
UCHAR SelfRegulaEnable(char ChannelNum);
void SetSystemToDefault(void);
void SetSystemFromEEP(void);
void Savedata(UINT flash_lacl, UINT len, UCHAR *ptr, char cmd);

void Para_Flag_Set(UCHAR direct, UCHAR cmd);
void Para_int_Set(UCHAR direct, UCHAR cmd);
void Para_char_Set(UCHAR direct, UCHAR cmd);

void Para_show(UCHAR direct, UCHAR cmd);
void ResetSPCSet(UCHAR direct, UCHAR cmd);
void PasswordEidtorSet(UCHAR direct, UCHAR cmd);
void HeaterIDSet(UCHAR direct, UCHAR cmd);
void HighTempAlarmSet(UCHAR direct, UCHAR cmd);
void LowTempAlarmSet(UCHAR direct, UCHAR cmd);
void DeadbandSet(UCHAR direct, UCHAR cmd);
void ChannelConfig(UCHAR direct, UCHAR cmd);
void MaintainTempSet(UCHAR direct, UCHAR cmd);
void TitleSet(UCHAR direct, UCHAR cmd);
void DisablePSWInputing(void);
void Authority_Set(UCHAR direct, UCHAR cmd);
void Version_show(UCHAR direct, UCHAR cmd);

void FromIntToStr(long ValueResoure, char *StringTarget, signed char offset);
void storage(void);
void ConflictCorrection(void);

void Reset_PSW(UCHAR direct, UCHAR cmd);
char getStringNum(void);

extern char ParametersChanged;
extern char PasswordNeed;
extern char FirstTempCheck;
#line 5 "d:/myproject/spc code1/spc code/spcvalue.h"
typedef struct tagSPCMENU
{
 UCHAR index;
 UCHAR subindex;
 UCHAR thirdindex;

 SPCMENUFLAG flag;
 UCHAR func_mark;

 char offset;
 unsigned long len;
 char add;

 int MaxVal;
 int MinVal;

 char NumVal;
 char Unit;

 char decimal;
 char edge_nofix;
}SPCMENU;

static code SPCMENU SpcMenu[ 61 ] =
{


 { 0 ,  0 ,  0 ,
  1 ,
  4 ,  0 ,  0 ,  0 ,
  0 ,  0 ,  0 ,  0 ,
  0 ,  0 },

 { 0 ,  0 ,  1 ,
  1 ,
  3 ,  16 ,  (unsigned long)0x00100000 | (unsigned long)0x80000000 ,  0 ,
  0 ,  0 ,  0 ,  0 ,
  0 ,  1 },

 { 0 ,  0 ,  2 ,
  1 | 4 | 8 ,
  3 ,  6 ,  (unsigned long)0x00000400 | (unsigned long)0x80000000 ,  0 ,
  0 ,  0 ,  0 ,  0 ,
  0 ,  1 },

 { 0 ,  0 ,  3 ,
  1 | 8 | 2 ,
  3 ,  8 ,  (unsigned long)0x00000400 | (unsigned long)0x80000000 ,  0 ,
  0 ,  0 ,  0 ,  0 ,
  0 ,  1 },

 { 0 ,  0 ,  4 ,
  1 | 8 | 2 ,
  3 ,  10 ,  (unsigned long)0x00000400 | (unsigned long)0x80000000 ,  0 ,
  0 ,  0 ,  0 ,  0 ,
  0 ,  1 },

 { 0 ,  0 ,  5 ,
  1 | 2 ,
  3 ,  18 ,  (unsigned long)0x00010000 | (unsigned long)0x80000000 ,  0 ,
  0 ,  0 ,  0 ,  0 ,
  0 ,  1 },

 { 0 ,  0 ,  6 ,
  1 ,
  3 ,  4 ,  (unsigned long)0x00000010 | (unsigned long)0x80000000 ,  0 ,
  0 ,  0 ,  0 ,  0 ,
  1 ,  1 },

 { 0 ,  0 ,  7 ,
  1 ,
  3 ,  2 ,  (unsigned long)0x00000010 | (unsigned long)0x80000000 ,  0 ,
  0 ,  0 ,  0 ,  0 ,
  0 ,  1 },

 { 0 ,  0 ,  8 ,
  1 ,
  3 ,  30 ,  (unsigned long)0x01000000 ,  0 ,
  0 ,  0 ,  0 ,  0 ,
  0 ,  0 },


 { 0 ,  1 ,  0 ,
  1 | 2 ,
  4 ,  1 ,  0 ,  0 ,
  0 ,  0 ,  0 ,  0 ,
  0 ,  0 },

 { 0 ,  1 ,  1 ,
  1 | 2 | 8 ,
  3 ,  12 ,  (unsigned long)0x00001000 | (unsigned long)0x80000000 ,  0 ,
  0 ,  0 ,  0 ,  0 ,
  0 ,  1 },

 { 0 ,  1 ,  2 ,
  1 | 2 | 8 ,
  3 ,  14 ,  (unsigned long)0x00004000 | (unsigned long)0x80000000 ,  0 ,
  0 ,  0 ,  0 ,  0 ,
  0 ,  1 },

 { 0 ,  1 ,  3 ,
  1 | 2 ,
  3 ,  20 ,  (unsigned long)0x00000040 | (unsigned long)0x80000000 ,  0 ,
  0 ,  0 ,  0 ,  0 ,
  1 ,  1 },

 { 0 ,  1 ,  4 ,
  1 | 2 ,
  3 ,  22 ,  (unsigned long)0x00000100 | (unsigned long)0x80000000 ,  0 ,
  0 ,  0 ,  0 ,  0 ,
  0 ,  1 },

 { 0 ,  1 ,  5 ,
  1 | 2 ,
  3 ,  32 ,  (unsigned long)0x02000000 ,  0 ,
  0 ,  0 ,  0 ,  0 ,
  0 ,  0 },

 { 0 ,  1 ,  6 ,
  1 | 2 ,
  3 ,  34 ,  (unsigned long)0x04000000 ,  0 ,
  0 ,  0 ,  0 ,  0 ,
  0 ,  0 },

 { 0 ,  1 ,  7 ,
  1 | 2 ,
  3 ,  24 ,  (unsigned long)0x00040000 | (unsigned long)0x80000000 ,  0 ,
  0 ,  0 ,  0 ,  0 ,
  0 ,  1 },

 { 0 ,  1 ,  8 ,
  1 | 2 ,
  3 ,  26 ,  (unsigned long)0x00040000 | (unsigned long)0x80000000 ,  0 ,
  0 ,  0 ,  0 ,  0 ,
  2 ,  1 },

 { 0 ,  1 ,  9 ,
  1 | 2 ,
  3 ,  0 ,  (unsigned long)0x00000001 | (unsigned long)0x80000000 ,  0 ,
  0 ,  0 ,  0 ,  0 ,
  0 ,  1 },

 { 0 ,  1 ,  10 ,
  1 | 2 ,
  3 ,  36 ,  (unsigned long)0x00000004 | (unsigned long)0x80000000 ,  0 ,
  0 ,  0 ,  0 ,  0 ,
  0 ,  1 },

 { 0 ,  1 ,  11 ,
  1 | 2 ,
  5 ,  0 ,  0 ,  0 ,
  0 ,  0 ,  0 ,  0 ,
  0 ,  0 },

 { 0 ,  1 ,  12 ,
  1 | 2 ,
  22 ,  0 ,  0 ,  0 ,
  0 ,  0 ,  0 ,  0 ,
  0 ,  0 },








 { 1 ,  0 ,  0 ,
  1  ,
  4 ,  2 ,  0 ,  0 ,
  0 ,  0 ,  0 ,  0 ,
  0 ,  0 },

 { 1 ,  0 ,  1 ,
  1 ,
  24 ,  0 ,  0 ,  0 ,
  0 ,  0 ,  0 ,  0 ,
  0 ,  0 },

 { 1 ,  0 ,  1 ,
  1 ,
  25 ,  0 ,  0 ,  0 ,
  0 ,  0 ,  0 ,  1+1 ,
  0 ,  1 },

 { 1 ,  0 ,  2 ,
  1 | 8 ,
  26 ,  0 ,  0 ,  0 ,
  0 ,  0 ,  0 ,  1+1 ,
  0 ,  1 },

 { 1 ,  0 ,  3 ,
  1 | 8 ,
  27 ,  0 ,  0 ,  0  ,
  0 ,  0 ,  0 ,  1+1 ,
  0 ,  1 },

 { 1 ,  0 ,  4 ,
  1 ,
  2 ,  16 , 10,  0 ,
  290 ,  1 , 1,  4 ,
  1 ,  0X10 },

 { 1 ,  0 ,  5 ,
  1 ,
  2 ,  18 , 10,  0 ,
  300 ,  10 , 1,  4 ,
  1 ,  0X20 },

 { 1 ,  0 ,  6 ,
  1 ,
  2 ,  20 , 5,  0 ,
  495 ,  10 , 1,  4+1 ,
  0 ,  0X10 },

 { 1 ,  0 ,  7 ,
  1 ,
  2 ,  22 , 5,  0 ,
  500 ,  15 , 1,  4+1 ,
  0 ,  0X20 },

 { 1 ,  0 ,  8 ,
  1 ,
  2 ,  24 , 10,  0 ,
  270 ,  85 , 1,  5+1 ,
  0 ,  0X10 },

 { 1 ,  0 ,  9 ,
  1 ,
  2 ,  26 , 10,  0 ,
  280 ,  95 , 1,  5+1 ,
  0 ,  0X20 },


 { 1 ,  1 ,  0 ,
  1 ,
  4 ,  3 ,  0 ,  0 ,
  0 ,  0 ,  0 ,  0 ,
  0 ,  0 },

 { 1 ,  1 ,  1 ,
  1 ,
  1 ,  1 ,  2 ,  4 ,
  0 ,  0 ,  0 ,  0 ,
  0 ,  1 },

 { 1 ,  1 ,  2 ,
  1 | 2 ,
  36 ,  0 ,  0 ,  0 ,
  0 ,  0 ,  0 ,  0 ,
  0 ,  1 },

 { 1 ,  1 ,  3 ,
  1 | 2 ,
  1 ,  15 ,  2 ,  31 ,
  0 ,  0 ,  0 ,  0 ,
  0 ,  1 },

 { 1 ,  1 ,  5 ,
  1 | 2 ,
  1 ,  2 ,  2 ,  73 ,
  0 ,  0 ,  0 ,  0 ,
  0 ,  1 },

 { 1 ,  1 ,  6 ,
  1 | 2 | 8 | 0x10 ,
  38 ,  0 ,  0 ,  0  ,
  0 ,  0 ,  0 ,  1+1 ,
  0 ,  1 },

 { 1 ,  1 ,  7 ,
  1 | 2 | 8 | 0X20 ,
  1 ,  3 ,  2 ,  20 ,
  0 ,  0 ,  0 ,  0 ,
  0 ,  1 },

 { 1 ,  1 ,  8 ,
  1 | 2 | 0X20 ,
  2 ,  28 ,  0 ,  0 ,
 100, 20, 1,  9 ,
  0 ,  1 },

 { 1 ,  1 ,  9 ,
  1 | 2 ,
  2 ,  30 ,  0 ,  0 ,
  999 ,  10 , 1,  6+1 ,
  0 ,  1 },

 { 1 ,  1 ,  10 ,
  1 | 2 ,
  2 ,  32 ,  0 ,  0 ,
  720 ,  1 , 1,  7+1 ,
  0 ,  0 },

 { 1 ,  1 ,  11 ,
  1 | 2 | 8 ,
  1 ,  4 ,  6 ,  25  ,
  0 ,  0 ,  0 ,  0 ,
  0 ,  1 },

 { 1 ,  1 ,  12 ,
  1 | 2 | 8 ,
  1 ,  7 ,  2 ,  73 ,
  0 ,  0 ,  0 ,  0 ,
  0 ,  1 },


 { 1 ,  2 ,  0 ,
  1 ,
  4 ,  4 ,  0 ,  0 ,
  0 ,  0 ,  0 ,  0 ,
  0 ,  0 },

 { 1 ,  2 ,  1 ,
  1 ,
  6 ,  8 ,  2 ,  13 ,
  0 ,  0 ,  0 ,  0 ,
  0 ,  0 },

 { 1 ,  2 ,  2 ,
  1 | 2 ,
  47 ,  0 ,  0 ,  0 ,
  0 ,  0 ,  0 ,  0 ,
  0 ,  0 },

 { 1 ,  2 ,  3 ,
  1 | 2 ,
  1 ,  0 ,  2 ,  11 ,
  0 ,  0 ,  0 ,  0 ,
  0 ,  1 },

 { 1 ,  2 ,  4 ,
  1 | 2 ,
  2 ,  36 ,  0 ,  0 ,
  100 ,  1 , 0,  0+1 | 0X80 ,
  2 ,  0 },

 { 1 ,  2 ,  5 ,
  1 ,
  1 ,  9 ,  2 ,  15 ,
  0 ,  0 ,  0 ,  0 ,
  0 ,  0 },

 { 1 ,  2 ,  6 ,
  1 | 2 ,
  1 ,  10 ,  3 ,  22 ,
  0 ,  0 ,  0 ,  0 ,
  0 ,  0 },

 { 1 ,  2 ,  7 ,
  1 | 2 ,
  2 ,  34 ,  0 ,  0 ,
  600 ,  5 , 1,  6+1 ,
  0 ,  0 },

 { 1 ,  2 ,  8 ,
  0 ,
  2 ,  38 ,  0 ,  0 ,
  10 ,  3 , 0,  6+1 ,
  0 ,  0 },

 { 1 ,  2 ,  9 ,
  1 | 2 ,
  2 ,  40 ,  0 ,  0 ,
  255 ,  1 , 0,  0 ,
  0 ,  0 },

 { 1 ,  2 ,  10 ,
  1 | 2 ,
  1 ,  12 ,  5 ,  6 ,
  0 ,  0 ,  0 ,  0 ,
  0 ,  0 },

 { 1 ,  2 ,  11 ,
  1 | 2 ,
  7 ,  0 ,  0 ,  0 ,
  0 ,  0 ,  0 ,  0 ,
  0 ,  0 },


 { 1 ,  3 ,  0 ,
  1 | 2 ,
  4 ,  5 ,  0 ,  0 ,
  0 ,  0 ,  0 ,  0 ,
  0 ,  0 },

 { 1 ,  3 ,  1 ,
  1 | 2 ,
  2 ,  44 ,  0 ,  0 ,
  24 ,  1 , 2,  7+1 ,
  0 ,  1 },

 { 1 ,  3 ,  2 ,
  1 | 2 ,
  2 ,  46 ,  0 ,  0 ,
  24 ,  1 , 2,  7+1 ,
  0 ,  1 },

 { 1 ,  3 ,  3 ,
  1 | 2 ,
  1 ,  16 ,  3 ,  17 ,
  0 ,  0 , 2,  0 ,
  0 ,  1 }
};

static code char SpcTxtLine1[ 61 ][17] =
{
 "Actual          ",
 "Heater Status   ",
 "Temperature     ",
 "RTD-A Actual    ",
 "RTD-B Actual    ",
 "Heater Power    ",
 "Heater Current  ",
 "Gound Fault     ",
 "Heater Voltage  ",
 "Actual          ",
 "Max Temperature ",
 "Min Temperature ",
 "Max Current     ",
 "Max Ground Fault",
 "Max Voltage     ",
 "Min Voltage     ",
 "Total Energy    ",
 "Total Cost      ",
 "Heater On Time  ",
 "Heater On Perc  ",
 "Reset Statistics",
 "Firmware Version",
 "Program         ",
 "Channel Config  ",
 "Maintain Temp   ",
 "Low Temp Alarm  ",
 "High Temp Alarm ",
 "Low Current Alm ",
 "High Current Alm",
 "GFI Alarm       ",
 "GFI Trip        ",
 "Low Volt Alarm  ",
 "High Volt Alarm ",
 "Program         ",
 "Enable Heater   ",
 "Heater ID       ",
 "Sel Heater Type ",
 "External Disable",
 "Deadband        ",
 "Control Type    ",
 "Power Limiting  ",
 "Soft Start Mode ",
 "Auto Test Cycle ",
 "RTD Operation   ",
 "RTD Failure Mode",
 "Program         ",
 "Password        ",
 "Change Password ",
 "Units           ",
 "Operational Cost",
 "Display Mode    ",
 "Default Display ",
 "Display Timeout ",
 "Scan Speed      ",
 "Modbus Address  ",
 "Baud Rate       ",
 "Reset Module    ",
 "Program         ",
 "Alarm Test      ",
 "Heater Test     ",
 "GFI Test        "
};

static code char ParaChar[98][17] =
{
 "Heater is Off   ",
 "Heater is On    ",
 "Heater is ManOn ",
 "Heater is ManOff",
 "no              ",
 "yes             ",
 "1200            ",
 "2400            ",
 "4800            ",
 "9600            ",
 "19200           ",
 "Fahrenheit      ",
 "Celcius         ",
 "Enable          ",
 "Disable         ",
 "Normal          ",
 "Advanced        ",
 "Autotest Cycle  ",
 "Now             ",
 "Disable         ",
 "On_off          ",
 "Proportional    ",
 "System Status   ",
 "Heater Status   ",
 "Heater Temp     ",
 "One RTD Mode    ",
 "Backup Mode     ",
 "Average Mode    ",
 "Lowest Mode     ",
 "Highest Mode    ",
 "High Temp Cutoff",
 "Fix-Res         ",
 "Self-Reg        ",

 "Calibrate       ",
 "RTD-A -50C      ",
 "RTD-A 500C      ",
 "RTD-B -50C      ",
 "RTD-B 500C      ",
 "Calibrating     ",
 "                ",

 "RTD Short       ",
 "RTD Open        ",
 "Out Of Range    ",

 "CH1 LowTemp Alm ",
 "CH2 LowTemp Alm ",
 "CH1 HighTemp Alm",
 "CH2 HighTemp Alm",
 "CH1 LowCur Alm  ",
 "CH2 LowCur Alm  ",
 "CH1 HighCur Alm ",
 "CH2 HighCur Alm ",
 "CH1 GFI Alarm   ",
 "CH2 GFI Alarm   ",
 "CH1 GFI Trip    ",
 "CH2 GFI Trip    ",
 "Low Volt Alarm  ",
 "High Volt Alarm ",
 "CH1 ContinueFail",
 "CH2 ContinueFail",
 "CH1 Switch Fail ",
 "CH2 Switch Fail ",
 "CH1 RTDA Open   ",
 "CH2 RTDA Open   ",
 "CH1 RTDA Short  ",
 "CH2 RTDA Short  ",
 "CH1 RTDB Open   ",
 "CH2 RTDB Open   ",
 "CH1 RTDB Short  ",
 "CH2 RTDB Short  ",
 "CH1 GFITest Fail",
 "CH2 GFITest Fail",
 "Self Check Fail ",
 "Auto Test Alarm ",

 "Off             ",
 "On              ",
 "None            ",
 "Continuously    ",
 "Disabled        ",


 "1234            ",
 "Enter Password  ",
 "Reset Password? ",
 "Reset Success   ",
 "Wrong Password  ",


 "STORED          ",


 "Comfirm Reset?  ",
 "Reset Complete  ",


 "Heater Temp     ",
 "Heater Status   ",
 "System Status   ",


 "--              ",


 "System Need Cali",
 "Calibrating     ",
 "Finish Calibrate",

 "System Need Test",
 "Testing         ",
 "Finish Testing  ",


 "Channel 1       ",
 "Channel 2       "
};

static code char SPCTitle[6][20] =
{
 "Operating values",
 "Statistics      ",
 "Setpoints       ",
 "Heater setup    ",
 "System setup    ",
 "System test     "
};

static code char PSWTitle[7][20] =
{
 "Change password ",
 "Enter Old Psw   ",
 "Enter New Psw   ",
 "Enter Again     ",
 "Operate success ",
 "Invalid password",
 "Not match       "
};

static code long Chr_str[8] =
 {
 10000000,
 1000000,
 100000,
 10000,
 1000,
 100,
 10,
 1
 };

static code char SPCUnit[14][9] =
{
 "        ",
 "$       ",
 {0x1b, 0x20, 0x20, 0x20, 0x20, 0x20, 0x20, 0x20},
 {0x1a, 0x20, 0x20, 0x20, 0x20, 0x20, 0x20, 0x20},
 "A       ",
 "mA      ",
 "VAC     ",
 "seconds ",
 "hours   ",
 "%       ",
 "V       ",
 "MWh     ",
 "Alarms  ",
 "Logs    "
};

static code char num[10] =
{
 '0','1','2','3','4','5','6','7','8','9'
};

static code char flag_num[16] =
{
 0,1,1,2,2,3,3,3,3,4,4,4,4,4,4,4
};

static code char SpcCharactors[ 63 + 31 ] =
{
 ' ', '0','1','2','3','4','5','6','7','8','9',
 'A','B','C','D','E','F','G','H','I','J','K','L','M','N','O',
 'P','Q','R','S','T','U','V','W','X','Y','Z',
 'a','b','c','d','e','f','g','h','i','j','k','l','m','n','o',
 'p','q','r','s','t','u','v','w','x','y','z',
 0x21, 0x22, 0x23, 0x24, 0x25, 0x26, 0x27, 0x28, 0x29, 0x2a,
 0x2b, 0x2c, 0x2d, 0x2e, 0x2f, 0x3a, 0x3b, 0x3c, 0x3d, 0x3e,
 0x3f, 0x40, 0x5b, 0x5c, 0x5d, 0x5e, 0x5f, 0x60, 0x7b, 0x7c,
 0x7d
};

static code unsigned int ResetCmd[6] =
{
 ( 12  << 8) |  1 ,
 ( 14  << 8) |  2 ,
 ( 20  << 8) |  16 ,
 ( 22  << 8) |  32 ,
 ( 32  << 8) |  4 ,
 ( 34  << 8) |  8 
};


static code char Version_title[17] = "DPC firmware    ";
static code char Version_content[17] = "Version 1.0     ";
static code char Selfcheck_str[17] = "System Check... ";
#line 1 "d:/myproject/spc code1/spc code/function.h"


void CopyTemp(TEMPERATURE *tempsource, TEMPERATURE *temptarget);
void tempaverage(TEMPERATURE *tempsource, TEMPERATURE *temptarget);
void AlarmLedOperation(void);
void alarmoperate(unsigned long alarmcommand, char active);
void CopyStr(char *resource, char *target, char len);
void CopyPSWTitle(char *target, char adder);
int ConvertCtoF(int sourse);
int ConvertFtoC(int sourse);
void ConvertTemp(TEMPERATURE *temptocon);
char StrCompar(char *resoure,char *target);
void Scantime_EN(void);
void Scantime_DIS(void);
void Flashing_EN(void);
void Flashing_DIS(void);
void Flashing(void);
void disp_default(void);
void dispupdate(void);
void alarmdispupdate(void);
void ConvertDead(TEMPERATURE *temptocon);
void SetOntimeStr(ULONG databuff, char strlocat);
void SetCostStr(ULONG databuff, char strlocat);

void SetCurrentStr(int *ptr, char strlocat, char unitlocar, char len);
void SetIntStr(int *ptr, char strlocat, char unitlocar, char len);
void SetTempStatStr(int *temp, char strlocat, char ChannelNum);
void SetHeatStatStr(char Strlocat, char ChannelNum);
void SetAlarmStr(char *prt, char datasouce, char datatotle, char unitype, char len, char cmd);
char GetAlarmEn(void);

void RollCharact(void);

void ResetAutoAutho(void);
char GetAutoAutho(void);
void SetAutoAutho(char AutoAuthoCmd);
void AutoAutho(void);
void ChannelIndicator(char ChannelNum);

extern char ScanTimeEN;
extern char ActualAlarmNum;
extern unsigned char AutoAuthoCount;

extern char RollCharactEN;
extern int RollCharactCount;
extern char RollCharactPointer;
#line 1 "d:/myproject/spc code1/spc code/m0220.h"
void MO22OMD_initial(void);
void nybble(void);
void writecom(unsigned char command);
void writedata(unsigned char adata);
void readcom(void);
void LcdInit(void);
void LcdOut(char num,char *line);
void LCD_output(unsigned char *txt1,unsigned char *txt2);
#line 1 "d:/myproject/spc code1/spc code/rtd.h"
#line 130 "d:/myproject/spc code1/spc code/rtd.h"
void GetTemperature(TEMPERATURE *RTDA_ptr, char ChannelNum);
UINT GetGFI(char ChannelSelect, char cmd);
signed int ConvertADtoCurrent(unsigned int ADcurrent, char ChannelNum);
unsigned int ConvertADtoGFI(unsigned int ADcurrent, char ChannelNum);
long ConvertADtoTEMP(UINT ADtemp, char paraL, char paraH, char ChannelNum );
void CaliTemp(UINT ADtemp, char paraL, char paraH );

extern unsigned int ADSampleA,ADSampleB;
#line 1 "d:/myproject/spc code1/spc code/string_op.h"
void getParaChar(char *ptr, char locat);
void ClearStr(char *target, int len);
void MemeSet(char *target, char Transdata, int len);
#line 1 "d:/myproject/spc code1/spc code/spcinitial.h"
#line 43 "d:/myproject/spc code1/spc code/spcinitial.h"
void SPC_Initial(void);
void QT60Reset(void);
void System_clock_initial(void);
void Timer_initial(void);
void Port_initial(void);
void Spi_initial(void);
void I2C_initial(void);
void Uart_initial(void);
void ADC_initial(void);
void LCD_initial(void);
void selftest(void);
void SelfCheck(void);
void QT60Initial(void);

void GlobalInterrupt_diable(void);
void GlobalInterrupt_enable(void);

extern int KeyResetCount;
extern char KeyResetEN;
#line 1 "d:/myproject/spc code1/spc code/ssr.h"







void RSSoperation(char ChannelNum);
void AlarmSSRoperation(void);
#line 12 "d:/myproject/spc code1/spc code/ssr.h"
void Alarm_SSR_on(char ChannelNum);
void Alarm_SSR_off(char ChannelNum);
char softstart(char ChannelNum);
char shift(unsigned int dduty, char ChannelNum);
char pwm(char ChannelNum);
unsigned int get_duty_table(char index);
void countformeasurement(char ChannelNum);

extern char AlarmForce[2];
extern char SSRStatInMeas[2];
extern char SSRForceOp[2];
#line 1 "d:/myproject/spc code1/spc code/calibration.h"
#line 25 "d:/myproject/spc code1/spc code/calibration.h"
typedef struct tagSPCCALIBRATIONREG
{
 int CalibartionActural;
 int CalibartionSetpoint;
}SPCCALIBRATIONREG;

typedef struct tagSPCCALIBRATIONSTRTCTURE
{
 SPCCALIBRATIONREG GFICalibrationNod1;
 SPCCALIBRATIONREG GFICalibrationNod2;
 SPCCALIBRATIONREG GFICalibrationNod3;
 SPCCALIBRATIONREG GFICalibrationNod4;
 SPCCALIBRATIONREG GFICalibrationNod5;
 SPCCALIBRATIONREG GFICalibrationNod6;
 SPCCALIBRATIONREG CurrentCalibrationNod1;
 SPCCALIBRATIONREG CurrentCalibrationNod2;
 SPCCALIBRATIONREG CurrentCalibrationNod3;
 SPCCALIBRATIONREG CurrentCalibrationNod4;
 SPCCALIBRATIONREG CurrentCalibrationNod5;
 SPCCALIBRATIONREG TempCalibrationNodLowA;
 SPCCALIBRATIONREG TempCalibrationNodHighA;
 SPCCALIBRATIONREG TempCalibrationNodLowB;
 SPCCALIBRATIONREG TempCalibrationNodHighB;
}SPCCALIBRATIONSTRTCTURE;

typedef struct tagSPCCALIBRATIONBOX
{
 char CalibartionType;
 char CalibartionAddress;
 int CalibartionData;
}SPCCALIBRATIONBOX;


void SPCCalibration(void);
void SetCommand(char CommandType, char CommandData);
char GetCommand(char CommandType);
int GetCalibrationData(SPCCALIBRATIONREG *Ptr,char Location, char ActualReq);
void InitialCalibrationReg(void);

extern char CalibrationCount;
extern char SPCCalibrationEN;
extern char SPCTestingEN;

extern SPCCALIBRATIONSTRTCTURE SPCCalibrationStructure[2];
extern SPCCALIBRATIONBOX SPCCalibrationBox;
#line 46 "D:/MyProject/SPC code1/SPC code/Spcsystem.c"
char FirstTempCheck=0;

char PasswordNeed = 0;
char ParametersChanged = 0;
char Usr_Psw_en = 0;
char CtrlTypeCheck[2]={ 0 };
int ShapeForDuty;
int PowerLimitCheck[2]={ 0X7fff };
unsigned char AlarmNumCheck=0;


typedef struct tagCONFILIC
{
 char ParaMenAdress;
 int MaxPara;
 int MinPara;
 char SpecialNum;
}CONFILIC;

code CONFILIC ConflictCheckList[20] = {

 { 0 +1,  500 ,  -50 , 8},

 { 6 +1,  5 ,  1 , 4},

 { 2 +1,  500 ,  -50 , 5},

 { 4 +1,  500 ,  -50 , 6},

 { 8 ,  300 ,  1 , 2},

 { 9 ,  300 ,  1 , 3},

 { 10 ,  500 ,  10 , 2},

 { 11 ,  500 ,  10 , 3},

 { 12 ,  280 ,  85 , 2},

 { 13 ,  280 ,  85 , 3},

 { 14 , 100, 20, 1},

 { 15 ,  999  ,  10 , 1},

 { 16 ,  720 ,  1 , 1},

 { 17 ,  600 ,  5 , 1},

 { 18 ,  100 ,  1 , 0},

 { 19 ,  10 ,  3 , 0},

 { 20 ,  255 ,  1 , 0},

 { 21 , 4, 0, 0},

 { 22 , 24, 1, 7},

 { 23 , 24, 1, 7}


};






void SPCSystemInitialize()
{
 MemeSet((char *)&pSPCValue[0], 0, sizeof(SPCVALUE));
 MemeSet((char *)&pSPCValue[1], 0, sizeof(SPCVALUE));
 MemeSet((char *)&SetP_shade, 0, sizeof(SPCSETPIONTS));
 MemeSet((char *)&spc_count, 0, sizeof(SPCCOUNT));
 MemeSet((char *)&pSPCAlarm, 0, sizeof(SPCALARMBOX));
 MemeSet((char *)&SpcSstart, 0, sizeof(SOFTSTART));
 MemeSet((char *)&SpcAcc[0], 0, sizeof(ACCUMULATE));
 MemeSet((char *)&SpcAcc[1], 0, sizeof(ACCUMULATE));
 MemeSet((char *)&Spcssr[0], 0, sizeof(SPCSSR));
 MemeSet((char *)&Spcssr[1], 0, sizeof(SPCSSR));
 MemeSet((char *)&Spcpwm[0], 0, sizeof(SPCPWM));
 MemeSet((char *)&Spcpwm[1], 0, sizeof(SPCPWM));
 MemeSet((char *)&Volt_acc, 0, sizeof(VALUEACC));
 MemeSet((char *)&Current_acc, 0, sizeof(VALUEACC));
 MemeSet((char *)&SYS_On_time, 0, sizeof(SPCTIME));
 MemeSet((char *)&Heat_On_time[0], 0, sizeof(SPCTIME));
 MemeSet((char *)&Heat_On_time[1], 0, sizeof(SPCTIME));

 ClearStr(Actural_disp_str[0], 38*17);

 pwm_duty[0] = 0;
 duty_index[0] = 0;
 pwm_duty[1] = 0;
 duty_index[1] = 0;

 Spcpwm[0].duty_point = 5;
 Spcpwm[1].duty_point = 5;
 spc_system_flag.word = 0;





 if(SPCIfFirstRun())
 {
 SetSystemToDefault();
 }
 else
 {
 SetSystemFromEEP();
 }

 Spcpwm[0].meas_cmd =  1 ;
 Spcpwm[1].meas_cmd =  1 ;
 Statis_flag[0] = ( 1  +  2  +  4  +  8  +  16  +  32 );
 Statis_flag[1] = ( 1  +  2  +  4  +  8  +  16  +  32 );

 if(pSPCValue[0].SPCSetPoints.system_valueb.bite.man_on)
 SetHeatStatStr( 3 , 0);
 else
 SetHeatStatStr( 0 , 0);

 if(pSPCValue[1].SPCSetPoints.system_valueb.bite.man_on)
 SetHeatStatStr( 3 , 1);
 else
 SetHeatStatStr( 0 , 1);

 SetIntStr((int*)&duty_index[0],  18 ,  9 , 1);
 SetIntStr((int*)&duty_index[0],  24 ,  10+1 , 3);
 SetIntStr((int*)&duty_index[0],  36 ,  8+1 , 1);
 SetIntStr((int*)&duty_index[1],  19 ,  9 , 1);
 SetIntStr((int*)&duty_index[1],  25 ,  10+1 , 3);
 SetIntStr((int*)&duty_index[1],  37 ,  8+1 , 1);
 SetOntimeStr(0,  0 );
 SetOntimeStr(0,  1 );
 SetCostStr(0,  26 );
 SetCostStr(0,  27 );

 SetIntStr((int*)&pSPCAlarm.spcalarms.num_alarms,  28 ,  11+1 , 7);


 SystemUpdate = 0;
 ActivedAlarms = 0;
 ActualAlarmNum = 0;
 forceop_level = 0;
 FirstTempCheck = 1;

 EEPROM_get(0x2f0,1,(char*)(&SPCCalibrationEN));
 EEPROM_get(0x2f1,1,(char*)(&SPCTestingEN));
 SPCCalibrationBox.CalibartionType = 25;

 LATC2_bit = 0;
 LATC5_bit = 0;
 KeyEn = 1;

 if(pSPCValue[0].SPCSetPoints.system_valueb.bite.gfi_test_mod ==  1 )
 {
 pSPCValue[0].SPCSetPoints.system_valueb.bite.gfi_test_mod =  2 ;
 }

 if(pSPCValue[1].SPCSetPoints.system_valueb.bite.gfi_test_mod ==  1 )
 {
 pSPCValue[1].SPCSetPoints.system_valueb.bite.gfi_test_mod =  2 ;
 }
}






UCHAR MainTainTempDisable(char ChannelNum)
{
 if(pSPCValue[ChannelNum].SPCSetPoints.MaintainTemp.Temperature_C ==  0X7ffe )
 return 1;
 else if(pSPCValue[ChannelNum].SPCSetPoints.MaintainTemp.Temperature_C ==  0X7fff )
 return 2;
 else
 return 0;
}






UCHAR ProCtlEnable(char ChannelNum)
{
 if(pSPCValue[ChannelNum].SPCSetPoints.system_valueb.bite.ctl_type ==  0 )
 return 0;
 else
 return 1;
}






UCHAR SelfRegulaEnable(char ChannelNum)
{
 if(pSPCValue[ChannelNum].SPCSetPoints.system_valueb.bite.heater_type ==  0 )
 return 0;
 else
 return 1;
}






void SetSystemToDefault()
{
 char i;

 for(i=0;i<2;i++)
 {
 pSPCValue[i].SPCSetPoints.MaintainTemp.Temperature_C =  10 ;
 pSPCValue[i].SPCSetPoints.MaintainTemp.Temperature_F =  50 ;
 pSPCValue[i].SPCSetPoints.LowTemp.Temperature_C =  5 ;
 pSPCValue[i].SPCSetPoints.LowTemp.Temperature_F =  41 ;
 pSPCValue[i].SPCSetPoints.HighTemp.Temperature_C =  0X7fff ;
 pSPCValue[i].SPCSetPoints.HighTemp.Temperature_F =  0X7fff ;
 pSPCValue[i].SPCSetPoints.DeadBand.Temperature_C =  2 ;
 pSPCValue[i].SPCSetPoints.DeadBand.Temperature_F =  5 ;

 pSPCValue[i].SPCSetPoints.LowCurrent =  0X7fff ;
 pSPCValue[i].SPCSetPoints.HighCurrent =  0X7fff ;
 pSPCValue[i].SPCSetPoints.GFIAlarm =  30 ;
 pSPCValue[i].SPCSetPoints.GFITrip =  50 ;

 pSPCValue[i].SPCSetPoints.LowVoltage =  0X7fff ;
 pSPCValue[i].SPCSetPoints.HighVoltage =  0X7fff ;

 pSPCValue[i].SPCSetPoints.LimitedCurrent =  0X7fff ;
 pSPCValue[i].SPCSetPoints.SoftStartTime =  0X7fff ;

 pSPCValue[i].SPCSetPoints.AutoTestTime =  24 ;

 pSPCValue[i].SPCSetPoints.DisplayTime =  120 ;
 pSPCValue[i].SPCSetPoints.CostPerKWH =  5 ;
 pSPCValue[i].SPCSetPoints.ScanSpeed =  3 ;
 pSPCValue[i].SPCSetPoints.ModbusAdd =  1 ;
 pSPCValue[i].SPCSetPoints.BaudRate =  3 ;

 pSPCValue[i].SPCSetPoints.AlarmOutTest =  0X7ffc ;
 pSPCValue[i].SPCSetPoints.HeaterTest =  0X7ffc ;
 pSPCValue[i].SPCSetPoints.GFTest =  2 ;

 ClearStr(pSPCValue[i].SPCSetPoints.HeaterName, 16);



 pSPCValue[i].SPCSetPoints.system_valueb.bite.heater_en =  1 ;
 pSPCValue[i].SPCSetPoints.system_valueb.bite.man_on =  0 ;
 pSPCValue[i].SPCSetPoints.system_valueb.bite.ctl_type =  0 ;
 pSPCValue[i].SPCSetPoints.system_valueb.bite.rtd_opr =  0 ;
 pSPCValue[i].SPCSetPoints.system_valueb.bite.rtd_fail_mod =  0 ;

 pSPCValue[i].SPCSetPoints.system_valueb.bite.spc_units_c =  1 ;
 pSPCValue[i].SPCSetPoints.system_valueb.bite.usr_advanced =  1 ;


 pSPCValue[i].SPCSetPoints.system_valueb.bite.def_display =  1 ;
 pSPCValue[i].SPCSetPoints.system_valueb.bite.gfi_test_mod =  2 ;
 pSPCValue[i].SPCSetPoints.system_valueb.bite.heater_type = 1;
 pSPCValue[i].SPCSetPoints.system_valueb.bite.baud =  3 ;


 Statis_flag[i] = ( 1  +  2  +  4  +  8  +  16  +  32 );
 }
 ClearStr(pSPCValue[0].SPCSetPoints.Password, 16);
 getParaChar(pSPCValue[0].SPCSetPoints.Password,  78 );
 pSPCValue[0].SPCSetPoints.system_valueb.bite.password_en = 1;

 EEPROM_set(0x01,sizeof(SPCSETPIONTS),(UCHAR*)(&pSPCValue[0].SPCSetPoints));
 EEPROM_set(0x01+sizeof(SPCSETPIONTS),sizeof(SPCSETPIONTS),(UCHAR*)(&pSPCValue[1].SPCSetPoints));

 EEPROM_set(0x01+2*sizeof(SPCSETPIONTS),sizeof(STATISTICS),(UCHAR*)(&pSPCValue[0].SPCStatistics));
 EEPROM_set(0x01+2*sizeof(SPCSETPIONTS)+sizeof(STATISTICS),sizeof(STATISTICS),(UCHAR*)(&pSPCValue[1].SPCStatistics));
 EEPROM_set(0x01+2*sizeof(SPCSETPIONTS)+2*sizeof(STATISTICS),sizeof(SPCLOG),(UCHAR*)(&pSPCAlarm.spclogs));
}






void SetSystemFromEEP()
{
 char units;
 signed int *temp_ptr;

 EEPROM_get(0x01,sizeof(SPCSETPIONTS),(UCHAR*)(&pSPCValue[0].SPCSetPoints));
 EEPROM_get(0x01+sizeof(SPCSETPIONTS),sizeof(SPCSETPIONTS),(UCHAR*)(&pSPCValue[1].SPCSetPoints));

 EEPROM_get(0x01+2*sizeof(SPCSETPIONTS),sizeof(STATISTICS),(UCHAR*)(&pSPCValue[0].SPCStatistics));
 EEPROM_get(0x01+2*sizeof(SPCSETPIONTS)+sizeof(STATISTICS),sizeof(STATISTICS),(UCHAR*)(&pSPCValue[1].SPCStatistics));
 EEPROM_get(0x01+2*sizeof(SPCSETPIONTS)+2*sizeof(STATISTICS),sizeof(SPCLOG),(UCHAR*)(&pSPCAlarm.spclogs));


 units = pSPCValue[0].SPCSetPoints.system_valueb.bite.spc_units_c;
 temp_ptr = (signed int *)(&pSPCValue[Cable_Channel].SPCStatistics.MaximumTemp) + units;
 SetTempStatStr(temp_ptr,  12 , Cable_Channel);
 temp_ptr = (signed int *)(&pSPCValue[Cable_Channel].SPCStatistics.MinimumTemp) + units;
 SetTempStatStr(temp_ptr, 14 , Cable_Channel);
 SetIntStr((int*)&pSPCValue[Cable_Channel].SPCStatistics.MaximumGFCurrent,  22 +Cable_Channel,  4+1 , 2);
 SetCurrentStr((int*)&pSPCValue[Cable_Channel].SPCStatistics.MaximumCurrent,  20 +Cable_Channel,  4 , 1);
 SetIntStr((int*)&pSPCValue[Cable_Channel].SPCStatistics.MaximumVoltage,  32 +Cable_Channel,  5+1 , 1);
 SetIntStr((int*)&pSPCValue[Cable_Channel].SPCStatistics.MinimumVoltage,  34 +Cable_Channel,  5+1 , 1);
}






void TitleSet(UCHAR direct, UCHAR cmd)
{
 UCHAR i;

 for(i=0;i<16;i++)
 Info_Line2[i] = SPCTitle[SpcMenu[Menustat].offset][i];
 asm nop;
}






void ChannelConfig(UCHAR direct, UCHAR cmd)
{
 static char ChannelConfigMirror;

 if(cmd ==  1 )
 {



 Cable_Channel = ChannelConfigMirror;
 storage();
 ParametersChanged = 1;
 }
 else if(cmd ==  2 )
 {
 getParaChar(Info_Line2,  96 +Cable_Channel);
 ChannelConfigMirror = Cable_Channel;
 }
 else if(cmd ==  4 )
 {



 if(direct)
 {
 if(ChannelConfigMirror == 0)
 {
 ChannelConfigMirror = 1;
 getParaChar(Info_Line2,  96 +ChannelConfigMirror);
 }
 }
 else
 {
 if(ChannelConfigMirror == 1)
 {
 ChannelConfigMirror = 0;
 getParaChar(Info_Line2,  96 +ChannelConfigMirror);
 }
 }
 }
}






void MaintainTempSet(UCHAR direct, UCHAR cmd)
{
 int maxtemp,mintemp,units;
 int *ptr;

 units = pSPCValue[0].SPCSetPoints.system_valueb.bite.spc_units_c;
 ptr = (int *)(&SetP_shade.MaintainTemp);

 if(units)
 {
 maxtemp =  500 ;
 mintemp =  -50 ;
 }
 else
 {
 maxtemp =  932 ;
 mintemp =  -58 ;
 }

 if(cmd ==  1 )
 {
 if(pSPCValue[0].SPCSetPoints.system_valueb.bite.password_en==0)
 return;

 if((SetP_shade.MaintainTemp.Temperature_C !=  0X7fff ) &&
 (SetP_shade.MaintainTemp.Temperature_C !=  0X7ffe ))
 ConvertTemp(&SetP_shade.MaintainTemp);

 CopyTemp(&SetP_shade.MaintainTemp, &pSPCValue[Cable_Channel].SPCSetPoints.MaintainTemp);
 storage();
 ParametersChanged = 1;
 }
 else if(cmd ==  2 )
 {
 CopyTemp(&pSPCValue[Cable_Channel].SPCSetPoints.MaintainTemp, &SetP_shade.MaintainTemp);
 if(SetP_shade.MaintainTemp.Temperature_C ==  0X7fff )
 getParaChar(Info_Line2,  73 );
 else if(SetP_shade.MaintainTemp.Temperature_C ==  0X7ffe )
 getParaChar(Info_Line2,  75 );
 else
 FromIntToStr(*(ptr+units),Info_Line2,SpcMenu[Menustat].decimal);
 }
 else if(cmd ==  4 )
 {
 if(pSPCValue[0].SPCSetPoints.system_valueb.bite.password_en==0)
 return;

 Flashing_EN();
 if(direct)
 {
 if(*(ptr+units) ==  0X7ffe )
 {
 SetP_shade.MaintainTemp.Temperature_C =  0X7fff ;
 SetP_shade.MaintainTemp.Temperature_F =  0X7fff ;
 getParaChar(Info_Line2,  73 );
 }
 else if(*(ptr+units) == maxtemp)
 {
 SetP_shade.MaintainTemp.Temperature_C =  0X7ffe ;
 SetP_shade.MaintainTemp.Temperature_F =  0X7ffe ;
 getParaChar(Info_Line2,  75 );
 }
 else if(*(ptr+units) < maxtemp)
 {
 (*(ptr+units)) += KeyHoldStep;
 if(*(ptr+units) > maxtemp) *(ptr+units) = maxtemp;
 FromIntToStr(*(ptr+units),Info_Line2,SpcMenu[Menustat].decimal);
 }
 }
 else
 {
 if(*(ptr+units) ==  0X7fff )
 {
 SetP_shade.MaintainTemp.Temperature_C =  0X7ffe ;
 SetP_shade.MaintainTemp.Temperature_F =  0X7ffe ;
 getParaChar(Info_Line2,  75 );
 }
 else if(*(ptr+units) ==  0X7ffe )
 {
 *(ptr+units) = maxtemp;
 ConvertTemp(&SetP_shade.MaintainTemp);
 FromIntToStr(*(ptr+units),Info_Line2,SpcMenu[Menustat].decimal);
 }
 else if(*(ptr+units) > mintemp)
 {
 (*(ptr+units)) -= KeyHoldStep;
 if(*(ptr+units) < mintemp) *(ptr+units) = mintemp;
 FromIntToStr(*(ptr+units),Info_Line2,SpcMenu[Menustat].decimal);
 }
 }
 }
 Info_Line2[14] = 'P';
 Info_Line2[15] = Cable_Channel+0X31;
}






void DeadbandSet(UCHAR direct, UCHAR cmd)
{
 int maxtemp,mintemp,units;
 int *ptr;

 units = pSPCValue[0].SPCSetPoints.system_valueb.bite.spc_units_c;
 ptr = (int *)(&SetP_shade.DeadBand);
 if(units)
 {
 maxtemp =  5 ;
 mintemp =  1 ;
 }
 else
 {
 maxtemp =  10 ;
 mintemp =  1 ;
 }

 if(cmd ==  1 )
 {
 if(pSPCValue[0].SPCSetPoints.system_valueb.bite.password_en==0)
 return;

 ConvertDead(&SetP_shade.DeadBand);
 CopyTemp(&SetP_shade.DeadBand, &pSPCValue[Cable_Channel].SPCSetPoints.DeadBand);
 storage();
 ParametersChanged = 1;
 }
 else if(cmd ==  2 )
 {
 CopyTemp(&pSPCValue[Cable_Channel].SPCSetPoints.DeadBand, &SetP_shade.DeadBand);
 FromIntToStr(*(ptr+units),Info_Line2,SpcMenu[Menustat].decimal);
 }
 else if(cmd ==  4 )
 {
 if(pSPCValue[0].SPCSetPoints.system_valueb.bite.password_en==0)
 return;

 Flashing_EN();
 if((*(ptr+units) <= maxtemp) && (*(ptr+units) >= mintemp))
 {
 if(direct)
 {
 (*(ptr+units)) += KeyHoldStep;
 if(*(ptr+units) > maxtemp) *(ptr+units) = maxtemp;
 }
 else
 {
 (*(ptr+units)) -= KeyHoldStep;
 if(*(ptr+units) < mintemp) *(ptr+units) = mintemp;
 }

 FromIntToStr(*(ptr+units),Info_Line2,SpcMenu[Menustat].decimal);
 }
 }
 Info_Line2[14] = 'P';
 Info_Line2[15] = Cable_Channel+0X31;
}






void LowTempAlarmSet(UCHAR direct, UCHAR cmd)
{
 int maxtemp,mintemp,units;
 int *Mtemp, *Dtemp, *ptr, *Ltemp;
 volatile signed int temp;

 units = pSPCValue[0].SPCSetPoints.system_valueb.bite.spc_units_c;
 Ltemp = (int *)(&pSPCValue[Cable_Channel].SPCSetPoints.LowTemp);
 Mtemp = (&pSPCValue[Cable_Channel].SPCSetPoints.MaintainTemp.Temperature_F);
 Dtemp = (&pSPCValue[Cable_Channel].SPCSetPoints.DeadBand.Temperature_F);
 ptr = (&SetP_shade.LowTemp.Temperature_F);

 temp = *(Ltemp+units);

 if((pSPCValue[Cable_Channel].SPCSetPoints.MaintainTemp.Temperature_C ==  0X7fff ) ||
 (pSPCValue[Cable_Channel].SPCSetPoints.MaintainTemp.Temperature_C ==  0X7ffe ))
 {
 if(pSPCValue[Cable_Channel].SPCSetPoints.HighTemp.Temperature_C ==  0X7fff )
 {
 if(units)
 maxtemp =  500 -1;
 else
 maxtemp =  932 -1;
 }
 else
 {
 if(units)
 maxtemp = pSPCValue[Cable_Channel].SPCSetPoints.HighTemp.Temperature_C-1;
 else
 maxtemp = pSPCValue[Cable_Channel].SPCSetPoints.HighTemp.Temperature_F-1;
 }
 }
 else
 {
 if(ProCtlEnable(Cable_Channel))
 maxtemp = *(Mtemp+units);
 else
 maxtemp = *(Mtemp+units) - *(Dtemp+units);
 }

 if(units)
 mintemp =  -50 ;
 else
 mintemp =  -58 ;

 if(cmd ==  1 )
 {
 if(pSPCValue[0].SPCSetPoints.system_valueb.bite.password_en==0)
 return;
 if(pSPCValue[Cable_Channel].SPCSetPoints.MaintainTemp.Temperature_C ==  0X7ffe )
 return;

 if(SetP_shade.LowTemp.Temperature_C !=  0X7fff )
 ConvertTemp(&SetP_shade.LowTemp);
 CopyTemp(&SetP_shade.LowTemp, &pSPCValue[Cable_Channel].SPCSetPoints.LowTemp);
 storage();
 ParametersChanged = 1;
 }
 else if(cmd ==  2 )
 {
 if(pSPCValue[Cable_Channel].SPCSetPoints.MaintainTemp.Temperature_C ==  0X7ffe )
 {
 getParaChar(Info_Line2,  89 );
 return;
 }

 CopyTemp(&pSPCValue[Cable_Channel].SPCSetPoints.LowTemp, &SetP_shade.LowTemp);
 if(SetP_shade.LowTemp.Temperature_C ==  0X7fff )
 getParaChar(Info_Line2,  73 );
 else
 FromIntToStr(*(ptr+units),Info_Line2,SpcMenu[Menustat].decimal);
 }
 else if(cmd ==  4 )
 {
 if(pSPCValue[0].SPCSetPoints.system_valueb.bite.password_en==0)
 return;
 if(pSPCValue[Cable_Channel].SPCSetPoints.MaintainTemp.Temperature_C ==  0X7ffe )
 return;

 Flashing_EN();
 if(direct)
 {
 if(*(ptr+units) == maxtemp-1)
 {
 SetP_shade.LowTemp.Temperature_C =  0X7fff ;
 SetP_shade.LowTemp.Temperature_F =  0X7fff ;
 getParaChar(Info_Line2,  73 );
 }
 else if(*(ptr+units) < maxtemp-1)
 {
 (*(ptr+units)) += KeyHoldStep;
 if(*(ptr+units) > maxtemp-1) *(ptr+units) = maxtemp-1;
 FromIntToStr(*(ptr+units),Info_Line2,SpcMenu[Menustat].decimal);
 }
 else
 {
 if(SetP_shade.LowTemp.Temperature_C !=  0X7fff )
 *(ptr+units) = maxtemp-1;
 ConvertTemp(&SetP_shade.LowTemp);
 }

 }
 else
 {
 if(*(ptr+units) ==  0X7fff )
 {
 *(ptr+units) = maxtemp-1;
 ConvertTemp(&SetP_shade.LowTemp);
 if(*(ptr+units) < mintemp) *(ptr+units) = mintemp;
 }
 else if(*(ptr+units) > mintemp)
 {
 (*(ptr+units)) -= KeyHoldStep;
 if(*(ptr+units) < mintemp) *(ptr+units) = mintemp;
 }
 else if(*(ptr+units) < mintemp)
 *(ptr+units) = mintemp;

 FromIntToStr(*(ptr+units),Info_Line2,SpcMenu[Menustat].decimal);
 }
 }
 Info_Line2[14] = 'P';
 Info_Line2[15] = Cable_Channel+0X31;
}






void HighTempAlarmSet(UCHAR direct, UCHAR cmd)
{
 int maxtemp,mintemp,units;
 int *Mtemp, *Dtemp, *ptr, *Htemp;
 volatile signed int temp;

 units = pSPCValue[0].SPCSetPoints.system_valueb.bite.spc_units_c;
 Htemp = (int *)(&pSPCValue[Cable_Channel].SPCSetPoints.HighTemp);
 Mtemp = (int *)(&pSPCValue[Cable_Channel].SPCSetPoints.MaintainTemp);
 Dtemp = (int *)(&pSPCValue[Cable_Channel].SPCSetPoints.DeadBand);
 ptr = (int *)(&SetP_shade.HighTemp);

 temp = *(Htemp+units);

 if((pSPCValue[Cable_Channel].SPCSetPoints.MaintainTemp.Temperature_C ==  0X7fff ) ||
 (pSPCValue[Cable_Channel].SPCSetPoints.MaintainTemp.Temperature_C ==  0X7ffe ))
 {
 if(pSPCValue[Cable_Channel].SPCSetPoints.LowTemp.Temperature_C ==  0X7fff )
 {
 if(units)
 mintemp =  -50 +1;
 else
 mintemp =  -58 +1;
 }
 else
 {
 if(units)
 mintemp = pSPCValue[Cable_Channel].SPCSetPoints.LowTemp.Temperature_C+1;
 else
 mintemp = pSPCValue[Cable_Channel].SPCSetPoints.LowTemp.Temperature_F+1;
 }
 }
 else
 {
 if(ProCtlEnable(Cable_Channel))
 mintemp = *(Mtemp+units);
 else
 mintemp = *(Mtemp+units) + *(Dtemp+units);
 }

 if(units)
 maxtemp =  500 ;
 else
 maxtemp =  932 ;

 if(cmd ==  1 )
 {
 if(pSPCValue[0].SPCSetPoints.system_valueb.bite.password_en==0)
 return;
 if(pSPCValue[Cable_Channel].SPCSetPoints.MaintainTemp.Temperature_C ==  0X7ffe )
 return;

 if(SetP_shade.HighTemp.Temperature_C !=  0X7fff )
 ConvertTemp(&SetP_shade.HighTemp);
 CopyTemp(&SetP_shade.HighTemp, &pSPCValue[Cable_Channel].SPCSetPoints.HighTemp);
 storage();
 ParametersChanged = 1;
 }
 else if(cmd ==  2 )
 {
 if(pSPCValue[Cable_Channel].SPCSetPoints.MaintainTemp.Temperature_C ==  0X7ffe )
 {
 getParaChar(Info_Line2,  89 );
 return;
 }

 CopyTemp(&pSPCValue[Cable_Channel].SPCSetPoints.HighTemp, &SetP_shade.HighTemp);
 if(SetP_shade.HighTemp.Temperature_C ==  0X7fff )
 getParaChar(Info_Line2,  73 );
 else
 FromIntToStr(*(ptr+units),Info_Line2,SpcMenu[Menustat].decimal);
 }
 else if(cmd ==  4 )
 {
 if(pSPCValue[0].SPCSetPoints.system_valueb.bite.password_en==0)
 return;
 if(pSPCValue[Cable_Channel].SPCSetPoints.MaintainTemp.Temperature_C ==  0X7ffe )
 return;

 Flashing_EN();
 if(direct)
 {
 if(*(ptr+units) == maxtemp)
 {
 SetP_shade.HighTemp.Temperature_C =  0X7fff ;
 SetP_shade.HighTemp.Temperature_F =  0X7fff ;
 getParaChar(Info_Line2,  73 );
 }
 else if(*(ptr+units) < maxtemp)
 {
 (*(ptr+units)) += KeyHoldStep;
 if(*(ptr+units) > maxtemp) *(ptr+units) = maxtemp;
 FromIntToStr(*(ptr+units),Info_Line2,SpcMenu[Menustat].decimal);
 }
 }
 else
 {
 if(*(ptr+units) ==  0X7fff )
 {
 *(ptr+units) = maxtemp;
 ConvertTemp(&SetP_shade.HighTemp);
 }
 else if(*(ptr+units) > mintemp+1)
 {
 (*(ptr+units)) -= KeyHoldStep;
 if(*(ptr+units) < mintemp+1) *(ptr+units) = mintemp+1;
 }
 FromIntToStr(*(ptr+units),Info_Line2,SpcMenu[Menustat].decimal);
 }
 }
 Info_Line2[14] = 'P';
 Info_Line2[15] = Cable_Channel+0X31;
}






void HeaterIDSet(UCHAR direct, UCHAR cmd)
{
 if(cmd ==  1 )
 {
 if(pSPCValue[0].SPCSetPoints.system_valueb.bite.password_en==0)
 return;

 if(SetP_shade.CharacNum >= 15)
 {
 CopyStr(SetP_shade.HeaterName, pSPCValue[Cable_Channel].SPCSetPoints.HeaterName, 16);
 SetP_shade.CharacNum = 0;
 SetP_shade.StringNum = getStringNum();
 spc_system_flag.bite.char_flash = 0;
 Lcd_Cmd(_LCD_CURSOR_OFF);
 storage();
 Savedata( 50 +Cable_Channel*sizeof(SPCSETPIONTS),
 16,
 (UCHAR *)(&pSPCValue[Cable_Channel].SPCSetPoints.HeaterName),
 0);
 }
 else
 {
 SetP_shade.CharacNum++;
 SetP_shade.StringNum = getStringNum();
 spc_system_flag.bite.char_flash = 1;

 char_flash_loca++;
 }
 }
 else if(cmd ==  2 )
 {

 CopyStr(pSPCValue[Cable_Channel].SPCSetPoints.HeaterName, SetP_shade.HeaterName, 16);
 CopyStr(SetP_shade.HeaterName, Info_Line2, 16);
 SetP_shade.CharacNum = 0;
 SetP_shade.StringNum = getStringNum();

 if(pSPCValue[0].SPCSetPoints.system_valueb.bite.password_en)
 {
 spc_system_flag.bite.char_flash = 1;
 char_flash_loca = 1;
 }
 }
 else if(cmd ==  4 )
 {
 if(pSPCValue[0].SPCSetPoints.system_valueb.bite.password_en==0)
 return;

 if((direct == 1) && (SetP_shade.StringNum <  63 + 31 ))
 SetP_shade.HeaterName[SetP_shade.CharacNum] = SpcCharactors[++SetP_shade.StringNum];
 else if((direct == 0) && (SetP_shade.StringNum > 0))
 SetP_shade.HeaterName[SetP_shade.CharacNum] = SpcCharactors[--SetP_shade.StringNum];

 Info_Line2[SetP_shade.CharacNum] = SetP_shade.HeaterName[SetP_shade.CharacNum];
 spc_system_flag.bite.char_flash = 1;
 }

 Info_Line2[14] = 'P';
 Info_Line2[15] = Cable_Channel+0X31;
}






void PasswordEidtorSet(UCHAR direct, UCHAR cmd)
{
 static char SetPSWReq = 0,SetPSWVal = 0;

 if(cmd ==  1 )
 {
 if(pSPCValue[0].SPCSetPoints.system_valueb.bite.password_en==0)
 return;

 if(SetPSWVal)
 {
 if(SetPSWReq ==  0 )
 {
 SetP_shade.CharacNum = 0;
 SetP_shade.StringNum = 0;
 SetPSWReq =  1 ;
 CopyPSWTitle(Info_Line1, SetPSWReq);
 spc_system_flag.bite.char_actived = 1;
 spc_system_flag.bite.char_flash = 1;
 char_flash_loca = 1;
 }
 else if(SetPSWReq ==  1 )
 {
 if(StrCompar(SetP_shade.Password, pSPCValue[0].SPCSetPoints.Password))
 {
 SetP_shade.CharacNum = 0;
 SetP_shade.StringNum = 0;
 SetPSWReq =  2 ;
 CopyPSWTitle(Info_Line1, SetPSWReq);
 spc_system_flag.bite.char_flash = 1;
 char_flash_loca = 1;
 }
 else
 {
 CopyPSWTitle(Info_Line1,  5 );
 SetPSWReq =  0 ;
 SetPSWVal = 0;
 spc_system_flag.bite.char_actived = 0;
 LCDext = 1;
 spc_system_flag.bite.char_flash = 0;
 Lcd_Cmd(_LCD_CURSOR_OFF);
 }
 }
 else if(SetPSWReq ==  2 )
 {
 if(SetP_shade.CharacNum < 3)
 {
 CopyPSWTitle(Info_Line1,  5 );
 SetPSWReq =  0 ;
 SetPSWVal = 0;
 spc_system_flag.bite.char_actived = 0;
 LCDext = 1;
 spc_system_flag.bite.char_flash = 0;
 Lcd_Cmd(_LCD_CURSOR_OFF);
 }
 else
 {
 SetP_shade.CharacNum = 0;
 SetP_shade.StringNum = 0;
 SetPSWReq =  3 ;
 CopyStr(SetP_shade.Password, Passwordbuff, 16);
 CopyPSWTitle(Info_Line1, SetPSWReq);
 spc_system_flag.bite.char_flash = 1;
 char_flash_loca = 1;
 }
 }
 else if(SetPSWReq ==  3 )
 {
 if(StrCompar(Passwordbuff, SetP_shade.Password))
 {
 SetPSWReq =  4 ;
 CopyStr(SetP_shade.Password, pSPCValue[0].SPCSetPoints.Password, 16);
 Savedata( 66 ,
 16,
 (UCHAR *)(&pSPCValue[0].SPCSetPoints.Password),
 0);
 }
 else
 SetPSWReq =  6 ;

 CopyPSWTitle(Info_Line1, SetPSWReq);
 SetPSWReq =  0 ;
 SetPSWVal = 0;
 LCDext = 1;
 spc_system_flag.bite.char_flash = 0;
 spc_system_flag.bite.char_actived = 0;
 Lcd_Cmd(_LCD_CURSOR_OFF);
 }
 ClearStr(Info_Line2, 16);
 ClearStr(SetP_shade.Password, 16);
 }
 else
 return;
 }
 else if(cmd ==  2 )
 {
 SetPSWReq =  0 ;
 SetPSWVal = 0;
 spc_system_flag.bite.char_actived = 0;
 CopyPSWTitle(Info_Line1, SetPSWReq);
 getParaChar(Info_Line2,  4 );
 CopyStr(Info_Line1, Info_Line1_shape, 16);
 CopyStr(Info_Line2, Info_Line2_shape, 16);
 ClearStr(SetP_shade.Password, 16);
 spc_system_flag.bite.char_flash = 0;
 Lcd_Cmd(_LCD_CURSOR_OFF);
 }
 else if(cmd ==  3 )
 {
 if(pSPCValue[0].SPCSetPoints.system_valueb.bite.password_en==0)
 return;

 CopyPSWTitle(Info_Line1, SetPSWReq);
 if(Info_Line2[SetP_shade.CharacNum] != ' ')
 {
 Info_Line2[SetP_shade.CharacNum] = '*';
 if((direct == 1) && (SetP_shade.CharacNum < 16) &&
 (SetP_shade.Password[SetP_shade.CharacNum] != ' '))
 SetP_shade.CharacNum++;
 SetP_shade.StringNum = 0;
 spc_system_flag.bite.char_flash = 1;
 char_flash_loca = SetP_shade.CharacNum+1;
 }
 }
 else if(cmd ==  4 )
 {
 if(pSPCValue[0].SPCSetPoints.system_valueb.bite.password_en==0)
 return;

 if(SetPSWReq ==  0 )
 {
 SetPSWVal ^= 1;
 if(SetPSWVal)
 getParaChar(Info_Line2,  5 );
 else
 getParaChar(Info_Line2,  4 );
 }
 else
 {
 CopyPSWTitle(Info_Line1, SetPSWReq);
 if((direct == 1) && (SetP_shade.StringNum <  63 ))
 SetP_shade.Password[SetP_shade.CharacNum] = SpcCharactors[++SetP_shade.StringNum];
 else if((direct == 0) && (SetP_shade.StringNum > 0))
 SetP_shade.Password[SetP_shade.CharacNum] = SpcCharactors[--SetP_shade.StringNum];

 Info_Line2[SetP_shade.CharacNum] = SetP_shade.Password[SetP_shade.CharacNum];
 spc_system_flag.bite.char_flash = 1;
 }
 }
}






void ResetSPCSet(UCHAR direct, UCHAR cmd)
{
 static char ResetStatisticsReq = 0,ResetStatisticsVal = 0;
 char i;

 if(cmd ==  1 )
 {
 if(pSPCValue[0].SPCSetPoints.system_valueb.bite.password_en==0)
 return;

 if(ResetStatisticsVal == 1)
 {
 ResetStatisticsVal = 0;
 if(ResetStatisticsReq == 0)
 {

 getParaChar(Info_Line1,  84 );
 getParaChar(Info_Line2,  4 );
 ResetStatisticsReq++;
 }
 else
 {
 ResetStatisticsReq = 0;
 if(SpcMenu[Menustat].func_mark ==  5 )
 {
 MemeSet((char *)&pSPCValue[0].SPCStatistics, 0, sizeof(STATISTICS));
 MemeSet((char *)&pSPCValue[1].SPCStatistics, 0, sizeof(STATISTICS));
 for(i=10; i<20;i++)
 ClearStr(Actural_disp_str[i], 16);
 Statis_flag[0] = ( 1  +  2  +  4  +  8  +  16  +  32 );
 Statis_flag[1] = ( 1  +  2  +  4  +  8  +  16  +  32 );
 SetIntStr((int*)&pSPCValue[0].SPCStatistics.EnergyUsed,  24 ,  10+1 , 3);
 SetIntStr((int*)&pSPCValue[1].SPCStatistics.EnergyUsed,  24 ,  10+1 , 3);
 SetIntStr((int*)&pSPCValue[0].SPCStatistics.HeaterOnTime,  24 ,  10+1 , 3);
 SetIntStr((int*)&pSPCValue[1].SPCStatistics.HeaterOnTime,  24 ,  10+1 , 3);
 SetCostStr(0,  26 );
 SetOntimeStr(0,  0 );
 SetCostStr(0,  27 );
 SetOntimeStr(0,  1 );
 SetIntStr((int*)&pSPCAlarm.spcalarms.num_alarms,  28 ,  11+1 , 7);
 }
 else if(SpcMenu[Menustat].func_mark ==  7 )
 {
 EEPROM_Write(0x00,0x00);
 SPCSystemInitialize();
 }
 getParaChar(Info_Line1,  85 );
 ClearStr(Info_Line2, 16);
 LCDext = 1;
 reset_psw_en = 0;
 }
 }
 else
 {
 ResetStatisticsReq = 0;
 ResetStatisticsVal = 0;
 CopyStr(Info_Line1_shape, Info_Line1, 16);
 CopyStr(Info_Line2_shape, Info_Line2, 16);
 }
 }
 else if(cmd ==  2 )
 {
 ResetStatisticsReq = 0;
 ResetStatisticsVal = 0;
 for(i=0; i<16; i++)
 Info_Line1[i] = SpcTxtLine1[Menustat][i];
 getParaChar(Info_Line2,  4 );
 CopyStr(Info_Line1, Info_Line1_shape, 16);
 CopyStr(Info_Line2, Info_Line2_shape, 16);
 }
 else if(cmd ==  4 )
 {
 if(pSPCValue[0].SPCSetPoints.system_valueb.bite.password_en==0)
 return;

 if(direct)
 {
 if(ResetStatisticsVal == 0) ResetStatisticsVal = 1;
 }
 else
 {
 if(ResetStatisticsVal) ResetStatisticsVal = 0;
 }

 if(ResetStatisticsReq == 1)
 getParaChar(Info_Line1,  84 );


 if(ResetStatisticsVal)
 getParaChar(Info_Line2,  5 );
 else
 getParaChar(Info_Line2,  4 );
 }
}






void Savedata(UINT flash_lacl, UINT len, UCHAR *ptr, char cmd)
{
 UINT add;
 UCHAR *prt_op;

 prt_op = ptr;

 if(cmd)
 add = 0x0001 + sizeof(SPCSETPIONTS);
 else
 add = 0x0001 + flash_lacl;

 EEPROM_set(add, len, prt_op);
}






void Para_Flag_Set(UCHAR direct, UCHAR cmd)
{
 volatile char address = 0;
 char ChannelTemp;
 char IndicatorEN=0;

 address = SpcMenu[Menustat].add;
 switch(SpcMenu[Menustat].offset)
 {
 case  8 :
 case  10 :
 case  9 :
 case  12 :
 case  0 :
 ChannelTemp = 0;
 break;
 default:
 ChannelTemp = Cable_Channel;
 IndicatorEN = 1;
 break;
 }



 if(cmd ==  1 )
 {
 if(pSPCValue[0].SPCSetPoints.system_valueb.bite.password_en==0)
 return;

 pSPCValue[ChannelTemp].SPCSetPoints.system_valueb.word &=
 ~(((0xffffffff << flag_num[SpcMenu[Menustat].len]) ^ 0xffffffff) << SpcMenu[Menustat].offset);
 pSPCValue[ChannelTemp].SPCSetPoints.system_valueb.word |= ((ULONG)SetP_shade1.chare << SpcMenu[Menustat].offset);

 storage();
 ParametersChanged = 1;
 }
 else if(cmd ==  2 )
 {
 SetP_shade1.chare = (pSPCValue[ChannelTemp].SPCSetPoints.system_valueb.word >>
 SpcMenu[Menustat].offset) &
 ((0xffffffff << flag_num[SpcMenu[Menustat].len]) ^ 0xffffffff);

 getParaChar(Info_Line2, address+SetP_shade1.chare);
 }
 else if(cmd ==  4 )
 {
 if(pSPCValue[0].SPCSetPoints.system_valueb.bite.password_en==0)
 return;

 Flashing_EN();
 if((direct == 1) && (SetP_shade1.chare<SpcMenu[Menustat].len-1))
 SetP_shade1.chare++;
 else if((direct == 0) && (SetP_shade1.chare>0))
 SetP_shade1.chare--;

 getParaChar(Info_Line2, address+SetP_shade1.chare);
 }

 if(IndicatorEN)
 {
 Info_Line2[14] = 'P';
 Info_Line2[15] = Cable_Channel+0X31;
 }
}






void Para_int_Set(UCHAR direct, UCHAR cmd)
{

 static int Para_int_temp,Para_int_max,Para_int_min;
 UCHAR* add;
 int *ptr;
 char IndicatorEN=0;

 switch(SpcMenu[Menustat].offset)
 {
 case  34 :
 case  32 :
 case  40 :
 case  24 :
 case  26 :
 add = (UCHAR *)(&pSPCValue[0].SPCSetPoints);
 break;
 default:
 if(Cable_Channel == 0)
 add = (UCHAR *)(&pSPCValue[0].SPCSetPoints);
 else
 add = (UCHAR *)(&pSPCValue[1].SPCSetPoints);

 IndicatorEN=1;
 break;
 }

 add += SpcMenu[Menustat].offset;
 ptr = (int*)add;


 if(SpcMenu[Menustat].edge_nofix &  0X10 )
 {
 Para_int_max = *(ptr+1);
 if(Para_int_max ==  0X7fff )
 Para_int_max = SpcMenu[Menustat].MaxVal;
 else
 Para_int_max -= SpcMenu[Menustat].len;

 if(Para_int_max < SpcMenu[Menustat].MinVal)
 Para_int_max = SpcMenu[Menustat].MinVal;
 }
 else
 Para_int_max = SpcMenu[Menustat].MaxVal;

 if(SpcMenu[Menustat].edge_nofix &  0X20 )
 {
 Para_int_min = *(ptr-1);
 if(Para_int_min ==  0X7fff )
 Para_int_min = SpcMenu[Menustat].MinVal;
 else
 Para_int_min += SpcMenu[Menustat].len;

 if(Para_int_min > SpcMenu[Menustat].MaxVal)
 Para_int_min = SpcMenu[Menustat].MaxVal;
 }
 else
 Para_int_min = SpcMenu[Menustat].MinVal;

 if(cmd ==  1 )
 {
 if(pSPCValue[0].SPCSetPoints.system_valueb.bite.password_en==0)
 return;

 *ptr = Para_int_temp;
 storage();
 ParametersChanged = 1;
 }
 else if(cmd ==  2 )
 {
 Para_int_temp = *ptr;

 if(Para_int_temp ==  0X7ffc )
 getParaChar(Info_Line2,  77 );
 else if(Para_int_temp ==  0X7ffd )
 getParaChar(Info_Line2,  76 );
 else if(Para_int_temp ==  0X7fff )
 getParaChar(Info_Line2,  73 );
 else
 FromIntToStr(Para_int_temp,Info_Line2,SpcMenu[Menustat].decimal);
 }
 else if(cmd ==  4 )
 {
 if(pSPCValue[0].SPCSetPoints.system_valueb.bite.password_en==0)
 return;

 Flashing_EN();
 if(direct)
 {
 if(Para_int_temp == Para_int_max)
 {
 if(SpcMenu[Menustat].NumVal == 1)
 {
 Para_int_temp =  0X7fff ;
 getParaChar(Info_Line2,  73 );
 }
 else if(SpcMenu[Menustat].NumVal == 2)
 {
 Para_int_temp =  0X7ffc ;
 getParaChar(Info_Line2,  77 );
 }
 }
 else if(Para_int_temp ==  0X7ffc )
 {
 Para_int_temp =  0X7ffd ;
 getParaChar(Info_Line2,  76 );
 }
 else if(Para_int_temp < Para_int_max)
 {
 if(SpcMenu[Menustat].offset ==  28 )
 Para_int_temp += KeyHoldStep*10;
 else
 Para_int_temp += KeyHoldStep;
 if(Para_int_temp > Para_int_max) Para_int_temp = Para_int_max;
 FromIntToStr(Para_int_temp,Info_Line2,SpcMenu[Menustat].decimal);
 }
 }
 else
 {
 if(Para_int_temp ==  0X7ffd )
 {
 if(SpcMenu[Menustat].NumVal == 2)
 {
 Para_int_temp =  0X7ffc ;
 getParaChar(Info_Line2,  77 );
 }
 else
 {
 Para_int_temp =  0X7fff ;
 getParaChar(Info_Line2,  73 );
 }
 }
 else if((Para_int_temp ==  0X7fff ) || (Para_int_temp ==  0X7ffc ))
 {
 Para_int_temp = Para_int_max;
 FromIntToStr(Para_int_temp,Info_Line2,SpcMenu[Menustat].decimal);
 }
 else if(Para_int_temp > Para_int_min)
 {
 if(SpcMenu[Menustat].offset ==  28 )
 Para_int_temp -= KeyHoldStep*10;
 else
 Para_int_temp -= KeyHoldStep;
 if(Para_int_temp < Para_int_min) Para_int_temp = Para_int_min;
 FromIntToStr(Para_int_temp,Info_Line2,SpcMenu[Menustat].decimal);
 }
 }
 }

 if(IndicatorEN)
 {
 Info_Line2[14] = 'P';
 Info_Line2[15] = Cable_Channel+0X31;
 }
}






void Para_show(UCHAR direct, UCHAR cmd)
{
 volatile char locat;
 volatile unsigned char StringLocate, ResetLocate;
 static char ResetStatus=0, ResetParaCmd=0;
 char ChannelTemp;
 char IndicatorEN=0;

 switch(Menustat)
 {
 case 8:
 case 14:
 case 15:
 ChannelTemp = 0;
 break;
 default:
 ChannelTemp = Cable_Channel;
 IndicatorEN = 1;
 break;
 }


 if((Menustat < 10) || (Menustat > 15))
 {
 ResetStatus = 0;
 locat = SpcMenu[Menustat].offset+ChannelTemp;
 CopyStr(Actural_disp_str[locat],Info_Line2,16);
 if(IndicatorEN)
 {
 Info_Line2[14] = 'P';
 Info_Line2[15] = Cable_Channel+0X31;
 }
 return;
 }
 else
 {
 if(cmd ==  2 )
 {
 ResetStatus = 0;
 ResetParaCmd = 0;
 locat = SpcMenu[Menustat].offset+ChannelTemp;
 CopyStr(Actural_disp_str[locat],Info_Line2,16);
 }
 else
 {
 switch(ResetStatus)
 {
 case 0:
 if(cmd ==  1 )
 {
 ResetStatus++;
 CopyStr(Info_Line1,Info_Line1_shape,16);
 getParaChar(Info_Line1,  84 );
 getParaChar(Info_Line2,  4 );
 }
 break;
 case 1:
 if(cmd ==  1 )
 {
 if(ResetParaCmd)
 {
 asm nop;
 ResetLocate = ResetCmd[Menustat-10] & 0xff;
 StringLocate = (ResetCmd[Menustat-10]>>8) & 0xff;
 Statis_flag[ChannelTemp] |= ResetLocate;
 ClearStr(Actural_disp_str[StringLocate], 16);
 getParaChar(Info_Line1,  85 );
 ClearStr(Info_Line2,16);
 LCDUpdate();
 Delay_ms(1000);
 CopyStr(Info_Line1_shape,Info_Line1,16);
 CopyStr(Actural_disp_str[StringLocate],Info_Line2,16);

 ResetStatus = 0;
 ResetParaCmd = 0;
 }
 else
 {
 ResetStatus = 0;
 ResetParaCmd = 0;
 locat = SpcMenu[Menustat].offset;
 CopyStr(Actural_disp_str[locat],Info_Line2,16);
 }
 }
 else if(cmd ==  4 )
 {
 ResetParaCmd ^= 1;
 getParaChar(Info_Line1,  84 );
 if(ResetParaCmd)
 getParaChar(Info_Line2,  5 );
 else
 getParaChar(Info_Line2,  4 );
 }
 else if(cmd ==  1 )
 {
 ResetStatus = 0;
 ResetParaCmd = 0;
 locat = SpcMenu[Menustat].offset;
 CopyStr(Actural_disp_str[locat],Info_Line2,16);
 }
 break;
 }
 }
 }

 if(IndicatorEN)
 {
 Info_Line2[14] = 'P';
 Info_Line2[15] = Cable_Channel+0X31;
 }
}






void DisablePSWInputing()
{
 Usr_Psw_en = 0;
}

void Authority_Set(UCHAR direct, UCHAR cmd)
{
 char Usr_mode_shape;

 if(cmd ==  1 )
 {
 if(pSPCValue[0].SPCSetPoints.system_valueb.bite.password_en)
 {
 pSPCValue[0].SPCSetPoints.system_valueb.bite.password_en = 0;
 getParaChar(Info_Line2,  13 );

 Savedata( 84 ,
 sizeof(SYSTEM_VALUEB),
 (UCHAR *)(&pSPCValue[0].SPCSetPoints.system_valueb),
 0);
 }
 else
 {
 if(Usr_Psw_en == 0)
 {
 Usr_Psw_en = 1;
 spc_system_flag.bite.char_actived = 1;
 SetP_shade.CharacNum = 0;
 SetP_shade.StringNum = 0;
 ClearStr(Info_Line2, 16);
 getParaChar(Info_Line1,  79 );

 spc_system_flag.bite.char_flash = 1;
 char_flash_loca = 1;
 }
 else
 {
 Usr_Psw_en = 0;
 if(StrCompar(SetP_shade.Password, pSPCValue[0].SPCSetPoints.Password))
 {
 pSPCValue[0].SPCSetPoints.system_valueb.bite.password_en = 1;
 ClearStr(Info_Line2, 16);
 getParaChar(Info_Line1,  83 );
 Usr_mode_shape = pSPCValue[0].SPCSetPoints.system_valueb.bite.password_en;
 getParaChar(Info_Line2_shape,  13 +Usr_mode_shape);

 Savedata( 84 ,
 sizeof(SYSTEM_VALUEB),
 (UCHAR *)(&pSPCValue[0].SPCSetPoints.system_valueb),
 0);
 }
 else
 {
 ClearStr(Info_Line2, 16);
 getParaChar(Info_Line1,  82 );
 }
 LCDext = 1;
 spc_system_flag.bite.char_actived = 0;
 spc_system_flag.bite.char_flash = 0;
 Lcd_Cmd(_LCD_CURSOR_OFF);
 }
 }
 }
 else if(cmd ==  2 )
 {
 if(spc_system_flag.bite.char_flash == 0)
 Usr_Psw_en = 0;

 if(Usr_Psw_en == 0)
 {
 Usr_mode_shape = pSPCValue[0].SPCSetPoints.system_valueb.bite.password_en;
 getParaChar(Info_Line2,  13 +Usr_mode_shape);

 CopyStr(Info_Line1, Info_Line1_shape, 16);
 CopyStr(Info_Line2, Info_Line2_shape, 16);
 }
 else
 {
 ClearStr(Info_Line2, 16);
 getParaChar(Info_Line1,  79 );
 SetP_shade.CharacNum = 0;
 SetP_shade.StringNum = 0;
 char_flash_loca = 1;
 }
 ClearStr(SetP_shade.Password, 16);
 }
 else if(cmd ==  4 )
 {
 if(Usr_Psw_en)
 {
 if((direct == 1) && (SetP_shade.StringNum <  63 ))
 SetP_shade.Password[SetP_shade.CharacNum] = SpcCharactors[++SetP_shade.StringNum];
 else if((direct == 0) && (SetP_shade.StringNum > 0))
 SetP_shade.Password[SetP_shade.CharacNum] = SpcCharactors[--SetP_shade.StringNum];

 Info_Line2[SetP_shade.CharacNum] = SetP_shade.Password[SetP_shade.CharacNum];
 getParaChar(Info_Line1,  79 );
 }
 }
 else if(cmd ==  3 )
 {
 getParaChar(Info_Line1,  79 );
 Info_Line2[SetP_shade.CharacNum] = '*';
 if((direct == 1) && (SetP_shade.CharacNum < 16) &&
 (SetP_shade.Password[SetP_shade.CharacNum] != ' '))
 SetP_shade.CharacNum++;
 SetP_shade.StringNum = 0;
 char_flash_loca = SetP_shade.CharacNum+1;
 }
}






void Version_show(UCHAR direct, UCHAR cmd)
{
 char i;

 for(i=0; i<16; i++) Info_Line1[i] = Version_title[i];
 for(i=0; i<16; i++) Info_Line2[i] = Version_content[i];
}






void FromIntToStr(long ValueResoure, char *StringTarget, signed char decimal)
{
 char sourcecont=0 ,targetcont=0,unitcont, i, flag=0, decimal_flag = 0;

 ClearStr(StringTarget, 16);
 unitcont = SpcMenu[Menustat].Unit;

 if(unitcont & 0x80)
 *(StringTarget++) = SPCUnit[unitcont&0x7f][0];

 if(ValueResoure < 0)
 *(StringTarget++) = '-';
 ValueResoure = abs(ValueResoure);

 for(i=0; i<8; i++)
 {
 if(flag)
 *(StringTarget++) = ValueResoure/Chr_str[i] + 0x30;
 else
 {
 if(ValueResoure/Chr_str[i])
 {
 flag = 1;
 *(StringTarget++) = ValueResoure/Chr_str[i] + 0x30;
 }
 else
 {
 if(decimal_flag)
 {
 *(StringTarget++) = ValueResoure/Chr_str[i] + 0x30;
 }

 if((decimal + i) == 7)
 {
 *(StringTarget++) = ValueResoure/Chr_str[i] + 0x30;
 }
 }
 }
 ValueResoure %= Chr_str[i];

 if((decimal + i) == 7)
 {
 if(decimal != 0)
 {
 *(StringTarget++) = '.';
 decimal_flag = 1;
 }
 }
 }

 if(!(unitcont & 0x80))
 {
 sourcecont = 0;
 if(unitcont ==  1+1 )
 unitcont += pSPCValue[0].SPCSetPoints.system_valueb.bite.spc_units_c;
 *(StringTarget++) = ' ';
 while(SPCUnit[unitcont][sourcecont] != ' ')
 {
 *(StringTarget+targetcont) = SPCUnit[unitcont][sourcecont];
 sourcecont++;
 targetcont++;
 }
 }
}






void storage()
{
 CopyStr(Info_Line1,Info_Line1_shape, 16);
 CopyStr(Info_Line2,Info_Line2_shape, 16);
 getParaChar(Info_Line1,  83 );
 ClearStr(Info_Line2, 16);
 LCDext = 1;
}






void Reset_PSW(UCHAR direct, UCHAR cmd)
{

 static char Reset_flag = 0;

 if(reset_psw_en==0)
 return;

 if(cmd ==  5 )
 {
 reset_psw_en = 1;
 Reset_flag = 0;
 getParaChar(Info_Line1,  80 );
 getParaChar(Info_Line2,  4 +Reset_flag);
 }
 else if(cmd ==  1 )
 {
 reset_psw_en = 0;
 if(Reset_flag == 1)
 {
 getParaChar(pSPCValue[0].SPCSetPoints.Password,  78 );
 Savedata( 66 ,
 16,
 (UCHAR *)(&pSPCValue[0].SPCSetPoints.Password),
 0);
 getParaChar(Info_Line1,  81 );
 ClearStr(Info_Line2, 16);
 LCDUpdate();
 Delay_ms(1500);
 spc_system_flag.bite.default_diaped = 0;
 disp_default();
 spc_system_flag.bite.default_diaped = 1;
 spc_system_flag.bite.stat_update = 1;
 disp_default();
 }
 else
 {
 spc_system_flag.bite.default_diaped = 0;
 disp_default();
 spc_system_flag.bite.default_diaped = 1;
 spc_system_flag.bite.stat_update = 1;
 disp_default();
 }

 }
 else if(cmd ==  4 )
 {
 if(direct)
 {
 if(Reset_flag==0)
 {
 Reset_flag = 1;
 getParaChar(Info_Line2,  4 +Reset_flag);
 LCDUpdate();
 }
 }
 else
 {
 if(Reset_flag == 1)
 {
 Reset_flag = 0;
 getParaChar(Info_Line2,  4 +Reset_flag);
 LCDUpdate();
 }
 }
 }
}






char getStringNum()
{
 char i;

 for(i=0; i< 63 + 31 ; i++)
 {
 if(SetP_shade.HeaterName[SetP_shade.CharacNum] == SpcCharactors[i])
 return i;
 }
}

char RangeCheck(int *Buff, int MaxPara, int MinPara)
{
 char ret=0;

 if((*Buff > MaxPara) || (*Buff < MinPara))
 ret = 1;

 return ret;
}

void OutRangeProcess(char index, unsigned int Address, int *Ptr)
{
 switch(index)
 {
 case 0:
 EEPROM_get(Address,sizeof(int),(unsigned char*)Ptr);
 break;
 case 1:
 case 2:
 case 3:
 if(*Ptr !=  0X7fff )
 EEPROM_get(Address,sizeof(int),(unsigned char*)Ptr);
 break;
 case 4:
 EEPROM_get(Address,sizeof(int),(unsigned char*)Ptr);
 EEPROM_get(Address-2,sizeof(int),(unsigned char*)Ptr-2);
 break;
 case 5:
 case 6:
 if(*Ptr !=  0X7fff )
 {
 EEPROM_get(Address,sizeof(int),(unsigned char*)Ptr);
 EEPROM_get(Address-2,sizeof(int),(unsigned char*)Ptr-2);
 }
 break;
 case 7:
 if((*Ptr !=  0X7ffc ) && (*Ptr !=  0X7ffd ))
 EEPROM_get(Address,sizeof(int),(unsigned char*)Ptr);
 break;
 case 8:
 if((*Ptr !=  0X7fff ) && (*Ptr !=  0X7ffe ))
 {
 EEPROM_get(Address,sizeof(int),(unsigned char*)Ptr);
 EEPROM_get(Address-2,sizeof(int),(unsigned char*)Ptr-2);
 }
 break;
 }
}

void InRangeProcess(char index, unsigned int Address, int *Ptr, char ChannelNum,
 int MaxData, int MinData)
{
 switch(index)
 {
 case 2:
 if(*Ptr !=  0X7fff )
 {
 if((*(Ptr+1) !=  0X7fff ) && (*Ptr >= *(Ptr+1)))
 {
 EEPROM_get(Address,sizeof(int),(unsigned char*)Ptr);
 }
 }
 break;
 case 3:
 if(*Ptr !=  0X7fff )
 {
 if((*(Ptr-1) !=  0X7fff ) && (*Ptr <= *(Ptr-1)))
 {
 EEPROM_get(Address,sizeof(int),(unsigned char*)Ptr);
 }
 }
 break;
 case 5:
 if(*Ptr !=  0X7fff )
 {
 if((*(Ptr+2) !=  0X7fff ) && (*Ptr >= *(Ptr+2)))
 {
 EEPROM_get(Address,sizeof(int),(unsigned char*)Ptr);
 EEPROM_get(Address-2,sizeof(int),(unsigned char*)Ptr-2);
 }
 if(ProCtlEnable(ChannelNum))
 {
 if(*Ptr >= pSPCValue[ChannelNum].SPCSetPoints.MaintainTemp.Temperature_C)
 {
 *Ptr = pSPCValue[ChannelNum].SPCSetPoints.MaintainTemp.Temperature_C-1;
 *(Ptr-1) = ConvertCtoF(*Ptr);
 }

 }
 else
 {
 if(*Ptr >= pSPCValue[ChannelNum].SPCSetPoints.MaintainTemp.Temperature_C-pSPCValue[ChannelNum].SPCSetPoints.DeadBand.Temperature_C)
 {
 *Ptr = pSPCValue[ChannelNum].SPCSetPoints.MaintainTemp.Temperature_C-pSPCValue[ChannelNum].SPCSetPoints.DeadBand.Temperature_C-1;
 *(Ptr-1) = ConvertCtoF(*Ptr);
 }
 }
 if(*Ptr < MinData)
 {
 *Ptr = MinData;
 *(Ptr-1) = ConvertCtoF(*Ptr);
 }
 }
 break;
 case 6:
 if(*Ptr !=  0X7fff )
 {
 if((*(Ptr-2) !=  0X7fff ) && (*Ptr <= *(Ptr-2)))
 {
 EEPROM_get(Address,sizeof(int),(unsigned char*)Ptr);
 EEPROM_get(Address-2,sizeof(int),(unsigned char*)Ptr-2);
 }
 if(ProCtlEnable(ChannelNum))
 {
 if(*Ptr <= pSPCValue[ChannelNum].SPCSetPoints.MaintainTemp.Temperature_C)
 {
 *Ptr = pSPCValue[ChannelNum].SPCSetPoints.MaintainTemp.Temperature_C+1;
 *(Ptr-1) = ConvertCtoF(*Ptr);
 }
 }
 else
 {
 if(*Ptr <= pSPCValue[ChannelNum].SPCSetPoints.MaintainTemp.Temperature_C+pSPCValue[ChannelNum].SPCSetPoints.DeadBand.Temperature_C)
 {
 *Ptr = pSPCValue[ChannelNum].SPCSetPoints.MaintainTemp.Temperature_C+pSPCValue[ChannelNum].SPCSetPoints.DeadBand.Temperature_C+1;
 *(Ptr-1) = ConvertCtoF(*Ptr);
 }
 }
 if(*Ptr > MaxData)
 {
 *Ptr = MaxData;
 *(Ptr-1) = ConvertCtoF(*Ptr);
 }
 }
 break;
 default:
 break;
 }
}

void ConflictCorrection()
{
 int *Ptr[2];
 char i;
 char OutOfRanged[2];
 char index;
 char BaudChanged=0;
 int Address=0;
 SYSTEM_VALUEB FlagBuff[2];


 if(ParametersChanged)
 {
 ParametersChanged = 0;
 Ptr[0] = (int*)&pSPCValue[0].SPCSetPoints;
 Ptr[1] = (int*)&pSPCValue[1].SPCSetPoints;

 for(i=0;i<20;i++)
 {
 Ptr[0] = (int*)&pSPCValue[0].SPCSetPoints + ConflictCheckList[i].ParaMenAdress;
 Ptr[1] = (int*)&pSPCValue[1].SPCSetPoints + ConflictCheckList[i].ParaMenAdress;
 OutOfRanged[0] = RangeCheck(Ptr[0], ConflictCheckList[i].MaxPara, ConflictCheckList[i].MinPara);
 OutOfRanged[1] = RangeCheck(Ptr[1], ConflictCheckList[i].MaxPara, ConflictCheckList[i].MinPara);
 if(OutOfRanged[0])
 {
 index = ConflictCheckList[i].SpecialNum;
 Address = 1+ConflictCheckList[i].ParaMenAdress*2;
 OutRangeProcess(index, Address, Ptr[0]);
 }
 else
 {
 index = ConflictCheckList[i].SpecialNum;
 Address = 1+ConflictCheckList[i].ParaMenAdress*2;
 InRangeProcess(index, Address, Ptr[0], 0, ConflictCheckList[i].MaxPara, ConflictCheckList[i].MinPara);
 }

 if(OutOfRanged[1])
 {
 index = ConflictCheckList[i].SpecialNum;
 Address = 1+ConflictCheckList[i].ParaMenAdress*2+sizeof(SPCSETPIONTS);
 OutRangeProcess(index, Address, Ptr[1]);
 }
 else
 {
 index = ConflictCheckList[i].SpecialNum;
 Address = 1+ConflictCheckList[i].ParaMenAdress*2+sizeof(SPCSETPIONTS);
 InRangeProcess(index, Address, Ptr[1], 1, ConflictCheckList[i].MaxPara, ConflictCheckList[i].MinPara);
 }
 }

 Address = 1+ 84 ;
 EEPROM_get(Address,sizeof(SYSTEM_VALUEB),(unsigned char*)&FlagBuff[0]);
 Address = 1+ 84 +sizeof(SPCSETPIONTS);
 EEPROM_get(Address,sizeof(SYSTEM_VALUEB),(unsigned char*)&FlagBuff[1]);
 if(pSPCValue[0].SPCSetPoints.system_valueb.bite.rtd_opr > 5)
 {

 if(FlagBuff[0].bite.rtd_opr > 5)
 {
 pSPCValue[0].SPCSetPoints.system_valueb.bite.rtd_opr =  0 ;
 }
 else
 {
 pSPCValue[0].SPCSetPoints.system_valueb.bite.rtd_opr = FlagBuff[0].bite.rtd_opr;
 }
 }

 if(pSPCValue[0].SPCSetPoints.system_valueb.bite.def_display > 2)
 {
 if(FlagBuff[0].bite.def_display > 2)
 {
 pSPCValue[0].SPCSetPoints.system_valueb.bite.def_display =  0 ;
 }
 else
 {
 pSPCValue[0].SPCSetPoints.system_valueb.bite.def_display = FlagBuff[0].bite.def_display;
 }
 }

 if(pSPCValue[0].SPCSetPoints.system_valueb.bite.gfi_test_mod > 2)
 {

 if(FlagBuff[0].bite.gfi_test_mod > 2)
 {
 pSPCValue[0].SPCSetPoints.system_valueb.bite.gfi_test_mod =  2 ;
 }
 else
 {
 pSPCValue[0].SPCSetPoints.system_valueb.bite.gfi_test_mod = FlagBuff[0].bite.gfi_test_mod;
 }
 }

 if(pSPCValue[1].SPCSetPoints.system_valueb.bite.gfi_test_mod > 2)
 {

 if(FlagBuff[1].bite.gfi_test_mod > 2)
 {
 pSPCValue[1].SPCSetPoints.system_valueb.bite.gfi_test_mod =  2 ;
 }
 else
 {
 pSPCValue[1].SPCSetPoints.system_valueb.bite.gfi_test_mod = FlagBuff[1].bite.gfi_test_mod;
 }
 }

 if(pSPCValue[0].SPCSetPoints.system_valueb.bite.baud > 4)
 {
 if(FlagBuff[0].bite.baud > 4)
 {
 pSPCValue[0].SPCSetPoints.system_valueb.bite.baud =  3 ;
 }
 else
 {
 pSPCValue[0].SPCSetPoints.system_valueb.bite.baud = FlagBuff[0].bite.baud;
 }
 BaudChanged=1;
 }
 else
 {
 if(pSPCValue[0].SPCSetPoints.system_valueb.bite.baud != FlagBuff[0].bite.baud)
 {
 BaudChanged=1;
 }
 }
 if(BaudChanged)
 {
 Uart_initial();
 }

 if(pSPCValue[0].SPCSetPoints.system_valueb.bite.heater_type==1)
 {
 if(pSPCValue[0].SPCSetPoints.LimitedCurrent !=  0X7fff )
 {
 pSPCValue[0].SPCSetPoints.LimitedCurrent =  0X7fff ;
 }
 if(pSPCValue[0].SPCSetPoints.system_valueb.bite.ctl_type != 0)
 {
 pSPCValue[0].SPCSetPoints.system_valueb.bite.ctl_type = 0;
 }
 }

 if(pSPCValue[1].SPCSetPoints.system_valueb.bite.heater_type==1)
 {
 if(pSPCValue[1].SPCSetPoints.LimitedCurrent !=  0X7fff )
 {
 pSPCValue[1].SPCSetPoints.LimitedCurrent =  0X7fff ;
 }
 if(pSPCValue[1].SPCSetPoints.system_valueb.bite.ctl_type != 0)
 {
 pSPCValue[1].SPCSetPoints.system_valueb.bite.ctl_type = 0;
 }
 }

 if(FlagBuff[0].bite.def_display != pSPCValue[0].SPCSetPoints.system_valueb.bite.def_display)
 {
 if(spc_system_flag.bite.default_diaped == 1)
 {
 spc_system_flag.bite.stat_update = 1;
 disp_default();
 }
 }



 Savedata( 0 ,
 sizeof(SPCSETPIONTS),
 (UCHAR *)(&pSPCValue[0].SPCSetPoints),
 0);
 Savedata( 0 +sizeof(SPCSETPIONTS),
 sizeof(SPCSETPIONTS),
 (UCHAR *)(&pSPCValue[1].SPCSetPoints),
 0);
 }

 for(i=0;i<2;i++)
 {
 if(CtrlTypeCheck[i] != pSPCValue[i].SPCSetPoints.system_valueb.bite.ctl_type)
 {
 CtrlTypeCheck[i] = pSPCValue[i].SPCSetPoints.system_valueb.bite.ctl_type;
 if(CtrlTypeCheck[i])
 {
 asm nop;
 Spcssr[0].SSR_cmd = 0;
 Spcssr[0].SSR_stat = 0;
 }
 }

 if(PowerLimitCheck[i] != pSPCValue[i].SPCSetPoints.LimitedCurrent)
 {
 PowerLimitCheck[i] = pSPCValue[i].SPCSetPoints.LimitedCurrent;
 if(pSPCValue[i].SPCSetPoints.system_valueb.bite.ctl_type == 0)
 {
 if(Spcssr[i].SSR_stat == 1)
 {
 if(PowerLimitCheck[i] ==  0X7fff )
 {
 duty_index[i] = 10;
 ShapeForDuty = duty_index[i]*10;
 pwm_duty[i] = get_duty_table(duty_index[i]);
 SystemUpdate |= ( (unsigned long)0x00010000  << i);
 SetIntStr((int*)&ShapeForDuty,  18 +i,  9 , 1);
 }
 else
 {
 if(Spcpwm[i].pwm_cmd == 0)
 {
 asm nop;
 Spcpwm[i].pwm_cmd = 1;
 }

 if(duty_index[i] != pSPCValue[i].SPCSetPoints.LimitedCurrent/10)
 {
 duty_index[i] = pSPCValue[i].SPCSetPoints.LimitedCurrent/10;
 pwm_duty[i] = get_duty_table(duty_index[i]);
 SystemUpdate |= ( (unsigned long)0x00010000  << i);
 SetIntStr((int*)&pSPCValue[i].SPCSetPoints.LimitedCurrent,  18 +i,  9 , 1);
 }
 }
 }
 }
 }
 }

 if(AlarmNumCheck != pSPCAlarm.spcalarms.num_alarms)
 {
 if(AlarmNumCheck > pSPCAlarm.spcalarms.num_alarms)
 {
 for(i=pSPCAlarm.spcalarms.num_alarms; i<20; i++)
 {
 pSPCAlarm.spcalarms.alarm_typ[i] = 0;
 }
 }
 AlarmNumCheck = pSPCAlarm.spcalarms.num_alarms;
 }
}
