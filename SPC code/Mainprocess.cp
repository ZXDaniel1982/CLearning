#line 1 "D:/MyProject/SPC code1/SPC code/Mainprocess.c"
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
#line 1 "d:/myproject/spc code1/spc code/rtd.h"
#line 130 "d:/myproject/spc code1/spc code/rtd.h"
void GetTemperature(TEMPERATURE *RTDA_ptr, char ChannelNum);
UINT GetGFI(char ChannelSelect, char cmd);
signed int ConvertADtoCurrent(unsigned int ADcurrent, char ChannelNum);
unsigned int ConvertADtoGFI(unsigned int ADcurrent, char ChannelNum);
long ConvertADtoTEMP(UINT ADtemp, char paraL, char paraH, char ChannelNum );
void CaliTemp(UINT ADtemp, char paraL, char paraH );

extern unsigned int ADSampleA,ADSampleB;
#line 1 "d:/myproject/spc code1/spc code/adc.h"
unsigned int read_adc(void);
void Getvoltage(void);
signed int ConvertADtoVoltage(unsigned int ADcurrent, char freq);
void GetFreqency(void);
#line 1 "d:/myproject/spc code1/spc code/usart.h"



void USART_send(UCHAR *bufout, char len);
void en485rx(void);
void en485tx(void);
void CommunicationErrorCheck(void);
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
#line 1 "d:/myproject/spc code1/spc code/string_op.h"
void getParaChar(char *ptr, char locat);
void ClearStr(char *target, int len);
void MemeSet(char *target, char Transdata, int len);
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
#line 25 "D:/MyProject/SPC code1/SPC code/Mainprocess.c"
unsigned int equalcount[2]={0};
unsigned int energycount=0;

char energyacc=0;
int dutyshadePI[2]={0};

char HighTempCutoffEn[2] = {0};

unsigned int HighCurrentAlarmCount[2]={0};
char HighCurrentEn[2]={0};






void VTProcess()
{
 static char TempChannel1_Finish=0, TempChannel2_Finish=0;


 if(spc_system_flag.bite.meas_VT_reach & 0x01)
 Voltprocess();


 if(spc_system_flag.bite.meas_VT_reach & 0x02)
 {

 if(TempChannel1_Finish == 0)
 {
 if(pSPCValue[ 0 ].SPCSetPoints.MaintainTemp.Temperature_C !=  0X7fff )
 TempChannel1_Finish = Tempprocess( 0 );
 else
 {
 asm nop;
 Spcssr[ 0 ].SSR_cmd = 0;
 ADC_busy[ 0 ] =  0 ;
 TempChannel1_Finish = 1;

 }
 }

 if(TempChannel2_Finish == 0)
 {
 if(pSPCValue[ 1 ].SPCSetPoints.MaintainTemp.Temperature_C !=  0X7fff )
 TempChannel2_Finish = Tempprocess( 1 );
 else
 {
 asm nop;
 Spcssr[ 1 ].SSR_cmd = 0;
 ADC_busy[ 1 ] =  0 ;
 TempChannel2_Finish = 1;

 }
 }

 if((TempChannel1_Finish) && (TempChannel2_Finish))
 {
 TempChannel1_Finish = 0;
 TempChannel2_Finish = 0;
 spc_system_flag.bite.meas_VT_reach &= 0xfd;
 }
 }
}






void CGProcess(char ChannelNum)
{
 int CurrentBuff,GFIBuff;

 if(Spcpwm[ChannelNum].meas_cmd ==  2 )
 {
 if((ADC_busy[ChannelNum] ==  1 ) || (ADC_busy[ChannelNum] ==  3 ))
 return;
 else
 {
 ADC_busy[ChannelNum] =  2 ;
 spc_count.meas_CG_count[ChannelNum] = 0;
 SpcAcc[ChannelNum].Current_acc = 0;
 SpcAcc[ChannelNum].GFI_acc = 0;
 Spcpwm[ChannelNum].meas_cmd =  3 ;
 while(Spcpwm[ChannelNum].meas_cmd ==  3 )
 {
 SpcAcc[ChannelNum].Current_acc += GetGFI(ADC_Channel[ChannelNum],  0x80 + 0x20 );
 SpcAcc[ChannelNum].GFI_acc += GetGFI(ADC_Channel[ChannelNum],  0x80 + 0x40 + 0x20 );
 spc_count.meas_CG_count[ChannelNum]++;
 }
 }
 }
 else if(Spcpwm[ChannelNum].meas_cmd ==  4 )
 {
 if(SpcAcc[ChannelNum].Current_acc == 0)
 CurrentBuff = 0;
 else
 CurrentBuff = SpcAcc[ChannelNum].Current_acc/spc_count.meas_CG_count[ChannelNum];

 if(SpcAcc[ChannelNum].GFI_acc == 0)
 GFIBuff = 0;
 else
 GFIBuff = SpcAcc[ChannelNum].GFI_acc/spc_count.meas_CG_count[ChannelNum];

 pSPCValue[ChannelNum].SPCActual.Current = ConvertADtoCurrent(CurrentBuff, ChannelNum);
 pSPCValue[ChannelNum].SPCActual.GFICurrent = ConvertADtoGFI(GFIBuff, ChannelNum);


 if(pSPCValue[ChannelNum].SPCActual.Current >  300 )
 {
 pSPCValue[ChannelNum].SPCActual.Current =  0x7ffe ;
 }
 else
 {
 if(duty_index[ChannelNum] == 0)
 pSPCValue[ChannelNum].SPCActual.Current_RMS = pSPCValue[ChannelNum].SPCActual.Current;
 else
 pSPCValue[ChannelNum].SPCActual.Current_RMS = pSPCValue[ChannelNum].SPCActual.Current*duty_index[ChannelNum]/10;
 }

 if(pSPCValue[ChannelNum].SPCActual.GFICurrent >  500 )
 pSPCValue[ChannelNum].SPCActual.GFICurrent =  0x7ffe ;

 SystemUpdate |= ( (unsigned long)0x00000010  << ChannelNum);
 SetIntStr((int*)&pSPCValue[ChannelNum].SPCActual.GFICurrent,  2 +ChannelNum,  4+1 , 2);
 SetCurrentStr((int*)&pSPCValue[ChannelNum].SPCActual.Current_RMS,  4 +ChannelNum,  4 , 1);

 Currentprocess(ChannelNum);

 ADC_busy[ChannelNum] =  0 ;
 Spcpwm[ChannelNum].meas_cmd =  5 ;
 }
}






