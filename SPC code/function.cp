#line 1 "D:/MyProject/SPC code1/SPC code/function.c"
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
#line 1 "d:/myproject/spc code1/spc code/pic18f6622.h"
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
#line 1 "d:/myproject/spc code1/spc code/m0220.h"
void MO22OMD_initial(void);
void nybble(void);
void writecom(unsigned char command);
void writedata(unsigned char adata);
void readcom(void);
void LcdInit(void);
void LcdOut(char num,char *line);
void LCD_output(unsigned char *txt1,unsigned char *txt2);
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
#line 1 "d:/myproject/spc code1/spc code/string_op.h"
void getParaChar(char *ptr, char locat);
void ClearStr(char *target, int len);
void MemeSet(char *target, char Transdata, int len);
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
#line 13 "D:/MyProject/SPC code1/SPC code/function.c"
char Channel1_Str[5] = "CH1:";
char Channel2_Str[6] = " CH2:";

char blank[17] = "                ";

char ScanTimeEN=0;


char AlarmEn=0;

char ActualAlarmNum=0;

char LostAlarmNum=0;

char AutoAuthoEN = 0;
unsigned char AutoAuthoCount=0;


char RollCharactBuff[41];
char RollCharactEN=0;
int RollCharactCount=0;
char RollCharactPointer=0;







void CopyTemp(TEMPERATURE *tempsource, TEMPERATURE *temptarget)
{
 temptarget->Temperature_C = tempsource->Temperature_C;
 temptarget->Temperature_F = tempsource->Temperature_F;
}






int ConvertCtoF(int sourse)
{

 return (int)(32 + ((long)sourse * 18) / 10);
}

int ConvertFtoC(int sourse)
{
 return (int)(((long)(sourse - 32)*10) / 18);
}

void ConvertTemp(TEMPERATURE *temptocon)
{
 char units;
 units = pSPCValue[0].SPCSetPoints.system_valueb.bite.spc_units_c;

 if(units)

 temptocon->Temperature_F = ConvertCtoF(temptocon->Temperature_C);
 else

 temptocon->Temperature_C = ConvertFtoC(temptocon->Temperature_F);
}






void ConvertDead(TEMPERATURE *temptocon)
{
 char units;
 units = pSPCValue[0].SPCSetPoints.system_valueb.bite.spc_units_c;

 if(units)
 {
 temptocon->Temperature_F = (int)(temptocon->Temperature_C * 2);
 if(temptocon->Temperature_F > 10)
 temptocon->Temperature_F = 10;
 if(temptocon->Temperature_F < 1)
 temptocon->Temperature_F = 1;
 }
 else
 {
 temptocon->Temperature_C = (int)(temptocon->Temperature_F / 2);
 if(temptocon->Temperature_C > 5)
 temptocon->Temperature_C = 5;
 if(temptocon->Temperature_C < 1)
 temptocon->Temperature_C = 1;
 }
}






void CopyPSWTitle(char *target, char adder)
{
 char i;
 for(i=0; i<16; i++)
 *(target+i) = PSWTitle[adder][i];
}






char StrCompar(char *resoure,char *target)
{
 char i=0;
 while(i<16)
 {
 if(*(resoure+i) == *(target+i)) i++;
 else return  0 ;
 }
 return  1 ;
}






void tempaverage(TEMPERATURE *tempsource, TEMPERATURE *temptarget)
{
 TEMPERATURE *temp;
 temp = tempsource+1;
 temptarget->Temperature_C = (tempsource->Temperature_C
 +temp->Temperature_C)/2;
 temptarget->Temperature_F = (tempsource->Temperature_F
 +temp->Temperature_F)/2;
}







void AlarmLedOperation()
{
 if(ActualAlarmNum>0)
 {
 AlarmEn = 1;
 }
 else
 {
 if(spc_system_flag.bite.alarmssr_forceop ==  0 )
 {
 Alarm_SSR_off(0);
 }

 if(pSPCAlarm.spcalarms.num_alarms>0)
 {
 AlarmEn = 0;
  LATE0_bit  = 1;
 }
 else
 {
 AlarmEn = 0;
  LATE0_bit  = 0;
 }
 }
}

