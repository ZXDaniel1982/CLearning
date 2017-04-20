#line 1 "D:/MyProject/SPC code1/SPC code/RTD.c"
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
#line 1 "d:/myproject/spc code1/spc code/pic18f6622.h"
#line 1 "d:/myproject/spc code1/spc code/rtd.h"
#line 130 "d:/myproject/spc code1/spc code/rtd.h"
void GetTemperature(TEMPERATURE *RTDA_ptr, char ChannelNum);
UINT GetGFI(char ChannelSelect, char cmd);
signed int ConvertADtoCurrent(unsigned int ADcurrent, char ChannelNum);
unsigned int ConvertADtoGFI(unsigned int ADcurrent, char ChannelNum);
long ConvertADtoTEMP(UINT ADtemp, char paraL, char paraH, char ChannelNum );
void CaliTemp(UINT ADtemp, char paraL, char paraH );

extern unsigned int ADSampleA,ADSampleB;
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
#line 14 "D:/MyProject/SPC code1/SPC code/RTD.c"
code unsigned int g_RTDTableC[ 570 ] =
{

 7673, 7712, 7752, 7792, 7832, 7872, 7911, 7951, 7991, 8031,

 8070, 8110, 8150, 8189, 8229, 8269, 8308, 8348, 8387, 8427,

 8467, 8506, 8546, 8585, 8625, 8664, 8704, 8743, 8783, 8822,

 8862, 8901, 8940, 8980, 9019, 9059, 9098, 9137, 9177, 9216,

 9255, 9295, 9334, 9373, 9412, 9452, 9491, 9530, 9569, 9609,

 9648, 9687, 9726, 9765, 9804, 9844, 9883, 9922, 9961, 10000,

 10039, 10078, 10117, 10156, 10195, 10234, 10273, 10312, 10351, 10390,

 10429, 10468, 10507, 10546, 10585, 10624, 10663, 10702, 10740, 10779,

 10818, 10857, 10896, 10935, 10973, 11012, 11051, 11090, 11129, 11167,

 11206, 11245, 11283, 11322, 11361, 11400, 11438, 11477, 11515, 11554,

 11593, 11631, 11670, 11708, 11747, 11786, 11824, 11863, 11901, 11940,

 11978, 12017, 12055, 12094, 12132, 12171, 12209, 12247, 12286, 12324,

 12363, 12401, 12439, 12478, 12516, 12554, 12593, 12631, 12669, 12708,

 12746, 12784, 12822, 12861, 12899, 12937, 12975, 13013, 13052, 13090,

 13128, 13166, 13204, 13242, 13280, 13318, 13357, 13395, 13433, 13471,

 13509, 13547, 13585, 13623, 13661, 13699, 13737, 13775, 13813, 13851,

 13888, 13926, 13964, 14002, 14040, 14078, 14116, 14154, 14191, 14229,

 14267, 14305, 14343, 14380, 14418, 14456, 14494, 14531, 14569, 14607,

 14644, 14682, 14720, 14757, 14795, 14833, 14870, 14908, 14946, 14983,

 15021, 15058, 15096, 15133, 15171, 15208, 15246, 15283, 15321, 15358,

 15396, 15433, 15471, 15508, 15546, 15583, 15620, 15658, 15695, 15733,

 15770, 15807, 15845, 15882, 15919, 15956, 15994, 16031, 16068, 16105,

 16143, 16180, 16217, 16254, 16291, 16329, 16366, 16403, 16440, 16477,

 16514, 16551, 16589, 16626, 16663, 16700, 16737, 16774, 16811, 16848,

 16885, 16922, 16959, 16996, 17033, 17070, 17107, 17143, 17180, 17217,

 17254, 17291, 17328, 17365, 17402, 17438, 17475, 17512, 17549, 17586,

 17622, 17659, 17696, 17733, 17769, 17806, 17843, 17879, 17916, 17953,

 17989, 18026, 18063, 18099, 18136, 18172, 18209, 18246, 18282, 18319,

 18355, 18392, 18428, 18465, 18501, 18538, 18574, 18611, 18647, 18684,

 18720, 18756, 18793, 18829, 18866, 18902, 18938, 18975, 19011, 19047,

 19084, 19120, 19156, 19192, 19229, 19265, 19301, 19337, 19374, 19410,

 19446, 19482, 19518, 19555, 19591, 19627, 19663, 19699, 19735, 19771,

 19807, 19843, 19879, 19915, 19951, 19987, 20023, 20059, 20095, 20131,

 20167, 20203, 20239, 20275, 20311, 20347, 20383, 20419, 20455, 20490,

 20526, 20562, 20598, 20634, 20670, 20705, 20741, 20777, 20813, 20848,

 20884, 20920, 20956, 20991, 21027, 21063, 21098, 21134, 21170, 21205,

 21241, 21276, 21312, 21348, 21383, 21419, 21454, 21490, 21525, 21561,

 21596, 21632, 21667, 21703, 21738, 21774, 21809, 21844, 21880, 21915,

 21951, 21986, 22021, 22057, 22092, 22127, 22163, 22198, 22233, 22268,

 22304, 22339, 22374, 22409, 22445, 22480, 22515, 22550, 22585, 22621,

 22656, 22691, 22726, 22761, 22796, 22831, 22866, 22902, 22937, 22972,

 23007, 23042, 23077, 23112, 23147, 23182, 23217, 23252, 23287, 23321,

 23356, 23391, 23426, 23461, 23496, 23531, 23566, 23600, 23635, 23670,

 23705, 23740, 23774, 23809, 23844, 23879, 23913, 23948, 23983, 24018,

 24052, 24087, 24122, 24156, 24191, 24226, 24260, 24295, 24329, 24364,

 24399, 24433, 24468, 24502, 24537, 24571, 24606, 24640, 24675, 24709,

 24744, 24778, 24813, 24847, 24881, 24916, 24950, 24985, 25019, 25053,

 25088, 25122, 25156, 25191, 25225, 25259, 25293, 25328, 25362, 25396,

 25430, 25465, 25499, 25533, 25567, 25601, 25635, 25670, 25704, 25738,

 25772, 25806, 25840, 25874, 25908, 25942, 25976, 26010, 26044, 26078,

 26112, 26146, 26180, 26214, 26248, 26282, 26316, 26350, 26384, 26418,

 26452, 26486, 26520, 26553, 26587, 26621, 26655, 26689, 26722, 26756,

 26790, 26824, 26857, 26891, 26925, 26959, 26992, 27026, 27060, 27093,

 27127, 27161, 27194, 27228, 27261, 27295, 27329, 27362, 27396, 27429,

 27463, 27496, 27530, 27563, 27597, 27630, 27664, 27697, 27731, 27764,

 27798, 27831, 27864, 27898, 27931, 27964, 27998, 28031, 28064, 28098,

 28131, 28164, 28198, 28231, 28264, 28297, 28331, 28364, 28397, 28430
};
#line 192 "D:/MyProject/SPC code1/SPC code/RTD.c"
unsigned int ADSampleA,ADSampleB;