void TempErrorAction(char ChannelNum, char ActionCmd)
{
 if(ActionCmd)
 {
 if(pSPCValue[ChannelNum].SPCSetPoints.system_valueb.bite.rtd_fail_mod)
 {
 ForceSSRONCondition[ChannelNum] |=  0x08 ;
 ForceSSROFFCondition[ChannelNum] &= ~ 0x04 ;
 }
 else
 {
 ForceSSRONCondition[ChannelNum] &= ~ 0x08 ;
 ForceSSROFFCondition[ChannelNum] |=  0x04 ;
 }
 }
 else
 {
 ForceSSRONCondition[ChannelNum] &= ~ 0x08 ;
 ForceSSROFFCondition[ChannelNum] &= ~ 0x04 ;
 }
}

void TempStatistics(char ChannelNum, char HighMode, char LowMode)
{
 TEMPERATURE *StaticticsT;
 char StaticsChange=0,units;
 signed int *temp_ptr;

 StaticticsT = &pSPCValue[ChannelNum].SPCActual.TemperatureA+HighMode;
 units = pSPCValue[0].SPCSetPoints.system_valueb.bite.spc_units_c;
 if(Statis_flag[ChannelNum] &  1 )
 {
 Statis_flag[ChannelNum] &= ~ 1 ;

 pSPCValue[ChannelNum].SPCStatistics.MaximumTemp.Temperature_C
 = StaticticsT->Temperature_C;
 pSPCValue[ChannelNum].SPCStatistics.MaximumTemp.Temperature_F
 = StaticticsT->Temperature_F;

 SystemUpdate |= ( (unsigned long)0x00001000  << ChannelNum);
 temp_ptr = (signed int *)(&pSPCValue[ChannelNum].SPCStatistics.MaximumTemp) + units;
 SetTempStatStr(temp_ptr,  12 , ChannelNum);
 StaticsChange = 1;
 }

 if(StaticticsT->Temperature_C !=  0x7fff )
 {
 if((pSPCValue[ChannelNum].SPCStatistics.MaximumTemp.Temperature_C ==  0x7fff ) ||
 (StaticticsT->Temperature_C > pSPCValue[ChannelNum].SPCStatistics.MaximumTemp.Temperature_C))
 {
 pSPCValue[ChannelNum].SPCStatistics.MaximumTemp.Temperature_C =
 StaticticsT->Temperature_C;
 pSPCValue[ChannelNum].SPCStatistics.MaximumTemp.Temperature_F =
 StaticticsT->Temperature_F;

 SystemUpdate |= ( (unsigned long)0x00001000  << ChannelNum);
 temp_ptr = (signed int *)(&pSPCValue[ChannelNum].SPCStatistics.MaximumTemp) + units;
 SetTempStatStr(temp_ptr,  12 , ChannelNum);
 StaticsChange = 1;
 }
 }

 StaticticsT = &pSPCValue[ChannelNum].SPCActual.TemperatureA+LowMode;
 if(Statis_flag[ChannelNum] &  2 )
 {
 Statis_flag[ChannelNum] &= ~ 2 ;

 pSPCValue[ChannelNum].SPCStatistics.MinimumTemp.Temperature_C
 = StaticticsT->Temperature_C;
 pSPCValue[ChannelNum].SPCStatistics.MinimumTemp.Temperature_F
 = StaticticsT->Temperature_F;

 SystemUpdate |= ( (unsigned long)0x00004000  << ChannelNum);
 temp_ptr = (signed int *)(&pSPCValue[ChannelNum].SPCStatistics.MinimumTemp) + units;
 SetTempStatStr(temp_ptr, 14 , ChannelNum);
 StaticsChange = 1;
 }

 if(StaticticsT->Temperature_C !=  0x7ffd )
 {
 if(StaticticsT->Temperature_C ==  0x7fff )
 {
 if(pSPCValue[ChannelNum].SPCStatistics.MinimumTemp.Temperature_C !=  0x7fff )
 {
 pSPCValue[ChannelNum].SPCStatistics.MinimumTemp.Temperature_C =  0x7fff ;
 pSPCValue[ChannelNum].SPCStatistics.MinimumTemp.Temperature_F =  0x7fff ;
 SystemUpdate |= ( (unsigned long)0x00004000  << ChannelNum);
 temp_ptr = (signed int *)(&pSPCValue[ChannelNum].SPCStatistics.MinimumTemp) + units;
 SetTempStatStr(temp_ptr, 14 , ChannelNum);
 StaticsChange = 1;
 }
 }
 else
 {
 if((pSPCValue[ChannelNum].SPCStatistics.MinimumTemp.Temperature_C !=  0x7fff ) &&
 (StaticticsT->Temperature_C < pSPCValue[ChannelNum].SPCStatistics.MinimumTemp.Temperature_C))
 {
 pSPCValue[ChannelNum].SPCStatistics.MinimumTemp.Temperature_C = StaticticsT->Temperature_C;
 pSPCValue[ChannelNum].SPCStatistics.MinimumTemp.Temperature_F = StaticticsT->Temperature_F;
 SystemUpdate |= ( (unsigned long)0x00004000  << ChannelNum);
 temp_ptr = (signed int *)(&pSPCValue[ChannelNum].SPCStatistics.MinimumTemp) + units;
 SetTempStatStr(temp_ptr, 14 , ChannelNum);
 StaticsChange = 1;
 }
 }
 }

 if(StaticsChange)
 EEPROM_set(0x01+2*sizeof(SPCSETPIONTS)+ChannelNum*sizeof(STATISTICS),sizeof(STATISTICS),(UCHAR*)(&pSPCValue[ChannelNum].SPCStatistics));
}