void alarmoperate(unsigned long alarmcommand, char active)
{
 char i,j;
 int alarm_num_temp;
 unsigned long AlarmTypeBuff=0;
 char AlarmTypeCount=0;

 spc_system_flag.bite.stat_update = 1;
 if(active ==  1 )
 {
 ActivedAlarms |= alarmcommand;

 if(pSPCAlarm.spcalarms.num_alarms ==  20 )
 {
 for(i=0;i< 20 ;i++)
 {
 AlarmTypeBuff = pSPCAlarm.spcalarms.alarm_typ[i];
 if(!(AlarmTypeBuff & ( (unsigned long)0x00000400 + (unsigned long)0x00000800 + (unsigned long)0x10000000 + (unsigned long)0x20000000 )))
 {
 break;
 }
 }

 if(ActivedAlarms & AlarmTypeBuff)
 {
 for(j=0;j< 20 ;j++)
 {
 if(pSPCAlarm.spcalarms.alarm_typ[j] == AlarmTypeBuff)
 AlarmTypeCount++;
 }
 if(AlarmTypeCount == 1)
 {
 ActivedAlarms &= ~AlarmTypeBuff;
 ActualAlarmNum--;
 }
 }

 for(; i< 20 -1; i++)
 pSPCAlarm.spcalarms.alarm_typ[i] = pSPCAlarm.spcalarms.alarm_typ[i+1];

 pSPCAlarm.spcalarms.alarm_typ[ 20 -1] = alarmcommand;
 ActualAlarmNum++;
 Alarm_SSR_on(0);
 }
 else
 {
 pSPCAlarm.spcalarms.alarm_typ[pSPCAlarm.spcalarms.num_alarms++] = alarmcommand;
 ActualAlarmNum++;
 Alarm_SSR_on(0);

 SystemUpdate |=  (unsigned long)0x00400000 ;
 alarm_num_temp = pSPCAlarm.spcalarms.num_alarms;
 SetAlarmStr(Actural_disp_str[ 28 ], alarm_num_temp,  0 ,  11+1 , 7,  0 );
 }
 }
 else if(active ==  0 )
 {
 ActivedAlarms &= ~alarmcommand;
 ActualAlarmNum--;
 }
}






void CopyStr(char *resource, char *target, char len)
{
 char i;
 for(i=0; i<len; i++)
 *(target+i) = *(resource+i);
}






void Scantime_EN()
{
 spc_count.scanT = 0;
 spc_system_flag.bite.scantime_en =  1 ;
}

void Scantime_DIS()
{
 spc_count.scanT = 0;
 spc_system_flag.bite.scantime_en =  0 ;
}






void Flashing_EN()
{
 spc_system_flag.bite.flashing_en = 1;
}

void Flashing_DIS()
{
 spc_system_flag.bite.flashing_en = 0;
 spc_system_flag.bite.flashing_reach = 0;
}

void Flashing()
{
 spc_system_flag.bite.flashing_state ^= 1;
 if(spc_system_flag.bite.flashing_state)
 LcdOut(2,Info_Line2);
 else
 LcdOut(2,blank);
}






void EnableRollInformation()
{
 RollCharactEN=1;
 RollCharactCount=0;
}

void DisableRollInformation()
{
 RollCharactEN=0;
 RollCharactCount=0;
}


void RollCharact()
{
 char temp;
 if(spc_system_flag.bite.default_diaped)
 {
 if((RollCharactEN == 0) && (pSPCValue[0].SPCSetPoints.system_valueb.bite.def_display !=  0 ))
 {
 RollCharactEN = 1;
 RollCharactCount = 0;
 }
 }
 else
 {
 RollCharactEN = 0;
 RollCharactCount = 0;
 }

 if(RollCharactEN == 2)
 {
 RollCharactEN = 1;
 if(RollCharactPointer <= 25)
 {
 CopyStr(RollCharactBuff+RollCharactPointer, Info_Line2, 16);
 RollCharactPointer++;
 }
 else if(RollCharactPointer <= 40)
 {
 temp = 41-RollCharactPointer;
 CopyStr(RollCharactBuff+RollCharactPointer, Info_Line2, temp);
 CopyStr(RollCharactBuff, Info_Line2+temp, RollCharactPointer-25);
 RollCharactPointer++;
 }
 else
 {
 RollCharactPointer = 0;
 CopyStr(RollCharactBuff+RollCharactPointer, Info_Line2, 16);
 }
 LCDUpdate();
 }
}


