#include "systemvalue.h"
#include "PIC18F6622.h"
#include "Spcsystem.h"
#include "EEPROM.h"
#include "Menuoperation.h"
#include "SpcValue.h"

void SPCSystemInitialize()
{
  memset(&pSPCValue, 0, sizeof(SPCVALUE));
  memset(&SetP_shade, 0, sizeof(SPCSETPIONTS));
  
  spc_system_flag.word = 0;
  
/*  SPCAlarms = CreatAlarms();
  AddAlarms(NOMSG);   */
  
  
  
  if(SPCIfFirstRun())
  {
    SetSystemToDefault();
  }
  else
  {
    SetSystemFromEEP();
  }
}

void Selfcheck()
{
  asm nop;
}

UCHAR MainTainTempDisable()
{
  if(pSPCValue.SPCSetPoints.MaintainTemp.Temperature_C == SPC_SYSTEMVALUE_NONE)
    return 1;
  else if(pSPCValue.SPCSetPoints.MaintainTemp.Temperature_C == SPC_SYSTEMVALUE_OFF)
    return 1;
  else
    return 0;
}

UCHAR ProCtlEnable()
{
  if(pSPCValue.SPCSetPoints.system_valueb.bite.ctl_type == FALSE)
    return 0;
  else
    return 1;
}

//==============================================================================
//把SPC恢复成默认出厂设置
//输入：无
//输出：无
//==============================================================================
void SetSystemToDefault()
{
  pSPCValue.SPCSetPoints.MaintainTemp.Temperature_C = MAINTAINTEMP_DEF_C;
  pSPCValue.SPCSetPoints.MaintainTemp.Temperature_F = MAINTAINTEMP_DEF_F;
  
  pSPCValue.SPCSetPoints.LowTemp.Temperature_C      = LOWTEMPALARM_DEF_C;
  pSPCValue.SPCSetPoints.LowTemp.Temperature_F = LOWTEMPALARM_DEF_F;
  pSPCValue.SPCSetPoints.HighTemp.Temperature_C = SPCVALUE_OFF;
  pSPCValue.SPCSetPoints.HighTemp.Temperature_F = SPCVALUE_OFF;
  pSPCValue.SPCSetPoints.DeadBand.Temperature_C = DEADBAND_DEF_C;
  pSPCValue.SPCSetPoints.DeadBand.Temperature_F = DEADBAND_DEF_F;
  
  pSPCValue.SPCSetPoints.LowCurrent = SPCVALUE_OFF;
  pSPCValue.SPCSetPoints.HighCurrent = SPCVALUE_OFF;
  pSPCValue.SPCSetPoints.GFIAlarm = GFI_ALARM_DEF;
  pSPCValue.SPCSetPoints.GFITrip = GFI_TRIP_DEF;
  pSPCValue.SPCSetPoints.LowVoltage = SPCVALUE_OFF;
  pSPCValue.SPCSetPoints.HighVoltage = SPCVALUE_OFF;
  
  pSPCValue.SPCSetPoints.LimitedCurrent = SPCVALUE_OFF;
  pSPCValue.SPCSetPoints.SoftStartTime = SPCVALUE_OFF;
  pSPCValue.SPCSetPoints.AutoTestTime = AUTOTESTCYCLE_DEF;
  
  pSPCValue.SPCSetPoints.DisplayTime = DISPLAY_TIME_DEF;
  pSPCValue.SPCSetPoints.CostPerKWH = COSTPERKWH_DEF;
  pSPCValue.SPCSetPoints.ScanSpeed = SCANSPEED_LOW;
  pSPCValue.SPCSetPoints.ModbusAdd = MODBUSADD_LOW;
  pSPCValue.SPCSetPoints.BaudRate = BAUDRATE_1200;
  
  pSPCValue.SPCSetPoints.AlarmOutTest = SPCVALUE_OFF;
  pSPCValue.SPCSetPoints.HeaterTest = SPCVALUE_OFF;
  pSPCValue.SPCSetPoints.GFTest = SPCVALUE_OFF;
  
  memset(pSPCValue.SPCSetPoints.HeaterName, 0, 16);
  memset(pSPCValue.SPCSetPoints.Password, 0, 16);
  strcpy(pSPCValue.SPCSetPoints.Password, "1234            ");
  
  pSPCValue.SPCSetPoints.system_valueb.bite.heater_en = TRUE;
  pSPCValue.SPCSetPoints.system_valueb.bite.man_on = FALSE;
  pSPCValue.SPCSetPoints.system_valueb.bite.ctl_type = FALSE;
  pSPCValue.SPCSetPoints.system_valueb.bite.rtd_opr = ONE_TRD_MOD;
  pSPCValue.SPCSetPoints.system_valueb.bite.rtd_fail_mod = FALSE;
  pSPCValue.SPCSetPoints.system_valueb.bite.password_en = TRUE;
  pSPCValue.SPCSetPoints.system_valueb.bite.spc_units_c = TRUE;
  pSPCValue.SPCSetPoints.system_valueb.bite.usr_advanced = TRUE;
  pSPCValue.SPCSetPoints.system_valueb.bite.def_display = SYSTEM_STATUS_MOD;
  
  spc_system_flag.bite.default_diaped = 1;
  
  //EEPROM_set(0x01,sizeof(SPCSETPIONTS),(UCHAR*)&pSPCValue.SPCSetPoints);
}

//==============================================================================
//把SPC恢初始化为上次的设置
//输入：无
//输出：无
//==============================================================================
void SetSystemFromEEP()
{
  //EEPROM_get(0x01,sizeof(SPCSETPIONTS),(UCHAR*)&pSPCValue.SPCSetPoints);
}

//==============================================================================
//未曾使用的函数
//输入：无
//输出：无
//==============================================================================
void dummy(UCHAR Forward, UCHAR Savedata)
{
  UCHAR Fmark;
  Fmark = GetFuncMark();

  if(Fmark == FUNC_OPV)
    strcpy(Info_Line2, "Operating values");
  else if(Fmark == FUNC_STIS)
    strcpy(Info_Line2, "Statistics      ");
  else if(Fmark == FUNC_SETP)
    strcpy(Info_Line2, "Setpoints        ");
  else if(Fmark == FUNC_HEATSET)
    strcpy(Info_Line2, "Heater setup     ");
  else if(Fmark == FUNC_SYSSET)
    strcpy(Info_Line2, "System setup     ");
  else if(Fmark == FUNC_SYSTEST)
    strcpy(Info_Line2, "System test      ");

  asm nop;
}

//==============================================================================
//设置MANITAINTEMP
//输入：无
//输出：无
//==============================================================================
void MaintainTempSet(UCHAR Forward, UCHAR Savedata)
{
  int maxtemp,mintemp,units;
  int *ptr;
  units = pSPCValue.SPCSetPoints.system_valueb.bite.spc_units_c;
  ptr = (int *)(&SetP_shade.MaintainTemp);
  if(units)
  {
    maxtemp = MAX_MAINTAINTEMP_C;
    mintemp = MIN_MAINTAINTEMP_C;
  }
  else
  {
    maxtemp = MAX_MAINTAINTEMP_F;
    mintemp = MIN_MAINTAINTEMP_F;
  }
  
  if(Savedata == 1)
  {
    //ConvertTemp(&SetP_shade.MaintainTemp, &(pSPCValue.SPCSetPoints.MaintainTemp), units);
    Savedata();
  }
  else if(Savedata == 3)
  {
    SetP_shade.MaintainTemp.Temperature_C = pSPCValue.SPCSetPoints.MaintainTemp.Temperature_C;
    SetP_shade.MaintainTemp.Temperature_F = pSPCValue.SPCSetPoints.MaintainTemp.Temperature_F;
    if(SetP_shade.MaintainTemp.Temperature_C == SPC_SYSTEMVALUE_OFF)
      strcpy(Info_Line2, "OFF             ");
    else if(SetP_shade.MaintainTemp.Temperature_C == SPC_SYSTEMVALUE_OFF)
      strcpy(Info_Line2, "None            ");
    else
      IntToStr(*(ptr+units),Info_Line2);
  }
  else
  {
    if(Forward)
    {
      if(*(ptr+units) == SPC_SYSTEMVALUE_NONE)
      {
        SetP_shade.MaintainTemp.Temperature_C = SPC_SYSTEMVALUE_OFF;
        SetP_shade.MaintainTemp.Temperature_F = SPC_SYSTEMVALUE_OFF;
        strcpy(Info_Line2, "OFF             ");
      }
      else if(*(ptr+units) == maxtemp)
      {
        SetP_shade.MaintainTemp.Temperature_C = SPC_SYSTEMVALUE_NONE;
        SetP_shade.MaintainTemp.Temperature_F = SPC_SYSTEMVALUE_NONE;
        strcpy(Info_Line2, "None            ");
      }
      else if(*(ptr+units) < maxtemp)
      {
        (*(ptr+units))++;
        IntToStr(*(ptr+units),Info_Line2);
      }
    }
    else
    {
      if(*(ptr+units) == SPC_SYSTEMVALUE_OFF)
      {
        *(ptr+units) = SPC_SYSTEMVALUE_NONE;
        strcpy(Info_Line2, "NONE            ");
      }
      else if(*(ptr+units) == SPC_SYSTEMVALUE_NONE)
      {
        *(ptr+units) = maxtemp;
        IntToStr(*(ptr+units),Info_Line2);
      }
      else if(*(ptr+units) > mintemp)
      {
        (*(ptr+units))--;
        IntToStr(*(ptr+units),Info_Line2);
      }
    }
  }
}