char Tempprocess(char ChannelNum)
{
 char duty_val, units, RTD_stat= 0 ;
 signed int temp_val;
 signed int *tempa_ptr, *tempb_ptr, *temp_ptr;
 signed int StatisticsTempHigh,StatisticsTempLow;
 char dispmodetemp;

 dispmodetemp = pSPCValue[ChannelNum].SPCSetPoints.system_valueb.bite.rtd_opr;


 if(ADC_busy[ChannelNum] ==  2 )
 {
 ADC_busy[ChannelNum] =  3 ;
 return 0;
 }
 else
 ADC_busy[ChannelNum] =  1 ;

 units = pSPCValue[0].SPCSetPoints.system_valueb.bite.spc_units_c;
 tempa_ptr = (signed int *)(&pSPCValue[ChannelNum].SPCActual.TemperatureA) + units;
 tempb_ptr = (signed int *)(&pSPCValue[ChannelNum].SPCActual.TemperatureB) + units;
 temp_ptr = (signed int *)(&pSPCValue[ChannelNum].SPCActual.Temperature) + units;

 spc_system_flag.bite.temp_err = 0;

 GetTemperature(&pSPCValue[ChannelNum].SPCActual.TemperatureA, ChannelNum);

 if(dispmodetemp ==  0 )
 {
 if(ActivedAlarms & ( (unsigned long)0x00400000  << ChannelNum))
 alarmoperate( (unsigned long)0x00400000  << ChannelNum, 0 );
 if(ActivedAlarms & ( (unsigned long)0x01000000  << ChannelNum))
 alarmoperate( (unsigned long)0x01000000  << ChannelNum, 0 );
 }
 else
 {
 if(*tempb_ptr ==  0x7fff )
 {
 RTD_stat |=  2 ;
 if(ActivedAlarms & ( (unsigned long)0x00400000  << ChannelNum))
 alarmoperate( (unsigned long)0x00400000  << ChannelNum, 0 );
 if(!(ActivedAlarms & ( (unsigned long)0x01000000  << ChannelNum)))
 alarmoperate( (unsigned long)0x01000000  << ChannelNum, 1 );
 }
 else if(*tempb_ptr ==  0x7ffd )
 {
 RTD_stat |=  2 ;
 if(ActivedAlarms & ( (unsigned long)0x01000000  << ChannelNum))
 alarmoperate( (unsigned long)0x01000000  << ChannelNum, 0 );
 if(!(ActivedAlarms & ( (unsigned long)0x00400000  << ChannelNum)))
 alarmoperate( (unsigned long)0x00400000  << ChannelNum, 1 );
 }
 else
 {
 if(ActivedAlarms & ( (unsigned long)0x00400000  << ChannelNum))
 alarmoperate( (unsigned long)0x00400000  << ChannelNum, 0 );
 if(ActivedAlarms & ( (unsigned long)0x01000000  << ChannelNum))
 alarmoperate( (unsigned long)0x01000000  << ChannelNum, 0 );
 }
 }
 if(*tempa_ptr ==  0x7fff )
 {
 RTD_stat |=  1 ;
 if(!(ActivedAlarms & ( (unsigned long)0x00100000  << ChannelNum)))
 alarmoperate( (unsigned long)0x00100000  << ChannelNum, 1 );
 if(ActivedAlarms & ( (unsigned long)0x00040000  << ChannelNum))
 alarmoperate( (unsigned long)0x00040000  << ChannelNum, 0 );
 }
 else if(*tempa_ptr ==  0x7ffd )
 {
 RTD_stat |=  1 ;
 if(!(ActivedAlarms & ( (unsigned long)0x00040000  << ChannelNum)))
 alarmoperate( (unsigned long)0x00040000  << ChannelNum, 1 );
 if(ActivedAlarms & ( (unsigned long)0x00100000  << ChannelNum))
 alarmoperate( (unsigned long)0x00100000  << ChannelNum, 0 );
 }
 else
 {
 if(ActivedAlarms & ( (unsigned long)0x00040000  << ChannelNum))
 alarmoperate( (unsigned long)0x00040000  << ChannelNum, 0 );
 if(ActivedAlarms & ( (unsigned long)0x00100000  << ChannelNum))
 alarmoperate( (unsigned long)0x00100000  << ChannelNum, 0 );
 }

 if(RTD_stat &  1 )
 {
 if((RTD_stat &  2 ) || (pSPCValue[ChannelNum].SPCSetPoints.system_valueb.bite.rtd_opr ==  0 ))
 {
 RTD_stat |=  4 ;
 spc_system_flag.bite.temp_err = 1;
 }
 }

 if(pSPCValue[ChannelNum].SPCSetPoints.system_valueb.bite.rtd_opr ==  0 )
 {
 StatisticsTempHigh =  0 ;
 StatisticsTempLow =  0 ;
 }
 else
 {
 if((*tempa_ptr ==  0x7fff ) || (*tempb_ptr ==  0x7fff ))
 {
 StatisticsTempLow =  0 ;
 }
 else
 {
 if(*tempa_ptr > *tempb_ptr)
 StatisticsTempLow =  1 ;
 else
 StatisticsTempLow =  0 ;
 }

 if((*tempa_ptr ==  0x7ffd ) || (*tempb_ptr ==  0x7ffd ))
 {
 StatisticsTempHigh =  0 ;
 }
 else
 {
 if(*tempa_ptr ==  0x7fff )
 {
 if(*tempb_ptr ==  0x7fff )
 StatisticsTempHigh =  0 ;
 else
 StatisticsTempHigh =  1 ;
 }
 else
 {
 if(*tempb_ptr ==  0x7fff )
 StatisticsTempHigh =  0 ;
 else
 {
 if(*tempa_ptr > *tempb_ptr)
 StatisticsTempHigh =  0 ;
 else
 StatisticsTempHigh =  1 ;
 }
 }
 }
 }

 TempStatistics(ChannelNum, StatisticsTempHigh, StatisticsTempLow);

 if(spc_system_flag.bite.temp_err)
 {
 TempErrorAction(ChannelNum, 1);

 spc_system_flag.bite.temp_update = 1;
 CopyTemp(&(pSPCValue[ChannelNum].SPCActual.TemperatureA),
 &(pSPCValue[ChannelNum].SPCActual.Temperature));
 SystemUpdate |= ( (unsigned long)0x00000400  << ChannelNum);
 SetTempStatStr(temp_ptr,  6 , ChannelNum);
 SetTempStatStr(tempa_ptr,  8 , ChannelNum);
 SetTempStatStr(tempb_ptr,  10 , ChannelNum);

 HighTempCutoffEn[ChannelNum] = 0;
 ForceSSROFFCondition[ChannelNum] &= ~ 0x02 ;

 ADC_busy[ChannelNum] =  0 ;

 if(ActivedAlarms & ( (unsigned long)0x00000001  << ChannelNum))
 alarmoperate( (unsigned long)0x00000001  << ChannelNum, 0 );

 if(ActivedAlarms & ( (unsigned long)0x00000004  << ChannelNum))
 alarmoperate( (unsigned long)0x00000004  << ChannelNum, 0 );
 return 1;
 }
 else
 {
 TempErrorAction(ChannelNum, 0);
 }

 CalSystemTemp(ChannelNum, RTD_stat);
 SystemUpdate |= ( (unsigned long)0x00000400  << ChannelNum);
 SetTempStatStr(temp_ptr,  6 , ChannelNum);
 SetTempStatStr(tempa_ptr,  8 , ChannelNum);
 SetTempStatStr(tempb_ptr,  10 , ChannelNum);




 if((pSPCValue[ChannelNum].SPCActual.Temperature.Temperature_C ==  0x7fff ) ||
 (pSPCValue[ChannelNum].SPCActual.Temperature.Temperature_C ==  0x7ffd ))
 {
 ADC_busy[ChannelNum] =  0 ;
 return 1;
 }

 if(pSPCValue[ChannelNum].SPCSetPoints.MaintainTemp.Temperature_C ==  0X7fff )
 {
 asm nop;
 Spcssr[ChannelNum].SSR_cmd = 0;
 if(ActivedAlarms & ( (unsigned long)0x00000001  << ChannelNum))
 alarmoperate( (unsigned long)0x00000001  << ChannelNum, 0 );

 if(ActivedAlarms & ( (unsigned long)0x00000004  << ChannelNum))
 alarmoperate( (unsigned long)0x00000004  << ChannelNum, 0 );
 }
 else
 {
 if((pSPCValue[ChannelNum].SPCActual.Temperature.Temperature_C >
 pSPCValue[ChannelNum].SPCSetPoints.HighTemp.Temperature_C) &&
 (pSPCValue[ChannelNum].SPCSetPoints.HighTemp.Temperature_C !=  0X7fff ))
 {
 if(HighTempCutoffEn[ChannelNum] == 0)
 {
 if(!(ActivedAlarms & ( (unsigned long)0x00000004  << ChannelNum)))
 alarmoperate( (unsigned long)0x00000004  << ChannelNum, 1 );
 }

 if(ActivedAlarms & ( (unsigned long)0x00000001  << ChannelNum))
 alarmoperate( (unsigned long)0x00000001  << ChannelNum, 0 );
 }
 else if((pSPCValue[ChannelNum].SPCActual.Temperature.Temperature_C <
 pSPCValue[ChannelNum].SPCSetPoints.LowTemp.Temperature_C) &&
 (pSPCValue[ChannelNum].SPCSetPoints.LowTemp.Temperature_C !=  0X7fff ))
 {
 if(!(ActivedAlarms & ( (unsigned long)0x00000001  << ChannelNum)))
 alarmoperate( (unsigned long)0x00000001  << ChannelNum, 1 );

 if(HighTempCutoffEn[ChannelNum] == 0)
 {
 if(ActivedAlarms & ( (unsigned long)0x00000004  << ChannelNum))
 alarmoperate( (unsigned long)0x00000004  << ChannelNum, 0 );
 }
 }
 else
 {
 if(ActivedAlarms & ( (unsigned long)0x00000001  << ChannelNum))
 alarmoperate( (unsigned long)0x00000001  << ChannelNum, 0 );

 if(HighTempCutoffEn[ChannelNum] == 0)
 {
 if(ActivedAlarms & ( (unsigned long)0x00000004  << ChannelNum))
 alarmoperate( (unsigned long)0x00000004  << ChannelNum, 0 );
 }
 }

 if(pSPCValue[ChannelNum].SPCSetPoints.MaintainTemp.Temperature_C ==  0X7ffe )
 {
 asm nop;
 Spcssr[ChannelNum].SSR_cmd = 0;
 ADC_busy[ChannelNum] =  0 ;
 return 1;
 }



 if(SSRForceOp[ChannelNum] !=  0 )
 {
 ADC_busy[ChannelNum] =  0 ;
 return 1;
 }

 if(pSPCValue[ChannelNum].SPCSetPoints.system_valueb.bite.ctl_type)
 {
 asm nop;
 Spcssr[ChannelNum].SSR_cmd = 1;
 if(Spcssr[ChannelNum].SSR_stat == 0)
 {
 temp_val_old[ChannelNum] = abs(pSPCValue[ChannelNum].SPCActual.Temperature.Temperature_C -
 pSPCValue[ChannelNum].SPCSetPoints.MaintainTemp.Temperature_C);
 }
 if(Spcssr[ChannelNum].SSR_stat == 1)
 {
 if(pSPCValue[ChannelNum].SPCActual.Temperature.Temperature_C >
 pSPCValue[ChannelNum].SPCSetPoints.MaintainTemp.Temperature_C)
 {

 temp_val = (pSPCValue[ChannelNum].SPCActual.Temperature.Temperature_C -
 pSPCValue[ChannelNum].SPCSetPoints.MaintainTemp.Temperature_C);

 if(temp_val > temp_val_old[ChannelNum])
 {
 if(Spcpwm[ChannelNum].duty_point > 0)
 Spcpwm[ChannelNum].duty_point--;
 }
 else if(temp_val == temp_val_old[ChannelNum])
 {
 if(equalcount[ChannelNum]++ > 20)
 {
 equalcount[ChannelNum] = 0;
 if(Spcpwm[ChannelNum].duty_point > 0)
 Spcpwm[ChannelNum].duty_point--;
 }
 }
 temp_val_old[ChannelNum] = temp_val;

 duty_val = temp_val;

 if(Spcpwm[ChannelNum].duty_point < duty_val)
 duty_index[ChannelNum] = 0;
 else
 duty_index[ChannelNum] = Spcpwm[ChannelNum].duty_point - duty_val;


 }
 else if(pSPCValue[ChannelNum].SPCActual.Temperature.Temperature_C <
 pSPCValue[ChannelNum].SPCSetPoints.MaintainTemp.Temperature_C)
 {

 temp_val = (pSPCValue[ChannelNum].SPCSetPoints.MaintainTemp.Temperature_C -
 pSPCValue[ChannelNum].SPCActual.Temperature.Temperature_C);

 if(temp_val < temp_val_old[ChannelNum])
 {
 if(Spcpwm[ChannelNum].duty_point < 10)
 Spcpwm[ChannelNum].duty_point++;
 }
 else if(temp_val == temp_val_old[ChannelNum])
 {
 if(equalcount[ChannelNum]++ > 20)
 {
 equalcount[ChannelNum] = 0;
 if(Spcpwm[ChannelNum].duty_point < 10)
 Spcpwm[ChannelNum].duty_point++;
 }
 }
 temp_val_old[ChannelNum] = temp_val;

 duty_val = temp_val;

 if(Spcpwm[ChannelNum].duty_point + duty_val > 10)
 duty_index[ChannelNum] = 10;
 else
 duty_index[ChannelNum] = Spcpwm[ChannelNum].duty_point + duty_val;
 }

 if(pSPCValue[ChannelNum].SPCSetPoints.LimitedCurrent !=  0X7fff )
 {
 if(duty_index[ChannelNum] > pSPCValue[ChannelNum].SPCSetPoints.LimitedCurrent/10)
 duty_index[ChannelNum] = pSPCValue[ChannelNum].SPCSetPoints.LimitedCurrent/10;
 }
 pwm_duty[ChannelNum] = get_duty_table(duty_index[ChannelNum]);

 if(pwm_duty[ChannelNum] == 0)
 SetHeatStatStr( 0 , ChannelNum);
 else
 SetHeatStatStr( 1 , ChannelNum);

 dutyshadePI[ChannelNum] = duty_index[ChannelNum]*10;
 SystemUpdate |= ( (unsigned long)0x00010000  << ChannelNum);
 SetIntStr((int*)&dutyshadePI[ChannelNum],  18 +ChannelNum,  8+1 , 1);
 }
 }
 else
 {

 if(pSPCValue[ChannelNum].SPCActual.Temperature.Temperature_C >
 pSPCValue[ChannelNum].SPCSetPoints.MaintainTemp.Temperature_C +
 pSPCValue[ChannelNum].SPCSetPoints.DeadBand.Temperature_C)
 {
 if(Spcssr[ChannelNum].SSR_cmd == 1)
 Spcssr[ChannelNum].SSR_cmd = 0;
 }
 else if(pSPCValue[ChannelNum].SPCActual.Temperature.Temperature_C <
 pSPCValue[ChannelNum].SPCSetPoints.MaintainTemp.Temperature_C -
 pSPCValue[ChannelNum].SPCSetPoints.DeadBand.Temperature_C)
 {
 if(Spcssr[ChannelNum].SSR_cmd == 0)
 Spcssr[ChannelNum].SSR_cmd = 1;
 }
 }
 }

 ADC_busy[ChannelNum] =  0 ;
 return 1;
}






