#line 1 "D:/MyProject/SPC code1/SPC code/modbus.c"
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
#line 1 "d:/myproject/spc code1/spc code/usart.h"



void USART_send(UCHAR *bufout, char len);
void en485rx(void);
void en485tx(void);
void CommunicationErrorCheck(void);
#line 1 "d:/myproject/spc code1/spc code/string_op.h"
void getParaChar(char *ptr, char locat);
void ClearStr(char *target, int len);
void MemeSet(char *target, char Transdata, int len);
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
#line 1 "d:/myproject/spc code1/spc code/eeprom.h"



void EEPROM_get(UINT EEPROM_READ_ADDRESS,UCHAR Len,UCHAR *readbuffer);
void EEPROM_set(UINT EEPROM_WRITE_ADDRESS,UCHAR Len,UCHAR *writebuffer);


UCHAR SPCIfFirstRun(void);
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
#line 1 "d:/myproject/spc code1/spc code/rtd.h"
#line 130 "d:/myproject/spc code1/spc code/rtd.h"
void GetTemperature(TEMPERATURE *RTDA_ptr, char ChannelNum);
UINT GetGFI(char ChannelSelect, char cmd);
signed int ConvertADtoCurrent(unsigned int ADcurrent, char ChannelNum);
unsigned int ConvertADtoGFI(unsigned int ADcurrent, char ChannelNum);
long ConvertADtoTEMP(UINT ADtemp, char paraL, char paraH, char ChannelNum );
void CaliTemp(UINT ADtemp, char paraL, char paraH );

extern unsigned int ADSampleA,ADSampleB;
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
#line 19 "D:/MyProject/SPC code1/SPC code/modbus.c"
char ModbusRecived=0, ModbusValid=0;
unsigned int ModbusCounter=0;
TEMPERATURE TempBuff;

data char modbus_rcdata[100], modbus_txdata[100];
unsigned int modbus_rcn=0, modbus_txn=0;

