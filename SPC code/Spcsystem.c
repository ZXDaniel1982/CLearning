#include "systemvalue.h"
#include "PIC18F6622.h"
#include "Spcsystem.h"
#include "EEPROM.h"
#include "Menuoperation.h"
#include "SpcValue.h"
#include "function.h"
#include "M0220.h"
#include "RTD.h"
#include "String_op.h"
#include "Spcinitial.h"
#include "SSR.h"
#include "Calibration.h"

#define TEMP_SETPOINT_UPDATE  6

#define MAINTAIN_MEM_LACAL 0
#define DEADBAND_MEM_LACAL 6
#define LOWTEMP_MEM_LACAL 2
#define HIGHTEMP_MEM_LACAL 4
#define LOWCURRENT_MEM_LACAL 8
#define HIGHCURRENT_MEM_LACAL 9
#define GFIALARM_MEM_LACAL 10
#define GFITRIP_MEM_LACAL 11
#define LOWVOLT_MEM_LACAL 12
#define HIGHVOLT_MEM_LACAL 13
#define LIMITCURRENT_MEM_LACAL 14

#define SOFTSTART_MEM_LACAL 15
#define AUTOTEST_MEM_LACAL 16
#define TIMEOUT_MEM_LACAL 17
#define COST_MEM_LACAL 18
#define SCANSPEED_MEM_LACAL 19
#define MODBUSADD_MEM_LACAL 20

#define BAUDRATE_MEM_LACAL 21
#define ALARMOUTTEST_MEM_LACAL 22
#define HEATERTEST_MEM_LACAL 23
#define GFITEST_MEM_LACAL 24

#define SYSTEMFLAG_EEPROM_LACAL 84

//#define CONFIRM_CHANGE_STR 63
//#define CHANGE_COMPLETE_STR 64

char FirstTempCheck=0;

char PasswordNeed = 0;
char ParametersChanged = 0;
char Usr_Psw_en = 0;
char CtrlTypeCheck[2]={FALSE};
int ShapeForDuty;
int PowerLimitCheck[2]={SPC_SYSTEMVALUE_OFF};
unsigned char AlarmNumCheck=0;
//SYSTEM_VALUEB FlagBuff;

typedef struct tagCONFILIC
{
  char ParaMenAdress;
  int MaxPara;
  int MinPara;
  char SpecialNum;
}CONFILIC;

code CONFILIC ConflictCheckList[20] = {
  //maintemp   0
    {MAINTAIN_MEM_LACAL+1, MAX_TEMP_C, MIN_TEMP_C, 8},
  //deadband   1
    {DEADBAND_MEM_LACAL+1, MAX_SPCDEADBAND_C, MIN_SPCDEADBAND_C, 4},
  //lowtemp    2
    {LOWTEMP_MEM_LACAL+1, MAX_TEMP_C, MIN_TEMP_C, 5},
  //hightemp   3
    {HIGHTEMP_MEM_LACAL+1, MAX_TEMP_C, MIN_TEMP_C, 6},
  //lowcurrent  4
    {LOWCURRENT_MEM_LACAL, MAX_SPCCURRENT, MIN_SPCCURRENT, 2},
  //highcurrent 5
    {HIGHCURRENT_MEM_LACAL, MAX_SPCCURRENT, MIN_SPCCURRENT, 3},
  //gfialarm     6
    {GFIALARM_MEM_LACAL, MAX_SPCGFIALARM, MIN_SPCGFIALARM, 2},
  //gfitrip     7
    {GFITRIP_MEM_LACAL, MAX_SPCGFIALARM, MIN_SPCGFIALARM, 3},
  //lowvolt     8
    {LOWVOLT_MEM_LACAL, MAX_SPCVOLT, MIN_SPCVOLT, 2},
  //highvolt     9
    {HIGHVOLT_MEM_LACAL, MAX_SPCVOLT, MIN_SPCVOLT, 3},
  //powerlimiting  10
    {LIMITCURRENT_MEM_LACAL, 100, 20, 1},
  //softstart      11
    {SOFTSTART_MEM_LACAL, MAX_SOFTSTART , MIN_SOFTSTART, 1},
  //autotest      12
    {AUTOTEST_MEM_LACAL, MAX_AUTOTEST, MIN_AUTOTEST, 1},
  //timeout       13
    {TIMEOUT_MEM_LACAL, MAX_TIMEOUT, MIN_TIMEOUT, 1},
  //cost          14
    {COST_MEM_LACAL, MAX_SPCOST, MIN_SPCOST, 0},
  //scan          15
    {SCANSPEED_MEM_LACAL, MAX_SCANSPEED, MIN_SCANSPEED, 0},
  //modbusaddress   16
    {MODBUSADD_MEM_LACAL, MAX_MODBUS, MIN_MODBUS, 0},
  //baudrate        17
    {BAUDRATE_MEM_LACAL, 4, 0, 0},
  //alarmtest       18
    {ALARMOUTTEST_MEM_LACAL, 24, 1, 7},
  //heatertest      19
    {HEATERTEST_MEM_LACAL, 24, 1, 7}
  //gfitest         20
    //{GFITEST_MEM_LACAL, 2, 0, 0}
};

//==============================================================================
//SPC system config
//input：none
//output：none
//==============================================================================
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
  //Statis_flag[0] = 0;
  //Statis_flag[1] = 0;
  
  //SetSystemToDefault();

  if(SPCIfFirstRun())
  {
    SetSystemToDefault();
  }
  else
  {
    SetSystemFromEEP();
  }
  
  Spcpwm[0].meas_cmd = INITIAL_MEASUREMENT;
  Spcpwm[1].meas_cmd = INITIAL_MEASUREMENT;
  Statis_flag[0] = (STATIS_MAX_TEMP + STATIS_MIN_TEMP + STATIS_MAX_VOLT + STATIS_MIN_VOLT + STATIS_CURRENT + STATIS_GFI);
  Statis_flag[1] = (STATIS_MAX_TEMP + STATIS_MIN_TEMP + STATIS_MAX_VOLT + STATIS_MIN_VOLT + STATIS_CURRENT + STATIS_GFI);
  
  if(pSPCValue[0].SPCSetPoints.system_valueb.bite.man_on)
    SetHeatStatStr(HEAT_IS_MANOFF, 0);
  else
    SetHeatStatStr(HEAT_IS_OFF, 0);
    
  if(pSPCValue[1].SPCSetPoints.system_valueb.bite.man_on)
    SetHeatStatStr(HEAT_IS_MANOFF, 1);
  else
    SetHeatStatStr(HEAT_IS_OFF, 1);
    
  SetIntStr((int*)&duty_index[0], CH1_ACTURAL_DUTY, UNIT_AMPER_PERCENT, 1);
  SetIntStr((int*)&duty_index[0], CH1_ACTURAL_ENEGY, UNIT_ENEGRY, 3);
  SetIntStr((int*)&duty_index[0], CH1_ACTURAL_ONTIME_PERCENT, UNIT_PERCENT, 1);
  SetIntStr((int*)&duty_index[1], CH2_ACTURAL_DUTY, UNIT_AMPER_PERCENT, 1);
  SetIntStr((int*)&duty_index[1], CH2_ACTURAL_ENEGY, UNIT_ENEGRY, 3);
  SetIntStr((int*)&duty_index[1], CH2_ACTURAL_ONTIME_PERCENT, UNIT_PERCENT, 1);
  SetOntimeStr(0, CH1_ACTURAL_ONTIME);
  SetOntimeStr(0, CH2_ACTURAL_ONTIME);
  SetCostStr(0, CH1_ACTURAL_COST);
  SetCostStr(0, CH2_ACTURAL_COST);

  SetIntStr((int*)&pSPCAlarm.spcalarms.num_alarms, ACTURAL_ALARM, UNIT_ALARM, 7);
  //SetHeatStatStr(HEAT_IS_OFF);
  
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
  
  if(pSPCValue[0].SPCSetPoints.system_valueb.bite.gfi_test_mod == GFI_TEST_NOW)
  {
    pSPCValue[0].SPCSetPoints.system_valueb.bite.gfi_test_mod = GFI_TEST_DISABLE;
  }
  
  if(pSPCValue[1].SPCSetPoints.system_valueb.bite.gfi_test_mod == GFI_TEST_NOW)
  {
    pSPCValue[1].SPCSetPoints.system_valueb.bite.gfi_test_mod = GFI_TEST_DISABLE;
  }
}