void BackupFunc(char ChannelNum, char RTDstats)
{
 if(RTDstats &  1 )
 {
 CopyTemp(&(pSPCValue[ChannelNum].SPCActual.TemperatureB),
 &(pSPCValue[ChannelNum].SPCActual.Temperature));
 }
 else
 {
 CopyTemp(&(pSPCValue[ChannelNum].SPCActual.TemperatureA),
 &(pSPCValue[ChannelNum].SPCActual.Temperature));
 }
}

void CalSystemTemp(char ChannelNum, char RTDstat)
{
 char dispmodetemp;

 HighTempCutoffEn[ChannelNum] = 0;
 dispmodetemp = pSPCValue[ChannelNum].SPCSetPoints.system_valueb.bite.rtd_opr;

 switch(dispmodetemp)
 {
 case  0 :
 HighTempCutoffEn[ChannelNum] = 0;
 ForceSSROFFCondition[ChannelNum] &= ~ 0x02 ;
 CopyTemp(&(pSPCValue[ChannelNum].SPCActual.TemperatureA),
 &(pSPCValue[ChannelNum].SPCActual.Temperature));
 break;
 case  1 :
 HighTempCutoffEn[ChannelNum] = 0;
 ForceSSROFFCondition[ChannelNum] &= ~ 0x02 ;
 BackupFunc(ChannelNum, RTDstat);
 break;
 case  2 :
 HighTempCutoffEn[ChannelNum] = 0;
 ForceSSROFFCondition[ChannelNum] &= ~ 0x02 ;
 if(RTDstat ==  0 )
 {
 tempaverage(&(pSPCValue[ChannelNum].SPCActual.TemperatureA),
 &(pSPCValue[ChannelNum].SPCActual.Temperature));
 }
 else
 {
 BackupFunc(ChannelNum, RTDstat);
 }
 break;
 case  3 :
 HighTempCutoffEn[ChannelNum] = 0;
 ForceSSROFFCondition[ChannelNum] &= ~ 0x02 ;
 if(RTDstat ==  0 )
 {
 if(pSPCValue[ChannelNum].SPCActual.TemperatureA.Temperature_C >=
 pSPCValue[ChannelNum].SPCActual.TemperatureB.Temperature_C)
 CopyTemp(&(pSPCValue[ChannelNum].SPCActual.TemperatureB),
 &(pSPCValue[ChannelNum].SPCActual.Temperature));
 else
 CopyTemp(&(pSPCValue[ChannelNum].SPCActual.TemperatureA),
 &(pSPCValue[ChannelNum].SPCActual.Temperature));
 }
 else
 {
 BackupFunc(ChannelNum, RTDstat);
 }
 break;
 case  4 :
 HighTempCutoffEn[ChannelNum] = 0;
 ForceSSROFFCondition[ChannelNum] &= ~ 0x02 ;
 if(RTDstat ==  0 )
 {
 if(pSPCValue[ChannelNum].SPCActual.TemperatureA.Temperature_C <=
 pSPCValue[ChannelNum].SPCActual.TemperatureB.Temperature_C)
 CopyTemp(&(pSPCValue[ChannelNum].SPCActual.TemperatureB),
 &(pSPCValue[ChannelNum].SPCActual.Temperature));
 else
 CopyTemp(&(pSPCValue[ChannelNum].SPCActual.TemperatureA),
 &(pSPCValue[ChannelNum].SPCActual.Temperature));
 }
 else
 {
 BackupFunc(ChannelNum, RTDstat);
 }
 break;
 case  5 :
 if(RTDstat ==  0 )
 {
 CopyTemp(&(pSPCValue[ChannelNum].SPCActual.TemperatureA),
 &(pSPCValue[ChannelNum].SPCActual.Temperature));
 }
 if(pSPCValue[ChannelNum].SPCSetPoints.HighTemp.Temperature_C ==  0X7fff )
 {
 HighTempCutoffEn[ChannelNum] = 0;
 ForceSSROFFCondition[ChannelNum] &= ~ 0x02 ;
 BackupFunc(ChannelNum, RTDstat);
 }
 else
 {
 if(RTDstat &  2 )
 {
 HighTempCutoffEn[ChannelNum] = 0;
 ForceSSROFFCondition[ChannelNum] &= ~ 0x02 ;
 BackupFunc(ChannelNum, RTDstat);
 }
 else
 {
 BackupFunc(ChannelNum, RTDstat);
 if(pSPCValue[ChannelNum].SPCActual.TemperatureB.Temperature_C >
 pSPCValue[ChannelNum].SPCSetPoints.HighTemp.Temperature_C)
 {
 HighTempCutoffEn[ChannelNum] = 1;
 ForceSSROFFCondition[ChannelNum] |=  0x02 ;
 if(!(ActivedAlarms & ( (unsigned long)0x00000004  << ChannelNum)))
 alarmoperate( (unsigned long)0x00000004  << ChannelNum, 1 );
 }
 else
 {
 HighTempCutoffEn[ChannelNum] = 0;
 ForceSSROFFCondition[ChannelNum] &= ~ 0x02 ;
 }
 }
 }
 break;
 }
}






