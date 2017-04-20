#line 1 "D:/MyProject/SPC code1/SPC code/SSR.c"
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
#line 1 "d:/myproject/spc code1/spc code/pic18f6622.h"
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
#line 14 "D:/MyProject/SPC code1/SPC code/SSR.c"
code unsigned int duty_table[11] =
{
 0x0000,
 0x8000,
 0xa000,
 0xa800,
 0xaa00,
 0xaa80,
 0xacc0,
 0xabc0,
 0xafc0,
 0xbfc0,
 0xffc0,
};

unsigned int SoftStartElement[2] = {0};
unsigned int SoftStartElementCount[2] = {0};
int dutyshadeSOFTSATRT=0;
int dutyshadeNORMAL=0;

char HeaterEN=0;

char SoftStartDisable[2]={0};
char SSRStatInMeas[2] = {0};
char SSRForceOp[2]={0};

char AlarmForce[2]={0};

char CurrentLimtEn=0;





void Alarm_SSR_on(char ChannelNum)
{
 if(ChannelNum ==  0 )
 {
  LATB4_bit = 1; LATB5_bit = 1; 
 }
 else if(ChannelNum ==  1 )
 {
  LATB1_bit = 1; LATB2_bit = 1; 
 }
}

void Alarm_SSR_off(char ChannelNum)
{
 if(ChannelNum ==  0 )
 {
  LATB4_bit = 0; LATB5_bit = 0; 
 }
 else if(ChannelNum ==  1 )
 {
  LATB1_bit = 0; LATB2_bit = 0; 
 }
}






char relay_on(char ChannelNum)
{
 if(Spcssr[ChannelNum].SSR_actual_stat ==  0 )
 {
 if(ChannelNum)
 LATC5_bit = 1;
 else
 LATC2_bit = 1;
 Spcssr[ChannelNum].SSR_actual_stat =  1 ;
 return 1;
 }
 else
 return 0;
}

char relay_off(char ChannelNum)
{
 if(Spcssr[ChannelNum].SSR_actual_stat ==  1 )
 {
 if(ChannelNum)
 LATC5_bit = 0;
 else
 LATC2_bit = 0;
 Spcssr[ChannelNum].SSR_actual_stat =  0 ;
 return 1;
 }
 else
 return 0;

}

char relay_on_ISR(char ChannelNum)
{
 if(Spcssr[ChannelNum].SSR_actual_stat ==  0 )
 {
 if(ChannelNum)
 LATC5_bit = 1;
 else
 LATC2_bit = 1;
 Spcssr[ChannelNum].SSR_actual_stat =  1 ;
 return 1;
 }
 else
 return 0;
}

char relay_off_ISR(char ChannelNum)
{
 if(Spcssr[ChannelNum].SSR_actual_stat ==  1 )
 {
 if(ChannelNum)
 LATC5_bit = 0;
 else
 LATC2_bit = 0;
 Spcssr[ChannelNum].SSR_actual_stat =  0 ;
 return 1;
 }
 else
 return 0;

}