int *ModbusList[] =
{

 (int *)&pSPCValue[0].SPCSetPoints.MaintainTemp.Temperature_F,
 (int *)&pSPCValue[1].SPCSetPoints.MaintainTemp.Temperature_F,
 (int *)&pSPCValue[0].SPCSetPoints.MaintainTemp.Temperature_C,
 (int *)&pSPCValue[1].SPCSetPoints.MaintainTemp.Temperature_C,
 (int *)&pSPCValue[0].SPCSetPoints.LowTemp.Temperature_F,
 (int *)&pSPCValue[1].SPCSetPoints.LowTemp.Temperature_F,
 (int *)&pSPCValue[0].SPCSetPoints.LowTemp.Temperature_C,
 (int *)&pSPCValue[1].SPCSetPoints.LowTemp.Temperature_C,
 (int *)&pSPCValue[0].SPCSetPoints.HighTemp.Temperature_F,
 (int *)&pSPCValue[1].SPCSetPoints.HighTemp.Temperature_F,
 (int *)&pSPCValue[0].SPCSetPoints.HighTemp.Temperature_C,
 (int *)&pSPCValue[1].SPCSetPoints.HighTemp.Temperature_C,
 (int *)&pSPCValue[0].SPCSetPoints.DeadBand.Temperature_F,
 (int *)&pSPCValue[1].SPCSetPoints.DeadBand.Temperature_F,
 (int *)&pSPCValue[0].SPCSetPoints.DeadBand.Temperature_C,
 (int *)&pSPCValue[1].SPCSetPoints.DeadBand.Temperature_C,
 (int *)&pSPCValue[0].SPCSetPoints.LowCurrent,
 (int *)&pSPCValue[1].SPCSetPoints.LowCurrent,
 (int *)&pSPCValue[0].SPCSetPoints.HighCurrent,
 (int *)&pSPCValue[1].SPCSetPoints.HighCurrent,
 (int *)&pSPCValue[0].SPCSetPoints.GFIAlarm,
 (int *)&pSPCValue[1].SPCSetPoints.GFIAlarm,
 (int *)&pSPCValue[0].SPCSetPoints.GFITrip,
 (int *)&pSPCValue[1].SPCSetPoints.GFITrip,
 (int *)&pSPCValue[0].SPCSetPoints.LimitedCurrent,
 (int *)&pSPCValue[1].SPCSetPoints.LimitedCurrent,
 (int *)&pSPCValue[0].SPCSetPoints.SoftStartTime,
 (int *)&pSPCValue[1].SPCSetPoints.SoftStartTime,
 (int *)&pSPCValue[0].SPCSetPoints.AlarmOutTest,
 (int *)&pSPCValue[1].SPCSetPoints.AlarmOutTest,
 (int *)&pSPCValue[0].SPCSetPoints.HeaterTest,
 (int *)&pSPCValue[1].SPCSetPoints.HeaterTest,
 (int *)&pSPCValue[0].SPCSetPoints.GFTest,
 (int *)&pSPCValue[1].SPCSetPoints.GFTest,
 (int *)&pSPCValue[0].SPCSetPoints.HeaterName[0],
 (int *)&pSPCValue[0].SPCSetPoints.HeaterName[0]+1,
 (int *)&pSPCValue[0].SPCSetPoints.HeaterName[0]+2,
 (int *)&pSPCValue[0].SPCSetPoints.HeaterName[0]+3,
 (int *)&pSPCValue[0].SPCSetPoints.HeaterName[0]+4,
 (int *)&pSPCValue[0].SPCSetPoints.HeaterName[0]+5,
 (int *)&pSPCValue[0].SPCSetPoints.HeaterName[0]+6,
 (int *)&pSPCValue[0].SPCSetPoints.HeaterName[0]+7,
 (int *)&pSPCValue[1].SPCSetPoints.HeaterName[0],
 (int *)&pSPCValue[1].SPCSetPoints.HeaterName[0]+1,
 (int *)&pSPCValue[1].SPCSetPoints.HeaterName[0]+2,
 (int *)&pSPCValue[1].SPCSetPoints.HeaterName[0]+3,
 (int *)&pSPCValue[1].SPCSetPoints.HeaterName[0]+4,
 (int *)&pSPCValue[1].SPCSetPoints.HeaterName[0]+5,
 (int *)&pSPCValue[1].SPCSetPoints.HeaterName[0]+6,
 (int *)&pSPCValue[1].SPCSetPoints.HeaterName[0]+7,
 (int *)&pSPCValue[0].SPCSetPoints.LowVoltage,
 (int *)&pSPCValue[0].SPCSetPoints.HighVoltage,
 (int *)&pSPCValue[0].SPCSetPoints.AutoTestTime,
 (int *)&pSPCValue[0].SPCSetPoints.DisplayTime,
 (int *)&pSPCValue[0].SPCSetPoints.CostPerKWH,
 (int *)&pSPCValue[0].SPCSetPoints.system_valueb,
 (int *)&pSPCValue[0].SPCSetPoints.system_valueb+1,
 (int *)&pSPCValue[1].SPCSetPoints.system_valueb,
 (int *)&pSPCValue[1].SPCSetPoints.system_valueb+1,

 (int *)&pSPCValue[0].SPCActual.Temperature.Temperature_F,
 (int *)&pSPCValue[1].SPCActual.Temperature.Temperature_F,
 (int *)&pSPCValue[0].SPCActual.Temperature.Temperature_C,
 (int *)&pSPCValue[1].SPCActual.Temperature.Temperature_C,
 (int *)&pSPCValue[0].SPCActual.TemperatureA.Temperature_F,
 (int *)&pSPCValue[1].SPCActual.TemperatureA.Temperature_F,
 (int *)&pSPCValue[0].SPCActual.TemperatureA.Temperature_C,
 (int *)&pSPCValue[1].SPCActual.TemperatureA.Temperature_C,
 (int *)&pSPCValue[0].SPCActual.TemperatureB.Temperature_F,
 (int *)&pSPCValue[1].SPCActual.TemperatureB.Temperature_F,
 (int *)&pSPCValue[0].SPCActual.TemperatureB.Temperature_C,
 (int *)&pSPCValue[1].SPCActual.TemperatureB.Temperature_C,
 (int *)&pSPCValue[0].SPCActual.HeaterPow,
 (int *)&pSPCValue[1].SPCActual.HeaterPow,
 (int *)&pSPCValue[0].SPCActual.Current_RMS,
 (int *)&pSPCValue[1].SPCActual.Current_RMS,
 (int *)&pSPCValue[0].SPCActual.GFICurrent,
 (int *)&pSPCValue[1].SPCActual.GFICurrent,

 (int *)&pSPCValue[0].SPCStatistics.MaximumTemp.Temperature_F,
 (int *)&pSPCValue[1].SPCStatistics.MaximumTemp.Temperature_F,
 (int *)&pSPCValue[0].SPCStatistics.MaximumTemp.Temperature_C,
 (int *)&pSPCValue[1].SPCStatistics.MaximumTemp.Temperature_C,
 (int *)&pSPCValue[0].SPCStatistics.MinimumTemp.Temperature_F,
 (int *)&pSPCValue[1].SPCStatistics.MinimumTemp.Temperature_F,
 (int *)&pSPCValue[0].SPCStatistics.MinimumTemp.Temperature_C,
 (int *)&pSPCValue[1].SPCStatistics.MinimumTemp.Temperature_C,
 (int *)&pSPCValue[0].SPCStatistics.MaximumCurrent,
 (int *)&pSPCValue[1].SPCStatistics.MaximumCurrent,
 (int *)&pSPCValue[0].SPCStatistics.MaximumGFCurrent,
 (int *)&pSPCValue[1].SPCStatistics.MaximumGFCurrent,
 (int *)&pSPCValue[0].SPCStatistics.EnergyUsed,
 (int *)&pSPCValue[1].SPCStatistics.EnergyUsed,
 (int *)&pSPCValue[0].SPCStatistics.EnergyCost,
 (int *)&pSPCValue[0].SPCStatistics.EnergyCost+1,
 (int *)&pSPCValue[1].SPCStatistics.EnergyCost,
 (int *)&pSPCValue[1].SPCStatistics.EnergyCost+1,
 (int *)&pSPCValue[0].SPCStatistics.RunTime,
 (int *)&pSPCValue[0].SPCStatistics.RunTime+1,
 (int *)&pSPCValue[1].SPCStatistics.RunTime,
 (int *)&pSPCValue[1].SPCStatistics.RunTime+1,
 (int *)&pSPCValue[0].SPCStatistics.HeaterOnTime,
 (int *)&pSPCValue[1].SPCStatistics.HeaterOnTime,
 (int *)&pSPCValue[0].SPCStatistics.MaximumVoltage,
 (int *)&pSPCValue[0].SPCStatistics.MinimumVoltage,
 (int *)&pSPCValue[0].SPCStatistics.Version
};
#line 150 "D:/MyProject/SPC code1/SPC code/modbus.c"
code char CRCHi_exp[] =
{
 0x00, 0xc1, 0x81, 0x40, 0x01, 0xc0, 0x80, 0x41, 0x01, 0xc0, 0x80, 0x41, 0x00, 0xc1, 0x81,
 0x40, 0x01, 0xc0, 0x80, 0x41, 0x00, 0xc1, 0x81, 0x40, 0x00, 0xc1, 0x81, 0x40, 0x01, 0xc0,
 0x80, 0x41, 0x01, 0xc0, 0x80, 0x41, 0x00, 0xc1, 0x81, 0x40, 0x00, 0xc1, 0x81, 0x40, 0x01,
 0xc0, 0x80, 0x41, 0x00, 0xc1, 0x81, 0x40, 0x01, 0xc0, 0x80, 0x41, 0x01, 0xc0, 0x80, 0x41,
 0x00, 0xc1, 0x81, 0x40, 0x01, 0xc0, 0x80, 0x41, 0x00, 0xc1, 0x81, 0x40, 0x00, 0xc1, 0x81,
 0x40, 0x01, 0xc0, 0x80, 0x41, 0x00, 0xc1, 0x81, 0x40, 0x01, 0xc0, 0x80, 0x41, 0x01, 0xc0,
 0x80, 0x41, 0x00, 0xc1, 0x81, 0x40, 0x00, 0xc1, 0x81, 0x40, 0x01, 0xc0, 0x80, 0x41, 0x01,
 0xc0, 0x80, 0x41, 0x00, 0xc1, 0x81, 0x40, 0x01, 0xc0, 0x80, 0x41, 0x00, 0xc1, 0x81, 0x40,
 0x00, 0xc1, 0x81, 0x40, 0x01, 0xc0, 0x80, 0x41, 0x01, 0xc0, 0x80, 0x41, 0x00, 0xc1, 0x81,
 0x40, 0x00, 0xc1, 0x81, 0x40, 0x01, 0xc0, 0x80, 0x41, 0x00, 0xc1, 0x81, 0x40, 0x01, 0xc0,
 0x80, 0x41, 0x01, 0xc0, 0x80, 0x41, 0x00, 0xc1, 0x81, 0x40, 0x00, 0xc1, 0x81, 0x40, 0x01,
 0xc0, 0x80, 0x41, 0x01, 0xc0, 0x80, 0x41, 0x00, 0xc1, 0x81, 0x40, 0x01, 0xc0, 0x80, 0x41,
 0x00, 0xc1, 0x81, 0x40, 0x00, 0xc1, 0x81, 0x40, 0x01, 0xc0, 0x80, 0x41, 0x00, 0xc1, 0x81,
 0x40, 0x01, 0xc0, 0x80, 0x41, 0x01, 0xc0, 0x80, 0x41, 0x00, 0xc1, 0x81, 0x40, 0x01, 0xc0,
 0x80, 0x41, 0x00, 0xc1, 0x81, 0x40, 0x00, 0xc1, 0x81, 0x40, 0x01, 0xc0, 0x80, 0x41, 0x01,
 0xc0, 0x80, 0x41, 0x00, 0xc1, 0x81, 0x40, 0x00, 0xc1, 0x81, 0x40, 0x01, 0xc0, 0x80, 0x41,
 0x00, 0xc1, 0x81, 0x40, 0x01, 0xc0, 0x80, 0x41, 0x01, 0xc0, 0x80, 0x41, 0x00, 0xc1, 0x81,
 0x40
} ;