void SetDefaultInformation()
{
 char pointer=0;
 char i=0;

 for(i=0;i<4;i++)
 RollCharactBuff[pointer++] = Channel1_Str[i];

 pointer+=16;
 for(i=0;i<5;i++)
 RollCharactBuff[pointer++] = Channel2_Str[i];

 pointer = 4;

 if(pSPCValue[0].SPCSetPoints.system_valueb.bite.def_display ==  2 )
 {
 if(pSPCValue[0].SPCSetPoints.MaintainTemp.Temperature_C ==  0X7fff )
 getParaChar(RollCharactBuff+pointer,  89 );
 else
 CopyStr(Actural_disp_str[ 6 ],RollCharactBuff+pointer,16);

 pointer += 21;

 if(pSPCValue[1].SPCSetPoints.MaintainTemp.Temperature_C ==  0X7fff )
 getParaChar(RollCharactBuff+pointer,  89 );
 else
 CopyStr(Actural_disp_str[ 7 ],RollCharactBuff+pointer,16);
 }
 else if(pSPCValue[0].SPCSetPoints.system_valueb.bite.def_display ==  1 )
 {
 CopyStr(Actural_disp_str[ 16 ],RollCharactBuff+pointer,16);
 pointer += 21;
 CopyStr(Actural_disp_str[ 17 ],RollCharactBuff+pointer,16);
 }
}

void disp_default()
{
 char i;
 static char DisplayApp=0;

 if(GFITestCmd[0] || GFITestCmd[1])
 return;

 if(DisplayApp == 0)
 {
 if(spc_system_flag.bite.default_diaped == 1)
 {
 DisplayApp = 1;
 ChannelSelStat =  0 ;
 }
 else
 {
 DisplayApp = 0;
 return;
 }
 }
 else
 {
 if(spc_system_flag.bite.default_diaped == 0)
 {
 DisplayApp = 0;
 }
 return;
 }

 Menustat = 0;
 Alarmstat = 0;
 spc_system_flag.bite.alarm_actived = 0;
 reset_psw_en = 0;
 spc_system_flag.bite.char_actived = 0;
 Flashing_DIS();
 spc_system_flag.bite.char_flash = 0;
 DisablePSWInputing();
 Lcd_Cmd(_LCD_CURSOR_OFF);

 if(pSPCValue[0].SPCSetPoints.system_valueb.bite.def_display ==  2 )
 {
 if(spc_system_flag.bite.stat_update)
 {
 spc_system_flag.bite.stat_update = 0;
 getParaChar(Info_Line1,  86 );

 ClearStr(RollCharactBuff,41);
 SetDefaultInformation();
#line 447 "D:/MyProject/SPC code1/SPC code/function.c"
 LCDUpdate();
 }
 }
 else if(pSPCValue[0].SPCSetPoints.system_valueb.bite.def_display ==  1 )
 {
 if(spc_system_flag.bite.stat_update)
 {
 spc_system_flag.bite.stat_update = 0;
 getParaChar(Info_Line1,  87 );

 ClearStr(RollCharactBuff,41);
 SetDefaultInformation();
 EnableRollInformation();
#line 463 "D:/MyProject/SPC code1/SPC code/function.c"
 LCDUpdate();
 }
 }
 else
 {
 if(spc_system_flag.bite.stat_update)
 {

 spc_system_flag.bite.stat_update = 0;
 getParaChar(Info_Line1,  88 );
 SetAlarmStr(Info_Line2, pSPCAlarm.spcalarms.num_alarms,  0 ,  11+1 , 7,  0 );
 LCDUpdate();
 }
 }
}