void EnableHighCurrentAlarmCount(char ChannelNum)
{
 if(HighCurrentEn[ChannelNum] == 0)
 {
 HighCurrentAlarmCount[ChannelNum]=0;
 HighCurrentEn[ChannelNum]=1;
 }
}

void DisableHighCurrentAlarmCount(char ChannelNum)
{
 HighCurrentAlarmCount[ChannelNum]=0;
 HighCurrentEn[ChannelNum]=0;
}

char GetHighCurrentEn(char ChannelNum)
{
 return HighCurrentEn[ChannelNum];
}

void SetHighCurrentEn(char ChannelNum, char HighCurrentCmd)
{
 HighCurrentEn[ChannelNum] = HighCurrentCmd;
}

void Currentprocess(char ChannelNum)
{
 unsigned int GFITestbuff;
 char GFIAlarmFlag=0;
 char StaticsChange=0;
 volatile unsigned long buff=0;
 static char ShortFailCount[2]={0}, CountinueFailCount[2]={0};


 if(Statis_flag[ChannelNum] &  16 )
 {
 Statis_flag[ChannelNum] &= ~ 16 ;
 pSPCValue[ChannelNum].SPCStatistics.MaximumCurrent = pSPCValue[ChannelNum].SPCActual.Current_RMS;
 SystemUpdate |= ( (unsigned long)0x00000040  << ChannelNum);
 SetCurrentStr((int*)&pSPCValue[ChannelNum].SPCStatistics.MaximumCurrent,  20 +ChannelNum,  4 , 1);
 StaticsChange = 1;
 }

 if(Statis_flag[ChannelNum] &  32 )
 {
 Statis_flag[ChannelNum] &= ~ 32 ;
 pSPCValue[ChannelNum].SPCStatistics.MaximumGFCurrent = pSPCValue[ChannelNum].SPCActual.GFICurrent;
 SystemUpdate |= ( (unsigned long)0x00000100  << ChannelNum);
 SetIntStr((int*)&pSPCValue[ChannelNum].SPCStatistics.MaximumGFCurrent,  22 +ChannelNum,  4+1 , 2);
 StaticsChange = 1;
 }

 if(pSPCValue[ChannelNum].SPCStatistics.MaximumCurrent < pSPCValue[ChannelNum].SPCActual.Current_RMS)
 {
 pSPCValue[ChannelNum].SPCStatistics.MaximumCurrent = pSPCValue[ChannelNum].SPCActual.Current_RMS;
 SystemUpdate |= ( (unsigned long)0x00000040  << ChannelNum);
 SetCurrentStr((int*)&pSPCValue[ChannelNum].SPCStatistics.MaximumCurrent,  20 +ChannelNum,  4 , 1);
 StaticsChange = 1;
 }

 if(pSPCValue[ChannelNum].SPCStatistics.MaximumGFCurrent < pSPCValue[ChannelNum].SPCActual.GFICurrent)
 {
 pSPCValue[ChannelNum].SPCStatistics.MaximumGFCurrent = pSPCValue[ChannelNum].SPCActual.GFICurrent;
 SystemUpdate |= ( (unsigned long)0x00000100  << ChannelNum);
 SetIntStr((int*)&pSPCValue[ChannelNum].SPCStatistics.MaximumGFCurrent,  22 +ChannelNum,  4+1 , 2);
 StaticsChange = 1;
 }
 if(StaticsChange)
 EEPROM_set(0x01+2*sizeof(SPCSETPIONTS)+ChannelNum*sizeof(STATISTICS),sizeof(STATISTICS),(UCHAR*)(&pSPCValue[ChannelNum].SPCStatistics));



 if(SSRStatInMeas[ChannelNum] ==  0 )
 {
 buff =  (unsigned long)0x00004000  << ChannelNum;
 if(ActivedAlarms & buff)
 alarmoperate(buff << ChannelNum, 0 );

 if(pSPCValue[ChannelNum].SPCActual.Current > 0)
 {
 if(ShortFailCount[ChannelNum] <= 20)
 {
 ShortFailCount[ChannelNum]++;
 }
 else
 {
 ShortFailCount[ChannelNum]=0;
 if(!(ActivedAlarms & ( (unsigned long)0x00010000  << ChannelNum)))
 alarmoperate( (unsigned long)0x00010000  << ChannelNum, 1 );
 }
 }
 else
 {
 ShortFailCount[ChannelNum]=0;
 }
 }
 else
 {
 if(ActivedAlarms & ( (unsigned long)0x00010000  << ChannelNum))
 alarmoperate( (unsigned long)0x00010000  << ChannelNum, 0 );

 if(pSPCValue[ChannelNum].SPCActual.Current == 0)
 {
 if(CountinueFailCount[ChannelNum] <= 20)
 {
 CountinueFailCount[ChannelNum]++;
 }
 else
 {
 CountinueFailCount[ChannelNum] = 0;
 if(!(ActivedAlarms & ( (unsigned long)0x00004000  << ChannelNum)))
 alarmoperate( (unsigned long)0x00004000  << ChannelNum, 1 );
 }
 }
 else
 {
 CountinueFailCount[ChannelNum] = 0;
 }
 }

 if(SSRStatInMeas[ChannelNum] ==  0 )
 {
 if(ActivedAlarms & ( (unsigned long)0x00000010  << ChannelNum))
 alarmoperate( (unsigned long)0x00000010  << ChannelNum, 0 );

 if(ActivedAlarms & ( (unsigned long)0x00000040  << ChannelNum))
 alarmoperate( (unsigned long)0x00000040  << ChannelNum, 0 );
 }
 else
 {
 if(pSPCValue[ChannelNum].SPCSetPoints.LowCurrent !=  0X7fff )
 {
 if(pSPCValue[ChannelNum].SPCActual.Current < pSPCValue[ChannelNum].SPCSetPoints.LowCurrent)
 {
 if(!(ActivedAlarms & ( (unsigned long)0x00000010  << ChannelNum)))
 alarmoperate( (unsigned long)0x00000010  << ChannelNum, 1 );
 }
 else
 {
 if(ActivedAlarms & ( (unsigned long)0x00000010  << ChannelNum))
 alarmoperate( (unsigned long)0x00000010  << ChannelNum, 0 );
 }
 }
 else
 {
 if(ActivedAlarms & ( (unsigned long)0x00000010  << ChannelNum))
 alarmoperate( (unsigned long)0x00000010  << ChannelNum, 0 );
 }

 if(pSPCValue[ChannelNum].SPCSetPoints.HighCurrent !=  0X7fff )
 {
 if(pSPCValue[ChannelNum].SPCActual.Current > pSPCValue[ChannelNum].SPCSetPoints.HighCurrent)
 {
 EnableHighCurrentAlarmCount(ChannelNum);
 }
 else
 {
 DisableHighCurrentAlarmCount(ChannelNum);
 if(ActivedAlarms & ( (unsigned long)0x00000040  << ChannelNum))
 alarmoperate( (unsigned long)0x00000040  << ChannelNum, 0 );
 }
 }
 else
 {
 DisableHighCurrentAlarmCount(ChannelNum);
 if(ActivedAlarms & ( (unsigned long)0x00000040  << ChannelNum))
 alarmoperate( (unsigned long)0x00000040  << ChannelNum, 0 );
 }


 if(GFITestCmd[ChannelNum] == 1)
 GFITestbuff = 30;
 else
 GFITestbuff = pSPCValue[ChannelNum].SPCSetPoints.GFITrip;

 if(GFITestbuff !=  0X7fff )
 {
 if(pSPCValue[ChannelNum].SPCActual.GFICurrent > GFITestbuff)
 {
 if((pSPCValue[ChannelNum].SPCSetPoints.system_valueb.bite.gfi_test_mod ==  0 ) &&
 (AutoGFITestEN[ChannelNum] == 1))
 {
 AutoGFITestPass[ChannelNum] = 1;

 if(ChannelNum ==  0 )
 LATF2_bit = 1;
 else if(ChannelNum ==  1 )
 LATF1_bit = 1;
 ForceSSROFFCondition[ChannelNum] |=  0x01 ;
 }
 else if((pSPCValue[ChannelNum].SPCSetPoints.system_valueb.bite.gfi_test_mod ==  1 ) &&
 (GFITestCmd[ChannelNum] == 1))
 {
 GFITestPass[ChannelNum] = 1;

 if(ChannelNum ==  0 )
 LATF2_bit = 1;
 else if(ChannelNum ==  1 )
 LATF1_bit = 1;
 ForceSSROFFCondition[ChannelNum] |=  0x01 ;
 }
 else
 {

 if(ChannelNum ==  0 )
 LATF2_bit = 1;
 else if(ChannelNum ==  1 )
 LATF1_bit = 1;
 ForceSSROFFCondition[ChannelNum] |=  0x01 ;

 if(!(ActivedAlarms & ( (unsigned long)0x00000400  << ChannelNum)))
 {
 if(ActivedAlarms & ( (unsigned long)0x00000100  << ChannelNum))
 alarmoperate( (unsigned long)0x00000100  << ChannelNum, 0 );

 alarmoperate( (unsigned long)0x00000400  << ChannelNum, 1 );
 }
 }
 }
 else
 GFIAlarmFlag |=  0X02 ;
 }
 else
 GFIAlarmFlag |=  0X02 ;

 if(pSPCValue[ChannelNum].SPCSetPoints.GFIAlarm !=  0X7fff )
 {
 if(pSPCValue[ChannelNum].SPCActual.GFICurrent > pSPCValue[ChannelNum].SPCSetPoints.GFIAlarm)
 {
 if((pSPCValue[ChannelNum].SPCSetPoints.system_valueb.bite.gfi_test_mod ==  0 ) &&
 (AutoGFITestEN[ChannelNum] == 1))
 {
 asm nop;
 }
 else if((pSPCValue[ChannelNum].SPCSetPoints.system_valueb.bite.gfi_test_mod ==  1 ) &&
 (GFITestCmd[ChannelNum] == 1))
 {
 asm nop;
 }
 else if(!(ActivedAlarms & ( (unsigned long)0x00000400  << ChannelNum)))
 {
 if(!(ActivedAlarms & ( (unsigned long)0x00000100  << ChannelNum)))
 alarmoperate( (unsigned long)0x00000100  << ChannelNum, 1 );
 }
 }
 else
 GFIAlarmFlag |=  0X01 ;
 }
 else
 GFIAlarmFlag |=  0X01 ;

 if((GFIAlarmFlag &  0X01 ) && (GFIAlarmFlag &  0X02 ))
 {
 if(!(ActivedAlarms & ( (unsigned long)0x00000400  << ChannelNum)))
 {
 if(ActivedAlarms & ( (unsigned long)0x00000100  << ChannelNum))
 alarmoperate( (unsigned long)0x00000100  << ChannelNum, 0 );
 }
 }
 }
}