code char CRCLo_exp[] =
{
 0x00, 0xc0, 0xc1, 0x01, 0xc3, 0x03, 0x02, 0xc2, 0xc6, 0x06, 0x07, 0xc7, 0x05, 0xc5, 0xc4,
 0x04, 0xcc, 0x0c, 0x0d, 0xcd, 0x0f, 0xcf, 0xce, 0x0e, 0x0a, 0xca, 0xcb, 0x0b, 0xc9, 0x09,
 0x08, 0xc8, 0xd8, 0x18, 0x19, 0xd9, 0x1b, 0xdb, 0xda, 0x1a, 0x1e, 0xde, 0xdf, 0x1f, 0xdd,
 0x1d, 0x1c, 0xdc, 0x14, 0xd4, 0xd5, 0x15, 0xd7, 0x17, 0x16, 0xd6, 0xd2, 0x12, 0x13, 0xd3,
 0x11, 0xd1, 0xd0, 0x10, 0xf0, 0x30, 0x31, 0xf1, 0x33, 0xf3, 0xf2, 0x32, 0x36, 0xf6, 0xf7,
 0x37, 0xf5, 0x35, 0x34, 0xf4, 0x3c, 0xfc, 0xfd, 0x3d, 0xff, 0x3f, 0x3e, 0xfe, 0xfa, 0x3a,
 0x3b, 0xfb, 0x39, 0xf9, 0xf8, 0x38, 0x28, 0xe8, 0xe9, 0x29, 0xeb, 0x2b, 0x2a, 0xea, 0xee,
 0x2e, 0x2f, 0xef, 0x2d, 0xed, 0xec, 0x2c, 0xe4, 0x24, 0x25, 0xe5, 0x27, 0xe7, 0xe6, 0x26,
 0x22, 0xe2, 0xe3, 0x23, 0xe1, 0x21, 0x20, 0xe0, 0xa0, 0x60, 0x61, 0xa1, 0x63, 0xa3, 0xa2,
 0x62, 0x66, 0xa6, 0xa7, 0x67, 0xa5, 0x65, 0x64, 0xa4, 0x6c, 0xac, 0xad, 0x6d, 0xaf, 0x6f,
 0x6e, 0xae, 0xaa, 0x6a, 0x6b, 0xab, 0x69, 0xa9, 0xa8, 0x68, 0x78, 0xb8, 0xb9, 0x79, 0xbb,
 0x7b, 0x7a, 0xba, 0xbe, 0x7e, 0x7f, 0xbf, 0x7d, 0xbd, 0xbc, 0x7c, 0xb4, 0x74, 0x75, 0xb5,
 0x77, 0xb7, 0xb6, 0x76, 0x72, 0xb2, 0xb3, 0x73, 0xb1, 0x71, 0x70, 0xb0, 0x50, 0x90, 0x91,
 0x51, 0x93, 0x53, 0x52, 0x92, 0x96, 0x56, 0x57, 0x97, 0x55, 0x95, 0x94, 0x54, 0x9c, 0x5c,
 0x5d, 0x9d, 0x5f, 0x9f, 0x9e, 0x5e, 0x5a, 0x9a, 0x9b, 0x5b, 0x99, 0x59, 0x58, 0x98, 0x88,
 0x48, 0x49, 0x89, 0x4b, 0x8b, 0x8a, 0x4a, 0x4e, 0x8e, 0x8f, 0x4f, 0x8d, 0x4d, 0x4c, 0x8c,
 0x44, 0x84, 0x85, 0x45, 0x87, 0x47, 0x46, 0x86, 0x82, 0x42, 0x43, 0x83, 0x41, 0x81, 0x80,
 0x40
} ;