char softstart(char ChannelNum)
{
 char dutychange=0;
 char temp;

 if(SpcSstart[ChannelNum].SOFTSTART_stat == 0)
 {
 duty_index[ChannelNum] = 1;
 temp = duty_index[ChannelNum];
 pwm_duty[ChannelNum] = duty_table[temp];
 dutychange = 1;
 SpcSstart[ChannelNum].SOFTSTART_cmd = 1;
 SpcSstart[ChannelNum].SOFTSTART_stat = 1;
 Spcpwm[ChannelNum].pwm_cmd = 1;
 if(pSPCValue[ChannelNum].SPCSetPoints.LimitedCurrent ==  0X7fff )
 SoftStartElement[ChannelNum] = pSPCValue[ChannelNum].SPCSetPoints.SoftStartTime/10;
 else
 SoftStartElement[ChannelNum] = pSPCValue[ChannelNum].SPCSetPoints.SoftStartTime*10/pSPCValue[ChannelNum].SPCSetPoints.LimitedCurrent;

 if(dutychange)
 {
 dutyshadeSOFTSATRT = duty_index[ChannelNum]*10;
 SystemUpdate |= ( (unsigned long)0x00010000  << ChannelNum);
 SetIntStr((int*)&dutyshadeSOFTSATRT,  18 +ChannelNum,  8+1 , 1);
 }
 }
 else if(SpcSstart[ChannelNum].SOFTSTART_stat == 1)
 {
 if(SpcSstart[ChannelNum].SOFTSTART_reach == 1)
 {
 SpcSstart[ChannelNum].SOFTSTART_reach = 0;
 if(SpcSstart[ChannelNum].SOFTSTART_count >= pSPCValue[ChannelNum].SPCSetPoints.SoftStartTime)
 {
 SpcSstart[ChannelNum].SOFTSTART_count = 0;
 SoftStartElementCount[ChannelNum] = 0;
 SpcSstart[ChannelNum].SOFTSTART_cmd = 0;
 }
 else
 {
 SpcSstart[ChannelNum].SOFTSTART_count++;
 SoftStartElementCount[ChannelNum]++;
 if(SoftStartElementCount[ChannelNum] >= SoftStartElement[ChannelNum])
 {
 SoftStartElementCount[ChannelNum] = 0;
 if(duty_index[ChannelNum] < 10)
 {
 temp = duty_index[ChannelNum]++;
 pwm_duty[ChannelNum] = duty_table[temp];
 dutychange = 1;
 }
 }
 }
 }

 if(dutychange)
 {
 dutyshadeSOFTSATRT = duty_index[ChannelNum]*10;
 SystemUpdate |= ( (unsigned long)0x00010000  << ChannelNum);
 SetIntStr((int*)&dutyshadeSOFTSATRT,  18 +ChannelNum,  8+1 , 1);
 }

 if(SpcSstart[ChannelNum].SOFTSTART_cmd == 0)
 {
 SpcSstart[ChannelNum].SOFTSTART_stat = 0;
 return 1;
 }
 }

 return 0;
}






