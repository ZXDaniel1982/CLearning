#line 1 "D:/MyProject/SPC code1/SPC code/Menuoperation.c"
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
#line 1 "d:/myproject/spc code1/spc code/qt60.h"
#line 48 "d:/myproject/spc code1/spc code/qt60.h"
void RestoreDefaultQtSetup ( void );
UCHAR SetQtSetup ( UCHAR Key, UCHAR Param, UCHAR Value, UCHAR WriteFlag );
void ReadQtSetup ( void );
void ReadQtKeys ( void );
UCHAR GetQtKeys(UCHAR Index);
void setkeyhold(void);
void setkeysence(void);
void setkeysenceaks(void);
void enablekeys(void);
void calikey(void);
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
#line 1 "d:/myproject/spc code1/spc code/m0220.h"
void MO22OMD_initial(void);
void nybble(void);
void writecom(unsigned char command);
void writedata(unsigned char adata);
void readcom(void);
void LcdInit(void);
void LcdOut(char num,char *line);
void LCD_output(unsigned char *txt1,unsigned char *txt2);
#line 1 "d:/myproject/spc code1/spc code/mcp3202.h"
#line 16 "d:/myproject/spc code1/spc code/mcp3202.h"
static code char ADC_Channel[4] =
{
  0x02 ,
  0x01 ,
  0x08 ,
  0x04 
};

UINT MCP3202_GET_AD_ONCE(UCHAR Spi_Channel,UCHAR Spi_AD_CMD);
UINT MCP3202_GET_AD(UCHAR Spi_Channel,UCHAR Spi_AD_CMD, char NumOfSample);
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
#line 18 "D:/MyProject/SPC code1/SPC code/Menuoperation.c"
unsigned int KeyDetectCount=0,KeyValidCount=0;

char KeyDetectStat= 0 ;
char KeyValidEn=0,KeyHoldEn=0;
char KeyBusy=0;
ULONG KeyValueshape = 0;

const char AlarmFullStr[17] = "Out Of Memory   ";
char ResetPasswordStep = 0;
unsigned int ResetPasswordCount=0;

char ChannelSelStat=0;






ULONG keyboard_get_value()
{
 UINT32 Key_Input;
 UCHAR i;

 ReadQtKeys();
 Key_Input.word = 0;
 for(i=0; i< 3 ; i++)
 {
 Key_Input.byte[i] = GetQtKeys(i);
 }

 return Key_Input.word;
}

char KeyVerify(unsigned long KeyBuff)
{
 static unsigned long KeyVerifyBUff=0;
 static char KeyVerifyStatus=0,KeyVerifyCount=0,KeyHoldCount=0;
 static unsigned int KeyHoldStepCount=0;
 static char KeyErrorCount=0;
 char ret=0;

 switch(KeyVerifyStatus)
 {
 case 0:
 if(KeyBuff != 0)
 {
 KeyVerifyBUff = KeyBuff;
 KeyVerifyStatus = 1;
 KeyVerifyCount = 0;
 KeyHoldCount = 0;
 KeyHoldEn = 0;
 KeyHoldStep = 1;
 KeyHoldStepCount = 0;
 ret=1;
 }
 else
 ret=0;
 break;
 case 1:
 if(KeyVerifyBUff == KeyBuff)
 {
 KeyVerifyCount++;
 if(KeyVerifyCount > 20)
 {
 KeyVerifyCount = 0;
 ret = 1;
 if((KeyBuff ==  16 ) || (KeyBuff ==  4 ))
 {
 KeyHoldCount++;
 if(KeyHoldCount > 5)
 {
 KeyVerifyStatus = 3;
 }
 }
 }
 else
 {
 ret = 0;
 }

 if(KeyErrorCount++ > 2000)
 {
 KeyErrorCount = 0;
 KeyVerifyStatus = 4;
 }
 }
 else
 {
 KeyVerifyCount = 0;
 KeyVerifyStatus = 2;
 ret = 0;
 }
 break;
 case 2:
 KeyVerifyCount++;
 if(KeyVerifyCount > 5)
 {
 KeyVerifyBUff = 0;
 KeyVerifyStatus = 0;
 KeyVerifyCount = 0;
 KeyHoldCount = 0;
 KeyHoldEn = 0;
 KeyHoldStep = 1;
 KeyHoldStepCount = 0;
 ret=0;
 }
 else
 ret = 0;
 break;
 case 3:
 if(KeyVerifyBUff == KeyBuff)
 {


 KeyVerifyCount++;
 if(KeyVerifyCount > 4)
 {
 KeyVerifyCount = 0;
 ret = 1;
 KeyHoldEn = 1;
 }
 else
 {
 ret = 0;
 KeyHoldEn = 0;
 }

 if(KeyErrorCount++ > 2000)
 {
 KeyErrorCount = 0;
 KeyVerifyStatus = 4;
 }
 }
 else
 {
 KeyVerifyBUff = 0;
 KeyVerifyStatus = 0;
 KeyVerifyCount = 0;
 KeyHoldCount = 0;
 KeyHoldEn = 0;
 KeyHoldStep = 1;
 KeyHoldStepCount = 0;
 ret=0;
 }
 break;
 case 4:
 KeyErrorCount = 0;
 KeyVerifyBUff = 0;
 KeyVerifyStatus = 0;
 KeyVerifyCount = 0;
 KeyHoldCount = 0;
 KeyHoldEn = 0;
 KeyHoldStep = 1;
 KeyHoldStepCount = 0;
 ret=0;
 QT60Initial();
 ReadQtSetup();
 break;
 }

 if(KeyHoldEn)
 {
 KeyHoldEn = 0;
#line 186 "D:/MyProject/SPC code1/SPC code/Menuoperation.c"
 if(KeyHoldStepCount > 5)
 {
 KeyHoldStepCount++;
 KeyHoldStep = 10;
 }
 else
 {
 KeyHoldStepCount++;
 KeyHoldStep = 1;
 }
 }

 return ret;
}