int* getRegisterAddr(char RegisterAdrr)
{
 int *ret;

 if(RegisterAdrr < 44)
 {
 ret = (int *)&pSPCValue[Cable_Channel].SPCSetPoints;
 ret += RegisterAdrr;
 }
 else if(RegisterAdrr < 56)
 {
 ret = (int *)&pSPCValue[Cable_Channel].SPCActual;
 ret += (RegisterAdrr-44);
 }
 else if(RegisterAdrr < 70)
 {
 ret = (int *)&pSPCValue[Cable_Channel].SPCStatistics;
 ret += (RegisterAdrr-56);
 }
 else if(RegisterAdrr < 90)
 {
 ret = (int *)&pSPCAlarm.spcalarms.alarm_typ;
 ret += (RegisterAdrr-70);
 }
 else if(RegisterAdrr == 90)
 {

 }

 return ret;
}

char SetErrorMessage(char *ptr, char errortype)
{
 unsigned int crc_temp;
 char len=0;

 *(ptr++) = 1;
 len++;
 *(ptr++) = 1;
 len++;
 *(ptr++) = errortype;
 len++;

 crc_temp = CRCChecksum(ptr, 3);
 *(ptr++) = (crc_temp >> 8) & 0xff;
 len++;
 *ptr = crc_temp & 0xff;
 len++;

 return len;
}