//==============================================================================
//get maintain temperature state
//input：none
//output：0-Normal, 1-None, 2-Off
//==============================================================================
UCHAR MainTainTempDisable(char ChannelNum)
{
  if(pSPCValue[ChannelNum].SPCSetPoints.MaintainTemp.Temperature_C == SPC_SYSTEMVALUE_NONE)
    return 1;
  else if(pSPCValue[ChannelNum].SPCSetPoints.MaintainTemp.Temperature_C == SPC_SYSTEMVALUE_OFF)
    return 2;
  else
    return 0;
}

//==============================================================================
//get control type
//input：none
//output：0-OnOff, 1-Proportion
//==============================================================================
UCHAR ProCtlEnable(char ChannelNum)
{
  if(pSPCValue[ChannelNum].SPCSetPoints.system_valueb.bite.ctl_type == FALSE)
    return 0;
  else
    return 1;
}

//==============================================================================
//get control type
//input：none
//output：0-FixResis, 1-SelfRegulate
//==============================================================================
UCHAR SelfRegulaEnable(char ChannelNum)
{
  if(pSPCValue[ChannelNum].SPCSetPoints.system_valueb.bite.heater_type == FALSE)
    return 0;
  else
    return 1;
}

//==============================================================================
//restore system to default
//input：none
//output：none
//==============================================================================
void SetSystemToDefault()
{
  char i;
  
  for(i=0;i<2;i++)
  {
    pSPCValue[i].SPCSetPoints.MaintainTemp.Temperature_C = MAINTAINTEMP_DEF_C;
    pSPCValue[i].SPCSetPoints.MaintainTemp.Temperature_F = MAINTAINTEMP_DEF_F;
    pSPCValue[i].SPCSetPoints.LowTemp.Temperature_C = LOWTEMPALARM_DEF_C;
    pSPCValue[i].SPCSetPoints.LowTemp.Temperature_F = LOWTEMPALARM_DEF_F;
    pSPCValue[i].SPCSetPoints.HighTemp.Temperature_C = SPC_SYSTEMVALUE_OFF;
    pSPCValue[i].SPCSetPoints.HighTemp.Temperature_F = SPC_SYSTEMVALUE_OFF;
    pSPCValue[i].SPCSetPoints.DeadBand.Temperature_C = DEADBAND_DEF_C;
    pSPCValue[i].SPCSetPoints.DeadBand.Temperature_F = DEADBAND_DEF_F;

    pSPCValue[i].SPCSetPoints.LowCurrent = SPC_SYSTEMVALUE_OFF;
    pSPCValue[i].SPCSetPoints.HighCurrent = SPC_SYSTEMVALUE_OFF;
    pSPCValue[i].SPCSetPoints.GFIAlarm = GFI_ALARM_DEF;
    pSPCValue[i].SPCSetPoints.GFITrip = GFI_TRIP_DEF;

    pSPCValue[i].SPCSetPoints.LowVoltage = SPC_SYSTEMVALUE_OFF;
    pSPCValue[i].SPCSetPoints.HighVoltage = SPC_SYSTEMVALUE_OFF;

    pSPCValue[i].SPCSetPoints.LimitedCurrent = SPC_SYSTEMVALUE_OFF;
    pSPCValue[i].SPCSetPoints.SoftStartTime = SPC_SYSTEMVALUE_OFF;
                     //pSPCValue.SPCSetPoints.SoftStartTime = 100;
    pSPCValue[i].SPCSetPoints.AutoTestTime = AUTOTESTCYCLE_DEF;

    pSPCValue[i].SPCSetPoints.DisplayTime = DISPLAY_TIME_DEF;
    pSPCValue[i].SPCSetPoints.CostPerKWH = COSTPERKWH_DEF;
    pSPCValue[i].SPCSetPoints.ScanSpeed = SCANSPEED_LOW;
    pSPCValue[i].SPCSetPoints.ModbusAdd = MODBUSADD_LOW;
    pSPCValue[i].SPCSetPoints.BaudRate = BAUDRATE_9600;

    pSPCValue[i].SPCSetPoints.AlarmOutTest = SPC_SYSTEMVALUE_DISABLE;
    pSPCValue[i].SPCSetPoints.HeaterTest = SPC_SYSTEMVALUE_DISABLE;
    pSPCValue[i].SPCSetPoints.GFTest = GFI_TEST_DISABLE;

    ClearStr(pSPCValue[i].SPCSetPoints.HeaterName, 16);
    //ClearStr(pSPCValue[i].SPCSetPoints.Password, 16);
    //getParaChar(pSPCValue[i].SPCSetPoints.Password, DEFAULT_PSW_STR);

    pSPCValue[i].SPCSetPoints.system_valueb.bite.heater_en = TRUE;
    pSPCValue[i].SPCSetPoints.system_valueb.bite.man_on = FALSE;
    pSPCValue[i].SPCSetPoints.system_valueb.bite.ctl_type = FALSE;
    pSPCValue[i].SPCSetPoints.system_valueb.bite.rtd_opr = ONE_RTD_MOD;
    pSPCValue[i].SPCSetPoints.system_valueb.bite.rtd_fail_mod = FALSE;
    //pSPCValue[i].SPCSetPoints.system_valueb.bite.password_en = FALSE;
    pSPCValue[i].SPCSetPoints.system_valueb.bite.spc_units_c = TRUE;
    pSPCValue[i].SPCSetPoints.system_valueb.bite.usr_advanced = TRUE;

    //pSPCValue[i].SPCSetPoints.system_valueb.bite.def_display = SYSTEM_STATUS_MOD;
        pSPCValue[i].SPCSetPoints.system_valueb.bite.def_display = HEATER_STATUS_MOD;
    pSPCValue[i].SPCSetPoints.system_valueb.bite.gfi_test_mod = GFI_TEST_DISABLE;
    pSPCValue[i].SPCSetPoints.system_valueb.bite.heater_type = 1;
    pSPCValue[i].SPCSetPoints.system_valueb.bite.baud = BAUDRATE_9600;


    Statis_flag[i] = (STATIS_MAX_TEMP + STATIS_MIN_TEMP + STATIS_MAX_VOLT + STATIS_MIN_VOLT + STATIS_CURRENT + STATIS_GFI);
  }
  ClearStr(pSPCValue[0].SPCSetPoints.Password, 16);
  getParaChar(pSPCValue[0].SPCSetPoints.Password, DEFAULT_PSW_STR);
  pSPCValue[0].SPCSetPoints.system_valueb.bite.password_en = 1;
  
  EEPROM_set(0x01,sizeof(SPCSETPIONTS),(UCHAR*)(&pSPCValue[0].SPCSetPoints));
  EEPROM_set(0x01+sizeof(SPCSETPIONTS),sizeof(SPCSETPIONTS),(UCHAR*)(&pSPCValue[1].SPCSetPoints));
  //EEPROM_set(0x01+2*sizeof(SPCSETPIONTS),sizeof(SPCLOG),(UCHAR*)(&pSPCAlarm.spclogs));
  EEPROM_set(0x01+2*sizeof(SPCSETPIONTS),sizeof(STATISTICS),(UCHAR*)(&pSPCValue[0].SPCStatistics));
  EEPROM_set(0x01+2*sizeof(SPCSETPIONTS)+sizeof(STATISTICS),sizeof(STATISTICS),(UCHAR*)(&pSPCValue[1].SPCStatistics));
  EEPROM_set(0x01+2*sizeof(SPCSETPIONTS)+2*sizeof(STATISTICS),sizeof(SPCLOG),(UCHAR*)(&pSPCAlarm.spclogs));
}