void ErrorCheck(unsigned long KeyBuff)
{

 static char ErrorDectect=0,ErrorDectectCount=0;
 if(ErrorDectect)
 {
 if(KeyBuff == 0)
 {
 ErrorDectect = 0;
 ErrorDectectCount++;
 }
 else
 {
 ErrorDectect = 0;
 ErrorDectectCount = 0;
 }
 }
 else
 {
 if(KeyBuff != 0)
 {
 ErrorDectect = 1;
 ErrorDectectCount++;
 }
 else
 {
 ErrorDectectCount = 0;
 }
 }

 if(ErrorDectectCount >= 8)
 {
 ErrorDectectCount = 0;
 ErrorDectect = 0;
 QT60Reset();


 }
}

void EnableTimeout()
{
 spc_system_flag.bite.default_diaped = 0;
 spc_count.Timeout_count = 0;
}





char ResetPSWSeq(char ResetStep)
{
 if(reset_psw_en)
 {
 ResetPasswordStep = 0;
 ResetPasswordCount = 0;
 return 0;
 }
 else
 {
 if(ResetStep ==  0 )
 {
 if((ResetPasswordStep == 0)|| (ResetPasswordStep == 1))
 {
 ResetPasswordStep++;
 ResetPasswordCount = 0;
 }
 else
 {
 ResetPasswordStep = 0;
 ResetPasswordCount = 0;
 }
 return 0;
 }
 else if(ResetStep ==  1 )
 {
 if(ResetPasswordStep == 2)
 {
 ResetPasswordStep++;
 ResetPasswordCount = 0;
 return 0;
 }
 else if(ResetPasswordStep == 3)
 {
 ResetPasswordStep = 0;
 ResetPasswordCount = 0;
 return 1;
 }
 else
 {
 ResetPasswordStep = 0;
 ResetPasswordCount = 0;
 return 0;
 }
 }
 else
 {
 ResetPasswordStep = 0;
 ResetPasswordCount = 0;
 return 0;
 }
 }
}