void dispupdate()
{
 static char AlarmIndex=0, AlarmMax;
 volatile char Alarmtype;
 char temp;
 char bUpdate=0;
 unsigned long Length=0;
 volatile unsigned long LTemp;


 if(spc_system_flag.bite.alarm_actived)
 return;
 if(reset_psw_en)
 return;
 if(GFITestCmd[0] || GFITestCmd[1])
 return;

 if(spc_system_flag.bite.default_diaped == 1)
 {
 if(pSPCValue[0].SPCSetPoints.system_valueb.bite.def_display ==  2 )
 {
#line 508 "D:/MyProject/SPC code1/SPC code/function.c"
 if(SystemUpdate &  (unsigned long)0x00000400 )
 {

 SetDefaultInformation();
#line 515 "D:/MyProject/SPC code1/SPC code/function.c"
 SystemUpdate &= ~ (unsigned long)0x00000400 ;
 bUpdate = 1;

 }

 if(SystemUpdate &  (unsigned long)0x00000800 )
 {

 SetDefaultInformation();
#line 527 "D:/MyProject/SPC code1/SPC code/function.c"
 SystemUpdate &= ~ (unsigned long)0x00000800 ;
 bUpdate = 1;
 }
 }
 else if(pSPCValue[Cable_Channel].SPCSetPoints.system_valueb.bite.def_display ==  1 )
 {
 if(SystemUpdate &  (unsigned long)0x00100000 )
 {

 SetDefaultInformation();
#line 540 "D:/MyProject/SPC code1/SPC code/function.c"
 SystemUpdate &= ~ (unsigned long)0x00100000 ;

 bUpdate = 1;
 }

 if(SystemUpdate &  (unsigned long)0x00200000 )
 {

 SetDefaultInformation();
#line 552 "D:/MyProject/SPC code1/SPC code/function.c"
 SystemUpdate &= ~ (unsigned long)0x00200000 ;

 bUpdate = 1;
 }
 }
 else
 {
 AlarmMax = pSPCAlarm.spcalarms.num_alarms;

 if(SystemUpdate &  (unsigned long)0x00400000 )
 {
 CopyStr(Actural_disp_str[ 28 ],Info_Line2,16);
 SystemUpdate &= ~ (unsigned long)0x00400000 ;

 bUpdate = 1;
 }
 }

 if(bUpdate)
 LCDUpdate();
 return;
 }

 if(SpcMenu[Menustat].index ==  0 )
 {
 if(SpcMenu[Menustat].len &  (unsigned long)0x80000000 )
 {
 Length = SpcMenu[Menustat].len;
 LTemp =  (unsigned long)0x80000000 ;
 Length &= ~LTemp;
 Length <<= Cable_Channel;
 if(SystemUpdate & Length)
 {
 temp = SpcMenu[Menustat].offset+Cable_Channel;
 CopyStr(Actural_disp_str[temp],Info_Line2,16);
 SystemUpdate &= ~Length;
 Info_Line2[14] = 'C';
 Info_Line2[15] = Cable_Channel+0X31;
 LCDUpdate();
 }
 }
 else
 {
 if(SystemUpdate & SpcMenu[Menustat].len)
 {
 temp = SpcMenu[Menustat].offset;
 CopyStr(Actural_disp_str[temp],Info_Line2,16);
 SystemUpdate &= ~SpcMenu[Menustat].len;
 LCDUpdate();
 }
 }
 }
}






void alarmdispupdate()
{
 if(spc_system_flag.bite.alarm_actived)
 {
 if(spc_system_flag.bite.alarm_displayed == 0)
 {
 if(SystemUpdate &  (unsigned long)0x00400000 )
 {
 CopyStr(Actural_disp_str[ 28 ],Info_Line1,16);
 SystemUpdate &= ~ (unsigned long)0x00400000 ;
 LCDUpdate();
 }
 }

 if(SystemUpdate &  (unsigned long)0x00400000 )
 {
 if(spc_system_flag.bite.alarm_displayed)
 {
 SystemUpdate &= ~ (unsigned long)0x00400000 ;
 }
 else
 {
 CopyStr(Actural_disp_str[ 28 ],Info_Line1,16);
 SystemUpdate &= ~ (unsigned long)0x00400000 ;
 LCDUpdate();
 }
 }
 }
}






void SetHeatStatStr(char Strlocat, char ChannelNum)
{
 static char SSRLedStat[2] = {0};
 getParaChar(Actural_disp_str[ 16 +ChannelNum], Strlocat);
 if((Strlocat ==  1 ) || (Strlocat ==  2 ))
 {

 SSRLedStat[ChannelNum] = 1;
 }
 else if((Strlocat ==  0 ) || (Strlocat ==  3 ))
 {

 SSRLedStat[ChannelNum] = 0;
 }

 if((SSRLedStat[0]==0) && (SSRLedStat[1]==0))
  LATE3_bit  = 0;
 else
  LATE3_bit  = 1;
}