//==============================================================================
//设置MANITAINTEMP
//输入：无
//输出：无
//==============================================================================
void DeadbandSet(UCHAR Forward, UCHAR Savedata)
{
  int maxtemp,mintemp,units;
  int *ptr;
  units = pSPCValue.SPCSetPoints.system_valueb.bite.spc_units_c;
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

  if(Savedata == 1)
  {
    //ConvertTemp(&SetP_shade.DeadBand, &(pSPCValue.SPCSetPoints.DeadBand), units);
    //Savedata();
  }
  else if(Savedata == 3)
  {
    SetP_shade.DeadBand.Temperature_C = pSPCValue.SPCSetPoints.DeadBand.Temperature_C;
    SetP_shade.DeadBand.Temperature_F = pSPCValue.SPCSetPoints.DeadBand.Temperature_F;
    IntToStr(*(ptr+units),Info_Line2);
  }
  else
  {
    if((*(ptr+units) < maxtemp) && (*(ptr+units) > mintemp))
    {
      if(Forward)
        *(ptr+units)++;
      else
        *(ptr+units)--;

      IntToStr(*(ptr+units),Info_Line2);
    }
  }
}

//==============================================================================
//设置MANITAINTEMP
//输入：无
//输出：无
//==============================================================================
void RTDOperationSet(UCHAR Forward, UCHAR Savedata)
{
  if(Savedata == 1)
  {
    pSPCValue.SPCSetPoints.system_valueb.bite.rtd_opr = SetP_shade.system_valueb.bite.rtd_opr;
    //Savedata();
  }
  else if(Savedata == 3)
  {
    SetP_shade.system_valueb.bite.rtd_opr = pSPCValue.SPCSetPoints.system_valueb.bite.rtd_opr;
    strcpy(Info_Line2, DefDisplaymod[SetP_shade.system_valueb.bite.rtd_opr].SPCtring);
  }
  else
  {
    if((SetP_shade.system_valueb.bite.rtd_opr < HIGHTEMPCUTOFF) && (SetP_shade.system_valueb.bite.rtd_opr > ONE_RTD))
    {
      if(Forward)
        SetP_shade.system_valueb.bite.rtd_opr++;
      else
        SetP_shade.system_valueb.bite.rtd_opr--;

      strcpy(Info_Line2, RTDoperatype[SetP_shade.system_valueb.bite.rtd_opr].SPCtring);
    }
  }
}

//==============================================================================
//设置MANITAINTEMP
//输入：无
//输出：无
//==============================================================================
void DefaultDisplaySet(UCHAR Forward, UCHAR Savedata)
{
  if(Savedata == 1)
  {
    pSPCValue.SPCSetPoints.system_valueb.bite.def_display = SetP_shade.system_valueb.bite.def_display;
    Savedata();
  }
  else if(Savedata == 3)
  {
    SetP_shade.system_valueb.bite.def_display = pSPCValue.SPCSetPoints.system_valueb.bite.def_display;
    strcpy(Info_Line2, DefDisplaymod[SetP_shade.system_valueb.bite.def_display].SPCtring);
  }
  else
  {
    if((SetP_shade.system_valueb.bite.def_display < SYSTEM_STATUS) && (SetP_shade.system_valueb.bite.def_display > HEATER_TEMP))
    {
      if(Forward)
        SetP_shade.system_valueb.bite.def_display++;
      else
        SetP_shade.system_valueb.bite.def_display--;

      strcpy(Info_Line2, DefDisplaymod[SetP_shade.system_valueb.bite.def_display].SPCtring);
    }
  }
}

//==============================================================================
//设置MANITAINTEMP
//输入：无
//输出：无
//==============================================================================
void GroundFaultTestSet(UCHAR Forward, UCHAR Savedata)
{
  if(Savedata == 1)
  {
    pSPCValue.SPCSetPoints.GFTest = SetP_shade.GFTest;
    Savedata();
  }
  else if(Savedata == 3)
  {
    SetP_shade.GFTest = pSPCValue.SPCSetPoints.GFTest;
    strcpy(Info_Line2, DefDisplaymod[SetP_shade.GFTest].SPCtring);
  }
  else
  {
    if((SetP_shade.GFTest < GFITEST_AUTO) && (SetP_shade.GFTest > GFITEST_DISABLE))
    {
      if(Forward)
        SetP_shade.GFTest++;
      else
        SetP_shade.GFTest--;

      strcpy(Info_Line2, DefDisplaymod[SetP_shade.GFTest].SPCtring);
    }
  }
}

//==============================================================================
//设置MANITAINTEMP
//输入：无
//输出：无
//==============================================================================
void BaudRateSet(UCHAR Forward, UCHAR Savedata)
{
  if(Savedata == 1)
  {
    pSPCValue.SPCSetPoints.BaudRate = SetP_shade.BaudRate;
    Savedata();
  }
  else if(Savedata == 3)
  {
    SetP_shade.BaudRate = pSPCValue.SPCSetPoints.BaudRate;
    strcpy(Info_Line2, DefDisplaymod[SetP_shade.BaudRate].SPCtring);
  }
  else
  {
    if((SetP_shade.BaudRate < BAUDRATE_19200) && (SetP_shade.BaudRate > BAUDRATE_1200))
    {
      if(Forward)
        SetP_shade.BaudRate++;
      else
        SetP_shade.BaudRate--;

      strcpy(Info_Line2, DefDisplaymod[SetP_shade.BaudRate].SPCtring);
    }
  }
}

//==============================================================================
//设置MANITAINTEMP
//输入：无
//输出：无
//==============================================================================
void OperationalCostSet(UCHAR Forward, UCHAR Savedata)
{
  if(Savedata == 1)
  {
    pSPCValue.SPCSetPoints.CostPerKWH = SetP_shade.CostPerKWH;
    Savedata();
  }
  else if(Savedata == 3)
  {
    SetP_shade.CostPerKWH = pSPCValue.SPCSetPoints.CostPerKWH;
    IntToStr(SetP_shade.CostPerKWH,Info_Line2);
  }
  else
  {
    if((SetP_shade.CostPerKWH < MAX_SPCOST) && (SetP_shade.CostPerKWH > MIN_SPCOST))
    {
      if(Forward)
        SetP_shade.CostPerKWH++;
      else
        SetP_shade.CostPerKWH--;

      IntToStr(SetP_shade.CostPerKWH,Info_Line2);
    }
  }
}

//==============================================================================
//设置MANITAINTEMP
//输入：无
//输出：无
//==============================================================================
void ScanSpeedSet(UCHAR Forward, UCHAR Savedata)
{
  if(Savedata == 1)
  {
    pSPCValue.SPCSetPoints.ScanSpeed = SetP_shade.ScanSpeed;
    Savedata();
  }
  else if(Savedata == 3)
  {
    SetP_shade.ScanSpeed = pSPCValue.SPCSetPoints.ScanSpeed;
    IntToStr(SetP_shade.ScanSpeed,Info_Line2);
  }
  else
  {
    if((SetP_shade.ScanSpeed < MAX_SCANSPEED) && (SetP_shade.ScanSpeed > MIN_SCANSPEED))
    {
      if(Forward)
        SetP_shade.ScanSpeed++;
      else
        SetP_shade.ScanSpeed--;

      IntToStr(SetP_shade.ScanSpeed,Info_Line2);
    }
  }
}