void SPCMenuOperation()
{
 ULONG KeyValue=0;
 char bUpdate=0;


 KeyValue = keyboard_get_value();
 KeyValue &= 0x000001ff;

 bUpdate = KeyVerify(KeyValue);
 ErrorCheck(KeyValue);

 if(bUpdate)
 {
 switch(KeyValue)
 {
 case  16 :

 ResetAutoAutho();
 if(spc_system_flag.bite.default_diaped == 1)
 {
 ResetPSWSeq( 0 );
 Reset_PSW( 1 , 4 );
 return;
 }

 EnableTimeout();

 if(reset_psw_en)
 Reset_PSW( 1 , 4 );
 else if(ChannelSelStat !=  0 )
 ChannelConfig( 1 , 4 );
 else if(!(spc_system_flag.bite.alarm_actived))
 {
 set_menu_info( 1 , 4 );
 if(spc_system_flag.bite.flashing_en)
 {
 if(spc_system_flag.bite.flashing_state)
 spc_count.scanT = 0;
 }
 }

 LCDUpdate();
 break;
 case  4 :

 ResetAutoAutho();
 if(spc_system_flag.bite.default_diaped == 1)
 {
 ResetPSWSeq( 2 );
 Reset_PSW( 0 , 4 );
 return;
 }

 EnableTimeout();

 if(reset_psw_en)
 Reset_PSW( 0 , 4 );
 else if(ChannelSelStat !=  0 )
 ChannelConfig( 0 , 4 );
 else if(!(spc_system_flag.bite.alarm_actived))
 {
 set_menu_info( 0 , 4 );
 if(spc_system_flag.bite.flashing_en)
 {
 if(spc_system_flag.bite.flashing_state)
 spc_count.scanT = 0;
 }
 }

 LCDUpdate();
 break;
 case  64 :
 ResetPSWSeq( 2 );
 ResetAutoAutho();
 if(spc_system_flag.bite.default_diaped == 1)
 return;
 EnableTimeout();

 Scantime_DIS();
 Flashing_DIS();

 if(spc_system_flag.bite.alarm_actived)
 AlarmRoll( 0 , 1 );
 else if(spc_system_flag.bite.char_actived)
 set_menu_info( 0 , 3 );
 else if(reset_psw_en)
 Reset_PSW( 0 , 3 );
 else if(ChannelSelStat !=  0 )
 {
 if(ChannelSelStat ==  1 )
 MenuRoll( 1 , 0 , 4 );
 else if(ChannelSelStat ==  2 )
 MenuRoll( 1 , 1 , 4 );

 ChannelSelStat =  0 ;
 }
 else
 MenuRoll( 0 , 0 , 6 );

 LCDUpdate();
 break;
 case  0x0100 :
 ResetPSWSeq( 2 );
 ResetAutoAutho();
 if(spc_system_flag.bite.default_diaped == 1)
 return;
 if(ChannelSelStat !=  0 )
 {
 if(ChannelSelStat ==  1 )
 MenuRoll( 1 , 0 , 4 );
 else if(ChannelSelStat ==  2 )
 MenuRoll( 1 , 1 , 4 );

 ChannelSelStat =  0 ;
 }
 else
 {
 rightkey_func();
 }
 EnableTimeout();
 break;
 case  128 :
 ResetPSWSeq( 2 );
 ResetAutoAutho();
 Alarmstat = 0;
 spc_system_flag.bite.char_actived = 0;
 reset_psw_en = 0;
 spc_system_flag.bite.char_flash = 0;
 Lcd_Cmd(_LCD_CURSOR_OFF);
 Scantime_DIS();
 Flashing_DIS();
 if(ChannelSelStat!= 1 )
 {
 ChannelSelStat =  1 ;
 ChannelConfig( 1 , 2 );
 }
 else
 MenuRoll( 1 , 0 , 4 );
 LCDUpdate();
 EnableTimeout();
 break;
 case  32 :
 ResetPSWSeq( 2 );
 ResetAutoAutho();
 EnableTimeout();
 Alarmstat = 0;
 spc_system_flag.bite.alarm_actived = 0;
 spc_system_flag.bite.char_actived = 0;
 spc_system_flag.bite.char_flash = 0;
 reset_psw_en = 0;
 Lcd_Cmd(_LCD_CURSOR_OFF);
 Flashing_DIS();
 Scantime_DIS();
 if(ChannelSelStat!= 2 )
 {
 ChannelSelStat =  2 ;
 ChannelConfig( 1 , 2 );
 }
 else
 MenuRoll( 1 , 1 , 4 );
 LCDUpdate();
 break;
 case  2 :
 ResetPSWSeq( 2 );
 ResetAutoAutho();
 EnableTimeout();
 Menustat = 0;
 spc_system_flag.bite.char_actived = 0;
 spc_system_flag.bite.char_flash = 0;
 reset_psw_en = 0;

 Lcd_Cmd(_LCD_CURSOR_OFF);
 Flashing_DIS();
 Scantime_DIS();
 ChannelSelStat =  0 ;
 AlarmRoll( 1 , 0 );
 LCDUpdate();
 break;
 case  1 :
 ResetPSWSeq( 2 );
 ResetAutoAutho();
 if(spc_system_flag.bite.default_diaped == 1)
 {
 return;
 }

 EnableTimeout();

 Flashing_DIS();
 if(spc_system_flag.bite.alarm_actived)
 AlarmRoll( 0 , 2 );
 else if(reset_psw_en)
 Reset_PSW( 0 , 2 );
 else if(ChannelSelStat !=  0 )
 ChannelConfig( 1 , 2 );
 else
 set_menu_info( 0 , 2 );
 LCDUpdate();
 break;
 case  8 :
 ResetAutoAutho();
 if(ResetPSWSeq( 1 ))
 {
 reset_psw_en = 1;
 Reset_PSW( 0 , 5 );
 LCDUpdate();
 return;
 }

 if(spc_system_flag.bite.default_diaped == 1)
 {
 Reset_PSW( 0 , 1 );
 return;
 }

 if(spc_system_flag.bite.alarm_actived)
 return;
 EnableTimeout();

 if(reset_psw_en)
 Reset_PSW( 0 , 1 );
 else if(ChannelSelStat !=  0 )
 ChannelConfig( 1 , 1 );
 else
 {
 set_menu_info( 0 , 1 );
 }
 Flashing_DIS();
 LCDUpdate();
 break;
 case  0 :
 if(spc_system_flag.bite.default_diaped == 1)
 return;

 KeyValueshape = 0;
 break;
 }

 }

 asm nop;
}