void ActivateHighCurrentAlarm(char ChannelNum)
{
 if(HighCurrentEn[ChannelNum] == 2)
 {
 HighCurrentEn[ChannelNum] = 0;
 if(!(ActivedAlarms & ( (unsigned long)0x00000040  << ChannelNum)))
 alarmoperate( (unsigned long)0x00000040  << ChannelNum, 1 );
 }
}






void Voltprocess()
{
 char StaticsChange=0;

 Getvoltage();
 if(pSPCValue[0].SPCActual.Voltage >  280 )
 {
 pSPCValue[0].SPCActual.Voltage =  0x7ffe ;
 }

 spc_system_flag.bite.meas_VT_reach &= 0xfe;

 SystemUpdate |=  (unsigned long)0x01000000 ;
 SetIntStr((int*)&pSPCValue[0].SPCActual.Voltage,  30 ,  5+1 , 1);



 if(Statis_flag[0] &  4 )
 {
 Statis_flag[0] &= ~ 4 ;
 pSPCValue[0].SPCStatistics.MaximumVoltage = pSPCValue[0].SPCActual.Voltage;
 SystemUpdate |=  (unsigned long)0x02000000 ;
 SetIntStr((int*)&pSPCValue[0].SPCStatistics.MaximumVoltage,  32 ,  5+1 , 1);
 StaticsChange = 1;
 }
 if(Statis_flag[0] &  8 )
 {
 Statis_flag[0] &= ~ 8 ;
 pSPCValue[0].SPCStatistics.MinimumVoltage = pSPCValue[0].SPCActual.Voltage;
 SystemUpdate |=  (unsigned long)0x04000000 ;
 SetIntStr((int*)&pSPCValue[0].SPCStatistics.MinimumVoltage,  34 ,  5+1 , 1);
 StaticsChange = 1;
 }
 if(pSPCValue[0].SPCActual.Voltage > pSPCValue[0].SPCStatistics.MaximumVoltage)
 {
 pSPCValue[0].SPCStatistics.MaximumVoltage = pSPCValue[0].SPCActual.Voltage;
 SystemUpdate |=  (unsigned long)0x02000000 ;
 SetIntStr((int*)&pSPCValue[0].SPCStatistics.MaximumVoltage,  32 ,  5+1 , 1);
 StaticsChange = 1;
 }
 else if(pSPCValue[0].SPCActual.Voltage < pSPCValue[0].SPCStatistics.MinimumVoltage)
 {
 pSPCValue[0].SPCStatistics.MinimumVoltage = pSPCValue[0].SPCActual.Voltage;
 SystemUpdate |=  (unsigned long)0x04000000 ;
 SetIntStr((int*)&pSPCValue[0].SPCStatistics.MinimumVoltage,  34 ,  5+1 , 1);
 StaticsChange = 1;
 }
 if(StaticsChange)
 EEPROM_set(0x01+2*sizeof(SPCSETPIONTS),sizeof(STATISTICS),(UCHAR*)(&pSPCValue[0].SPCStatistics));


 if((pSPCValue[0].SPCActual.Voltage < pSPCValue[0].SPCSetPoints.LowVoltage) &&
 (pSPCValue[0].SPCSetPoints.LowVoltage !=  0X7fff ))
 {
 if(!(ActivedAlarms &  (unsigned long)0x00001000 ))
 alarmoperate( (unsigned long)0x00001000 , 1 );

 if(ActivedAlarms &  (unsigned long)0x00002000 )
 alarmoperate( (unsigned long)0x00002000 , 0 );
 }
 else if((pSPCValue[0].SPCActual.Voltage > pSPCValue[0].SPCSetPoints.HighVoltage) &&
 (pSPCValue[0].SPCSetPoints.HighVoltage !=  0X7fff ))
 {
 if(!(ActivedAlarms &  (unsigned long)0x00002000 ))
 alarmoperate( (unsigned long)0x00002000 , 1 );

 if(ActivedAlarms &  (unsigned long)0x00001000 )
 alarmoperate( (unsigned long)0x00001000 , 0 );
 }
 else
 {
 if(ActivedAlarms &  (unsigned long)0x00002000 )
 alarmoperate( (unsigned long)0x00002000 , 0 );

 if(ActivedAlarms &  (unsigned long)0x00001000 )
 alarmoperate( (unsigned long)0x00001000 , 0 );
 }
}