//==============================================================================
//设置MANITAINTEMP
//输入：无
//输出：无
//==============================================================================
void ModbusAddSet(UCHAR Forward, UCHAR Savedata)
{
  if(Savedata == 1)
  {
    pSPCValue.SPCSetPoints.ModbusAdd = SetP_shade.ModbusAdd;
    Savedata();
  }
  else if(Savedata == 3)
  {
    SetP_shade.ModbusAdd = pSPCValue.SPCSetPoints.ModbusAdd;
    IntToStr(SetP_shade.ModbusAdd,Info_Line2);
  }
  else
  {
    if((SetP_shade.ModbusAdd < MAX_MODBUS) && (SetP_shade.ModbusAdd > MIN_MODBUS))
    {
      if(Forward)
        SetP_shade.ModbusAdd++;
      else
        SetP_shade.ModbusAdd--;

      IntToStr(SetP_shade.ModbusAdd,Info_Line2);
    }
  }
}


//==============================================================================
//设置MANITAINTEMP
//输入：无
//输出：无
//==============================================================================
void LowTempAlarmSet(UCHAR Forward, UCHAR Savedata)
{
  int maxtemp,mintemp,units;
  int *Ltemp, *Dtemp, *ptr;
  units = pSPCValue.SPCSetPoints.system_valueb.bite.spc_units_c;
  Ltemp = (int *)(&pSPCValue.SPCSetPoints.LowTemp);
  Dtemp = (int *)(&pSPCValue.SPCSetPoints.DeadBand);
  ptr = (int *)(&SetP_shade.LowTemp);
  
  if(ProCtlEnable())
    maxtemp = *(Ltemp+units) - *(Dtemp+units);
  else
    maxtemp = *(Ltemp+units);
    
  if(units)
    mintemp = MIN_MAINTAINTEMP_C;
  else
    mintemp = MIN_MAINTAINTEMP_F;

  if(Savedata == 1)
  {
    //ConvertTemp(&SetP_shade.LowTemp, &(pSPCValue.SPCSetPoints.LowTemp), units);
    Savedata();
  }
  else if(Savedata == 3)
  {
    SetP_shade.LowTemp.Temperature_C = pSPCValue.SPCSetPoints.LowTemp.Temperature_C;
    SetP_shade.LowTemp.Temperature_F = pSPCValue.SPCSetPoints.LowTemp.Temperature_F;
    if(SetP_shade.LowTemp.Temperature_C == SPC_SYSTEMVALUE_OFF)
      strcpy(Info_Line2, "OFF             ");
    else
      IntToStr(*(ptr+units),Info_Line2);
  }
  else
  {
    if(Forward)
    {
      if(*(ptr+units) == maxtemp)
      {
        *(ptr+units) = SPC_SYSTEMVALUE_OFF;
        strcpy(Info_Line2, "OFF             ");
      }
      else if(*(ptr+units) < maxtemp)
      {
        *(ptr+units)++;
        IntToStr(*(ptr+units),Info_Line2);
      }
    }
    else
    {
      if(*(ptr+units) == SPC_SYSTEMVALUE_OFF)
      {
        *(ptr+units) = maxtemp;
      }
      else if(*(ptr+units) > mintemp)
      {
        *(ptr+units)--;
      }
      IntToStr(*(ptr+units),Info_Line2);
    }
  }
}

//==============================================================================
//设置MANITAINTEMP
//输入：无
//输出：无
//==============================================================================
void HighTempAlarmSet(UCHAR Forward, UCHAR Savedata)
{
  int maxtemp,mintemp,units;
  int *Htemp, *Dtemp, *ptr;
  units = pSPCValue.SPCSetPoints.system_valueb.bite.spc_units_c;
  Htemp = (int *)(&pSPCValue.SPCSetPoints.HighTemp);
  Dtemp = (int *)(&pSPCValue.SPCSetPoints.DeadBand);
  ptr = (int *)(&SetP_shade.HighTemp);

  if(ProCtlEnable())
    mintemp = *(Htemp+units) + *(Dtemp+units);
  else
    mintemp = *(Htemp+units);

  if(units)
    maxtemp = MAX_MAINTAINTEMP_C;
  else
    maxtemp = MAX_MAINTAINTEMP_F;

  if(Savedata == 1)
  {
    //ConvertTemp(&SetP_shade.HighTemp, &(pSPCValue.SPCSetPoints.HighTemp), units);
    Savedata();
  }
  else if(Savedata == 3)
  {
    SetP_shade.HighTemp.Temperature_C = pSPCValue.SPCSetPoints.HighTemp.Temperature_C;
    SetP_shade.HighTemp.Temperature_F = pSPCValue.SPCSetPoints.HighTemp.Temperature_F;
    if(SetP_shade.HighTemp.Temperature_C == SPC_SYSTEMVALUE_OFF)
      strcpy(Info_Line2, "OFF             ");
    else
      IntToStr(*(ptr+units),Info_Line2);
  }
  else
  {
    if(Forward)
    {
      if(*(ptr+units) == maxtemp)
      {
        *(ptr+units) = SPC_SYSTEMVALUE_OFF;
        strcpy(Info_Line2, "OFF             ");
      }
      else if(*(ptr+units) < maxtemp)
      {
        *(ptr+units)++;
        IntToStr(*(ptr+units),Info_Line2);
      }
    }
    else
    {
      if(*(ptr+units) == SPC_SYSTEMVALUE_OFF)
      {
        *(ptr+units) = maxtemp;
      }
      else if(*(ptr+units) > mintemp)
      {
        *(ptr+units)--;
      }
      IntToStr(*(ptr+units),Info_Line2);
    }
  }
}

//==============================================================================
//设置MANITAINTEMP
//输入：无
//输出：无
//==============================================================================
void LowCurrentAlarmSet(UCHAR Forward, UCHAR Savedata)
{
  UINT maxcurrent,mincurrent;

  mincurrent = MIN_SPCCURRENT;
  if(pSPCValue.SPCSetPoints.HighCurrent == SPC_SYSTEMVALUE_OFF)
    maxcurrent = MAX_SPCCURRENT;
  else
    maxcurrent = pSPCValue.SPCSetPoints.HighCurrent;

  if(Savedata == 1)
  {
    pSPCValue.SPCSetPoints.LowCurrent = SetP_shade.LowCurrent;
    Savedata();
  }
  else if(Savedata == 3)
  {
    SetP_shade.LowCurrent = pSPCValue.SPCSetPoints.LowCurrent;
    if(SetP_shade.LowCurrent == SPC_SYSTEMVALUE_OFF)
      strcpy(Info_Line2, "OFF             ");
    else
      IntToStr(SetP_shade.LowCurrent,Info_Line2);
  }
  else
  {
    if(Forward)
    {
      if(SetP_shade.LowCurrent >= maxcurrent)
      {
        SetP_shade.LowCurrent = SPC_SYSTEMVALUE_OFF;
        strcpy(Info_Line2, "OFF             ");
      }
      else if(SetP_shade.LowCurrent < maxcurrent)
      {
        SetP_shade.LowCurrent++;
        IntToStr(SetP_shade.LowCurrent,Info_Line2);
      }
    }
    else
    {
      if(SetP_shade.LowCurrent == SPC_SYSTEMVALUE_OFF)
      {
        SetP_shade.LowCurrent = maxcurrent;
      }
      else if(SetP_shade.LowCurrent > mincurrent)
      {
        SetP_shade.LowCurrent--;
      }
      IntToStr(SetP_shade.LowCurrent,Info_Line2);
    }
  }
}

//==============================================================================
//设置MANITAINTEMP
//输入：无
//输出：无
//==============================================================================
void HighCurrentAlarmSet(UCHAR Forward, UCHAR Savedata)
{
  UINT maxcurrent,mincurrent;

  maxcurrent = MAX_SPCCURRENT;
  if(pSPCValue.SPCSetPoints.LowCurrent == SPC_SYSTEMVALUE_OFF)
    mincurrent = MIN_SPCCURRENT;
  else
    mincurrent = pSPCValue.SPCSetPoints.LowCurrent;

  if(Savedata == 1)
  {
    pSPCValue.SPCSetPoints.HighCurrent = SetP_shade.HighCurrent;
    Savedata();
  }
  else if(Savedata == 3)
  {
    SetP_shade.HighCurrent = pSPCValue.SPCSetPoints.HighCurrent;
    if(SetP_shade.HighCurrent == SPC_SYSTEMVALUE_OFF)
      strcpy(Info_Line2, "OFF             ");
    else
      IntToStr(SetP_shade.HighCurrent,Info_Line2);
  }
  else
  {
    if(Forward)
    {
      if(SetP_shade.HighCurrent >= maxcurrent)
      {
        SetP_shade.HighCurrent = SPC_SYSTEMVALUE_OFF;
        strcpy(Info_Line2, "OFF             ");
      }
      else if(SetP_shade.HighCurrent < maxcurrent)
      {
        SetP_shade.HighCurrent++;
        IntToStr(SetP_shade.HighCurrent,Info_Line2);
      }
    }
    else
    {
      if(SetP_shade.HighCurrent == SPC_SYSTEMVALUE_OFF)
      {
        SetP_shade.HighCurrent = maxcurrent;
      }
      else if(SetP_shade.HighCurrent > mincurrent)
      {
        SetP_shade.HighCurrent--;
      }
      IntToStr(SetP_shade.HighCurrent,Info_Line2);
    }
  }
}