void MenuRoll(UCHAR Forward,UCHAR Para,UCHAR Level)
{
 UCHAR mainloop = 1;
 volatile UCHAR Index_temp,SubIndex_temp,ThirdIndex_temp;
 UCHAR Index_real,SubIndex_real,ThirdIndex_real;

 spc_system_flag.bite.char_flash = 0;

 Index_temp = SpcMenu[Menustat].index;
 SubIndex_temp = SpcMenu[Menustat].subindex;
 ThirdIndex_temp = SpcMenu[Menustat].thirdindex;

 if(spc_system_flag.bite.default_diaped)
 {
 spc_system_flag.bite.default_diaped = 0;
 if(Para ==  0 )
 {
 Menustat = 0;
 mainloop = 0;
 }
 }
 else if(spc_system_flag.bite.alarm_actived)
 spc_system_flag.bite.alarm_actived = 0;
 else if((Level ==  4 ) && (Para == SpcMenu[Menustat].index))
 Level =  5 ;

 while(mainloop)
 {
 if(Forward)
 {
 Menustat++;
 Menustat = (Menustat% 61 );
 }
 else
 {
 if(Menustat == 0)
 Menustat =  61 -1;
 else
 Menustat--;
 }

 Index_real = SpcMenu[Menustat].index;
 SubIndex_real = SpcMenu[Menustat].subindex;
 ThirdIndex_real = SpcMenu[Menustat].thirdindex;

 if(Level ==  4 )
 {
 if((Para == Index_real) && (SubIndex_real == 0) && (ThirdIndex_real == 0))
 mainloop = 0;
 else
 mainloop = 1;
 }
 else if(Level ==  5 )
 {
 if(Index_temp == Index_real)
 {
 if(ThirdIndex_real == 0)
 mainloop = 0;
 else
 mainloop = 1;
 }
 else
 mainloop = 1;
 }
 else if(Level ==  6 )
 {
 if(Index_temp == Index_real)
 {
 if(ThirdIndex_temp == ThirdIndex_real)
 mainloop = 1;
 if((ThirdIndex_real == 0) && (Forward == 0))
 mainloop = 1;
 else
 mainloop = 0;
 }
 else
 mainloop = 1;
 }

 if(SpcMenu[Menustat].flag.bite.menu_active)
 mainloop |= 0;
 else
 mainloop = 1;

 if(MainTainTempDisable(Cable_Channel) == 1)
 {
 if(SpcMenu[Menustat].flag.bite.maintainnone_conflict)
 mainloop = 1;
 else
 mainloop |= 0;
 }

 if(MainTainTempDisable(Cable_Channel) == 2)
 {
 if(SpcMenu[Menustat].flag.bite.maintainoff_conflict)
 mainloop = 1;
 else
 mainloop |= 0;
 }

 if(ProCtlEnable(Cable_Channel))
 {
 if(SpcMenu[Menustat].flag.bite.proportional_conflict)
 mainloop = 1;
 else
 mainloop |= 0;
 }

 if(pSPCValue[0].SPCSetPoints.system_valueb.bite.usr_advanced == 0)
 {
 if(SpcMenu[Menustat].flag.bite.advanced_req)
 mainloop = 1;
 else
 mainloop |= 0;
 }

 if(SelfRegulaEnable(Cable_Channel))
 {
 if(SpcMenu[Menustat].flag.bite.SelfRegula_conflict)
 mainloop = 1;
 else
 mainloop |= 0;
 }
 else
 {
 if(SpcMenu[Menustat].flag.bite.FoxResis_conflict)
 mainloop = 1;
 else
 mainloop |= 0;
 }
 }

 set_menu_info(Forward, 2 );
}