void TempSend(unsigned int ADSample, char line)
{
 char String=0, i;
 char *ptr;

 if(line == 1)
 ptr = Info_Line2;
 else
 ptr = Info_Line1;

 ClearStr(ptr, 16);
 *ptr = ADSample/1000 + 0x30;
 *(ptr+1) = ADSample%1000/100 + 0x30;
 *(ptr+2) = ADSample%100/10 + 0x30;
 *(ptr+3) = ADSample%10 + 0x30;
}

void GetTemperature(TEMPERATURE *RTDA_ptr, char ChannelNum)
{
 TEMPERATURE *ptr;
 unsigned int TempAD;
#line 228 "D:/MyProject/SPC code1/SPC code/RTD.c"
 ptr = RTDA_ptr;
 TempAD = MCP3202_GET_AD(ADC_Channel[ChannelNum+2], 0x80 + 0x40 + 0x20 , 100);
 ptr->Temperature_C = ConvertADtoTEMP(TempAD,  0 ,  1 , ChannelNum);
 if((ptr->Temperature_C ==  0x7fff ) || (ptr->Temperature_C ==  0x7ffd ))
 ptr->Temperature_F = ptr->Temperature_C;
 else
 ptr->Temperature_F = ConvertCtoF(ptr->Temperature_C);

 ptr++;
 TempAD = MCP3202_GET_AD(ADC_Channel[ChannelNum+2], 0x80 + 0x20 , 100);
 ptr->Temperature_C = ConvertADtoTEMP(TempAD,  2 ,  3 , ChannelNum);
 if((ptr->Temperature_C ==  0x7fff ) || (ptr->Temperature_C ==  0x7ffd ))
 ptr->Temperature_F = ptr->Temperature_C;
 else
 ptr->Temperature_F = ConvertCtoF(ptr->Temperature_C);
}






UINT GetGFI(char ChannelSelect, char cmd)
{
 return MCP3202_GET_AD_ONCE(ChannelSelect,cmd);
}