//==============================================================================
//设置MANITAINTEMP
//输入：无
//输出：无
//==============================================================================
void GFIAlarmSet(UCHAR Forward, UCHAR Savedata)
{
  UINT maxcurrent,mincurrent;

  mincurrent = MIN_SPCGFIALARM;
  if(pSPCValue.SPCSetPoints.GFITrip == SPC_SYSTEMVALUE_OFF)
    maxcurrent = MAX_SPCGFIALARM;
  else
    maxcurrent = pSPCValue.SPCSetPoints.GFITrip;

  if(Savedata == 1)
  {
    pSPCValue.SPCSetPoints.GFIAlarm = SetP_shade.GFIAlarm;
    Savedata();
  }
  else if(Savedata == 3)
  {
    SetP_shade.GFIAlarm = pSPCValue.SPCSetPoints.GFIAlarm;
    if(SetP_shade.GFIAlarm == SPC_SYSTEMVALUE_OFF)
      strcpy(Info_Line2, "OFF             ");
    else
      IntToStr(SetP_shade.GFIAlarm,Info_Line2);
  }
  else
  {
    if(Forward)
    {
      if(SetP_shade.GFIAlarm >= maxcurrent)
      {
        SetP_shade.GFIAlarm = SPC_SYSTEMVALUE_OFF;
        strcpy(Info_Line2, "OFF             ");
      }
      else if(SetP_shade.GFIAlarm < maxcurrent)
      {
        SetP_shade.GFIAlarm++;
        IntToStr(SetP_shade.GFIAlarm,Info_Line2);
      }
    }
    else
    {
      if(SetP_shade.GFIAlarm == SPC_SYSTEMVALUE_OFF)
      {
        SetP_shade.GFIAlarm = maxcurrent;
      }
      else if(SetP_shade.GFIAlarm > mincurrent)
      {
        SetP_shade.GFIAlarm--;
      }
      IntToStr(SetP_shade.GFIAlarm,Info_Line2);
    }
  }
}

//==============================================================================
//设置MANITAINTEMP
//输入：无
//输出：无
//==============================================================================
void GFITripSet(UCHAR Forward, UCHAR Savedata)
{
  UINT maxcurrent,mincurrent;

  maxcurrent = MAX_SPCGFIALARM;
  if(pSPCValue.SPCSetPoints.GFIAlarm == SPC_SYSTEMVALUE_OFF)
    mincurrent = MIN_SPCGFIALARM;
  else
    mincurrent = pSPCValue.SPCSetPoints.GFIAlarm;

  if(Savedata == 1)
  {
    pSPCValue.SPCSetPoints.GFITrip = SetP_shade.GFITrip;
    Savedata();
  }
  else if(Savedata == 3)
  {
    SetP_shade.GFITrip = pSPCValue.SPCSetPoints.GFITrip;
    if(SetP_shade.GFITrip == SPC_SYSTEMVALUE_OFF)
      strcpy(Info_Line2, "OFF             ");
    else
      IntToStr(SetP_shade.GFITrip,Info_Line2);
  }
  else
  {
    if(Forward)
    {
      if(SetP_shade.GFITrip >= maxcurrent)
      {
        SetP_shade.GFITrip = SPC_SYSTEMVALUE_OFF;
        strcpy(Info_Line2, "OFF             ");
      }
      else if(SetP_shade.GFITrip < maxcurrent)
      {
        SetP_shade.GFITrip++;
        IntToStr(SetP_shade.GFITrip,Info_Line2);
      }
    }
    else
    {
      if(SetP_shade.GFITrip == SPC_SYSTEMVALUE_OFF)
      {
        SetP_shade.GFITrip = maxcurrent;
      }
      else if(SetP_shade.GFITrip > mincurrent)
      {
        SetP_shade.GFITrip--;
      }
      IntToStr(SetP_shade.GFITrip,Info_Line2);
    }
  }
}

//==============================================================================
//设置MANITAINTEMP
//输入：无
//输出：无
//==============================================================================
void LowVoltageAlarmSet(UCHAR Forward, UCHAR Savedata)
{
  UINT maxvolt,minvolt;

  minvolt = MIN_SPCVOLT;
  if(pSPCValue.SPCSetPoints.HighVoltage == SPC_SYSTEMVALUE_OFF)
    maxvolt = MAX_SPCVOLT;
  else
    maxvolt = pSPCValue.SPCSetPoints.HighVoltage;

  if(Savedata == 1)
  {
    pSPCValue.SPCSetPoints.LowVoltage = SetP_shade.LowVoltage;
    Savedata();
  }
  else if(Savedata == 3)
  {
    SetP_shade.LowVoltage = pSPCValue.SPCSetPoints.LowVoltage;
    if(SetP_shade.LowVoltage == SPC_SYSTEMVALUE_OFF)
      strcpy(Info_Line2, "OFF             ");
    else
      IntToStr(SetP_shade.LowVoltage,Info_Line2);
  }
  else
  {
    if(Forward)
    {
      if(SetP_shade.LowVoltage >= maxvolt)
      {
        SetP_shade.LowVoltage = SPC_SYSTEMVALUE_OFF;
        strcpy(Info_Line2, "OFF             ");
      }
      else if(SetP_shade.LowVoltage < maxvolt)
      {
        SetP_shade.LowVoltage++;
        IntToStr(SetP_shade.LowVoltage,Info_Line2);
      }
    }
    else
    {
      if(SetP_shade.LowVoltage == SPC_SYSTEMVALUE_OFF)
      {
        SetP_shade.LowVoltage = maxvolt;
      }
      else if(SetP_shade.LowVoltage > minvolt)
      {
        SetP_shade.LowVoltage--;
      }
      IntToStr(SetP_shade.LowVoltage,Info_Line2);
    }
  }
}

//==============================================================================
//设置MANITAINTEMP
//输入：无
//输出：无
//==============================================================================
void HighVoltageAlarmSet(UCHAR Forward, UCHAR Savedata)
{
  UINT maxvolt,minvolt;

  maxvolt = MAX_SPCVOLT;
  if(pSPCValue.SPCSetPoints.LowVoltage == SPC_SYSTEMVALUE_OFF)
    minvolt = MIN_SPCVOLT;
  else
    minvolt = pSPCValue.SPCSetPoints.LowVoltage;

  if(Savedata == 1)
  {
    pSPCValue.SPCSetPoints.HighVoltage = SetP_shade.HighVoltage;
    Savedata();
  }
  else if(Savedata == 3)
  {
    SetP_shade.HighVoltage = pSPCValue.SPCSetPoints.HighVoltage;
    if(SetP_shade.HighVoltage == SPC_SYSTEMVALUE_OFF)
      strcpy(Info_Line2, "Continuously    ");
    else if(SetP_shade.HighVoltage == SPC_SYSTEMVALUE_NONE)
      strcpy(Info_Line2, "Disabled        ");
    else
      IntToStr(SetP_shade.HighVoltage,Info_Line2);
  }
  else
  {
    if(Forward)
    {
      if(SetP_shade.HighVoltage >= maxvolt)
      {
        SetP_shade.HighVoltage = SPC_SYSTEMVALUE_OFF;
        strcpy(Info_Line2, "OFF             ");
      }
      else if(SetP_shade.HighVoltage < maxvolt)
      {
        SetP_shade.HighVoltage++;
        IntToStr(SetP_shade.HighVoltage,Info_Line2);
      }
    }
    else
    {
      if(SetP_shade.HighVoltage == SPC_SYSTEMVALUE_OFF)
      {
        SetP_shade.HighVoltage = maxvolt;
      }
      else if(SetP_shade.HighVoltage > minvolt)
      {
        SetP_shade.HighVoltage--;
      }
      IntToStr(SetP_shade.HighVoltage,Info_Line2);
    }
  }
}