void enegy_acc()
{
 volatile long v_temp, c_temp;
 char enegychaged=0;
 static unsigned int TotalEnergyWh[2]={0}, TotalEnergyKwh[2]={0};
 char SkipCh[2]={0};
 char i;

 if(energyacc == 0)
 return;

 energyacc = 0;
 for(i=0;i<2;i++)
 {
 if(pSPCValue[i].SPCStatistics.EnergyUsed ==  0x7ffe )
 {
 MemeSet((char *)&Volt_acc[i], 0, sizeof(VALUEACC));
 MemeSet((char *)&Current_acc[i], 0, sizeof(VALUEACC));
 SkipCh[i] = 1;

 }

 if(pSPCValue[0].SPCActual.Voltage ==  0x7ffe )
 SkipCh[i] = 1;

 if(pSPCValue[i].SPCActual.Current_RMS ==  0x7ffe )
 SkipCh[i] = 1;

 if(SkipCh[i] == 0)
 {
 if(Volt_acc[i].num >= 100)
 {
 v_temp = Volt_acc[i].acc/100;
 c_temp = Current_acc[i].acc/100;
 TotalEnergyWh[i] += v_temp*c_temp;

 if(TotalEnergyWh[i] > 1000)
 {
 TotalEnergyKwh[i] += (TotalEnergyWh[i]/1000);
 TotalEnergyWh[i] %= 1000;

 if(TotalEnergyKwh[i] > 1000)
 {
 pSPCValue[i].SPCStatistics.EnergyUsed += (TotalEnergyKwh[i]/1000);
 TotalEnergyKwh[i] %= 1000;

 if(pSPCValue[i].SPCStatistics.EnergyUsed >  10000 )
 {
 pSPCValue[i].SPCStatistics.EnergyUsed =  0x7ffe ;
 pSPCValue[i].SPCStatistics.EnergyCost =  0X7FFFFFFF ;
 }
 }

 if(pSPCValue[i].SPCStatistics.EnergyCost !=  0X7FFFFFFF )
 {
 pSPCValue[i].SPCStatistics.EnergyCost = TotalEnergyKwh[i]*
 pSPCValue[i].SPCSetPoints.CostPerKWH/10;
 pSPCValue[i].SPCStatistics.EnergyCost += (unsigned long)pSPCValue[i].SPCStatistics.EnergyUsed*
 pSPCValue[i].SPCSetPoints.CostPerKWH * 100;
 }
 if(pSPCValue[i].SPCStatistics.EnergyCost >  100000000 )
 pSPCValue[i].SPCStatistics.EnergyCost =  0X7FFFFFFF ;
 }
 MemeSet((char *)&Volt_acc[i], 0, sizeof(VALUEACC));
 MemeSet((char *)&Current_acc[i], 0, sizeof(VALUEACC));
 enegychaged = 1;
 }
 else
 {
 Volt_acc[i].num++;
 Volt_acc[i].acc += pSPCValue[0].SPCActual.Voltage;
 Current_acc[i].acc += pSPCValue[i].SPCActual.Current_RMS;
 }

 if(enegychaged)
 {
 SystemUpdate |= ( (unsigned long)0x00040000  << i);
 SetCostStr(pSPCValue[i].SPCStatistics.EnergyUsed,  24 +i);
 SetCostStr(pSPCValue[i].SPCStatistics.EnergyCost,  26 +i);
 EEPROM_set(0x01+2*sizeof(SPCSETPIONTS)+i*sizeof(STATISTICS),sizeof(STATISTICS),(UCHAR*)(&pSPCValue[i].SPCStatistics));
 }
 }
 }
}