void SetTempStatStr(int *temp, char strlocat, char ChannelNum)
{
 char units, strbuf;
 char j=0,i;
 int buffer;
 int MaxTemp,MinTemp;

 units = pSPCValue[0].SPCSetPoints.system_valueb.bite.spc_units_c;
 strlocat += ChannelNum;

 if(units)
 {
 strbuf = 0x1a;
 MaxTemp =  500 ;
 MinTemp =  -50 ;
 }
 else
 {
 strbuf = 0x1b;
 MaxTemp =  932 ;
 MinTemp =  -58 ;
 }

 for(i=0; i<16; i++)
 Actural_disp_str[strlocat][i] = ' ';

 buffer = *temp;
 if(buffer ==  0x7fff )
 {

 for(i=0; i<16; i++)
 Actural_disp_str[strlocat][i] = ParaChar[ 40 ][i];

 return;
 }
 else if(buffer ==  0x7ffd )
 {

 for(i=0; i<16; i++)
 Actural_disp_str[strlocat][i] = ParaChar[ 41 ][i];
 return;
 }
 else
 {
 if(buffer > MaxTemp)
 buffer = MaxTemp;
 if(buffer < MinTemp)
 buffer = MinTemp;
 }



 if(buffer < 0)
 {
 Actural_disp_str[strlocat][j++] = '-';
 buffer = -buffer;
 }

 if(buffer > 99)
 {
 Actural_disp_str[strlocat][j++] = buffer/100 +0x30;
 Actural_disp_str[strlocat][j++] = buffer%100/10 +0x30;
 Actural_disp_str[strlocat][j++] = buffer%10 +0x30;
 }
 else if(buffer > 9)
 {
 Actural_disp_str[strlocat][j++] = buffer/10 +0x30;
 Actural_disp_str[strlocat][j++] = buffer%10 +0x30;
 }
 else
 Actural_disp_str[strlocat][j++] = buffer +0x30;

 Actural_disp_str[strlocat][j++] = ' ';
 Actural_disp_str[strlocat][j++] = strbuf;
}






void SetIntStr(int *ptr, char strlocat, char unitlocar, char len)
{
 char j=0, i;
 volatile int temp;

 temp = *ptr;

 for(i=0; i<16; i++)
 Actural_disp_str[strlocat][i] = ' ';

 if(*ptr ==  0x7ffe )
 {
 for(i=0; i<16; i++)
 Actural_disp_str[strlocat][i] = ParaChar[ 42 ][i];
 return;
 }

 if(*ptr > 999)
 {
 Actural_disp_str[strlocat][j++] = *ptr/1000 +0x30;
 Actural_disp_str[strlocat][j++] = *ptr%1000/100 +0x30;
 Actural_disp_str[strlocat][j++] = *ptr%100/10 +0x30;
 Actural_disp_str[strlocat][j++] = *ptr%10 +0x30;
 }
 else if(*ptr > 99)
 {
 Actural_disp_str[strlocat][j++] = *ptr/100 +0x30;
 Actural_disp_str[strlocat][j++] = *ptr%100/10 +0x30;
 Actural_disp_str[strlocat][j++] = *ptr%10 +0x30;
 }
 else if(*ptr > 9)
 {
 Actural_disp_str[strlocat][j++] = *ptr/10 +0x30;
 Actural_disp_str[strlocat][j++] = *ptr%10 +0x30;
 }
 else
 Actural_disp_str[strlocat][j++] = *ptr +0x30;

 Actural_disp_str[strlocat][j++] = ' ';

 for(i=0;i<len;i++)
 Actural_disp_str[strlocat][j++] = SPCUnit[unitlocar][i];
}






void SetCurrentStr(int *ptr, char strlocat, char unitlocar, char len)
{
 char j=0, i;
 int value_H,value_L;

 for(i=0; i<16; i++)
 Actural_disp_str[strlocat][i] = ' ';

 if(*ptr ==  0x7ffe )
 {

 for(i=0; i<16; i++)
 Actural_disp_str[strlocat][i] = ParaChar[ 42 ][i];
 return;
 }

 value_H = *ptr/10;
 value_L = *ptr%10;

 if(value_H > 9)
 {
 Actural_disp_str[strlocat][j++] = value_H/10 +0x30;
 Actural_disp_str[strlocat][j++] = value_H%10 +0x30;
 }
 else
 Actural_disp_str[strlocat][j++] = value_H +0x30;

 Actural_disp_str[strlocat][j++] = '.';
 Actural_disp_str[strlocat][j++] = value_L +0x30;

 Actural_disp_str[strlocat][j++] = ' ';
 for(i=0;i<len;i++)
 Actural_disp_str[strlocat][j++] = SPCUnit[unitlocar][i];
}