//==============================================================================
//设置MANITAINTEMP
//输入：无
//输出：无
//==============================================================================
void AlarmOutTestSet(UCHAR Forward, UCHAR Savedata)
{
  if(Savedata == 1)
  {
    pSPCValue.SPCSetPoints.AlarmOutTest = SetP_shade.AlarmOutTest;
    Savedata();
  }
  else if(Savedata == 3)
  {
    SetP_shade.AlarmOutTest = pSPCValue.SPCSetPoints.AlarmOutTest;
    if(SetP_shade.AlarmOutTest == SPC_SYSTEMVALUE_OFF)
      strcpy(Info_Line2, "Continuously    ");
    else if(SetP_shade.AlarmOutTest == SPC_SYSTEMVALUE_NONE)
      strcpy(Info_Line2, "Disabled        ");
    else
      IntToStr(SetP_shade.AlarmOutTest,Info_Line2);
  }
  else
  {
    if(Forward)
    {
      if(SetP_shade.AlarmOutTest == SPC_SYSTEMVALUE_NONE)
      {
        SetP_shade.AlarmOutTest = SPC_SYSTEMVALUE_OFF;
        strcpy(Info_Line2, "Continuously    ");
      }
      else if(SetP_shade.AlarmOutTest == MAX_ALARMOUT)
      {
        SetP_shade.AlarmOutTest = SPC_SYSTEMVALUE_NONE;
        strcpy(Info_Line2, "Disabled        ");
      }
      else if(SetP_shade.AlarmOutTest < MAX_ALARMOUT)
      {
        SetP_shade.AlarmOutTest++;
        IntToStr(SetP_shade.AlarmOutTest,Info_Line2);
      }
    }
    else
    {
      if(SetP_shade.AlarmOutTest == SPC_SYSTEMVALUE_OFF)
      {
        SetP_shade.AlarmOutTest = SPC_SYSTEMVALUE_NONE;
        strcpy(Info_Line2, "Disabled        ");
      }
      else if(SetP_shade.AlarmOutTest == SPC_SYSTEMVALUE_NONE)
      {
        SetP_shade.AlarmOutTest = MAX_ALARMOUT;
      }
      else if(SetP_shade.AlarmOutTest > MIN_ALARMOUT)
      {
        SetP_shade.AlarmOutTest--;
      }
      IntToStr(SetP_shade.AlarmOutTest,Info_Line2);
    }
  }
}

//==============================================================================
//设置MANITAINTEMP
//输入：无
//输出：无
//==============================================================================
void HeaterTestSet(UCHAR Forward, UCHAR Savedata)
{
  if(Savedata == 1)
  {
    pSPCValue.SPCSetPoints.HeaterTest = SetP_shade.HeaterTest;
    Savedata();
  }
  else if(Savedata == 3)
  {
    SetP_shade.HeaterTest = pSPCValue.SPCSetPoints.HeaterTest;
    if(SetP_shade.HeaterTest == SPC_SYSTEMVALUE_OFF)
      strcpy(Info_Line2, "Continuously    ");
    else if(SetP_shade.HeaterTest == SPC_SYSTEMVALUE_NONE)
      strcpy(Info_Line2, "Disabled        ");
    else
      IntToStr(SetP_shade.HeaterTest,Info_Line2);
  }
  else
  {
    if(Forward)
    {
      if(SetP_shade.HeaterTest == SPC_SYSTEMVALUE_NONE)
      {
        SetP_shade.HeaterTest = SPC_SYSTEMVALUE_OFF;
        strcpy(Info_Line2, "Continuously    ");
      }
      else if(SetP_shade.HeaterTest == MAX_HEATERTEST)
      {
        SetP_shade.HeaterTest = SPC_SYSTEMVALUE_NONE;
        strcpy(Info_Line2, "Disabled        ");
      }
      else if(SetP_shade.HeaterTest < MAX_HEATERTEST)
      {
        SetP_shade.HeaterTest++;
        IntToStr(SetP_shade.HeaterTest,Info_Line2);
      }
    }
    else
    {
      if(SetP_shade.HeaterTest == SPC_SYSTEMVALUE_OFF)
      {
        SetP_shade.HeaterTest = SPC_SYSTEMVALUE_NONE;
        strcpy(Info_Line2, "Disabled        ");
      }
      else if(SetP_shade.HeaterTest == SPC_SYSTEMVALUE_NONE)
      {
        SetP_shade.HeaterTest = MAX_HEATERTEST;
      }
      else if(SetP_shade.HeaterTest > MIN_HEATERTEST)
      {
        SetP_shade.HeaterTest--;
      }
      IntToStr(SetP_shade.HeaterTest,Info_Line2);
    }
  }
}
//==============================================================================
//设置MANITAINTEMP
//输入：无
//输出：无
//==============================================================================
void CurrentLimitSet(UCHAR Forward, UCHAR Savedata)
{
  if(Savedata == 1)
  {
    pSPCValue.SPCSetPoints.LimitedCurrent = SetP_shade.LimitedCurrent;
    Savedata();
  }
  else if(Savedata == 3)
  {
    SetP_shade.LimitedCurrent = pSPCValue.SPCSetPoints.LimitedCurrent;
    if(SetP_shade.LimitedCurrent == SPC_SYSTEMVALUE_OFF)
      strcpy(Info_Line2, "OFF             ");
    else
      IntToStr(SetP_shade.SoftStartTime,Info_Line2);
  }
  else
  {
    if(Forward)
    {
      if(SetP_shade.LimitedCurrent >= MAX_CURRENTLIMIT)
      {
        SetP_shade.LimitedCurrent = SPC_SYSTEMVALUE_OFF;
        strcpy(Info_Line2, "OFF             ");
      }
      else if(SetP_shade.LimitedCurrent < MAX_CURRENTLIMIT)
      {
        SetP_shade.LimitedCurrent++;
        IntToStr(SetP_shade.LimitedCurrent,Info_Line2);
      }
    }
    else
    {
      if(SetP_shade.LimitedCurrent == SPC_SYSTEMVALUE_OFF)
      {
        SetP_shade.LimitedCurrent = MAX_CURRENTLIMIT;
      }
      else if(SetP_shade.LimitedCurrent > MIN_CURRENTLIMIT)
      {
        SetP_shade.LimitedCurrent--;
      }
      IntToStr(SetP_shade.LimitedCurrent,Info_Line2);
    }
  }
}

//==============================================================================
//设置MANITAINTEMP
//输入：无
//输出：无
//==============================================================================
void SoftstartModeSet(UCHAR Forward, UCHAR Savedata)
{
  if(Savedata == 1)
  {
    pSPCValue.SPCSetPoints.SoftStartTime = SetP_shade.SoftStartTime;
    Savedata();
  }
  else if(Savedata == 3)
  {
    SetP_shade.SoftStartTime = pSPCValue.SPCSetPoints.SoftStartTime;
    if(SetP_shade.SoftStartTime == SPC_SYSTEMVALUE_OFF)
      strcpy(Info_Line2, "OFF             ");
    else
      IntToStr(SetP_shade.SoftStartTime,Info_Line2);
  }
  else
  {
    if(Forward)
    {
      if(SetP_shade.SoftStartTime >= MAX_SOFTSTART)
      {
        SetP_shade.SoftStartTime = SPC_SYSTEMVALUE_OFF;
        strcpy(Info_Line2, "OFF             ");
      }
      else if(SetP_shade.SoftStartTime < MAX_SOFTSTART)
      {
        SetP_shade.SoftStartTime++;
        IntToStr(SetP_shade.SoftStartTime,Info_Line2);
      }
    }
    else
    {
      if(SetP_shade.SoftStartTime == SPC_SYSTEMVALUE_OFF)
      {
        SetP_shade.SoftStartTime = MAX_SOFTSTART;
      }
      else if(SetP_shade.SoftStartTime > MIN_SOFTSTART)
      {
        SetP_shade.SoftStartTime--;
      }
      IntToStr(SetP_shade.SoftStartTime,Info_Line2);
    }
  }
}