//==============================================================================
//set the system form EEP
//input：none
//output：none
//==============================================================================
void SetSystemFromEEP()
{
  char units;
  signed int *temp_ptr;

  EEPROM_get(0x01,sizeof(SPCSETPIONTS),(UCHAR*)(&pSPCValue[0].SPCSetPoints));
  EEPROM_get(0x01+sizeof(SPCSETPIONTS),sizeof(SPCSETPIONTS),(UCHAR*)(&pSPCValue[1].SPCSetPoints));
  //EEPROM_get(0x01+2*sizeof(SPCSETPIONTS),sizeof(SPCLOG),(UCHAR*)(&pSPCAlarm.spclogs));
  EEPROM_get(0x01+2*sizeof(SPCSETPIONTS),sizeof(STATISTICS),(UCHAR*)(&pSPCValue[0].SPCStatistics));
  EEPROM_get(0x01+2*sizeof(SPCSETPIONTS)+sizeof(STATISTICS),sizeof(STATISTICS),(UCHAR*)(&pSPCValue[1].SPCStatistics));
  EEPROM_get(0x01+2*sizeof(SPCSETPIONTS)+2*sizeof(STATISTICS),sizeof(SPCLOG),(UCHAR*)(&pSPCAlarm.spclogs));
  //EEPROM_get(0x300,8,(UCHAR*)Cali_value);
  
  units = pSPCValue[0].SPCSetPoints.system_valueb.bite.spc_units_c;
  temp_ptr = (signed int *)(&pSPCValue[Cable_Channel].SPCStatistics.MaximumTemp) + units;
  SetTempStatStr(temp_ptr, CH1_ACTURAL_MAX, Cable_Channel);
  temp_ptr = (signed int *)(&pSPCValue[Cable_Channel].SPCStatistics.MinimumTemp) + units;
  SetTempStatStr(temp_ptr,CH1_ACTURAL_MIN, Cable_Channel);
  SetIntStr((int*)&pSPCValue[Cable_Channel].SPCStatistics.MaximumGFCurrent, CH1_ACTURAL_GFI_MAX+Cable_Channel, UNIT_MILIAMPER, 2);
  SetCurrentStr((int*)&pSPCValue[Cable_Channel].SPCStatistics.MaximumCurrent, CH1_ACTURAL_CURRENT_MAX+Cable_Channel, UNIT_AMPER, 1);
  SetIntStr((int*)&pSPCValue[Cable_Channel].SPCStatistics.MaximumVoltage, ACTURAL_VOLT_MAX+Cable_Channel, UNIT_ACVOLT, 1);
  SetIntStr((int*)&pSPCValue[Cable_Channel].SPCStatistics.MinimumVoltage, ACTURAL_VOLT_MIN+Cable_Channel, UNIT_ACVOLT, 1);
}

//==============================================================================
//set the title
//input：none
//output：none
//==============================================================================
void TitleSet(UCHAR direct, UCHAR cmd)
{
  UCHAR i;

  for(i=0;i<16;i++)
    Info_Line2[i] = SPCTitle[SpcMenu[Menustat].offset][i];
  asm nop;
}

//==============================================================================
//config channel
//input：increase/decrease , key type
//output：none
//==============================================================================
void ChannelConfig(UCHAR direct, UCHAR cmd)
{
  static char ChannelConfigMirror;

  if(cmd == CMD_ENTER)
  {
    //if(pSPCValue[0].SPCSetPoints.system_valueb.bite.password_en==0)
    //return;

    Cable_Channel = ChannelConfigMirror;
    storage();
    ParametersChanged = 1;
  }
  else if(cmd == CMD_RESET)
  {
    getParaChar(Info_Line2, CHANNEL1_STR+Cable_Channel);
    ChannelConfigMirror = Cable_Channel;
  }
  else if(cmd == CMD_ADJUST)
  {
    //if(pSPCValue[0].SPCSetPoints.system_valueb.bite.password_en==0)
    //return;

    if(direct)
    {
      if(ChannelConfigMirror == 0)
      {
        ChannelConfigMirror = 1;
        getParaChar(Info_Line2, CHANNEL1_STR+ChannelConfigMirror);
      }
    }
    else
    {
      if(ChannelConfigMirror == 1)
      {
        ChannelConfigMirror = 0;
        getParaChar(Info_Line2, CHANNEL1_STR+ChannelConfigMirror);
      }
    }
  }
}

