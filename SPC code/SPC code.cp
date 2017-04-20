#line 1 "D:/MyProject/SPC code1/SPC code/SPC code.c"
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
#line 1 "d:/myproject/spc code1/spc code/mainprocess.h"





void VTProcess(void);
void CGProcess(char ChannelNum);
char Tempprocess(char ChannelNum);
void CalSystemTemp(char ChannelNum, char RTDstat);

void Currentprocess(char ChannelNum);
void Voltprocess(void);
void enegy_acc(void);
void Timeprocess(void);
void modifytemp(TEMPERATURE *ptr);
char GetHighCurrentEn(char ChannelNum);
void SetHighCurrentEn(char ChannelNum, char HighCurrentCmd);
void ActivateHighCurrentAlarm(char ChannelNum);

extern unsigned int HighCurrentAlarmCount[2];
extern unsigned int energycount;
extern char energyacc;
#line 1 "d:/myproject/spc code1/spc code/modbus.h"



typedef struct tagMODBUSREGLIST
{
 int ModbusAddress;
 int *DataAddress;
}MODBUSREGLIST;

extern unsigned char modbus_rcdata[20];
extern unsigned int modbus_rcn;
extern char ModbusRecived,ModbusValid;
extern unsigned int ModbusCounter;

static code char ModbusExarea[] =
{
 0,
 30,
 15,
 8,
 4,
 2,
} ;

void Split(unsigned int source, unsigned char *target);
UINT Combine(unsigned char * source);
void Copydata(unsigned char *source, unsigned char *target, char len);
unsigned int CRCChecksum(unsigned char *chkbuf, unsigned char len);
void modbusprocess(void);
void modbus_respond(void);
void SetModbusTxData(int TransData);
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
#line 1 "d:/myproject/spc code1/spc code/adc.h"
unsigned int read_adc(void);
void Getvoltage(void);
signed int ConvertADtoVoltage(unsigned int ADcurrent, char freq);
void GetFreqency(void);
#line 1 "d:/myproject/spc code1/spc code/i2c.h"
sbit Soft_I2C_Scl at RC3_bit;
sbit Soft_I2C_Sda at RC4_bit;
sbit Soft_I2C_Scl_Direction at TRISC3_bit;
sbit Soft_I2C_Sda_Direction at TRISC4_bit;

void I2C_get(UCHAR QTAddress,UCHAR QTRegister,UCHAR *Keystate,UCHAR Length);
void I2C_write(UCHAR QTAddress,UCHAR QTRegister,UCHAR *Keystate,UCHAR Length);

void I2C_send(UCHAR DataToSlave);
UCHAR I2C_receive(void);
void I2C_start(void);
void I2C_stop(void);
void WaitI2CIdel(void);
void WaitSlaveACK(void);
void SendACKToSlave(void);
void SendNACKToSlave(void);

extern char I2CError;
#line 1 "d:/myproject/spc code1/spc code/systemtest.h"





void systemtest(char ChannelNum);

extern char AlarmTestCount[2], HeaterTestCount[2];
extern char AlarmTestCmd[2];
extern char HeaterTestCmd[2];
extern int GFITestCount[2];
extern char GFITestCmd[2], GFITestStat;
extern char GFITestPass[2];
extern char AutoGFITestPass[2];
extern char AutoGFITestEN[2];

extern char TestEN[2];
#line 1 "d:/myproject/spc code1/spc code/manual.h"
void manual(char ChannelNum);
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
#line 1 "d:/myproject/spc code1/spc code/string_op.h"
void getParaChar(char *ptr, char locat);
void ClearStr(char *target, int len);
void MemeSet(char *target, char Transdata, int len);
#line 18 "D:/MyProject/SPC code1/SPC code/SPC code.c"
UCHAR Info_Line1[ 16 ];
UCHAR Info_Line2[ 16 ];
UCHAR Info_Line1_shape[ 16 ];
UCHAR Info_Line2_shape[ 16 ];
UCHAR Alarmstat = 0;
UCHAR Passwordbuff[ 16 ];
UCHAR Menustat;

UINT KeyHoldDelay=0;
UINT KeyHoldStep=1;
char Keyactived=0,Keyhold=0;
SYSTEM_FLAG spc_system_flag;
SPCVALUE pSPCValue[2];
char Cable_Channel=0;

SETPSHADE SetP_shade1;
SPCSETPIONTS SetP_shade;

CLIBRATIONCMD Cali_cmd;

SPCCOUNT spc_count;
SPCALARMBOX pSPCAlarm;

unsigned long ActivedAlarms = 0;

char bUpdate=0;
char LCDext = 0;
SPCPWM Spcpwm[2];
SPCSSR Spcssr[2];
SOFTSTART SpcSstart[2];
signed int temp_val_old[2];
ACCUMULATE SpcAcc[2];

SPCTIME SYS_On_time;
SPCTIME Heat_On_time[2];

UINT rcdata;

UCHAR Statis_flag[2];

unsigned int pwm_duty[2],duty_index[2];

UINT freqency;
UINT freq_pori;

char char_flash_loca;

char reset_psw_en=0;