//==============================================================================
//设置MANITAINTEMP
//输入：无
//输出：无
//==============================================================================
void AutoTestCycleSet(UCHAR Forward, UCHAR Savedata)
{
  if(Savedata == 1)
  {
    pSPCValue.SPCSetPoints.AutoTestTime = SetP_shade.AutoTestTime;
    Savedata();
  }
  else if(Savedata == 3)
  {
    SetP_shade.AutoTestTime = pSPCValue.SPCSetPoints.AutoTestTime;
    if(SetP_shade.AutoTestTime == SPC_SYSTEMVALUE_OFF)
      strcpy(Info_Line2, "OFF             ");
    else
      IntToStr(SetP_shade.AutoTestTime,Info_Line2);
  }
  else
  {
    if(Forward)
    {
      if(SetP_shade.AutoTestTime >= MAX_AUTOTEST)
      {
        SetP_shade.AutoTestTime = SPC_SYSTEMVALUE_OFF;
        strcpy(Info_Line2, "OFF             ");
      }
      else if(SetP_shade.AutoTestTime < MAX_AUTOTEST)
      {
        SetP_shade.AutoTestTime++;
        IntToStr(SetP_shade.AutoTestTime,Info_Line2);
      }
    }
    else
    {
      if(SetP_shade.AutoTestTime == SPC_SYSTEMVALUE_OFF)
      {
        SetP_shade.AutoTestTime = MAX_AUTOTEST;
      }
      else if(SetP_shade.AutoTestTime > MIN_AUTOTEST)
      {
        SetP_shade.AutoTestTime--;
      }
      IntToStr(SetP_shade.AutoTestTime,Info_Line2);
    }
  }
}

//==============================================================================
//设置MANITAINTEMP
//输入：无
//输出：无
//==============================================================================
void DisplayTimeOutSet(UCHAR Forward, UCHAR Savedata)
{
  if(Savedata == 1)
  {
    pSPCValue.SPCSetPoints.DisplayTime = SetP_shade.DisplayTime;
    Savedata();
  }
  else if(Savedata == 3)
  {
    SetP_shade.DisplayTime = pSPCValue.SPCSetPoints.DisplayTime;
    if(SetP_shade.DisplayTime == SPC_SYSTEMVALUE_OFF)
      strcpy(Info_Line2, "OFF             ");
    else
      IntToStr(SetP_shade.DisplayTime,Info_Line2);
  }
  else
  {
    if(Forward)
    {
      if(SetP_shade.DisplayTime >= MAX_TIMEOUT)
      {
        SetP_shade.DisplayTime = SPC_SYSTEMVALUE_OFF;
        strcpy(Info_Line2, "OFF             ");
      }
      else if(SetP_shade.DisplayTime < MAX_TIMEOUT)
      {
        SetP_shade.DisplayTime++;
        IntToStr(SetP_shade.DisplayTime,Info_Line2);
      }
    }
    else
    {
      if(SetP_shade.DisplayTime == SPC_SYSTEMVALUE_OFF)
      {
        SetP_shade.DisplayTime = MAX_TIMEOUT;
      }
      else if(SetP_shade.DisplayTime > MIN_TIMEOUT)
      {
        SetP_shade.DisplayTime--;
      }
      IntToStr(SetP_shade.DisplayTime,Info_Line2);
    }
  }
}

//==============================================================================
//设置MANITAINTEMP
//输入：无
//输出：无
//==============================================================================
void HeaterEnableSet(UCHAR Forward, UCHAR Savedata)
{
  if(Savedata == 1)
  {
    pSPCValue.SPCSetPoints.system_valueb.bite.heater_en = SetP_shade.system_valueb.bite.heater_en;
    Savedata();
  }
  else
  {
    if(Savedata == 3)
      SetP_shade.system_valueb.bite.heater_en ^= 1;
      
    if(SetP_shade.system_valueb.bite.heater_en)
      strcpy(Info_Line2, "yes             ");
    else
      strcpy(Info_Line2, "no              ");
  }
}

//==============================================================================
//设置MANITAINTEMP
//输入：无
//输出：无
//==============================================================================
void OverrideSet(UCHAR Forward, UCHAR Savedata)
{
  if(Savedata == 1)
  {
    pSPCValue.SPCSetPoints.system_valueb.bite.man_on = SetP_shade.system_valueb.bite.man_on;
    Savedata();
  }
  else
  {
    if(Savedata == 3)
      SetP_shade.system_valueb.bite.man_on ^= 1;
      
    if(SetP_shade.system_valueb.bite.man_on)
      strcpy(Info_Line2, "on              ");
    else
      strcpy(Info_Line2, "off             ");
  }
}

//==============================================================================
//设置MANITAINTEMP
//输入：无
//输出：无
//==============================================================================
void PICtrSet(UCHAR Forward, UCHAR Savedata)
{
  if(Savedata == 1)
  {
    pSPCValue.SPCSetPoints.system_valueb.bite.ctl_type = SetP_shade.system_valueb.bite.ctl_type;
    Savedata();
  }
  else
  {
    if(Savedata == 3)
      SetP_shade.system_valueb.bite.ctl_type ^= 1;
    
    if(SetP_shade.system_valueb.bite.ctl_type)
      strcpy(Info_Line2, "Proportional    ");
    else
      strcpy(Info_Line2, "On-off          ");
  }
}

//==============================================================================
//设置MANITAINTEMP
//输入：无
//输出：无
//未完成
//==============================================================================
void HeaterIDSet(UCHAR Forward, UCHAR Savedata)
{
  /*if(Savedata)
  {
    strcpy(pSPCValue.SPCSetPoints.HeaterName, SetP_shade.HeaterName);
    Savedata();
  }
  else
  {     */
    if(Savedata == 1)   //enter
    {
      if(SetP_shade.CharacNum >= 15)
      {
        strcpy(pSPCValue.SPCSetPoints.HeaterName, SetP_shade.HeaterName);
        SetP_shade.CharacNum = 0;
      }
      else
        SetP_shade.CharacNum++;
    }
    else if(Savedata == 3)    //reset
    {
      strcpy(SetP_shade.HeaterName, pSPCValue.SPCSetPoints.HeaterName);
      SetP_shade.CharacNum = 0;
    }
    else      //up/down
    {
      if((Forward == 1) && (SetP_shade.StringNum < MAX_CHARACT_NUM))
        SetP_shade.HeaterName[SetP_shade.CharacNum] = SpcCharactors[SetP_shade.StringNum++];
      else if((Forward == 0) && (SetP_shade.StringNum > 0))
        SetP_shade.HeaterName[SetP_shade.CharacNum] = SpcCharactors[SetP_shade.StringNum--];
    }
    strcpy(Info_Line2, SetP_shade.HeaterName);
 // }
}

//==============================================================================
//设置MANITAINTEMP
//输入：无
//输出：无
//未完成
//==============================================================================
void PasswordEidtorSet(UCHAR Forward, UCHAR Savedata)
{
  static char SetPSWReq = 0,SetPSWVal = 0;

  if(Savedata == 1)     //enter
  {
    if(SetPSWVal)
    {
      if(SetPSWReq == 0)
      {
        SetP_shade.CharacNum = 0;
        SetP_shade.StringNum = 0;
        strcpy(Info_Line1, "Enter Old Psw   ");
        strcpy(Info_Line2, "                ");
        SetPSWReq++;
        spc_system_flag.bite.char_actived = 1;
      }
      else if(SetPSWReq == 1)
      {
        if(SetP_shade.Password == pSPCValue.SPCSetPoints.Password)
        {
          SetP_shade.CharacNum = 0;
          SetP_shade.StringNum = 0;
          strcpy(Info_Line1, "Enter New Psw   ");
          strcpy(Info_Line2, "                ");
          SetPSWReq++;
        }
        else
        {
          strcpy(Info_Line1, "Invalid password");
          strcpy(Info_Line2, "                ");
          //等待scanspeed
        }
      }
      else if(SetPSWReq == 2)
      {
        SetP_shade.CharacNum = 0;
        SetP_shade.StringNum = 0;
        strcpy(Passwordbuff, SetP_shade.Password);
        strcpy(Info_Line1, "Enter Again     ");
        strcpy(Info_Line1, "                ");
        SetPSWReq++;
      }
      else if(SetPSWReq == 3)
      {
        if(Passwordbuff == SetP_shade.Password)
        {
          strcpy(Info_Line1, "Operate success ");
          strcpy(Info_Line1, "                ");
        }
        else
        {
          strcpy(Info_Line1, "Not match       ");
          strcpy(Info_Line1, "                ");
        }
        //等待scanspeed
      }
    }
  }
  else if(Savedata == 3)   //reset
  {
    SetPSWReq = 0;
    SetPSWVal = 0;
    strcpy(Info_Line1, "Change password ");
    strcpy(Info_Line2, "no              ");
    spc_system_flag.bite.char_actived = 0;
  }
  else if(Savedata == 4)    //up/down
  {
    if((Forward == 1) && (SetP_shade.StringNum < MAX_CHARACT_NUM))
      SetP_shade.Password[SetP_shade.CharacNum] = SpcCharactors[SetP_shade.StringNum++];
    else if((Forward == 0) && (SetP_shade.StringNum > 0))
      SetP_shade.Password[SetP_shade.CharacNum] = SpcCharactors[SetP_shade.StringNum--];
      
    strcpy(Info_Line2, SetP_shade.Password);
  }
  else
  {
    if(SetPSWReq == 0)
    {
      SetPSWVal ^= 1;
      if(SetPSWVal)
        strcpy(Info_Line2, "yes             ");
      else
        strcpy(Info_Line2, "no              ");
    }
    else
    {
      if((Forward == 1) && (SetP_shade.CharacNum < 16) && (SetP_shade.HeaterName[SetP_shade.CharacNum] != ' '))
        SetP_shade.CharacNum++;
    }
  }
}