signed int ConvertADtoCurrent(unsigned int ADcurrent, char ChannelNum)
{
 signed long ret,temp,tempL;
 char index=0;
 SPCCALIBRATIONREG *PtrForCalibrationData;

 PtrForCalibrationData = (SPCCALIBRATIONREG *)&SPCCalibrationStructure[ChannelNum];
 if(ADcurrent < GetCalibrationData(PtrForCalibrationData,  10 , 0))
 return 0;
 else if(ADcurrent < GetCalibrationData(PtrForCalibrationData,  11 , 0))
 index = 0;
 else if(ADcurrent < GetCalibrationData(PtrForCalibrationData,  12 , 0))
 index = 1;
 else if(ADcurrent < GetCalibrationData(PtrForCalibrationData,  13 , 0))
 index = 2;
 else
 index = 3;

 index +=  10 ;
 temp = GetCalibrationData(PtrForCalibrationData, index+1, 1) - GetCalibrationData(PtrForCalibrationData, index, 1);
 tempL = GetCalibrationData(PtrForCalibrationData, index+1, 0) - GetCalibrationData(PtrForCalibrationData, index, 0);
 temp = temp* (ADcurrent - GetCalibrationData(PtrForCalibrationData, index, 0))/ tempL;
 ret = temp + GetCalibrationData(PtrForCalibrationData, index, 1);

 return ret/10;
}






unsigned int ConvertADtoGFI(unsigned int ADcurrent, char ChannelNum)
{
 signed long ret,temp, tempL;
 char index=0;
 SPCCALIBRATIONREG *PtrForCalibrationData;

 PtrForCalibrationData = (SPCCALIBRATIONREG *)&SPCCalibrationStructure[ChannelNum];
 if(ADcurrent < GetCalibrationData(PtrForCalibrationData,  4 , 0))
 return 0;
 else if(ADcurrent < GetCalibrationData(PtrForCalibrationData,  5 , 0))
 index = 0;
 else if(ADcurrent < GetCalibrationData(PtrForCalibrationData,  6 , 0))
 index = 1;
 else if(ADcurrent < GetCalibrationData(PtrForCalibrationData,  7 , 0))
 index = 2;
 else if(ADcurrent < GetCalibrationData(PtrForCalibrationData,  8 , 0))
 index = 3;
 else
 index = 4;

 index +=  4 ;
 temp = GetCalibrationData(PtrForCalibrationData, index+1, 1) - GetCalibrationData(PtrForCalibrationData, index, 1);
 tempL = GetCalibrationData(PtrForCalibrationData, index+1, 0) - GetCalibrationData(PtrForCalibrationData, index, 0);
 temp = temp* (ADcurrent - GetCalibrationData(PtrForCalibrationData, index, 0))/ tempL;
 ret = temp + GetCalibrationData(PtrForCalibrationData, index, 1);

 return ret/10;
}






long ConvertADtoTEMP(UINT ADtemp, char paraL, char paraH, char ChannelNum)
{
 unsigned int resis;
 signed long ret,tempH, tempL;
 long tempresult,tempcount=0, temp;
 SPCCALIBRATIONREG *PtrForCalibrationData;

 PtrForCalibrationData = (SPCCALIBRATIONREG *)&SPCCalibrationStructure[ChannelNum];
 tempH = GetCalibrationData(PtrForCalibrationData, paraH, 1) - GetCalibrationData(PtrForCalibrationData, paraL, 1);
 tempL = GetCalibrationData(PtrForCalibrationData, paraH, 0) - GetCalibrationData(PtrForCalibrationData, paraL, 0);
 tempH = tempH* ((signed int)ADtemp - GetCalibrationData(PtrForCalibrationData, paraL, 0))/ tempL;
 resis = tempH + GetCalibrationData(PtrForCalibrationData, paraL, 1);

 if(resis >  28430 )
 return  0x7ffd ;
 else if(resis <  7673 )
 return  0x7fff ;

 while(1)
 {
 if(resis < g_RTDTableC[tempcount])
 {
 if(tempcount)
 {
 temp = (long)tempcount *10;
 tempresult = (long)(temp - (g_RTDTableC[tempcount] - resis)*
 10.0/(g_RTDTableC[tempcount] - g_RTDTableC[tempcount-1]));
 tempresult -= 590;
 }
 else
 tempresult = -590;

 if(tempresult > 0)
 return (tempresult+5)/10;
 else
 return (tempresult-5)/10;

 }
 else
 tempcount++;
 }

}