void modbusprocess()
{
 volatile int modbus_data, index, length;
 volatile unsigned int crc_check, crc_rx, crc_tx, AlarmType;
 char i,j, ErrorDetected=0;
 int *Ptr;
 char *PtrTemp;
 volatile unsigned char StringLocate, ResetLocate;
 char ParameterChanged = 0;
 int temp;

 CommunicationErrorCheck();

 if(ModbusValid == 0)
 return;
 ModbusValid = 0;
 RC1IE_bit = 0;


 modbus_txn = 0;
 index = (((UINT)(modbus_rcdata[2]) << 8) | modbus_rcdata[3]);
 length = (((UINT)(modbus_rcdata[4]) << 8) | modbus_rcdata[5]);
 crc_rx = (((unsigned int)(modbus_rcdata[modbus_rcn-2]) << 8) | modbus_rcdata[modbus_rcn-1]);

 if((modbus_rcdata[0] == pSPCValue[Cable_Channel].SPCSetPoints.ModbusAdd) || (modbus_rcdata[0] == 255))
 {
 crc_check = CRCChecksum(modbus_rcdata, modbus_rcn-2);

 if(crc_check == crc_rx)
 {
 modbus_txdata[modbus_txn] = modbus_rcdata[modbus_txn];
 modbus_txn++;
 modbus_txdata[modbus_txn] = modbus_rcdata[modbus_txn];
 modbus_txn++;

 switch(modbus_rcdata[1])
 {
 case 0x03:
 if(modbus_rcn == 8)
 {
 modbus_txdata[modbus_txn++] = length*2;

 for(i=0; i<length ;i++)
 {
 if(((index+i)>=0) && ((index+i)<104))
 {

 Ptr = ModbusList[index+i];
 modbus_txdata[modbus_txn++] = (*Ptr>>8) & 0xff;
 modbus_txdata[modbus_txn++] = *Ptr & 0xff;
 }
 else if((index+i)<104+40)
 {
 Ptr = (int *)&pSPCAlarm.spcalarms.alarm_typ;
 modbus_txdata[modbus_txn++] = (*Ptr>>8) & 0xff;
 modbus_txdata[modbus_txn++] = *Ptr & 0xff;
 }
 else if((index+i)<104+80)
 {
 Ptr = (int *)&pSPCAlarm.spclogs.log_typ;
 modbus_txdata[modbus_txn++] = (*Ptr>>8) & 0xff;
 modbus_txdata[modbus_txn++] = *Ptr & 0xff;
 }
 else if((index+i)==0x7fff0)
 {
 *Ptr =  0X5656 ;
 modbus_txdata[modbus_txn++] = (*Ptr>>8) & 0xff;
 modbus_txdata[modbus_txn++] = *Ptr & 0xff;
 }
 else
 {

 modbus_txn = SetErrorMessage(modbus_txdata,  2 );
 ErrorDetected = 1;
 break;
 }
 }

 if(ErrorDetected == 0)
 {
 crc_tx = CRCChecksum(modbus_txdata, modbus_txn);
 modbus_txdata[modbus_txn++] = (crc_tx >> 8) & 0xff;
 modbus_txdata[modbus_txn++] = crc_tx & 0xff;
 }
 }
 else
 {}
 break;
 case 0x05:
 if(modbus_rcn == 8)
 {
 modbus_data = (((unsigned int)(modbus_rcdata[4]) << 8) | modbus_rcdata[5]);
 if(modbus_data == 0xff00)
 {
 if(index < 184)
 {

 modbus_txn = SetErrorMessage(modbus_txdata,  2 );
 ErrorDetected = 1;
 }
 else if(index < 186)
 {
 temp = index-184;
 if(temp == 0)
 {
 MemeSet((char *)&pSPCAlarm.spcalarms, 0, sizeof(SPCALARM));
 ForceSSROFFCondition[0] &= ~ 0x01 ;
 ForceSSROFFCondition[1] &= ~ 0x01 ;
 ActivedAlarms = 0;
 }
 else
 {
 MemeSet((char *)&pSPCAlarm.spclogs, 0, sizeof(SPCALARM));
 }
 }
 else if(index < 188)
 {
 temp = index-186;
 if(temp < 6)
 {
 PtrTemp = &Statis_flag[0];
 StringLocate = (ResetCmd[temp]>>8) & 0xff;
 }
 else
 {
 temp -= 6;
 PtrTemp = &Statis_flag[1];
 StringLocate = (ResetCmd[temp]>>8) & 0xff;
 StringLocate++;
 }
 ResetLocate = ResetCmd[temp] & 0xff;
 *PtrTemp |= ResetLocate;
 ClearStr(Actural_disp_str[StringLocate], 16);
 }
 else if(index < 190)
 {
 temp = index-188;
 pSPCValue[temp].SPCStatistics.EnergyUsed = 0;
 SetIntStr((int*)&pSPCValue[temp].SPCStatistics.EnergyUsed,  24 +temp,  10+1 , 3);
 }
 else if(index < 192)
 {
 temp = index-190;
 pSPCValue[temp].SPCStatistics.EnergyCost = 0;
 SetCostStr(0,  26 +temp);
 }
 else if(index < 194)
 {
 temp = index-192;
 pSPCValue[temp].SPCStatistics.RunTime = 0;
 SetOntimeStr(0,  0 +temp);
 }
 else if(index < 196)
 {
 temp = index-194;
 pSPCValue[temp].SPCStatistics.HeaterOnTime = 0;
 SetIntStr((int*)&pSPCValue[temp].SPCStatistics.HeaterOnTime,  24 +temp,  10+1 , 3);
 }
 else if(index == 196)
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
 }
 else if(index == 197)
 {
 if(Alarmstat == 0)
 {
 Alarm_SSR_off(0);
 }
 }
 }
 else
 {

 }

 if(ErrorDetected == 0)
 {
 modbus_txn = 8;
 for(i=0;i<8;i++)
 modbus_txdata[i] = modbus_rcdata[i];
 }
 }
 else
 {}
 break;
 case 0x06:
 if(modbus_rcn == 8)
 {
 if(index < 59)
 {
 Ptr = ModbusList[index+i];

 if(modbus_rcdata[0] == 255)
 {

 }
 else
 {
 modbus_data = (((int)(modbus_rcdata[4]) << 8) | modbus_rcdata[5]);
 *Ptr = modbus_data;
 ParameterChanged = 1;
 }

 modbus_txn = 8;
 for(i=0;i<8;i++)
 modbus_txdata[i] = modbus_rcdata[i];
 }
 else
 {

 modbus_txn = SetErrorMessage(modbus_txdata,  2 );
 }
 }
 else
 {}
 break;
 case 0x10:
 if(modbus_rcdata[6] == (length*2))
 {
 if((index+length) < 59)
 {
 Ptr = ModbusList[index+i];
 i=0;
 j=7;
 for(;i<length;i++)
 {
 *Ptr = (unsigned int)modbus_rcdata[j++] << 8;
 *Ptr |= modbus_rcdata[j++];
 Ptr++;
 }
 ParameterChanged = 1;
 }
 else
 {

 modbus_txn = SetErrorMessage(modbus_txdata,  2 );
 ErrorDetected = 1;
 }
 }

 if(ErrorDetected == 0)
 {
 for(i=0;i<4;i++)
 {
 modbus_txdata[modbus_txn] = modbus_rcdata[modbus_txn];
 modbus_txn++;
 }

 crc_tx = CRCChecksum(modbus_txdata, modbus_txn);
 modbus_txdata[modbus_txn++] = (crc_tx >> 8) & 0xff;
 modbus_txdata[modbus_txn++] = crc_tx & 0xff;
 }

 break;
 case 0x16:
 for(i=0;i<15;i++)
 {

 modbus_txdata[modbus_txn++] = (temp >> 8) & 0xff;
 modbus_txdata[modbus_txn++] = temp & 0xff;
 }
#line 540 "D:/MyProject/SPC code1/SPC code/modbus.c"
 crc_tx = CRCChecksum(modbus_txdata, modbus_txn);
 modbus_txdata[modbus_txn++] = (crc_tx >> 8) & 0xff;
 modbus_txdata[modbus_txn++] = crc_tx & 0xff;
 break;
#line 565 "D:/MyProject/SPC code1/SPC code/modbus.c"
 default:
 modbus_txn = SetErrorMessage(modbus_txdata,  1 );
 break;
 }
 }
 else
 {

 }

 modbus_respond();
 }
 else
 {
 modbus_txn = 0;
 modbus_rcn = 0;
 }

 RC1IE_bit = 1;

 if(ParameterChanged)
 {
 Ptr = (int *)&pSPCValue[Cable_Channel].SPCSetPoints;
 for(i=0;i<4;i++)
 {
 EEPROM_get(1+i*sizeof(TEMPERATURE),sizeof(TEMPERATURE),(unsigned char*)&TempBuff);
 if(*(Ptr+i*2) != TempBuff.Temperature_F)
 {
 if((*(Ptr+i*2) ==  0X7fff ) || (*(Ptr+i*2) ==  0X7ffe ))
 *(Ptr+i*2+1) = *(Ptr+i*2);
 else
 *(Ptr+i*2+1) = ConvertFtoC(*(Ptr+i*2));
 }
 else if(*(Ptr+i*2+1) != TempBuff.Temperature_C)
 {
 if((*(Ptr+i*2+1) ==  0X7fff ) || (*(Ptr+i*2+1) ==  0X7ffe ))
 *(Ptr+i*2) = *(Ptr+i*2+1);
 else
 *(Ptr+i*2) = ConvertCtoF(*(Ptr+i*2+1));
 }
 }

 ParametersChanged = 1;
 }
}