//==============================================================================
//设置MANITAINTEMP
//输入：无
//输出：无
//未完成
//==============================================================================
void RTDFailModeSet(UCHAR Forward, UCHAR Savedata)
{
  if(Savedata == 1)
  {
    pSPCValue.SPCSetPoints.system_valueb.bite.rtd_fail_mod = SetP_shade.system_valueb.bite.rtd_fail_mod;
    Savedata();
  }
  else
  {
    if(Savedata == 3)
      SetP_shade.system_valueb.bite.rtd_fail_mod ^= 1;
      
    if(SetP_shade.system_valueb.bite.rtd_fail_mod)
      strcpy(Info_Line2, "ON              ");
    else
      strcpy(Info_Line2, "OFF             ");
  }
}

//==============================================================================
//设置MANITAINTEMP
//输入：无
//输出：无
//未完成
//==============================================================================
void PasswordEnableSet(UCHAR Forward, UCHAR Savedata)
{
  if(Savedata)
  {
    pSPCValue.SPCSetPoints.system_valueb.bite.password_en = SetP_shade.system_valueb.bite.password_en;
    Savedata();
  }
  else
  {
    if(Savedata == 3)
      SetP_shade.system_valueb.bite.password_en ^= 1;
      
    if(SetP_shade.system_valueb.bite.password_en)
      strcpy(Info_Line2, "ENABLE          ");
    else
      strcpy(Info_Line2, "DISABLE         ");
  }
}

//==============================================================================
//设置MANITAINTEMP
//输入：无
//输出：无
//未完成
//==============================================================================
void TempUnitSet(UCHAR Forward, UCHAR Savedata)
{
  if(Savedata)
  {
    pSPCValue.SPCSetPoints.system_valueb.bite.spc_units_c = SetP_shade.system_valueb.bite.spc_units_c;
    Savedata();
  }
  else
  {
    if(Savedata == 3)
      SetP_shade.system_valueb.bite.spc_units_c ^= 1;
      
    if(SetP_shade.system_valueb.bite.spc_units_c)
      strcpy(Info_Line2, "Celcius         ");
    else
      strcpy(Info_Line2, "Fahrenheit      ");
  }
}

//==============================================================================
//设置MANITAINTEMP
//输入：无
//输出：无
//未完成
//==============================================================================
void DisplayModeSet(UCHAR Forward, UCHAR Savedata)
{
  if(Savedata == 1)
  {
    pSPCValue.SPCSetPoints.system_valueb.bite.usr_advanced = SetP_shade.system_valueb.bite.usr_advanced;
    Savedata();
  }
  else
  {
    if(Savedata == 3)
      SetP_shade.system_valueb.bite.usr_advanced ^= 1;
      
    if(SetP_shade.system_valueb.bite.usr_advanced)
      strcpy(Info_Line2, "Advanced        ");
    else
      strcpy(Info_Line2, "Normal          ");
  }
}

//==============================================================================
//设置MANITAINTEMP
//输入：无
//输出：无
//未完成
//==============================================================================
void ResetModuleSet(UCHAR Forward, UCHAR Savedata)
{
  static char ResetModuleReq = 0,ResetModuleVal = 0;
  if(Savedata == 1)
  {
    if(ResetModuleVal == 1)
    {
      if(ResetModuleReq == 0)
      {
        strcpy(Info_Line1, "Comfirm Reset?    ");
        strcpy(Info_Line2, "No                ");
        ResetModuleReq++;
      }
      else if(ResetModuleReq == 1)
      {
        strcpy(Info_Line1, "Reset Complete    ");
        strcpy(Info_Line2, "                  ");
      }
    }
    else
    {
      ResetModuleReq = 0;
      ResetModuleVal = 0;
      strcpy(Info_Line1, "Reset Module    ");
      strcpy(Info_Line2, "No              ");
    }
  }
  else if(Savedata == 3)
  {
    ResetModuleReq = 0;
    ResetModuleVal = 0;
    strcpy(Info_Line1, "Reset Module    ");
    strcpy(Info_Line2, "No              ");
  }
  else
  {
    ResetModuleVal ^= 1;
      
    if(ResetModuleVal)
      strcpy(Info_Line2, "yes             ");
    else
      strcpy(Info_Line2, "no              ");
  }
}

//==============================================================================
//设置MANITAINTEMP
//输入：无
//输出：无
//未完成
//==============================================================================
void HeaterStatusSet(UCHAR Forward, UCHAR Savedata)
{

}

//==============================================================================
//设置MANITAINTEMP
//输入：无
//输出：无
//未完成
//==============================================================================
void HeaterTempSet(UCHAR Forward, UCHAR Savedata)
{
  UCHAR units;
  int *ptr;
  units = pSPCValue.SPCSetPoints.system_valueb.bite.spc_units_c;
  ptr = (int *)(&pSPCValue.SPCActual.Temperature);

  if(pSPCValue.SPCActual.Temperature.Temperature_C == RTD_SHORT)
    strcpy(Info_Line2, "RTD_SHORT       ");
  else if(pSPCValue.SPCActual.Temperature.Temperature_C == RTD_OPNE)
    strcpy(Info_Line2, "RTD_OPNE        ");
  else
    IntToStr(*(ptr+units),Info_Line2);
}

//==============================================================================
//设置MANITAINTEMP
//输入：无
//输出：无
//未完成
//==============================================================================
void HeaterTempASet(UCHAR Forward, UCHAR Savedata)
{
  UCHAR units;
  int *ptr;
  units = pSPCValue.SPCSetPoints.system_valueb.bite.spc_units_c;
  ptr = (int *)(&pSPCValue.SPCActual.TemperatureA);

  if(pSPCValue.SPCActual.TemperatureA.Temperature_C == RTD_SHORT)
    strcpy(Info_Line2, "RTD_SHORT       ");
  else if(pSPCValue.SPCActual.TemperatureA.Temperature_C == RTD_OPNE)
    strcpy(Info_Line2, "RTD_OPNE        ");
  else
    IntToStr(*(ptr+units),Info_Line2);
}

//==============================================================================
//设置MANITAINTEMP
//输入：无
//输出：无
//未完成
//==============================================================================
void HeaterTempBSet(UCHAR Forward, UCHAR Savedata)
{
  UCHAR units;
  int *ptr;
  units = pSPCValue.SPCSetPoints.system_valueb.bite.spc_units_c;
  ptr = (int *)(&pSPCValue.SPCActual.TemperatureB);

  if(pSPCValue.SPCActual.TemperatureB.Temperature_C == RTD_SHORT)
    strcpy(Info_Line2, "RTD_SHORT       ");
  else if(pSPCValue.SPCActual.TemperatureB.Temperature_C == RTD_OPNE)
    strcpy(Info_Line2, "RTD_OPNE        ");
  else
    IntToStr(*(ptr+units),Info_Line2);
}

//==============================================================================
//设置MANITAINTEMP
//输入：无
//输出：无
//未完成
//==============================================================================
void MaxTempSet(UCHAR Forward, UCHAR Savedata)
{
  UCHAR units;
  int *ptr;
  units = pSPCValue.SPCSetPoints.system_valueb.bite.spc_units_c;
  ptr = (int *)(&pSPCValue.SPCStatistics.MaximumTemp);

  if(pSPCValue.SPCStatistics.MaximumTemp.Temperature_C == RTD_OPNE)
    strcpy(Info_Line2, "RTD_OPNE        ");
  else
    IntToStr(*(ptr+units),Info_Line2);
}