void RSSoperation(char ChannelNum)
{
 char LoadForce;

 if(pSPCValue[ChannelNum].SPCSetPoints.system_valueb.bite.heater_en == 0)
 {
 ForceSSROFFCondition[ChannelNum] |=  0x10 ;
 }
 else
 {
 ForceSSROFFCondition[ChannelNum] &= ~ 0x10 ;
 }



 if(ForceSSROFFCondition[ChannelNum] & ( 0x01 + 0x02 + 0x08 + 0x10 ))
 LoadForce =  2 ;
 else
 {
 if(ForceSSRONCondition[ChannelNum] & ( 0x01 + 0x02 + 0x08 ))
 LoadForce =  1 ;
 else
 {
 if(ForceSSROFFCondition[ChannelNum] &  0x04 )
 LoadForce =  2 ;
 else
 {
 if(ForceSSRONCondition[ChannelNum] &  0x04 )
 LoadForce =  1 ;
 else
 LoadForce =  0 ;
 }
 }
 }

 if(LoadForce ==  1 )
 {
 SSRForceOp[ChannelNum] =  1 ;
 if(ForceSSRONCondition[ChannelNum] & ( 0x02  +  0x08 ))
 {
 if(pSPCValue[ChannelNum].SPCSetPoints.LimitedCurrent !=  0X7fff )
 {
 SetHeatStatStr( 1 , ChannelNum);
 Spcpwm[ChannelNum].meas_cmd =  5 ;
 Spcssr[ChannelNum].SSR_stat = 1;
 Spcpwm[ChannelNum].pwm_cmd = 1;
 return;
 }
 }

 if(relay_on(ChannelNum))
 {
 SystemUpdate |= ( (unsigned long)0x00100000  << ChannelNum);
 SetHeatStatStr( 1 , ChannelNum);

 SystemUpdate |= ( (unsigned long)0x00010000  << ChannelNum);
 duty_index[ChannelNum] = 10;
 dutyshadeNORMAL = duty_index[ChannelNum]*10;
 SetIntStr((int*)&dutyshadeNORMAL,  18 +ChannelNum,  9 , 1);

 Spcpwm[ChannelNum].meas_cmd =  5 ;
 Spcssr[ChannelNum].SSR_stat = 1;
 }

 return;
 }
 else if(LoadForce ==  2 )
 {
 SSRForceOp[ChannelNum] =  2 ;
 if(relay_off(ChannelNum))
 {
 SystemUpdate |= ( (unsigned long)0x00100000  << ChannelNum);

 if(pSPCValue[ChannelNum].SPCSetPoints.system_valueb.bite.man_on)
 SetHeatStatStr( 3 , ChannelNum);
 else
 SetHeatStatStr( 0 , ChannelNum);

 SystemUpdate |= ( (unsigned long)0x00010000  << ChannelNum);
 duty_index[ChannelNum] = 0;
 dutyshadeNORMAL = duty_index[ChannelNum];
 SetIntStr((int*)&dutyshadeNORMAL,  18 +ChannelNum,  9 , 1);

 Spcpwm[ChannelNum].meas_cmd =  5 ;
 Spcssr[ChannelNum].SSR_stat = 0;
 }

 return;
 }
 else
 SSRForceOp[ChannelNum] =  0 ;

 if(Spcssr[ChannelNum].SSR_cmd == 1)
 {
 if(Spcssr[ChannelNum].SSR_stat == 0)
 {
 if((pSPCValue[ChannelNum].SPCSetPoints.SoftStartTime ==  0X7fff ) || (SoftStartDisable[ChannelNum]))
 {
 if(pSPCValue[ChannelNum].SPCSetPoints.system_valueb.bite.ctl_type == 0)
 {
 relay_on(ChannelNum);
 SystemUpdate |= ( (unsigned long)0x00100000  << ChannelNum);
 SetHeatStatStr( 1 , ChannelNum);
 Spcpwm[ChannelNum].pwm_cmd = 0;
 Spcpwm[ChannelNum].meas_cmd =  5 ;


 duty_index[ChannelNum] = 10;
 dutyshadeNORMAL = duty_index[ChannelNum]*10;
 if(pSPCValue[ChannelNum].SPCSetPoints.LimitedCurrent !=  0X7fff )
 {
 duty_index[ChannelNum] = pSPCValue[ChannelNum].SPCSetPoints.LimitedCurrent/10;
 dutyshadeNORMAL = pSPCValue[ChannelNum].SPCSetPoints.LimitedCurrent;
 pwm_duty[ChannelNum] = get_duty_table(duty_index[ChannelNum]);
 Spcpwm[ChannelNum].pwm_cmd = 1;
 }

 SystemUpdate |= ( (unsigned long)0x00010000  << ChannelNum);
 SetIntStr((int*)&dutyshadeNORMAL,  18 +ChannelNum,  9 , 1);
 }
 else
 Spcpwm[ChannelNum].pwm_cmd = 1;

 Spcssr[ChannelNum].SSR_stat = 1;
 SoftStartDisable[ChannelNum] = 1;
 }
 else
 {
 if(softstart(ChannelNum))
 {
 if(pSPCValue[ChannelNum].SPCSetPoints.system_valueb.bite.ctl_type == 0)
 {
 relay_on(ChannelNum);
 SystemUpdate |= ( (unsigned long)0x00100000  << ChannelNum);
 SetHeatStatStr( 1 , ChannelNum);
 Spcpwm[ChannelNum].pwm_cmd = 0;
 Spcpwm[ChannelNum].meas_cmd =  5 ;


 duty_index[ChannelNum] = 10;
 dutyshadeNORMAL = duty_index[ChannelNum]*10;
 if(pSPCValue[ChannelNum].SPCSetPoints.LimitedCurrent !=  0X7fff )
 {
 duty_index[ChannelNum] = pSPCValue[ChannelNum].SPCSetPoints.LimitedCurrent/10;
 dutyshadeNORMAL = pSPCValue[ChannelNum].SPCSetPoints.LimitedCurrent;
 pwm_duty[ChannelNum] = get_duty_table(duty_index[ChannelNum]);
 Spcpwm[ChannelNum].pwm_cmd = 1;
 }

 SystemUpdate |= ( (unsigned long)0x00010000  << ChannelNum);
 SetIntStr((int*)&dutyshadeNORMAL,  18 +ChannelNum,  9 , 1);
 }
 else
 Spcpwm[ChannelNum].pwm_cmd = 1;

 Spcssr[ChannelNum].SSR_stat = 1;
 SoftStartDisable[ChannelNum] = 1;
 }
 }
 }
 else
 {
 asm nop;
 if((pSPCValue[ChannelNum].SPCSetPoints.system_valueb.bite.ctl_type == 1) ||
 (pSPCValue[ChannelNum].SPCSetPoints.LimitedCurrent !=  0X7fff ))
 {
 asm nop;
 Spcpwm[ChannelNum].pwm_cmd = 1;
 }
 else
 {
 asm nop;
 Spcpwm[ChannelNum].pwm_cmd = 0;
 }
 }
 }
 else if(Spcssr[ChannelNum].SSR_cmd == 0)
 {
 if(Spcssr[ChannelNum].SSR_stat == 1)
 {
 relay_off(ChannelNum);
 SystemUpdate |= ( (unsigned long)0x00100000  << ChannelNum);
 Spcssr[ChannelNum].SSR_stat = 0;
 SetHeatStatStr( 0 , ChannelNum);
 Spcpwm[ChannelNum].pwm_cmd = 0;
 Spcpwm[ChannelNum].meas_cmd =  5 ;

 SystemUpdate |= ( (unsigned long)0x00010000  << ChannelNum);
 duty_index[ChannelNum] = 0;
 dutyshadeNORMAL = duty_index[ChannelNum];
 SetIntStr((int*)&dutyshadeNORMAL,  18 +ChannelNum,  9 , 1);
 }
 SpcSstart[ChannelNum].SOFTSTART_stat = 0;
 SpcSstart[ChannelNum].SOFTSTART_cmd = 0;
 Spcpwm[ChannelNum].pwm_cmd = 0;
 }
}