void set_menu_info(UCHAR direction,UCHAR command)
{
 char i;
 char temp;
 for(i=0; i<16; i++)
 Info_Line1[i] = SpcTxtLine1[Menustat][i];

 temp = SpcMenu[Menustat].func_mark;

 switch(temp)
 {
 case  4 :
 TitleSet(direction,command);
 break;
 case  24 :
 ChannelConfig(direction,command);
 break;
 case  25 :
 MaintainTempSet(direction,command);
 break;
 case  26 :
 LowTempAlarmSet(direction,command);
 break;
 case  27 :
 HighTempAlarmSet(direction,command);
 break;
 case  38 :
 DeadbandSet(direction,command);
 break;
 case  36 :
 HeaterIDSet(direction,command);
 break;
 case  47 :
 PasswordEidtorSet(direction,command);
 break;
 case  7 :
 case  5 :
 ResetSPCSet(direction,command);
 break;
 case  1 :
 Para_Flag_Set(direction,command);
 break;
 case  2 :
 Para_int_Set(direction,command);
 break;
 case  3 :
 Para_show(direction,command);
 break;
 case  6 :
 Authority_Set(direction,command);
 break;
 case  22 :
 Version_show(direction,command);
 break;
 }

 asm nop;
}






void AlarmRoll_Index(char trige)
{
 UCHAR index,i;
 char ALARM_NUM, ALARM_UNIT;

 if(spc_system_flag.bite.alarm_actived)
 {

 if(trige)
 spc_system_flag.bite.alarm_displayed ^=  1 ;

 index = spc_system_flag.bite.alarm_displayed;
 if(index)
 {
 ALARM_NUM = pSPCAlarm.spclogs.num_logs;
 ALARM_UNIT =  13 ;

 if(ALARM_NUM >=  20 )
 {
 for(i=0;i<16;i++)
 Info_Line1[i] = AlarmFullStr[i];
 ClearStr(Info_Line2, 16);

 LCDUpdate();
 Delay_ms(1000);
 }
 }
 else
 {
 ALARM_NUM = pSPCAlarm.spcalarms.num_alarms;
 ALARM_UNIT =  11+1 ;

 if(ALARM_NUM >=  20 )
 {
 for(i=0;i<16;i++)
 Info_Line1[i] = AlarmFullStr[i];
 ClearStr(Info_Line2, 16);

 LCDUpdate();
 Delay_ms(1000);
 }
 }

 SetAlarmStr(Info_Line1, ALARM_NUM,  0 , ALARM_UNIT, 7,  0 );
 ClearStr(Info_Line2, 16);
 }
 else
 {

 spc_system_flag.bite.alarm_actived = 1;
 spc_system_flag.bite.alarm_displayed = 0;
 ALARM_NUM = pSPCAlarm.spcalarms.num_alarms;
 ALARM_UNIT =  11+1 ;

 if(ALARM_NUM >=  20 )
 {
 for(i=0;i<16;i++)
 Info_Line1[i] = AlarmFullStr[i];
 ClearStr(Info_Line2, 16);

 LCDUpdate();
 Delay_ms(1000);
 }

 SetAlarmStr(Info_Line1, ALARM_NUM,  0 , ALARM_UNIT, 7,  0 );
 ClearStr(Info_Line2, 16);
 }
 Alarmstat = 0;
 return;
}






