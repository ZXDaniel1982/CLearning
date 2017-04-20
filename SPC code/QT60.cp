#line 1 "D:/MyProject/SPC code1/SPC code/QT60.c"
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
#line 1 "d:/myproject/spc code1/spc code/pic18f6622.h"
#line 1 "d:/myproject/spc code1/spc code/string_op.h"
void getParaChar(char *ptr, char locat);
void ClearStr(char *target, int len);
void MemeSet(char *target, char Transdata, int len);
#line 21 "D:/MyProject/SPC code1/SPC code/QT60.c"
struct param_def {
 UCHAR Offset;
 UCHAR Position;
 UCHAR Mask;
 };


volatile unsigned char QtSetupBlock[ 123 ];
volatile UCHAR TestBuff[123];
UCHAR QtAddress = 117;
UCHAR QtKeys[ 3 ];
UCHAR calibufer;



code struct param_def ParamDef[] = {
 { 0, 0, 0x0f },
 { 0, 4, 0x0f },
 { 24, 0, 0x0f },
 { 48, 0, 0x0f },
 { 48, 4, 0x0f },
 { 72, 0, 0xff },
 { 96, 3, 0x01 },
 { 96, 4, 0x03 },
 { 96, 6, 0x01 },
 { 96, 7, 0x01 },
 { 120, 0, 0x07 },
 { 120, 6, 0x01 },
 { 121, 0, 0xff },
 { 122, 0, 0xff }
 };

UCHAR QtCommand =  0x55 ;






void RestoreDefaultQtSetup ( void )
{
 UCHAR i;


 for (i = 0; i < 24; i++)
 {
 QtSetupBlock[i] =  6  + ( 10  << 4);
 QtSetupBlock[i + 24] =  4 ;
 QtSetupBlock[i + 48] =  2  + ( 5  << 4);
 QtSetupBlock[i + 72] =  20 ;
 QtSetupBlock[i + 96] =  2  << 4;
 }


 QtSetupBlock[120] =  3 ;
 QtSetupBlock[121] =  255 ;




 I2C_write (QtAddress,
  130 ,
 &QtCommand,
 1);
 I2C_write (QtAddress,
 131,
 QtSetupBlock,
 122);

}






UCHAR SetQtSetup ( UCHAR Key, UCHAR Param, UCHAR Value, UCHAR WriteFlag )
{
 UCHAR RetVal =  1 ;
 UCHAR Temp;
 UCHAR Index;


 Index = ParamDef[Param].Offset;
 if ( Param <=  9  )
 Index += Key;


 if ( (Index <  123 ) && (Key <  9 ) )
 {

 Temp = (Value & ParamDef[Param].Mask) << ParamDef[Param].Position;
 QtSetupBlock[Index] &= ~(ParamDef[Param].Mask << ParamDef[Param].Position);
 QtSetupBlock[Index] += Temp;

 if ( WriteFlag )
 {
 I2C_write (QtAddress,  130 , &QtCommand, 1);
 I2C_write (QtAddress,  131 , QtSetupBlock,  123 );
 }
 }
 else
 RetVal =  0 ;

 return RetVal;
}






void ReadQtSetup ( void )
{
 I2C_get( QtAddress, 131, TestBuff, 123);
}






void ReadQtKeys ( void )
{
 I2C_get( QtAddress,  1 , QtKeys,  3 );
}






UCHAR GetQtKeys(UCHAR Index)
{
 return QtKeys[Index];
}






void setkeyhold()
{
 MemeSet(QtSetupBlock,  0 ,  9 );
 asm nop;

 I2C_write (QtAddress,
  130 ,
 &QtCommand,
 1);
 I2C_write (QtAddress,
  131 +ParamDef[ 5 ].Offset,
 QtSetupBlock,
  9 );
#line 180 "D:/MyProject/SPC code1/SPC code/QT60.c"
 asm nop;
}






void setkeysence()
{
 volatile UCHAR bufer;

 bufer =  15  + ( 10  << 4);
 MemeSet(QtSetupBlock, bufer,  9 );
 asm nop;

 I2C_write (QtAddress,
  130 ,
 &QtCommand,
 1);
 I2C_write (QtAddress,
  131 +ParamDef[ 0 ].Offset,
 QtSetupBlock,
  9 );
#line 208 "D:/MyProject/SPC code1/SPC code/QT60.c"
 asm nop;
}






void setkeysenceaks()
{
 volatile UCHAR bufer;

 bufer = ( 1  << 6) + (1 << 4);
 MemeSet(QtSetupBlock, bufer,  9 );
#line 224 "D:/MyProject/SPC code1/SPC code/QT60.c"
 asm nop;

 I2C_write (QtAddress,
  130 ,
 &QtCommand,
 1);
 I2C_write (QtAddress,
  131 +ParamDef[ 8 ].Offset,
 QtSetupBlock,
  9 );
#line 238 "D:/MyProject/SPC code1/SPC code/QT60.c"
 asm nop;
}






void enablekeys()
{
 UCHAR bufer;
 char i;

 bufer =  2  + ( 5  << 4);
 for(i=0;i< 9 ;i++)
 {
 QtSetupBlock[i] = bufer;
 }
 bufer = 0 + ( 5  << 4);
 for(;i<24;i++)
 {
 QtSetupBlock[i] = bufer;
 }
 asm nop;

 I2C_write (QtAddress,
  130 ,
 &QtCommand,
 1);
 I2C_write (QtAddress,
  131 +ParamDef[ 3 ].Offset,
 QtSetupBlock,
 24);
#line 275 "D:/MyProject/SPC code1/SPC code/QT60.c"
 asm nop;
}






void calikey()
{
 calibufer = 0x55;
 asm nop;

 I2C_write (QtAddress,
  130 ,
 &QtCommand,
 1);
 I2C_write (QtAddress,
 125,
 &calibufer,
 1);
 Delay_ms(500);
 asm nop;
}