VALUEACC Volt_acc[2];
VALUEACC Current_acc[2];

char ADC_busy[2] = {0};

char Actural_disp_str[38][17];
ULONG SystemUpdate=0;
unsigned int DataUpdate=0;

char freq_en;


char forceop_level;
char KeyEn;

unsigned char ForceSSRONCondition[2]={0};
unsigned char ForceSSROFFCondition[2]={0};

 unsigned long ACheck=0;
 char ErrorCode=0;

char CheckError()
{
 if(ActivedAlarms)
 ACheck = ActivedAlarms;
 else
 {
 if(ACheck)
 {
 ACheck = 0;
 return 1;
 }
 }

 return 0;
}

void main()
{
 GlobalInterrupt_diable();
 SPCSystemInitialize();
 SPC_Initial();
 selftest();
 GlobalInterrupt_enable();

 spc_system_flag.bite.default_diaped = 1;
 spc_system_flag.bite.stat_update = 1;
 Menustat = 0;

 SelfCheck();

 asm nop;



 freqency = 60;

 freq_pori = 83;
#line 145 "D:/MyProject/SPC code1/SPC code/SPC code.c"
 InitialCalibrationReg();


 while(1)
 {
 if((spc_system_flag.bite.keypushed ==  1 ) && (LCDext==0))
 {

 spc_system_flag.bite.keypushed =  0 ;
 SPCMenuOperation();
 }



 if(bUpdate)
 {

 bUpdate = 0;

 if(SpcMenu[Menustat].func_mark ==  36 )
 {
 spc_system_flag.bite.char_flash = 1;
 char_flash_loca = 1;
 }

 CopyStr(Info_Line1_shape, Info_Line1, 16);
 CopyStr(Info_Line2_shape, Info_Line2, 16);
 LCDUpdate();
 }



 disp_default();




 if(spc_system_flag.bite.flashing_reach == 1)
 {
 spc_system_flag.bite.flashing_reach = 0;
 Flashing();
 }



 if(spc_system_flag.bite.meas_VT_reach)
 {
 VTProcess();
 }




 RollCharact();



 CGProcess( 0 );

 CGProcess( 1 );

 Timeprocess();

 enegy_acc();

 systemtest( 0 );

 systemtest( 1 );

 manual( 0 );

 manual( 1 );

 dispupdate();

 alarmdispupdate();

 RSSoperation( 0 );

 RSSoperation( 1 );

 AlarmSSRoperation();

 AlarmLedOperation();

 ActivateHighCurrentAlarm(0);

 modbusprocess();

 ConflictCorrection();

 AutoAutho();


 if(KeyResetEN)
 {
 KeyResetEN = 0;
 QT60Reset();
 }


 }
}

void Tcount(SPCTIME *time ,char cmd)
{
 char i;

 if(time->second++ >  60 )
 {
 time->second = 0;
 if(cmd == 0)
 {
 DataUpdate |= ( (unsigned long)0x00000004 + (unsigned long)0x00000008 );

 if(KeyResetCount++ > 5)
 {
 KeyResetCount = 0;
 KeyResetEN = 1;
 }

 if(GetAutoAutho() == 1)
 {
 AutoAuthoCount++;
 if(AutoAuthoCount >= 15)
 {
 AutoAuthoCount = 0;
 SetAutoAutho(2);
 }
 }
 }

 if(time->minute++ >  60 )
 {


 time->minute = 0;
 if(time->hour < 0xffffffff)
 time->hour++;

 if(cmd)
 {
 if(time->hour < 1000000)
 pSPCValue[cmd-1].SPCStatistics.RunTime = time->hour;
 else
 pSPCValue[cmd-1].SPCStatistics.RunTime =  1500000 ;

 DataUpdate |= ( (unsigned long)0x00000001  << (cmd-1));
 }

 if(cmd == 0)
 {
 for(i=0;i<2;i++)
 {
 if(HeaterTestCmd[i] == 1)
 {
 if(HeaterTestCount[i]++ >= pSPCValue[i].SPCSetPoints.HeaterTest)
 {
 HeaterTestCount[i] = 0;

 HeaterTestCmd[i] = 2;
 }
 }

 if(AlarmTestCmd[i] == 1)
 {
 if(AlarmTestCount[i]++ >= pSPCValue[i].SPCSetPoints.AlarmOutTest)
 {
 AlarmTestCount[i] = 0;

 AlarmTestCmd[i] = 2;
 }
 }
 }

 if(pSPCValue[0].SPCSetPoints.AutoTestTime ==  0X7fff )
 return;

 spc_count.AutoTest_count++;
 if(spc_count.AutoTest_count >= pSPCValue[0].SPCSetPoints.AutoTestTime)
 {
 spc_count.AutoTest_count = 0;
 if(spc_system_flag.bite.autotest_req ==  0 )
 {
 if((ActivedAlarms &  (unsigned long)0x00000004 ) || (ActivedAlarms &  (unsigned long)0x00000008 ))
 return;

 if(spc_system_flag.bite.load_forceop !=  2 )
 spc_system_flag.bite.autotest_req =  1 ;
 }
 }
 }
 }
 }
}