void AlarmSSRoperation()
{
 if(AlarmForce[0] ==  1 )
 {
 Alarm_SSR_on(0);
 }

 if(AlarmForce[1] ==  1 )
 {
 Alarm_SSR_on(1);
 }
}






char pwm(char ChannelNum)
{
 char WavesPerPerior=0;

 if(Spcpwm[ChannelNum].pwm_cmd == 0)
 return 0;

 if(ForceSSROFFCondition[ChannelNum] != 0)
 return 0;

 if(SpcSstart[ChannelNum].SOFTSTART_cmd)
 WavesPerPerior = 1;
 else
 WavesPerPerior =  6 ;

 if(Spcpwm[ChannelNum].pwm_count.element_count++ > WavesPerPerior*freq_pori)
 {
 if(shift(pwm_duty[ChannelNum], ChannelNum))
 {
#line 470 "D:/MyProject/SPC code1/SPC code/SSR.c"
 }

 Spcpwm[ChannelNum].pwm_count.element_count = 0;
 }
}






char shift(unsigned int dduty, char ChannelNum)
{
 if(ChannelNum == 0)
 asm nop;

 if(Spcpwm[ChannelNum].pwm_count.duty_count <= 10)
 {
 if((dduty << Spcpwm[ChannelNum].pwm_count.duty_count) & 0x8000)
 {
 if(relay_on_ISR(ChannelNum))
 {
 asm nop;
 Spcpwm[ChannelNum].meas_cmd =  1 ;
 Spcpwm[ChannelNum].pwm_count.meas_count = 0;
 }
 }
 else
 {
 if(relay_off_ISR(ChannelNum))
 Spcpwm[ChannelNum].meas_cmd =  0 ;
 }

 Spcpwm[ChannelNum].pwm_count.duty_count++;
 if(Spcpwm[ChannelNum].pwm_count.duty_count == 10)
 {
 asm nop;
 Spcpwm[ChannelNum].pwm_count.duty_count = 0;
 return 1;
 }
 else
 return 0;
 }
}






void countformeasurement(char ChannelNum)
{
 if(Spcpwm[ChannelNum].meas_cmd ==  5 )
 {
 if(Spcpwm[ChannelNum].pwm_count.meas_count++ > 100*freq_pori)
 {
 asm nop;
 Spcpwm[ChannelNum].pwm_count.meas_count = 0;
 Spcpwm[ChannelNum].meas_cmd =  1 ;
 }
 }
 else if(Spcpwm[ChannelNum].meas_cmd ==  1 )
 {
 if(Spcpwm[ChannelNum].pwm_count.meas_count++ > 3*freq_pori)
 {
 asm nop;
 Spcpwm[ChannelNum].pwm_count.meas_count = 0;
 Spcpwm[ChannelNum].meas_cmd =  2 ;
 }
 }
 else if(Spcpwm[ChannelNum].meas_cmd ==  3 )
 {
 if(ADC_busy[ChannelNum] ==  2 )
 {
 if(Spcpwm[ChannelNum].pwm_count.meas_count++ > freq_pori)
 {
 asm nop;
 Spcpwm[ChannelNum].pwm_count.meas_count = 0;
 Spcpwm[ChannelNum].meas_cmd =  4 ;
 SSRStatInMeas[ChannelNum] = Spcssr[ChannelNum].SSR_actual_stat;
 }
 }
 else
 Spcpwm[ChannelNum].meas_cmd =  5 ;
 }
}





unsigned int get_duty_table(char index)
{
 volatile unsigned int dtemp;
 dtemp = duty_table[index];
 return dtemp;
}