void Timeprocess()
{
 char StaticsChange=0;
 char i;

 for(i=0;i<2;i++)
 {
 if(DataUpdate & ( (unsigned long)0x00000001  << i))
 {
 DataUpdate &= ~( (unsigned long)0x00000001  << i);
 SystemUpdate |= ( (unsigned long)0x00000001  << i);
 SetOntimeStr(pSPCValue[i].SPCStatistics.RunTime,  0 +i);
 StaticsChange = 1;
 }

 if(DataUpdate & ( (unsigned long)0x00000004  << i))
 {
 DataUpdate &= ~( (unsigned long)0x00000004  << i);
 SystemUpdate |= ( (unsigned long)0x00000004  << i);

 pSPCValue[i].SPCStatistics.HeaterOnTime =
 (Heat_On_time[i].hour*60+Heat_On_time[i].minute)*100/(SYS_On_time.hour*60+SYS_On_time.minute);
 SetIntStr((int*)&pSPCValue[i].SPCStatistics.HeaterOnTime,  36 +i,  8+1 , 1);
 StaticsChange = 1;
 }

 if(StaticsChange)
 EEPROM_set(0x01+2*sizeof(SPCSETPIONTS)+i*sizeof(STATISTICS),sizeof(STATISTICS),(UCHAR*)(&pSPCValue[i].SPCStatistics));
 }
}