void interrupt()
{
 static UINT timereset=0,trige = 0;

 if(TMR0IF_bit)
 {

 if(freq_en)
 {
 spc_count.freq_count++;
 if(spc_count.freq_count > 100)
 freq_en = 0;
 else if(spc_count.freq_count > 50)
 freq_en = 2;
 }
 else
 {
 pwm( 0 );
 pwm( 1 );
 countformeasurement( 0 );
 countformeasurement( 1 );

 if(ModbusRecived)
 {
  LATE1_bit  = 1;
 ModbusCounter++;
 if(ModbusCounter >= 100)
 {
 ModbusRecived = 0;
  LATE1_bit  = 0;
 ModbusValid = 1;
 }
 }
#line 385 "D:/MyProject/SPC code1/SPC code/SPC code.c"
 if(RollCharactEN == 1)
 {
 RollCharactCount++;
 if(RollCharactCount >= 600)
 {
 RollCharactCount = 0;
 RollCharactEN = 2;
 }
 }

 spc_count.secout++;
 if(spc_count.secout >=  5000 )
 {
 LATG1_bit ^= 1;
 spc_count.secout = 0;
 SpcSstart[0].SOFTSTART_reach = 1;
 SpcSstart[1].SOFTSTART_reach = 1;


 if(ResetPasswordStep)
 {
 if(ResetPasswordCount++ > 10)
 {
 ResetPasswordStep = 0;
 ResetPasswordCount = 0;
 }
 }

 if(spc_system_flag.bite.default_diaped == 0)
 {
 if(pSPCValue[0].SPCSetPoints.DisplayTime !=  0X7fff )
 {
 if(spc_count.Timeout_count++ >= pSPCValue[0].SPCSetPoints.DisplayTime)
 {
 spc_count.Timeout_count = 0;
 spc_system_flag.bite.default_diaped = 1;
 spc_system_flag.bite.stat_update = 1;
 }
 }
 }

 if(spc_count.meas_VT_count++ >=  10 )
 {
 spc_count.meas_VT_count = 0;
 spc_system_flag.bite.meas_VT_reach = 0x03;
 }

 if(energycount++ >= 36)
 {
 energycount = 0;
 energyacc = 1;
 }

 if(GFITestCmd[0] == 1)
 {
 if(GFITestCount[0]++ >= 10)
 {
 GFITestCount[0] = 0;
 GFITestCmd[0] = 2;
 LATF2_bit = 0;
 }
 }

 if(GFITestCmd[1] == 1)
 {
 if(GFITestCount[1]++ >= 10)
 {
 GFITestCount[1] = 0;
 GFITestCmd[1] = 2;
 LATF1_bit = 0;
 }
 }

 if(spc_system_flag.bite.autotest_req ==  1 )
 {
 if(spc_count.AutoTest_last_count++ >= 320)
 {
 spc_count.AutoTest_last_count = 0;
 spc_system_flag.bite.autotest_req =  2 ;
 }
 }

 if(GetHighCurrentEn(0) == 1)
 {
 if(HighCurrentAlarmCount[0]++ >= 300)
 {
 HighCurrentAlarmCount[0] = 0;
 SetHighCurrentEn(2,0);
 }
 }

 if(GetHighCurrentEn(1) == 1)
 {
 if(HighCurrentAlarmCount[1]++ >= 300)
 {
 HighCurrentAlarmCount[1] = 0;
 SetHighCurrentEn(2,1);
 }
 }

 if(GetAlarmEn())
 {
  LATE0_bit  ^= 1;
 }

 Tcount(&SYS_On_time, 0);
 if(Spcssr[0].SSR_stat == 1)
 Tcount(&Heat_On_time[0], 1);
 if(Spcssr[1].SSR_stat == 1)
 Tcount(&Heat_On_time[1], 2);
 }

 if(LCDext)
 {
 if(spc_count.toutT++ >=  5000 )
 {
 LCDext = 0;
 spc_count.toutT = 0;
 if(reset_psw_en)
 spc_system_flag.bite.default_diaped = 1;
 else
 bUpdate = 1;
 }
 }

 if(spc_system_flag.bite.flashing_en == 1)
 {
 if(spc_count.scanT++ >= 5000)
 {
 spc_count.scanT = 0;
 spc_system_flag.bite.flashing_reach = 1;
 }
 }

 if(KeyEn)
 {
 if(KeyDetectCount++ >= 150)
 {
 KeyDetectCount = 0;
 spc_system_flag.bite.keypushed =  1 ;
 }
 }
 }
#line 535 "D:/MyProject/SPC code1/SPC code/SPC code.c"
 TMR0H = 0XFe;
 TMR0L = 0x84;
 TMR0IF_bit = 0;
 }
 else if(INT0IF_bit)
 {
 INT0IF_bit = 0;
 }
 else if(RC1IF_bit)
 {
 if(ModbusRecived == 0)
 ModbusRecived = 1;

 modbus_rcdata[modbus_rcn] = RCREG1;
 modbus_rcn++;
 ModbusCounter = 0;

 RC1IF_bit = 0;
 }
}