//==============================================================================
//设置MANITAINTEMP
//输入：无
//输出：无
//未完成
//==============================================================================
void MinTempSet(UCHAR Forward, UCHAR Savedata)
{
  UCHAR units;
  int *ptr;
  units = pSPCValue.SPCSetPoints.system_valueb.bite.spc_units_c;
  ptr = (int *)(&pSPCValue.SPCStatistics.MinimumTemp);

  if(pSPCValue.SPCStatistics.MinimumTemp.Temperature_C == RTD_OPNE)
    strcpy(Info_Line2, "RTD_OPNE        ");
  else
    IntToStr(*(ptr+units),Info_Line2);
}

//==============================================================================
//设置MANITAINTEMP
//输入：无
//输出：无
//未完成
//==============================================================================
void HeaterPowSet(UCHAR Forward, UCHAR Savedata)
{
  IntToStr(pSPCValue.SPCActual.HeaterPow,Info_Line2);
}

//==============================================================================
//设置MANITAINTEMP
//输入：无
//输出：无
//未完成
//==============================================================================
void SPCurrentSet(UCHAR Forward, UCHAR Savedata)
{
  if(pSPCValue.SPCActual.Current == OUTOFRANGE)
    strcpy(Info_Line2, "Out of range    ");
  else
    IntToStr(pSPCValue.SPCActual.Current,Info_Line2);
}

//==============================================================================
//设置MANITAINTEMP
//输入：无
//输出：无
//未完成
//==============================================================================
void GFICurrentSet(UCHAR Forward, UCHAR Savedata)
{
  if(pSPCValue.SPCActual.GFICurrent == OUTOFRANGE)
    strcpy(Info_Line2, "Out of range    ");
  else
    IntToStr(pSPCValue.SPCActual.GFICurrent,Info_Line2);
}

//==============================================================================
//设置MANITAINTEMP
//输入：无
//输出：无
//未完成
//==============================================================================
void SPCVoltSet(UCHAR Forward, UCHAR Savedata)
{
  if(pSPCValue.SPCActual.Voltage == OUTOFRANGE)
    strcpy(Info_Line2, "Out of range    ");
  else
    IntToStr(pSPCValue.SPCActual.Voltage,Info_Line2);
}

//==============================================================================
//设置MANITAINTEMP
//输入：无
//输出：无
//未完成
//==============================================================================
void MaxCurrentSet(UCHAR Forward, UCHAR Savedata)
{
  if(pSPCValue.SPCStatistics.MaximumCurrent == OUTOFRANGE)
    strcpy(Info_Line2, "Out of range    ");
  else
    IntToStr(pSPCValue.SPCStatistics.MaximumCurrent,Info_Line2);
}

//==============================================================================
//设置MANITAINTEMP
//输入：无
//输出：无
//未完成
//==============================================================================
void MaxGFICurrentSet(UCHAR Forward, UCHAR Savedata)
{
  if(pSPCValue.SPCStatistics.MaximumGFCurrent == OUTOFRANGE)
    strcpy(Info_Line2, "Out of range    ");
  else
    IntToStr(pSPCValue.SPCStatistics.MaximumGFCurrent,Info_Line2);
}

//==============================================================================
//设置MANITAINTEMP
//输入：无
//输出：无
//未完成
//==============================================================================
void MaxVoltSet(UCHAR Forward, UCHAR Savedata)
{
  if(pSPCValue.SPCStatistics.MaximumVoltage == OUTOFRANGE)
    strcpy(Info_Line2, "Out of range    ");
  else
    IntToStr(pSPCValue.SPCStatistics.MaximumVoltage,Info_Line2);
}

//==============================================================================
//设置MANITAINTEMP
//输入：无
//输出：无
//未完成
//==============================================================================
void MinVoltSet(UCHAR Forward, UCHAR Savedata)
{
  if(pSPCValue.SPCStatistics.MinimumVoltage == OUTOFRANGE)
    strcpy(Info_Line2, "Out of range    ");
  else
    IntToStr(pSPCValue.SPCStatistics.MinimumVoltage,Info_Line2);
}

//==============================================================================
//设置MANITAINTEMP
//输入：无
//输出：无
//未完成
//==============================================================================
void SPCEnergySet(UCHAR Forward, UCHAR Savedata)
{
  if(pSPCValue.SPCStatistics.EnergyUsed == OUTOFRANGE)
    strcpy(Info_Line2, "Out of range    ");
  else
    IntToStr(pSPCValue.SPCStatistics.EnergyUsed,Info_Line2);
}

//==============================================================================
//设置MANITAINTEMP
//输入：无
//输出：无
//未完成
//==============================================================================
void SPCostSet(UCHAR Forward, UCHAR Savedata)
{
  if(pSPCValue.SPCStatistics.EnergyCost == OUTOFRANGE)
    strcpy(Info_Line2, "Out of range    ");
  else
    IntToStr(pSPCValue.SPCStatistics.EnergyCost,Info_Line2);
}

//==============================================================================
//设置MANITAINTEMP
//输入：无
//输出：无
//未完成
//==============================================================================
void SPOntimeSet(UCHAR Forward, UCHAR Savedata)
{
  if(pSPCValue.SPCStatistics.RunTime == OUTOFRANGE)
    strcpy(Info_Line2, "Out of range    ");
  else
    IntToStr(pSPCValue.SPCStatistics.RunTime,Info_Line2);
}

//==============================================================================
//设置MANITAINTEMP
//输入：无
//输出：无
//未完成
//==============================================================================
void SPOntimeCycleSet(UCHAR Forward, UCHAR Savedata)
{
  IntToStr(pSPCValue.SPCStatistics.HeaterOnTime,Info_Line2);
}

//==============================================================================
//设置MANITAINTEMP
//输入：无
//输出：无
//未完成
//==============================================================================
void SPCVersionSet(UCHAR Forward, UCHAR Savedata)
{
  IntToStr(pSPCValue.SPCStatistics.Version,Info_Line2);
}


//==============================================================================
//设置MANITAINTEMP
//输入：无
//输出：无
//未完成
//==============================================================================
void ResetStatisticSet(UCHAR Forward, UCHAR Savedata)
{
  static char ResetStatisticsReq = 0,ResetStatisticsVal = 0;

  if(Savedata == 1)  //enter
  {
    if(ResetStatisticsVal == 1)
    {
      if((ResetStatisticsReq == 0) && (ResetStatisticsVal == 1))
      {
        strcpy(Info_Line1, "Comfirm Reset?    ");
        strcpy(Info_Line2, "No                ");
        ResetStatisticsReq++;
      }
      else if(ResetStatisticsReq == 1)
      {
        strcpy(Info_Line1, "Reset Complete    ");
        strcpy(Info_Line2, "                  ");
      }
    }
    else
    {
      ResetStatisticsReq = 0;
      ResetStatisticsVal = 0;
      strcpy(Info_Line1, "Reset Statistics");
      strcpy(Info_Line2, "No              ");
    }
  }
  else if(Savedata == 3)   //reset
  {
    ResetStatisticsReq = 0;
    ResetStatisticsVal = 0;
    strcpy(Info_Line1, "Reset Statistics");
    strcpy(Info_Line2, "No              ");
  }
  else
  {
    ResetStatisticsVal ^= 1;
    
    if(ResetStatisticsVal)
      strcpy(Info_Line2, "Yes             ");
    else
      strcpy(Info_Line2, "No              ");
  }
}

void Savedata(UCHAR Forward, UCHAR Savedata)
{

}

//==============================================================================
//一下为减少冗余的尝试
//==============================================================================
void Tempset(UCHAR Forward, UCHAR Savedata)
{
  int maxtemp,mintemp,units;
  int *Htemp, *Dtemp, *ptr;
  units = pSPCValue.SPCSetPoints.system_valueb.bite.spc_units_c;
  Mtemp = (int *)(&pSPCValue.SPCSetPoints.MaintainTemp);
  Dtemp = (int *)(&pSPCValue.SPCSetPoints.DeadBand);
  ptr = (int *)(&SetP_shade.HighTemp);
  //传入指针偏移 offset 暂用flag代替
  ptr +=  SpcMenu[Menustat].flag;
  
  if(units)
  {
    if(SpcMenu[Menustat].flag & MAXTEMPFIX)
      maxtemp =
  }
}