void AlarmRoll(UINT Forward,UINT Alarmcmd)
{
 UCHAR index,i=0;
 char ALARM_NUM, ALARM_UNIT;
 char AlarmTypeCount=0;
 unsigned long AlarmTypeBuff=0;

 if(Alarmcmd ==  0 )
 {
 AlarmRoll_Index(1);
 return;
 }
 else if(Alarmcmd ==  2 )
 {
 if(Alarmstat == 0)
 {
 Alarm_SSR_off(0);
 return;
 }

 if(spc_system_flag.bite.alarm_displayed)
 {
 if(pSPCValue[0].SPCSetPoints.system_valueb.bite.password_en==0)
 return;

 if(pSPCAlarm.spclogs.num_logs > 1)
 {
 AlarmTypeBuff = pSPCAlarm.spclogs.log_typ[Alarmstat-1];
 for(i=Alarmstat; i<pSPCAlarm.spclogs.num_logs; i++)
 pSPCAlarm.spclogs.log_typ[i-1] = pSPCAlarm.spclogs.log_typ[i];

 pSPCAlarm.spclogs.num_logs--;

 if(Alarmstat == (pSPCAlarm.spclogs.num_logs+1))
 Alarmstat = 1;
 }
 else if(pSPCAlarm.spclogs.num_logs == 1)
 {
 AlarmTypeBuff = pSPCAlarm.spclogs.log_typ[Alarmstat-1];
 pSPCAlarm.spclogs.num_logs = 0;
 Alarmstat = 0;
 AlarmRoll_Index(0);

 return;
 }
 else
 return;
 }
 else
 {
 if(pSPCAlarm.spcalarms.num_alarms > 1)
 {
 AlarmTypeBuff = pSPCAlarm.spcalarms.alarm_typ[Alarmstat-1];
 for(i=Alarmstat-1;i<pSPCAlarm.spcalarms.num_alarms;i++)
 {
 if(pSPCAlarm.spcalarms.alarm_typ[i] == AlarmTypeBuff)
 AlarmTypeCount++;
 }
 if(AlarmTypeCount == 1)
 {
 switch(AlarmTypeBuff)
 {
 asm nop;
 case  (unsigned long)0x00000400 :
 ForceSSROFFCondition[0] &= ~ 0x01 ;
 alarmoperate(AlarmTypeBuff, 0 );
 break;
 case  (unsigned long)0x00000800 :
 ForceSSROFFCondition[1] &= ~ 0x01 ;
 case  (unsigned long)0x10000000 :
 case  (unsigned long)0x20000000 :
 case  (unsigned long)0x04000000 :
 case  (unsigned long)0x08000000 :
 alarmoperate(AlarmTypeBuff, 0 );
 break;
 default:
 if(ActivedAlarms & AlarmTypeBuff)
 return;
 break;
 }
 }

 for(i=Alarmstat; i<pSPCAlarm.spcalarms.num_alarms; i++)
 pSPCAlarm.spcalarms.alarm_typ[i-1] = pSPCAlarm.spcalarms.alarm_typ[i];

 pSPCAlarm.spcalarms.num_alarms--;
 if(Alarmstat == (pSPCAlarm.spcalarms.num_alarms+1))
 Alarmstat = 1;

 if(pSPCAlarm.spclogs.num_logs ==  20 )
 {
 for(i=0; i< 20 -1; i++)
 pSPCAlarm.spclogs.log_typ[i] = pSPCAlarm.spclogs.log_typ[i+1];

 pSPCAlarm.spclogs.log_typ[ 20 -1] = AlarmTypeBuff;
 }
 else
 {
 pSPCAlarm.spclogs.log_typ[pSPCAlarm.spclogs.num_logs++] = AlarmTypeBuff;
 }
 }
 else if(pSPCAlarm.spcalarms.num_alarms == 1)
 {
 AlarmTypeBuff = pSPCAlarm.spcalarms.alarm_typ[Alarmstat-1];
 switch(AlarmTypeBuff)
 {
 case  (unsigned long)0x00000400 :
 ForceSSROFFCondition[0] &= ~ 0x01 ;
 alarmoperate(AlarmTypeBuff, 0 );
 break;
 case  (unsigned long)0x00000800 :
 ForceSSROFFCondition[1] &= ~ 0x01 ;
 case  (unsigned long)0x10000000 :
 case  (unsigned long)0x20000000 :
 case  (unsigned long)0x04000000 :
 case  (unsigned long)0x08000000 :
 alarmoperate(AlarmTypeBuff, 0 );
 break;
 default:
 if(ActivedAlarms & AlarmTypeBuff)
 return;
 break;
 }

 pSPCAlarm.spcalarms.num_alarms = 0;
 Alarmstat = 0;

 AlarmRoll_Index(0);

 if(pSPCAlarm.spclogs.num_logs ==  20 )
 {
 for(i=0; i< 20 -1; i++)
 pSPCAlarm.spclogs.log_typ[i] = pSPCAlarm.spclogs.log_typ[i+1];

 pSPCAlarm.spclogs.log_typ[ 20 -1] = AlarmTypeBuff;
 }
 else
 {
 pSPCAlarm.spclogs.log_typ[pSPCAlarm.spclogs.num_logs++] = AlarmTypeBuff;
 }
 return;
 }
 else
 return;
 }
 }
 else
 {
 index = spc_system_flag.bite.alarm_displayed;
 if(index)
 {
 ALARM_NUM = pSPCAlarm.spclogs.num_logs;
 ALARM_UNIT =  13 ;
 }
 else
 {
 ALARM_NUM = pSPCAlarm.spcalarms.num_alarms;
 ALARM_UNIT =  11+1 ;
 }

 if(ALARM_NUM == 0)
 {
 SetAlarmStr(Info_Line1, ALARM_NUM,  0 , ALARM_UNIT, 7,  0 );
 ClearStr(Info_Line2, 16);
 return;
 }

 if(Forward)
 {
 if((Alarmstat >= ALARM_NUM) || (Alarmstat >=  20 ))
 Alarmstat = 1;
 else
 Alarmstat++;
 }
 else
 {
 if(Alarmstat <= 1)
 Alarmstat = ALARM_NUM;
 else
 Alarmstat--;
 }
 }
 set_alarm_info(Alarmstat);
}