//==============================================================================
//set maintain temp
//input：increase/decrease , key type
//output：none
//==============================================================================
void MaintainTempSet(UCHAR direct, UCHAR cmd)
{
  int maxtemp,mintemp,units;
  int *ptr;

  units = pSPCValue[0].SPCSetPoints.system_valueb.bite.spc_units_c;
  ptr = (int *)(&SetP_shade.MaintainTemp);

  if(units)
  {
    maxtemp = MAX_TEMP_C;
    mintemp = MIN_TEMP_C;
  }
  else
  {
    maxtemp = MAX_TEMP_F;
    mintemp = MIN_TEMP_F;
  }
  
  if(cmd == CMD_ENTER)
  {
    if(pSPCValue[0].SPCSetPoints.system_valueb.bite.password_en==0)
    return;
  
    if((SetP_shade.MaintainTemp.Temperature_C != SPC_SYSTEMVALUE_OFF) &&
       (SetP_shade.MaintainTemp.Temperature_C != SPC_SYSTEMVALUE_NONE))
      ConvertTemp(&SetP_shade.MaintainTemp);

    CopyTemp(&SetP_shade.MaintainTemp, &pSPCValue[Cable_Channel].SPCSetPoints.MaintainTemp);
    storage();
    ParametersChanged = 1;
  }
  else if(cmd == CMD_RESET)
  {
    CopyTemp(&pSPCValue[Cable_Channel].SPCSetPoints.MaintainTemp, &SetP_shade.MaintainTemp);
    if(SetP_shade.MaintainTemp.Temperature_C == SPC_SYSTEMVALUE_OFF)
      getParaChar(Info_Line2, OFF_STR);
    else if(SetP_shade.MaintainTemp.Temperature_C == SPC_SYSTEMVALUE_NONE)
      getParaChar(Info_Line2, NONE_STR);
    else
      FromIntToStr(*(ptr+units),Info_Line2,SpcMenu[Menustat].decimal);
  }
  else if(cmd == CMD_ADJUST)
  {
    if(pSPCValue[0].SPCSetPoints.system_valueb.bite.password_en==0)
      return;
  
    Flashing_EN();
    if(direct)
    {
      if(*(ptr+units) == SPC_SYSTEMVALUE_NONE)
      {
        SetP_shade.MaintainTemp.Temperature_C = SPC_SYSTEMVALUE_OFF;
        SetP_shade.MaintainTemp.Temperature_F = SPC_SYSTEMVALUE_OFF;
        getParaChar(Info_Line2, OFF_STR);
      }
      else if(*(ptr+units) == maxtemp)
      {
        SetP_shade.MaintainTemp.Temperature_C = SPC_SYSTEMVALUE_NONE;
        SetP_shade.MaintainTemp.Temperature_F = SPC_SYSTEMVALUE_NONE;
        getParaChar(Info_Line2, NONE_STR);
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
      if(*(ptr+units) == SPC_SYSTEMVALUE_OFF)
      {
        SetP_shade.MaintainTemp.Temperature_C = SPC_SYSTEMVALUE_NONE;
        SetP_shade.MaintainTemp.Temperature_F = SPC_SYSTEMVALUE_NONE;
        getParaChar(Info_Line2, NONE_STR);
      }
      else if(*(ptr+units) == SPC_SYSTEMVALUE_NONE)
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

//==============================================================================
//set deadband
//input：increase/decrease , key type
//output：none
//==============================================================================
void DeadbandSet(UCHAR direct, UCHAR cmd)
{
  int maxtemp,mintemp,units;
  int *ptr;

  units = pSPCValue[0].SPCSetPoints.system_valueb.bite.spc_units_c;
  ptr = (int *)(&SetP_shade.DeadBand);
  if(units)
  {
    maxtemp = MAX_SPCDEADBAND_C;
    mintemp = MIN_SPCDEADBAND_C;
  }
  else
  {
    maxtemp = MAX_SPCDEADBAND_F;
    mintemp = MIN_SPCDEADBAND_F;
  }
  
  if(cmd == CMD_ENTER)
  {
    if(pSPCValue[0].SPCSetPoints.system_valueb.bite.password_en==0)
    return;
  
    ConvertDead(&SetP_shade.DeadBand);
    CopyTemp(&SetP_shade.DeadBand, &pSPCValue[Cable_Channel].SPCSetPoints.DeadBand);
    storage();
    ParametersChanged = 1;
  }
  else if(cmd == CMD_RESET)
  {
    CopyTemp(&pSPCValue[Cable_Channel].SPCSetPoints.DeadBand, &SetP_shade.DeadBand);
    FromIntToStr(*(ptr+units),Info_Line2,SpcMenu[Menustat].decimal);
  }
  else if(cmd == CMD_ADJUST)
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

//==============================================================================
//set low temp alarm
//input：increase/decrease , key type
//output：none
//==============================================================================
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
  
  if((pSPCValue[Cable_Channel].SPCSetPoints.MaintainTemp.Temperature_C == SPC_SYSTEMVALUE_OFF) ||
     (pSPCValue[Cable_Channel].SPCSetPoints.MaintainTemp.Temperature_C == SPC_SYSTEMVALUE_NONE))
  {
    if(pSPCValue[Cable_Channel].SPCSetPoints.HighTemp.Temperature_C == SPC_SYSTEMVALUE_OFF)
    {
      if(units)
        maxtemp = MAX_TEMP_C-1;
      else
        maxtemp = MAX_TEMP_F-1;
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
    mintemp = MIN_TEMP_C;
  else
    mintemp = MIN_TEMP_F;

  if(cmd == CMD_ENTER)
  {
    if(pSPCValue[0].SPCSetPoints.system_valueb.bite.password_en==0)
      return;
    if(pSPCValue[Cable_Channel].SPCSetPoints.MaintainTemp.Temperature_C == SPC_SYSTEMVALUE_NONE)
      return;
  
    if(SetP_shade.LowTemp.Temperature_C != SPC_SYSTEMVALUE_OFF)
      ConvertTemp(&SetP_shade.LowTemp);
    CopyTemp(&SetP_shade.LowTemp, &pSPCValue[Cable_Channel].SPCSetPoints.LowTemp);
    storage();
    ParametersChanged = 1;
  }
  else if(cmd == CMD_RESET)
  {
    if(pSPCValue[Cable_Channel].SPCSetPoints.MaintainTemp.Temperature_C == SPC_SYSTEMVALUE_NONE)
    {
      getParaChar(Info_Line2, NONEVALUE_STR);
      return;
    }
  
    CopyTemp(&pSPCValue[Cable_Channel].SPCSetPoints.LowTemp, &SetP_shade.LowTemp);
    if(SetP_shade.LowTemp.Temperature_C == SPC_SYSTEMVALUE_OFF)
      getParaChar(Info_Line2, OFF_STR);
    else
      FromIntToStr(*(ptr+units),Info_Line2,SpcMenu[Menustat].decimal);
  }
  else if(cmd == CMD_ADJUST)
  {
    if(pSPCValue[0].SPCSetPoints.system_valueb.bite.password_en==0)
      return;
    if(pSPCValue[Cable_Channel].SPCSetPoints.MaintainTemp.Temperature_C == SPC_SYSTEMVALUE_NONE)
      return;
  
    Flashing_EN();
    if(direct)
    {
      if(*(ptr+units) == maxtemp-1)
      {
        SetP_shade.LowTemp.Temperature_C = SPC_SYSTEMVALUE_OFF;
        SetP_shade.LowTemp.Temperature_F = SPC_SYSTEMVALUE_OFF;
        getParaChar(Info_Line2, OFF_STR);
      }
      else if(*(ptr+units) < maxtemp-1)
      {
        (*(ptr+units)) += KeyHoldStep;
        if(*(ptr+units) > maxtemp-1) *(ptr+units) = maxtemp-1;
        FromIntToStr(*(ptr+units),Info_Line2,SpcMenu[Menustat].decimal);
      }
      else
      {
        if(SetP_shade.LowTemp.Temperature_C != SPC_SYSTEMVALUE_OFF)
          *(ptr+units) = maxtemp-1;
        ConvertTemp(&SetP_shade.LowTemp);
      }

    }
    else
    {
      if(*(ptr+units) == SPC_SYSTEMVALUE_OFF)
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

//==============================================================================
//set high temp alarm
//input：increase/decrease , key type
//output：none
//==============================================================================
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
  
  if((pSPCValue[Cable_Channel].SPCSetPoints.MaintainTemp.Temperature_C == SPC_SYSTEMVALUE_OFF) ||
     (pSPCValue[Cable_Channel].SPCSetPoints.MaintainTemp.Temperature_C == SPC_SYSTEMVALUE_NONE))
  {
    if(pSPCValue[Cable_Channel].SPCSetPoints.LowTemp.Temperature_C == SPC_SYSTEMVALUE_OFF)
    {
      if(units)
        mintemp = MIN_TEMP_C+1;
      else
        mintemp = MIN_TEMP_F+1;
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
    maxtemp = MAX_TEMP_C;
  else
    maxtemp = MAX_TEMP_F;
    
  if(cmd == CMD_ENTER)
  {
    if(pSPCValue[0].SPCSetPoints.system_valueb.bite.password_en==0)
      return;
    if(pSPCValue[Cable_Channel].SPCSetPoints.MaintainTemp.Temperature_C == SPC_SYSTEMVALUE_NONE)
      return;
  
    if(SetP_shade.HighTemp.Temperature_C != SPC_SYSTEMVALUE_OFF)
      ConvertTemp(&SetP_shade.HighTemp);
    CopyTemp(&SetP_shade.HighTemp, &pSPCValue[Cable_Channel].SPCSetPoints.HighTemp);
    storage();
    ParametersChanged = 1;
  }
  else if(cmd == CMD_RESET)
  {
    if(pSPCValue[Cable_Channel].SPCSetPoints.MaintainTemp.Temperature_C == SPC_SYSTEMVALUE_NONE)
    {
      getParaChar(Info_Line2, NONEVALUE_STR);
      return;
    }
  
    CopyTemp(&pSPCValue[Cable_Channel].SPCSetPoints.HighTemp, &SetP_shade.HighTemp);
    if(SetP_shade.HighTemp.Temperature_C == SPC_SYSTEMVALUE_OFF)
      getParaChar(Info_Line2, OFF_STR);
    else
      FromIntToStr(*(ptr+units),Info_Line2,SpcMenu[Menustat].decimal);
  }
  else if(cmd == CMD_ADJUST)
  {
    if(pSPCValue[0].SPCSetPoints.system_valueb.bite.password_en==0)
      return;
    if(pSPCValue[Cable_Channel].SPCSetPoints.MaintainTemp.Temperature_C == SPC_SYSTEMVALUE_NONE)
      return;
  
    Flashing_EN();
    if(direct)
    {
      if(*(ptr+units) == maxtemp)
      {
        SetP_shade.HighTemp.Temperature_C = SPC_SYSTEMVALUE_OFF;
        SetP_shade.HighTemp.Temperature_F = SPC_SYSTEMVALUE_OFF;
        getParaChar(Info_Line2, OFF_STR);
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
      if(*(ptr+units) == SPC_SYSTEMVALUE_OFF)
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

//==============================================================================
//set heater ID
//input：increase/decrease , key type
//output：none
//==============================================================================
void HeaterIDSet(UCHAR direct, UCHAR cmd)
{
  if(cmd == CMD_ENTER)   //enter
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
      Savedata(HEATERNAME_FLASH_LACAL+Cable_Channel*sizeof(SPCSETPIONTS),
               16,
               (UCHAR *)(&pSPCValue[Cable_Channel].SPCSetPoints.HeaterName),
               0);
    }
    else
    {
      SetP_shade.CharacNum++;
      SetP_shade.StringNum = getStringNum();
      spc_system_flag.bite.char_flash = 1;
      //char_flash_loca = SetP_shade.CharacNum+1;
      char_flash_loca++;
    }
  }
  else if(cmd == CMD_RESET)    //reset
  {
    //strcpy(SetP_shade.HeaterName, pSPCValue.SPCSetPoints.HeaterName);
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
  else if(cmd == CMD_ADJUST)      //up/down
  {
    if(pSPCValue[0].SPCSetPoints.system_valueb.bite.password_en==0)
    return;
  
    if((direct == 1) && (SetP_shade.StringNum < PSW_CHARACT_NUM+PSW_CHARACT_EX_NUM))
      SetP_shade.HeaterName[SetP_shade.CharacNum] = SpcCharactors[++SetP_shade.StringNum];
    else if((direct == 0) && (SetP_shade.StringNum > 0))
      SetP_shade.HeaterName[SetP_shade.CharacNum] = SpcCharactors[--SetP_shade.StringNum];

    Info_Line2[SetP_shade.CharacNum] = SetP_shade.HeaterName[SetP_shade.CharacNum];
    spc_system_flag.bite.char_flash = 1;
  }
  
  Info_Line2[14] = 'P';
  Info_Line2[15] = Cable_Channel+0X31;
}

//==============================================================================
//set password
//input：increase/decrease , key type
//output：none
//==============================================================================
void PasswordEidtorSet(UCHAR direct, UCHAR cmd)
{
  static char SetPSWReq = 0,SetPSWVal = 0;

  if(cmd == CMD_ENTER)     //enter
  {
    if(pSPCValue[0].SPCSetPoints.system_valueb.bite.password_en==0)
        return;
  
    if(SetPSWVal)
    {
      if(SetPSWReq == SET_PSW_START)
      {
        SetP_shade.CharacNum = 0;
        SetP_shade.StringNum = 0;
        SetPSWReq = SET_OLD_PSW;
        CopyPSWTitle(Info_Line1, SetPSWReq);
        spc_system_flag.bite.char_actived = 1;
        spc_system_flag.bite.char_flash = 1;
        char_flash_loca = 1;
      }
      else if(SetPSWReq == SET_OLD_PSW)
      {
        if(StrCompar(SetP_shade.Password, pSPCValue[0].SPCSetPoints.Password))
        {
          SetP_shade.CharacNum = 0;
          SetP_shade.StringNum = 0;
          SetPSWReq = SET_NEW_PSW;
          CopyPSWTitle(Info_Line1, SetPSWReq);
          spc_system_flag.bite.char_flash = 1;
          char_flash_loca = 1;
        }
        else
        {
          CopyPSWTitle(Info_Line1, SET_PSW_INVALID);
          SetPSWReq = SET_PSW_START;
          SetPSWVal = 0;
          spc_system_flag.bite.char_actived = 0;
          LCDext = 1;
          spc_system_flag.bite.char_flash = 0;
          Lcd_Cmd(_LCD_CURSOR_OFF);
        }
      }
      else if(SetPSWReq == SET_NEW_PSW)
      {
        if(SetP_shade.CharacNum < 3)
        {
          CopyPSWTitle(Info_Line1, SET_PSW_INVALID);
          SetPSWReq = SET_PSW_START;
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
          SetPSWReq = SET_NEW_PSW_AGAIN;
          CopyStr(SetP_shade.Password, Passwordbuff, 16);   //strcpy(Passwordbuff, SetP_shade.Password);
          CopyPSWTitle(Info_Line1, SetPSWReq);
          spc_system_flag.bite.char_flash = 1;
          char_flash_loca = 1;
        }
      }
      else if(SetPSWReq == SET_NEW_PSW_AGAIN)
      {
        if(StrCompar(Passwordbuff, SetP_shade.Password))
        {
          SetPSWReq =  SET_PSW_SUCCED;
          CopyStr(SetP_shade.Password, pSPCValue[0].SPCSetPoints.Password, 16);
          Savedata(PASSWORD_FLASH_LACAL,
                   16,
                   (UCHAR *)(&pSPCValue[0].SPCSetPoints.Password),
                   0);
        }
        else
          SetPSWReq =  SET_PSW_FAIL;
          
        CopyPSWTitle(Info_Line1, SetPSWReq);
        SetPSWReq = SET_PSW_START;
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
  else if(cmd == CMD_RESET)   //reset
  {
    SetPSWReq = SET_PSW_START;
    SetPSWVal = 0;
    spc_system_flag.bite.char_actived = 0;
    CopyPSWTitle(Info_Line1, SetPSWReq);
    getParaChar(Info_Line2, NO_STR);
    CopyStr(Info_Line1, Info_Line1_shape, 16);
    CopyStr(Info_Line2, Info_Line2_shape, 16);
    ClearStr(SetP_shade.Password, 16);
    spc_system_flag.bite.char_flash = 0;
    Lcd_Cmd(_LCD_CURSOR_OFF);
  }
  else if(cmd == CMD_SWITCH)
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
  else if(cmd == CMD_ADJUST)
  {
    if(pSPCValue[0].SPCSetPoints.system_valueb.bite.password_en==0)
        return;
  
    if(SetPSWReq == SET_PSW_START)
    {
      SetPSWVal ^= 1;
      if(SetPSWVal)
        getParaChar(Info_Line2, YES_STR);
      else
        getParaChar(Info_Line2, NO_STR);
    }
    else
    {
      CopyPSWTitle(Info_Line1, SetPSWReq);
      if((direct == 1) && (SetP_shade.StringNum < PSW_CHARACT_NUM))
        SetP_shade.Password[SetP_shade.CharacNum] = SpcCharactors[++SetP_shade.StringNum];
      else if((direct == 0) && (SetP_shade.StringNum > 0))
        SetP_shade.Password[SetP_shade.CharacNum] = SpcCharactors[--SetP_shade.StringNum];

      Info_Line2[SetP_shade.CharacNum] = SetP_shade.Password[SetP_shade.CharacNum];
      spc_system_flag.bite.char_flash = 1;
    }
  }
}

//==============================================================================
//set SPC to default
//input：increase/decrease , key type
//output：none
//==============================================================================
void ResetSPCSet(UCHAR direct, UCHAR cmd)
{
  static char ResetStatisticsReq = 0,ResetStatisticsVal = 0;
  char i;

  if(cmd == CMD_ENTER)  //enter
  {
    if(pSPCValue[0].SPCSetPoints.system_valueb.bite.password_en==0)
        return;
  
    if(ResetStatisticsVal == 1)
    {
      ResetStatisticsVal = 0;
      if(ResetStatisticsReq == 0)
      {
        //strcpy(Info_Line1, "Comfirm Reset?  ");
        getParaChar(Info_Line1, CONFIRM_CHANGE_STR);
        getParaChar(Info_Line2, NO_STR);
        ResetStatisticsReq++;
      }
      else
      {
        ResetStatisticsReq = 0;
        if(SpcMenu[Menustat].func_mark == FUNC_RESET)
        {
          MemeSet((char *)&pSPCValue[0].SPCStatistics, 0, sizeof(STATISTICS));
          MemeSet((char *)&pSPCValue[1].SPCStatistics, 0, sizeof(STATISTICS));
          for(i=10; i<20;i++)
            ClearStr(Actural_disp_str[i], 16);
          Statis_flag[0] = (STATIS_MAX_TEMP + STATIS_MIN_TEMP + STATIS_MAX_VOLT + STATIS_MIN_VOLT + STATIS_CURRENT + STATIS_GFI);
          Statis_flag[1] = (STATIS_MAX_TEMP + STATIS_MIN_TEMP + STATIS_MAX_VOLT + STATIS_MIN_VOLT + STATIS_CURRENT + STATIS_GFI);
          SetIntStr((int*)&pSPCValue[0].SPCStatistics.EnergyUsed, CH1_ACTURAL_ENEGY, UNIT_ENEGRY, 3);
          SetIntStr((int*)&pSPCValue[1].SPCStatistics.EnergyUsed, CH1_ACTURAL_ENEGY, UNIT_ENEGRY, 3);
          SetIntStr((int*)&pSPCValue[0].SPCStatistics.HeaterOnTime, CH1_ACTURAL_ENEGY, UNIT_ENEGRY, 3);
          SetIntStr((int*)&pSPCValue[1].SPCStatistics.HeaterOnTime, CH1_ACTURAL_ENEGY, UNIT_ENEGRY, 3);
          SetCostStr(0, CH1_ACTURAL_COST);
          SetOntimeStr(0, CH1_ACTURAL_ONTIME);
          SetCostStr(0, CH2_ACTURAL_COST);
          SetOntimeStr(0, CH2_ACTURAL_ONTIME);
          SetIntStr((int*)&pSPCAlarm.spcalarms.num_alarms, ACTURAL_ALARM, UNIT_ALARM, 7);
        }
        else if(SpcMenu[Menustat].func_mark == FUNC_RESET_MODULE)
        {
          EEPROM_Write(0x00,0x00);
          SPCSystemInitialize();
        }
        getParaChar(Info_Line1, CHANGE_COMPLETE_STR);
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
  else if(cmd == CMD_RESET)   //reset
  {
    ResetStatisticsReq = 0;
    ResetStatisticsVal = 0;
    for(i=0; i<16; i++)
      Info_Line1[i] = SpcTxtLine1[Menustat][i];
    getParaChar(Info_Line2, NO_STR);
    CopyStr(Info_Line1, Info_Line1_shape, 16);
    CopyStr(Info_Line2, Info_Line2_shape, 16);
  }
  else if(cmd == CMD_ADJUST)
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
      getParaChar(Info_Line1, CONFIRM_CHANGE_STR);
      //strcpy(Info_Line1, "Comfirm Reset?  ");
    
    if(ResetStatisticsVal)
      getParaChar(Info_Line2, YES_STR);
    else
      getParaChar(Info_Line2, NO_STR);
  }
}

//==============================================================================
//store the data into EEP
//input：address , length, pointer of data, command
//output：none
//==============================================================================
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

//==============================================================================
//set bit Parameters
//input：increase/decrease , key type
//output：none
//==============================================================================
void Para_Flag_Set(UCHAR direct, UCHAR cmd)
{
  volatile char address = 0;
  char ChannelTemp;
  char IndicatorEN=0;

  address = SpcMenu[Menustat].add;
  switch(SpcMenu[Menustat].offset)
  {
    case FLAG_PSWEN:
    case FLAG_DEFAULTDISP:
    case FLAG_DISPMODE:
    case FLAG_BAUDRATE:
    case FLAG_UNIT:
      ChannelTemp = 0;
      break;
    default:
      ChannelTemp = Cable_Channel;
      IndicatorEN = 1;
      break;
  }
  


  if(cmd == CMD_ENTER) //enter
  {
    if(pSPCValue[0].SPCSetPoints.system_valueb.bite.password_en==0)
      return;
  
    pSPCValue[ChannelTemp].SPCSetPoints.system_valueb.word &=
        ~(((0xffffffff << flag_num[SpcMenu[Menustat].len]) ^ 0xffffffff) << SpcMenu[Menustat].offset);
    pSPCValue[ChannelTemp].SPCSetPoints.system_valueb.word |= ((ULONG)SetP_shade1.chare << SpcMenu[Menustat].offset);

    storage();
    ParametersChanged = 1;
  }
  else if(cmd == CMD_RESET)     //reset
  {
    SetP_shade1.chare = (pSPCValue[ChannelTemp].SPCSetPoints.system_valueb.word >>
                                      SpcMenu[Menustat].offset) &
                                    ((0xffffffff << flag_num[SpcMenu[Menustat].len]) ^ 0xffffffff);
    
    getParaChar(Info_Line2, address+SetP_shade1.chare);
  }
  else if(cmd == CMD_ADJUST)    //left/right
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

//==============================================================================
//set int Parameters
//input：increase/decrease , key type
//output：none
//==============================================================================
void Para_int_Set(UCHAR direct, UCHAR cmd)
{
  //int变量函数设置
  static int Para_int_temp,Para_int_max,Para_int_min;
  UCHAR* add;
  int *ptr;
  char IndicatorEN=0;

  switch(SpcMenu[Menustat].offset)
  {
    case INTSET_DISPTIMEOUT:
    case INTSET_AUTOTEST:
    case INTSET_MODBUS:
    case INTSET_LOWVOLT:
    case INTSET_HIGHVOLT:
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

  //上下限有相关性，非固定
  if(SpcMenu[Menustat].edge_nofix & MAX_NOFIX)
  {
    Para_int_max = *(ptr+1);
    if(Para_int_max == SPC_SYSTEMVALUE_OFF)
      Para_int_max = SpcMenu[Menustat].MaxVal;
    else
      Para_int_max -= SpcMenu[Menustat].len;
      
    if(Para_int_max < SpcMenu[Menustat].MinVal)
      Para_int_max = SpcMenu[Menustat].MinVal;
  }
  else
    Para_int_max = SpcMenu[Menustat].MaxVal;
    
  if(SpcMenu[Menustat].edge_nofix & MIN_NOFIX)
  {
    Para_int_min = *(ptr-1);
    if(Para_int_min == SPC_SYSTEMVALUE_OFF)
      Para_int_min = SpcMenu[Menustat].MinVal;
    else
      Para_int_min += SpcMenu[Menustat].len;
      
    if(Para_int_min > SpcMenu[Menustat].MaxVal)
      Para_int_min = SpcMenu[Menustat].MaxVal;
  }
  else
    Para_int_min = SpcMenu[Menustat].MinVal;
    
  if(cmd == CMD_ENTER)    //enter
  {
    if(pSPCValue[0].SPCSetPoints.system_valueb.bite.password_en==0)
        return;
  
    *ptr = Para_int_temp;
    storage();
    ParametersChanged = 1;
  }
  else if(cmd == CMD_RESET)  //reset
  {
    Para_int_temp = *ptr;

    if(Para_int_temp == SPC_SYSTEMVALUE_DISABLE)
      getParaChar(Info_Line2, DISABLE_STR);
    else if(Para_int_temp == SPC_SYSTEMVALUE_CONTINU)
      getParaChar(Info_Line2, COUNTINU_STR);
    else if(Para_int_temp == SPC_SYSTEMVALUE_OFF)
      getParaChar(Info_Line2, OFF_STR);
    else
      FromIntToStr(Para_int_temp,Info_Line2,SpcMenu[Menustat].decimal);
  }
  else if(cmd == CMD_ADJUST)    //left/right
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
          Para_int_temp = SPC_SYSTEMVALUE_OFF;
          getParaChar(Info_Line2, OFF_STR);
        }
        else if(SpcMenu[Menustat].NumVal == 2)
        {
          Para_int_temp = SPC_SYSTEMVALUE_DISABLE;
          getParaChar(Info_Line2, DISABLE_STR);
        }
      }
      else if(Para_int_temp == SPC_SYSTEMVALUE_DISABLE)
      {
        Para_int_temp = SPC_SYSTEMVALUE_CONTINU;
        getParaChar(Info_Line2, COUNTINU_STR);
      }
      else if(Para_int_temp < Para_int_max)
      {
        if(SpcMenu[Menustat].offset == INTSET_CURRENTLIMIT)
          Para_int_temp += KeyHoldStep*10;
        else
          Para_int_temp += KeyHoldStep;
        if(Para_int_temp > Para_int_max) Para_int_temp = Para_int_max;
        FromIntToStr(Para_int_temp,Info_Line2,SpcMenu[Menustat].decimal);
      }
    }
    else
    {
      if(Para_int_temp == SPC_SYSTEMVALUE_CONTINU)
      {
        if(SpcMenu[Menustat].NumVal == 2)
        {
          Para_int_temp = SPC_SYSTEMVALUE_DISABLE;
          getParaChar(Info_Line2, DISABLE_STR);
        }
        else
        {
          Para_int_temp = SPC_SYSTEMVALUE_OFF;
          getParaChar(Info_Line2, OFF_STR);
        }
      }
      else if((Para_int_temp == SPC_SYSTEMVALUE_OFF) || (Para_int_temp == SPC_SYSTEMVALUE_DISABLE))
      {
        Para_int_temp = Para_int_max;
        FromIntToStr(Para_int_temp,Info_Line2,SpcMenu[Menustat].decimal);
      }
      else if(Para_int_temp > Para_int_min)
      {
        if(SpcMenu[Menustat].offset == INTSET_CURRENTLIMIT)
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

//==============================================================================
//show preset information
//input：none
//output：none
//==============================================================================
void Para_show(UCHAR direct, UCHAR cmd)
{
  volatile char locat;
  volatile unsigned char StringLocate, ResetLocate;
  static char ResetStatus=0, ResetParaCmd=0;
  char ChannelTemp;
  char IndicatorEN=0;

  switch(Menustat)
  {
    case 8:      //volt
    case 14:     //max volt
    case 15:     //min volt
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
    if(cmd == CMD_RESET)
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
          if(cmd == CMD_ENTER)
          {
            ResetStatus++;
            CopyStr(Info_Line1,Info_Line1_shape,16);
            getParaChar(Info_Line1, CONFIRM_CHANGE_STR);
            getParaChar(Info_Line2, NO_STR);
          }
          break;
        case 1:
          if(cmd == CMD_ENTER)
          {
            if(ResetParaCmd)
            {
              asm nop;
              ResetLocate = ResetCmd[Menustat-10] & 0xff;
              StringLocate = (ResetCmd[Menustat-10]>>8) & 0xff;
              Statis_flag[ChannelTemp] |= ResetLocate;
              ClearStr(Actural_disp_str[StringLocate], 16);
              getParaChar(Info_Line1, CHANGE_COMPLETE_STR);
              ClearStr(Info_Line2,16);
              LCDUpdate();
              Delay_ms(1000);
              CopyStr(Info_Line1_shape,Info_Line1,16);
              CopyStr(Actural_disp_str[StringLocate],Info_Line2,16);
              //LCDext = 1;
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
          else if(cmd == CMD_ADJUST)
          {
            ResetParaCmd ^= 1;
            getParaChar(Info_Line1, CONFIRM_CHANGE_STR);
            if(ResetParaCmd)
              getParaChar(Info_Line2, YES_STR);
            else
              getParaChar(Info_Line2, NO_STR);
          }
          else if(cmd == KEY_VALUE_RESET)
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

//==============================================================================
//set user authority
//input：increase/decrease , key type
//output：none
//==============================================================================
void DisablePSWInputing()
{
  Usr_Psw_en = 0;
}

void Authority_Set(UCHAR direct, UCHAR cmd)
{
  char Usr_mode_shape;            //, Usr_Psw_en=0;

    if(cmd == CMD_ENTER) //enter
    {
      if(pSPCValue[0].SPCSetPoints.system_valueb.bite.password_en)
      {
        pSPCValue[0].SPCSetPoints.system_valueb.bite.password_en = 0;
        getParaChar(Info_Line2, EN_DIS_STR);
        
        Savedata(SYSTEMFLAG_FLASH_LACAL,
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
          getParaChar(Info_Line1, ENTER_PSW_STR);

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
             getParaChar(Info_Line1, STORE_STR);
             Usr_mode_shape = pSPCValue[0].SPCSetPoints.system_valueb.bite.password_en;
             getParaChar(Info_Line2_shape, EN_DIS_STR+Usr_mode_shape);

             Savedata(SYSTEMFLAG_FLASH_LACAL,
                         sizeof(SYSTEM_VALUEB),
                         (UCHAR *)(&pSPCValue[0].SPCSetPoints.system_valueb),
                         0);
           }
           else
           {
             ClearStr(Info_Line2, 16);
             getParaChar(Info_Line1, RESET_FAILT_PSW_STR);
           }
           LCDext = 1;
           spc_system_flag.bite.char_actived = 0;
           spc_system_flag.bite.char_flash = 0;
           Lcd_Cmd(_LCD_CURSOR_OFF);
        }
      }
    }
    else if(cmd == CMD_RESET)     //reset
    {
      if(spc_system_flag.bite.char_flash == 0)
        Usr_Psw_en = 0;
    
      if(Usr_Psw_en == 0)
      {
        Usr_mode_shape = pSPCValue[0].SPCSetPoints.system_valueb.bite.password_en;
        getParaChar(Info_Line2, EN_DIS_STR+Usr_mode_shape);

        CopyStr(Info_Line1, Info_Line1_shape, 16);
        CopyStr(Info_Line2, Info_Line2_shape, 16);
      }
      else
      {
        ClearStr(Info_Line2, 16);
        getParaChar(Info_Line1, ENTER_PSW_STR);
        SetP_shade.CharacNum = 0;
        SetP_shade.StringNum = 0;
        char_flash_loca = 1;
      }
      ClearStr(SetP_shade.Password, 16);
    }
    else if(cmd == CMD_ADJUST)    //left/right
    {
      if(Usr_Psw_en)
      {
        if((direct == 1) && (SetP_shade.StringNum < PSW_CHARACT_NUM))
          SetP_shade.Password[SetP_shade.CharacNum] = SpcCharactors[++SetP_shade.StringNum];
        else if((direct == 0) && (SetP_shade.StringNum > 0))
          SetP_shade.Password[SetP_shade.CharacNum] = SpcCharactors[--SetP_shade.StringNum];
          
        Info_Line2[SetP_shade.CharacNum] = SetP_shade.Password[SetP_shade.CharacNum];
        getParaChar(Info_Line1, ENTER_PSW_STR);
      }
    }
    else if(cmd == CMD_SWITCH)
    {
      getParaChar(Info_Line1, ENTER_PSW_STR);
      Info_Line2[SetP_shade.CharacNum] = '*';
      if((direct == 1) && (SetP_shade.CharacNum < 16) &&
         (SetP_shade.Password[SetP_shade.CharacNum] != ' '))
          SetP_shade.CharacNum++;
      SetP_shade.StringNum = 0;
      char_flash_loca = SetP_shade.CharacNum+1;
    }
}

//==============================================================================
//show Version information
//input：increase/decrease , key type
//output：none
//==============================================================================
void Version_show(UCHAR direct, UCHAR cmd)
{
  char i;

  for(i=0; i<16; i++) Info_Line1[i] = Version_title[i];
  for(i=0; i<16; i++) Info_Line2[i] = Version_content[i];
}

//==============================================================================
//convert int data to srting
//input：intdata , pointer of string,  decimal
//output：none
//==============================================================================
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
    if(unitcont == UNIT_TEMP)
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

//==============================================================================
//show storage informationg on screen
//input：none
//output：none
//==============================================================================
void storage()
{
  CopyStr(Info_Line1,Info_Line1_shape, 16);
  CopyStr(Info_Line2,Info_Line2_shape, 16);
  getParaChar(Info_Line1, STORE_STR);
  ClearStr(Info_Line2, 16);
  LCDext = 1;
}

//==============================================================================
//reset password
//input：increase/decrease , key type
//output：none
//==============================================================================
void Reset_PSW(UCHAR direct, UCHAR cmd)
{
    //int变量函数设置
  static char Reset_flag = 0;
  
  if(reset_psw_en==0)
    return;

  if(cmd == CMD_INIT)
  {
    reset_psw_en = 1;
    Reset_flag = 0;
    getParaChar(Info_Line1, RESET_REQ_PSW_STR);
    getParaChar(Info_Line2, YES_NO_STR+Reset_flag);
  }
  else if(cmd == CMD_ENTER)    //enter
  {
    reset_psw_en = 0;
    if(Reset_flag == 1)        //yes
    {
      getParaChar(pSPCValue[0].SPCSetPoints.Password, DEFAULT_PSW_STR);
      Savedata(PASSWORD_FLASH_LACAL,
               16,
               (UCHAR *)(&pSPCValue[0].SPCSetPoints.Password),
               0);
      getParaChar(Info_Line1, RESET_SUCCESS_PSW_STR);
      ClearStr(Info_Line2, 16);
      LCDUpdate();
      Delay_ms(1500);
      spc_system_flag.bite.default_diaped = 0;
      disp_default();
      spc_system_flag.bite.default_diaped = 1;   //initial to display default information
      spc_system_flag.bite.stat_update = 1;      //show system stat information
      disp_default();
    }
    else
    {
      spc_system_flag.bite.default_diaped = 0;
      disp_default();
      spc_system_flag.bite.default_diaped = 1;   //initial to display default information
      spc_system_flag.bite.stat_update = 1;      //show system stat information
      disp_default();
    }
    //LCDext = 1;
  }
  else if(cmd == CMD_ADJUST)    //left/right
  {
    if(direct)
    {
      if(Reset_flag==0)
      {
        Reset_flag = 1;
        getParaChar(Info_Line2, YES_NO_STR+Reset_flag);
        LCDUpdate();
      }
    }
    else
    {
      if(Reset_flag == 1)
      {
        Reset_flag = 0;
        getParaChar(Info_Line2, YES_NO_STR+Reset_flag);
        LCDUpdate();
      }
    }
  }
}

//==============================================================================
//change charactors on screen
//input：none
//output：none
//==============================================================================
char getStringNum()
{
  char i;
  
  for(i=0; i<PSW_CHARACT_NUM+PSW_CHARACT_EX_NUM; i++)
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
    case 0:  //no special value, no related value
      EEPROM_get(Address,sizeof(int),(unsigned char*)Ptr);
      break;
    case 1:  //1 special value OFF, no related value
    case 2:  //1 special value OFF, no related value
    case 3:  //1 special value OFF, no related value
      if(*Ptr != SPC_SYSTEMVALUE_OFF)
        EEPROM_get(Address,sizeof(int),(unsigned char*)Ptr);
      break;
    case 4:  //no special value, no related value  ,temp value
      EEPROM_get(Address,sizeof(int),(unsigned char*)Ptr);
      EEPROM_get(Address-2,sizeof(int),(unsigned char*)Ptr-2);
      break;
    case 5:  //1 special value OFF, related value ,temp
    case 6:  //1 special value OFF, related value ,temp
      if(*Ptr != SPC_SYSTEMVALUE_OFF)
      {
        EEPROM_get(Address,sizeof(int),(unsigned char*)Ptr);
        EEPROM_get(Address-2,sizeof(int),(unsigned char*)Ptr-2);
      }
      break;
    case 7:  //2 special value DISABLE/CONTINUE, no related value
      if((*Ptr != SPC_SYSTEMVALUE_DISABLE) && (*Ptr != SPC_SYSTEMVALUE_CONTINU))
        EEPROM_get(Address,sizeof(int),(unsigned char*)Ptr);
      break;
    case 8:  //2 special value OFF/NONE, 1 related value
      if((*Ptr != SPC_SYSTEMVALUE_OFF) && (*Ptr != SPC_SYSTEMVALUE_NONE))
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
    case 2:  //have high related
      if(*Ptr != SPC_SYSTEMVALUE_OFF)
      {
        if((*(Ptr+1) != SPC_SYSTEMVALUE_OFF) && (*Ptr >= *(Ptr+1)))
        {
          EEPROM_get(Address,sizeof(int),(unsigned char*)Ptr);
        }
      }
      break;
    case 3:  //have low related
      if(*Ptr != SPC_SYSTEMVALUE_OFF)
      {
        if((*(Ptr-1) != SPC_SYSTEMVALUE_OFF) && (*Ptr <= *(Ptr-1)))
        {
          EEPROM_get(Address,sizeof(int),(unsigned char*)Ptr);
        }
      }
      break;
    case 5:  //have high related, temp
      if(*Ptr != SPC_SYSTEMVALUE_OFF)
      {
        if((*(Ptr+2) != SPC_SYSTEMVALUE_OFF) && (*Ptr >= *(Ptr+2)))
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
    case 6:  //have low related, temp
      if(*Ptr != SPC_SYSTEMVALUE_OFF)
      {
        if((*(Ptr-2) != SPC_SYSTEMVALUE_OFF) && (*Ptr <= *(Ptr-2)))
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
    
    Address = 1+SYSTEMFLAG_EEPROM_LACAL;
    EEPROM_get(Address,sizeof(SYSTEM_VALUEB),(unsigned char*)&FlagBuff[0]);
    Address = 1+SYSTEMFLAG_EEPROM_LACAL+sizeof(SPCSETPIONTS);
    EEPROM_get(Address,sizeof(SYSTEM_VALUEB),(unsigned char*)&FlagBuff[1]);
    if(pSPCValue[0].SPCSetPoints.system_valueb.bite.rtd_opr > 5)
    {
      //EEPROM_get(1+SYSTEMFLAG_EEPROM_LACAL,sizeof(SYSTEM_VALUEB),(unsigned char*)&FlagBuff);
      if(FlagBuff[0].bite.rtd_opr > 5)
      {
        pSPCValue[0].SPCSetPoints.system_valueb.bite.rtd_opr = ONE_RTD_MOD;
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
        pSPCValue[0].SPCSetPoints.system_valueb.bite.def_display = SYSTEM_STATUS_MOD;
      }
      else
      {
        pSPCValue[0].SPCSetPoints.system_valueb.bite.def_display = FlagBuff[0].bite.def_display;
      }
    }
    
    if(pSPCValue[0].SPCSetPoints.system_valueb.bite.gfi_test_mod > 2)
    {
      //EEPROM_get(1+SYSTEMFLAG_EEPROM_LACAL,sizeof(SYSTEM_VALUEB),(unsigned char*)&FlagBuff);
      if(FlagBuff[0].bite.gfi_test_mod > 2)
      {
        pSPCValue[0].SPCSetPoints.system_valueb.bite.gfi_test_mod = GFI_TEST_DISABLE;
      }
      else
      {
        pSPCValue[0].SPCSetPoints.system_valueb.bite.gfi_test_mod = FlagBuff[0].bite.gfi_test_mod;
      }
    }
    
    if(pSPCValue[1].SPCSetPoints.system_valueb.bite.gfi_test_mod > 2)
    {
      //EEPROM_get(1+SYSTEMFLAG_EEPROM_LACAL,sizeof(SYSTEM_VALUEB),(unsigned char*)&FlagBuff);
      if(FlagBuff[1].bite.gfi_test_mod > 2)
      {
        pSPCValue[1].SPCSetPoints.system_valueb.bite.gfi_test_mod = GFI_TEST_DISABLE;
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
        pSPCValue[0].SPCSetPoints.system_valueb.bite.baud = BAUDRATE_9600;
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
    
    if(pSPCValue[0].SPCSetPoints.system_valueb.bite.heater_type==1)      //SR
    {
      if(pSPCValue[0].SPCSetPoints.LimitedCurrent != SPC_SYSTEMVALUE_OFF)
      {
        pSPCValue[0].SPCSetPoints.LimitedCurrent = SPC_SYSTEMVALUE_OFF;
      }
      if(pSPCValue[0].SPCSetPoints.system_valueb.bite.ctl_type != 0)
      {
        pSPCValue[0].SPCSetPoints.system_valueb.bite.ctl_type = 0;
      }
    }
    
    if(pSPCValue[1].SPCSetPoints.system_valueb.bite.heater_type==1)      //SR
    {
      if(pSPCValue[1].SPCSetPoints.LimitedCurrent != SPC_SYSTEMVALUE_OFF)
      {
        pSPCValue[1].SPCSetPoints.LimitedCurrent = SPC_SYSTEMVALUE_OFF;
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


    
    Savedata(MAINTAIN_FLASH_LACAL,
             sizeof(SPCSETPIONTS),
             (UCHAR *)(&pSPCValue[0].SPCSetPoints),
             0);
    Savedata(MAINTAIN_FLASH_LACAL+sizeof(SPCSETPIONTS),
             sizeof(SPCSETPIONTS),
             (UCHAR *)(&pSPCValue[1].SPCSetPoints),
             0);
  }
  
  for(i=0;i<2;i++)
  {
    if(CtrlTypeCheck[i] != pSPCValue[i].SPCSetPoints.system_valueb.bite.ctl_type)
    {
      CtrlTypeCheck[i] = pSPCValue[i].SPCSetPoints.system_valueb.bite.ctl_type;
      if(CtrlTypeCheck[i])   //PI
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
          if(PowerLimitCheck[i] == SPC_SYSTEMVALUE_OFF)
          {
            duty_index[i] = 10;
            ShapeForDuty = duty_index[i]*10;
            pwm_duty[i] = get_duty_table(duty_index[i]);
            SystemUpdate |= (CH1_DUTY_UPDATE_REQ << i);
            SetIntStr((int*)&ShapeForDuty, CH1_ACTURAL_DUTY+i, UNIT_AMPER_PERCENT, 1);
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
              SystemUpdate |= (CH1_DUTY_UPDATE_REQ << i);
              SetIntStr((int*)&pSPCValue[i].SPCSetPoints.LimitedCurrent, CH1_ACTURAL_DUTY+i, UNIT_AMPER_PERCENT, 1);
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