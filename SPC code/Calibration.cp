#line 1 "D:/MyProject/SPC code1/SPC code/Calibration.c"
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
#line 1 "d:/myproject/spc code1/spc code/eeprom.h"



void EEPROM_get(UINT EEPROM_READ_ADDRESS,UCHAR Len,UCHAR *readbuffer);
void EEPROM_set(UINT EEPROM_WRITE_ADDRESS,UCHAR Len,UCHAR *writebuffer);


UCHAR SPCIfFirstRun(void);
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
#line 18 "D:/MyProject/SPC code1/SPC code/Calibration.c"
char SPCCalibrationEN=1;
char SPCTestingEN=1;
char ChannelSwitch=0;
SPCCALIBRATIONSTRTCTURE SPCCalibrationStructure[2];
SPCCALIBRATIONBOX SPCCalibrationBox;

char CalibrationCommand[5] = {0};
char CalibrationCount=0;
int LowValueBuff[2] = {0};


code signed int ConstCalibrationBuff[60] =
{
 139, 19, 259, 47, 369, 91, 534, 195, 3092, 2242, 5230, 3838,
 22, 28, 162, 161, 552, 700, 1757, 2184, 2542, 2970,
 0, 1083, 0, 3678, 0, 1071, 0, 3670,
 139, 19, 259, 47, 369, 91, 534, 195, 3092, 2242, 5230, 3838,
 22, 28, 162, 161, 552, 700, 1757, 2184, 2542, 2970,
 0, 1063, 0, 3663, 0, 1057, 0, 3661
};
#line 95 "D:/MyProject/SPC code1/SPC code/Calibration.c"
int GetCalibrationData(SPCCALIBRATIONREG *Ptr,char Location, char ActualReq)
{
 SPCCALIBRATIONREG *TempPtr;
 TempPtr = Ptr + Location;

 if(ActualReq)
 return TempPtr->CalibartionActural;
 else
 return TempPtr->CalibartionSetpoint;
}

void SetCommand(char CommandType, char CommandData)
{
 CalibrationCommand[CommandType] = CommandData;
}

char GetCommand(char CommandType)
{
 return CalibrationCommand[CommandType];
}

int MeasureCG(char CalibrateCGCmd)
{
 int CurrentBuff,GFIBuff;
 long CurrentAcc=0, GFIAcc=0;
 int SampleNum=0;
 char MeasureEn=0;

 MeasureEn = 1;
 CalibrationCommand[ 0 ] =  1 ;
 CalibrationCount = 0;

 while(MeasureEn)
 {
 CurrentAcc += GetGFI(ChannelSwitch,  0x80 + 0x20 );
 GFIAcc += GetGFI(ChannelSwitch,  0x80 + 0x40 + 0x20 );
 SampleNum++;

 if(CalibrationCommand[ 0 ] ==  2 )
 MeasureEn = 0;
 }

 CalibrationCommand[ 0 ] = 0;
 CalibrationCount = 0;
 if(CurrentAcc == 0)
 CurrentBuff = 0;
 else
 CurrentBuff = CurrentAcc/SampleNum;

 if(GFIAcc == 0)
 GFIBuff = 0;
 else
 GFIBuff = GFIAcc/SampleNum;

 if(CalibrateCGCmd)
 return CurrentBuff;
 else
 return GFIBuff;
}


void WaitForValue(char LowValueType)
{
 char Loop=1;
 int ValueTemp=0;

 while(Loop)
 {
 ValueTemp = MeasureCG(LowValueType);
 if(ValueTemp < 50)
 Loop = 0;
 }
}