void modbus_respond()
{
  LATE1_bit  = 1;
 USART_send(modbus_txdata, modbus_txn);
  LATE1_bit  = 0;
 modbus_txn = 0;
 modbus_rcn = 0;
}
#line 655 "D:/MyProject/SPC code1/SPC code/modbus.c"
void Copydata(UCHAR *source, UCHAR *target, char len)
{
 char i;

 for(i=0; i<len; i++)
 *target = *source;
}






unsigned int CRCChecksum(unsigned char *chkbuf, unsigned char len)
{
 unsigned char uchCRCHi = 0xff ;
 unsigned char uchCRCLo = 0xff ;
 volatile unsigned int uIndex ;
 volatile unsigned int temp_code;

 while (len)
 {
 uIndex = (unsigned int)(uchCRCHi ^ *chkbuf++) ;
 uchCRCHi = (unsigned char)(uchCRCLo ^ CRCHi_exp[uIndex]) ;
 uchCRCLo = CRCLo_exp[uIndex] ;
 len-- ;
 }

 temp_code = (unsigned int) uchCRCHi;
 temp_code = (unsigned int)(temp_code << 8);
 return (unsigned int)(temp_code | uchCRCLo) ;
}

void SetModbusTxData(int TransData)
{
 int CRCBuff;

 modbus_txdata[modbus_txn] = modbus_rcdata[modbus_txn];
 modbus_txn++;
 modbus_txdata[modbus_txn] = modbus_rcdata[modbus_txn];
 modbus_txn++;

 modbus_txdata[modbus_txn++] = (TransData >> 8) & 0x00ff;
 modbus_txdata[modbus_txn++] = TransData & 0x00ff;

 CRCBuff = CRCChecksum(modbus_txdata, modbus_txn);
 modbus_txdata[modbus_txn++] = (CRCBuff >> 8) & 0xff;
 modbus_txdata[modbus_txn++] = CRCBuff & 0xff;
}