void SetCostStr(ULONG databuff, char strlocat)
{
 char j=0, i;
 ULONG value_H;
 int value_L;
 char Divider;

 for(i=0; i<16; i++)
 Actural_disp_str[strlocat][i] = ' ';

 if((databuff ==  0x7ffe ) || (databuff ==  0X7FFFFFFF ))
 {

 for(i=0; i<16; i++)
 Actural_disp_str[strlocat][i] = ParaChar[ 42 ][i];
 return;
 }

 if((strlocat ==  26 ) || (strlocat ==  27 ))
 Divider = 100;
 else
 Divider = 10;

 value_H = databuff/Divider;
 value_L = databuff%Divider;

 if((strlocat ==  26 ) || (strlocat ==  27 ))
 Actural_disp_str[strlocat][j++] = '$';

 for(i=0; i<8; i++)
 {
 if(value_H / Chr_str[i])
 break;
 else
 value_H %= Chr_str[i];

 if(i == 7)
 Actural_disp_str[strlocat][j++] = value_H + 0x30;
 }

 for(; i<8; i++)
 {
 Actural_disp_str[strlocat][j++] = value_H / Chr_str[i] + 0x30;
 value_H %= Chr_str[i];
 }

 Actural_disp_str[strlocat][j++] = '.';

 if((strlocat ==  26 ) || (strlocat ==  27 ))
 {
 Actural_disp_str[strlocat][j++] = value_L/10 +0x30;
 Actural_disp_str[strlocat][j++] = value_L%10 +0x30;
 }
 else
 {
 Actural_disp_str[strlocat][j++] = value_L +0x30;
 Actural_disp_str[strlocat][j++] = ' ';
 for(i=0;i<3;i++)
 Actural_disp_str[strlocat][j++] = SPCUnit[ 10+1 ][i];
 }
}






void SetOntimeStr(ULONG databuff, char strlocat)
{
 char j=0, i;

 for(i=0; i<16; i++)
 Actural_disp_str[strlocat][i] = ' ';

 if(databuff ==  1500000 )
 {

 for(i=0; i<16; i++)
 Actural_disp_str[strlocat][i] = ParaChar[ 42 ][i];
 return;
 }

 for(i=0; i<8; i++)
 {
 if(databuff / Chr_str[i])
 break;
 else
 databuff %= Chr_str[i];

 if(i == 7)
 Actural_disp_str[strlocat][j++] = databuff + 0x30;
 }

 for(; i<8; i++)
 {
 Actural_disp_str[strlocat][j++] = databuff / Chr_str[i] + 0x30;
 databuff %= Chr_str[i];
 }

 Actural_disp_str[strlocat][j++] = ' ';
 for(i=0;i<5;i++)
 Actural_disp_str[strlocat][j++] = SPCUnit[ 7+1 ][i];
}







void SetAlarmStr(char *ptr, char datasouce, char datatotle,
 char unitype, char len, char cmd)
{
 char i;

 ClearStr(ptr, 16);

 if(datasouce > 9)
 {
 *(ptr++) = datasouce/10 + 0x30;
 *(ptr++) = datasouce%10 + 0x30;
 }
 else
 *(ptr++) = datasouce + 0x30;

 *(ptr++) = '/';

 if(cmd ==  1 )
 {
 if(datatotle > 9)
 {
 *(ptr++) = datatotle/10 + 0x30;
 *(ptr++) = datatotle%10 + 0x30;
 }
 else
 *(ptr++) = datatotle + 0x30;
 }

 for(i=0;i<len;i++)
 *(ptr+i) = SPCUnit[unitype][i];
}

char GetAlarmEn()
{
 return AlarmEn;
}

void AutoAutho()
{
 if(pSPCValue[0].SPCSetPoints.system_valueb.bite.password_en)
 {
 if(AutoAuthoEN == 0)
 {
 AutoAuthoEN = 1;
 AutoAuthoCount = 0;
 }
 else if(AutoAuthoEN == 2)
 {
 AutoAuthoEN = 0;
 AutoAuthoCount = 0;
 }
 }
 else
 {
 AutoAuthoEN = 0;
 AutoAuthoCount = 0;
 }
}

void ResetAutoAutho()
{
 AutoAuthoCount = 0;
}

char GetAutoAutho()
{
 return AutoAuthoEN;
}

void SetAutoAutho(char AutoAuthoCmd)
{
 AutoAuthoEN = AutoAuthoCmd;
}