void SPCCalibration()
{
 int ADBuff;
 SPCCALIBRATIONREG *Ptr;

 Ptr = (SPCCALIBRATIONREG *)&SPCCalibrationStructure[0];
 if(SPCCalibrationEN == 0)
 return;
 else
 {
 while(SPCCalibrationEN)
 {
 modbusprocess();
 switch(SPCCalibrationBox.CalibartionType)
 {
 case 0:
 getParaChar(Info_Line1,  91 );
 getParaChar(Info_Line2,  39 );
 LCDUpdate();
 SPCCalibrationBox.CalibartionType = 25;
 SetModbusTxData(0);
 modbus_respond();
 break;
 case 1:
 Delay_ms(600);
 ADBuff = MCP3202_GET_AD( 0x08 +ChannelSwitch, 0x80 + 0x40 + 0x20 , 100);

 Ptr += SPCCalibrationBox.CalibartionAddress;
 Ptr->CalibartionSetpoint = ADBuff;
 Ptr->CalibartionActural = SPCCalibrationBox.CalibartionData;
 SPCCalibrationBox.CalibartionType = 25;
 SetModbusTxData(ADBuff);
 modbus_respond();
 break;
 case 2:
 Delay_ms(600);
 ADBuff = MCP3202_GET_AD( 0x08 +ChannelSwitch, 0x80 + 0x20 , 100);

 Ptr += SPCCalibrationBox.CalibartionAddress;
 Ptr->CalibartionSetpoint = ADBuff;
 Ptr->CalibartionActural = SPCCalibrationBox.CalibartionData;
 SPCCalibrationBox.CalibartionType = 25;
 SetModbusTxData(ADBuff);
 modbus_respond();
 break;
 case 3:
 if(CalibrationCommand[ 3 ] == 0)
 {
 WaitForValue( 1 );
 SetModbusTxData(0);
 }
 else
 {
 Delay_ms(600);
 ADBuff = MeasureCG( 1 );

 Ptr += SPCCalibrationBox.CalibartionAddress;
 Ptr->CalibartionSetpoint = ADBuff;
 Ptr->CalibartionActural = SPCCalibrationBox.CalibartionData;
 SetModbusTxData(ADBuff);
 }
 CalibrationCommand[ 3 ] ^= 1;
 SPCCalibrationBox.CalibartionType = 25;
 modbus_respond();
 break;
 case 4:
 if(CalibrationCommand[ 4 ] == 0)
 {
 WaitForValue( 0 );
 SetModbusTxData(0);
 }
 else
 {
 Delay_ms(600);
 ADBuff = MeasureCG( 0 );

 Ptr += SPCCalibrationBox.CalibartionAddress;
 Ptr->CalibartionSetpoint = ADBuff;
 Ptr->CalibartionActural = SPCCalibrationBox.CalibartionData;
 SetModbusTxData(ADBuff);
 }
 CalibrationCommand[ 4 ] ^= 1;
 SPCCalibrationBox.CalibartionType = 25;
 modbus_respond();
 break;
 case 5:
 Delay_ms(600);
 ADBuff = MCP3202_GET_AD( 0x08 +ChannelSwitch, 0x80 + 0x40 + 0x20 , 100);
 ADBuff = ConvertADtoTEMP(ADBuff,  0 ,  1 , 0);
 SPCCalibrationBox.CalibartionType = 25;
 SetModbusTxData(ADBuff);
 modbus_respond();
 break;
 case 6:
 Delay_ms(600);
 ADBuff = MCP3202_GET_AD( 0x08 +ChannelSwitch, 0x80 + 0x20 , 100);
 ADBuff = ConvertADtoTEMP(ADBuff,  2 ,  3 , 0);
 SPCCalibrationBox.CalibartionType = 25;
 SetModbusTxData(ADBuff);
 modbus_respond();
 break;
 case 7:
 if(CalibrationCommand[ 3 ] == 0)
 {
 WaitForValue( 1 );
 SetModbusTxData(0);
 }
 else
 {
 Delay_ms(600);
 ADBuff = MeasureCG( 1 );
 ADBuff = ConvertADtoCurrent(ADBuff,0);
 SetModbusTxData(ADBuff*10);
 }
 CalibrationCommand[ 3 ] ^= 1;
 SPCCalibrationBox.CalibartionType = 25;
 modbus_respond();
 break;
 case 8:
 if(CalibrationCommand[ 4 ] == 0)
 {
 WaitForValue( 0 );
 SetModbusTxData(0);
 }
 else
 {
 Delay_ms(600);
 ADBuff = MeasureCG( 0 );
 ADBuff = ConvertADtoGFI(ADBuff, 0);
 SetModbusTxData(ADBuff*10);
 }
 CalibrationCommand[ 4 ] ^= 1;
 SPCCalibrationBox.CalibartionType = 25;
 modbus_respond();
 break;
 case 9:
 LATC2_bit = 1;
 Delay_ms(600);
 ADBuff = MeasureCG( 1 );
 ADBuff = ConvertADtoCurrent(ADBuff,0);
 SetModbusTxData(ADBuff*10);
 LATC2_bit = 0;
 SPCCalibrationBox.CalibartionType = 25;
 modbus_respond();
 break;
 case 10:
 LATB4_bit = 1;
 LATB5_bit = 1;
 ADBuff = 0;
 SPCCalibrationBox.CalibartionType = 25;
 SetModbusTxData(ADBuff);
 modbus_respond();
 Delay_ms(600);
 LATB4_bit = 0;
 LATB5_bit = 0;
 break;
 case 11:
 Delay_ms(600);
 ADBuff = RB3_bit;
 SPCCalibrationBox.CalibartionType = 25;
 SetModbusTxData(ADBuff);
 modbus_respond();
 break;
 case 12:
 getParaChar(Info_Line1,  93 );
 getParaChar(Info_Line2,  39 );
 EEPROM_set(0x300,sizeof(SPCCALIBRATIONREG)*30,(UCHAR*)&SPCCalibrationStructure[0]);
 LCDUpdate();
 SPCCalibrationBox.CalibartionType = 25;
 SetModbusTxData(0);
 modbus_respond();
 break;
 case 13:
 getParaChar(Info_Line1,  94 );
 getParaChar(Info_Line2,  39 );
 LCDUpdate();
 SPCCalibrationBox.CalibartionType = 25;
 SetModbusTxData(0);
 modbus_respond();
 break;
 case 14:
 SPCTestingEN = 0;
 SPCCalibrationEN = 0;
 EEPROM_set(0x2f1, 1, (char*)&SPCTestingEN);
 EEPROM_set(0x2f0, 1, (char*)&SPCCalibrationEN);
 SetModbusTxData(0);
 modbus_respond();
 break;
 default:
 break;
 }
 }
 }

 if(SPCTestingEN == 0)
 return;
 else
 {

 }
}

void InitialCalibrationReg()
{
 signed int *Ptr;
 char i;

 Ptr = (signed int *)&SPCCalibrationStructure[0];
 for(i=0;i<60;i++)
 {
 *(Ptr+i) = ConstCalibrationBuff[i];
 }
}