void set_alarm_info(UCHAR AlarmIndex)
{
 UCHAR index;
 volatile UINT Alarmtype=0;
 char ALARM_NUM, ALARM_UNIT;

 index = spc_system_flag.bite.alarm_displayed;

 if(index)
 {
 ALARM_NUM = pSPCAlarm.spclogs.num_logs;
 ALARM_UNIT =  13 ;
 }
 else
 {
 ALARM_NUM = pSPCAlarm.spcalarms.num_alarms;
 ALARM_UNIT =  11+1 ;
 }

 SetAlarmStr(Info_Line1, AlarmIndex, ALARM_NUM, ALARM_UNIT, 7,  1 );
 Alarmtype = GetAlarmType(AlarmIndex-1,index);
 getParaChar(Info_Line2, Alarmtype+43);
}






UINT GetAlarmType(UCHAR index, char cmd)
{
 char index_bit=0;
 UINT count=0;
 while(count < 32)
 {
 if(cmd)
 index_bit = (pSPCAlarm.spclogs.log_typ[index] >> count) & 0x01;
 else
 index_bit = (pSPCAlarm.spcalarms.alarm_typ[index] >> count) & 0x01;

 if(index_bit)
 return count;
 else
 count++;
 }
}






void LCDUpdate()
{
 LCD_output(Info_Line1,Info_Line2);
}






void rightkey_func()
{
 Scantime_DIS();
 Flashing_DIS();

 if(spc_system_flag.bite.alarm_actived)
 AlarmRoll( 1 , 1 );
 else if(spc_system_flag.bite.char_actived)
 set_menu_info( 1 , 3 );
 else if(reset_psw_en)
 Reset_PSW( 1 , 3 );
 else
 {
 MenuRoll( 1 , 0 , 6 );
 }

 LCDUpdate();
}
