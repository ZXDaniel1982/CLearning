#include "systemvalue.h"
#include "Mainprocess.h"
#include "PIC18F6622.h"
#include "function.h"
#include "RTD.h"
#include "ADC.h"
#include "usart.h"
#include "SSR.h"
#include "MCP3202.h"
#include "systemtest.h"
#include "Spcsystem.h"
#include "EEPROM.h"
#include "String_op.h"

#include "Menuoperation.h"

#define ALARMNOTHAPPEN 0X01
#define TRIPNOTHAPPEN 0X02

#define STATICTEMPHIGHA 0
#define STATICTEMPHIGHB 1
#define STATICTEMPLOWA  0
#define STATICTEMPLOWB  1

unsigned int equalcount[2]={0};
unsigned int energycount=0;
//unsigned int totalenergy=0;
char energyacc=0;
int dutyshadePI[2]={0};

char HighTempCutoffEn[2] = {0};

unsigned int HighCurrentAlarmCount[2]={0};
char HighCurrentEn[2]={0};

//==============================================================================
//measurement for voltage and temp
//input：none
//output：none
//==============================================================================
void VTProcess()
{
  static char TempChannel1_Finish=0, TempChannel2_Finish=0;

//measurement for voltage
  if(spc_system_flag.bite.meas_VT_reach & 0x01)
    Voltprocess();

//measurement for temp
  if(spc_system_flag.bite.meas_VT_reach & 0x02)
  {
    /*spc_system_flag.bite.meas_VT_reach &= 0xfd;*/
    if(TempChannel1_Finish == 0)
    {
      if(pSPCValue[CHANNEL1].SPCSetPoints.MaintainTemp.Temperature_C != SPC_SYSTEMVALUE_OFF)
        TempChannel1_Finish = Tempprocess(CHANNEL1);
      else
      {
        asm nop;
        Spcssr[CHANNEL1].SSR_cmd = 0;
        ADC_busy[CHANNEL1] = ADC_FREE;
        TempChannel1_Finish = 1;
        //spc_system_flag.bite.meas_VT_reach &= 0xfd;
      }
    }

    if(TempChannel2_Finish == 0)
    {
      if(pSPCValue[CHANNEL2].SPCSetPoints.MaintainTemp.Temperature_C != SPC_SYSTEMVALUE_OFF)
        TempChannel2_Finish = Tempprocess(CHANNEL2);
      else
      {
        asm nop;
        Spcssr[CHANNEL2].SSR_cmd = 0;
        ADC_busy[CHANNEL2] = ADC_FREE;
        TempChannel2_Finish = 1;
        //spc_system_flag.bite.meas_VT_reach &= 0xfd;
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

//==============================================================================
//measurement for current and GFI
//input：none
//output：none
//==============================================================================
void CGProcess(char ChannelNum)
{
  int CurrentBuff,GFIBuff;

  if(Spcpwm[ChannelNum].meas_cmd == START_MEASUREMENT)
  {
    if((ADC_busy[ChannelNum] == GETING_TEMP) || (ADC_busy[ChannelNum] == GETING_TEMP_REQ))
      return;
    else
    {
      ADC_busy[ChannelNum] = GETING_GFI_CURRENT;
      spc_count.meas_CG_count[ChannelNum] = 0;
      SpcAcc[ChannelNum].Current_acc = 0;
      SpcAcc[ChannelNum].GFI_acc = 0;
      Spcpwm[ChannelNum].meas_cmd = RUNING_MEASUREMENT;
      while(Spcpwm[ChannelNum].meas_cmd == RUNING_MEASUREMENT)
      {
        SpcAcc[ChannelNum].Current_acc += GetGFI(ADC_Channel[ChannelNum], CURRENT_AD_COMMND);
        SpcAcc[ChannelNum].GFI_acc += GetGFI(ADC_Channel[ChannelNum], GFI_AD_COMMND);
        spc_count.meas_CG_count[ChannelNum]++;
      }
    }
  }
  else if(Spcpwm[ChannelNum].meas_cmd == FINISH_MEASUREMENT)
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


      if(pSPCValue[ChannelNum].SPCActual.Current > MAX_SPCCURRENT)
      {
        pSPCValue[ChannelNum].SPCActual.Current = OUTOFRANGE;
      }
      else
      {
        if(duty_index[ChannelNum] == 0)
          pSPCValue[ChannelNum].SPCActual.Current_RMS = pSPCValue[ChannelNum].SPCActual.Current;
        else
          pSPCValue[ChannelNum].SPCActual.Current_RMS = pSPCValue[ChannelNum].SPCActual.Current*duty_index[ChannelNum]/10;
      }

      if(pSPCValue[ChannelNum].SPCActual.GFICurrent > MAX_SPCGFIALARM)
        pSPCValue[ChannelNum].SPCActual.GFICurrent = OUTOFRANGE;
      
      SystemUpdate |= (CH1_CURRENT_GFI_UPDATE_REQ << ChannelNum);
      SetIntStr((int*)&pSPCValue[ChannelNum].SPCActual.GFICurrent, CH1_ACTURAL_GFI+ChannelNum, UNIT_MILIAMPER, 2);
      SetCurrentStr((int*)&pSPCValue[ChannelNum].SPCActual.Current_RMS, CH1_ACTURAL_CURRENT+ChannelNum, UNIT_AMPER, 1);
      
      Currentprocess(ChannelNum);
      
      ADC_busy[ChannelNum] = ADC_FREE;
      Spcpwm[ChannelNum].meas_cmd = IDEL_MEASUREMENT;
  }
}

//==============================================================================
//process for control based on temp
//input：none
//output：none
//==============================================================================
void TempErrorAction(char ChannelNum, char ActionCmd)
{
  if(ActionCmd)
  {
    if(pSPCValue[ChannelNum].SPCSetPoints.system_valueb.bite.rtd_fail_mod)
    {
      ForceSSRONCondition[ChannelNum] |= FAILUREMODEFORCEON;
      ForceSSROFFCondition[ChannelNum] &= ~FAILUREMODEFORCEOFF;
    }
    else
    {
      ForceSSRONCondition[ChannelNum] &= ~FAILUREMODEFORCEON;
      ForceSSROFFCondition[ChannelNum] |= FAILUREMODEFORCEOFF;
    }
  }
  else
  {
    ForceSSRONCondition[ChannelNum] &= ~FAILUREMODEFORCEON;
    ForceSSROFFCondition[ChannelNum] &= ~FAILUREMODEFORCEOFF;
  }
}

void TempStatistics(char ChannelNum, char HighMode, char LowMode)
{
  TEMPERATURE *StaticticsT;
  char StaticsChange=0,units;
  signed int *temp_ptr;
  
  StaticticsT = &pSPCValue[ChannelNum].SPCActual.TemperatureA+HighMode;
  units = pSPCValue[0].SPCSetPoints.system_valueb.bite.spc_units_c;
  if(Statis_flag[ChannelNum] & STATIS_MAX_TEMP)
  {
    Statis_flag[ChannelNum] &= ~STATIS_MAX_TEMP;

    pSPCValue[ChannelNum].SPCStatistics.MaximumTemp.Temperature_C
      = StaticticsT->Temperature_C;
    pSPCValue[ChannelNum].SPCStatistics.MaximumTemp.Temperature_F
      = StaticticsT->Temperature_F;

    SystemUpdate |= (CH1_TEMP_MAX_UPDATE_REQ << ChannelNum);
    temp_ptr = (signed int *)(&pSPCValue[ChannelNum].SPCStatistics.MaximumTemp) + units;
    SetTempStatStr(temp_ptr, CH1_ACTURAL_MAX, ChannelNum);
    StaticsChange = 1;
  }

  if(StaticticsT->Temperature_C != RTD_SHORT)
  {
    if((pSPCValue[ChannelNum].SPCStatistics.MaximumTemp.Temperature_C == RTD_SHORT) ||
        (StaticticsT->Temperature_C > pSPCValue[ChannelNum].SPCStatistics.MaximumTemp.Temperature_C))
    {
      pSPCValue[ChannelNum].SPCStatistics.MaximumTemp.Temperature_C =
        StaticticsT->Temperature_C;
      pSPCValue[ChannelNum].SPCStatistics.MaximumTemp.Temperature_F =
        StaticticsT->Temperature_F;

      SystemUpdate |= (CH1_TEMP_MAX_UPDATE_REQ << ChannelNum);
      temp_ptr = (signed int *)(&pSPCValue[ChannelNum].SPCStatistics.MaximumTemp) + units;
      SetTempStatStr(temp_ptr, CH1_ACTURAL_MAX, ChannelNum);
      StaticsChange = 1;
    }
  }
  
  StaticticsT = &pSPCValue[ChannelNum].SPCActual.TemperatureA+LowMode;
  if(Statis_flag[ChannelNum] & STATIS_MIN_TEMP)
  {
    Statis_flag[ChannelNum] &= ~STATIS_MIN_TEMP;

    pSPCValue[ChannelNum].SPCStatistics.MinimumTemp.Temperature_C
      = StaticticsT->Temperature_C;
    pSPCValue[ChannelNum].SPCStatistics.MinimumTemp.Temperature_F
      = StaticticsT->Temperature_F;

    SystemUpdate |= (CH1_TEMP_MIN_UPDATE_REQ << ChannelNum);
    temp_ptr = (signed int *)(&pSPCValue[ChannelNum].SPCStatistics.MinimumTemp) + units;
    SetTempStatStr(temp_ptr,CH1_ACTURAL_MIN, ChannelNum);
    StaticsChange = 1;
  }

  if(StaticticsT->Temperature_C != RTD_OPNE)
  {
    if(StaticticsT->Temperature_C == RTD_SHORT)
    {
      if(pSPCValue[ChannelNum].SPCStatistics.MinimumTemp.Temperature_C != RTD_SHORT)
      {
        pSPCValue[ChannelNum].SPCStatistics.MinimumTemp.Temperature_C = RTD_SHORT;
        pSPCValue[ChannelNum].SPCStatistics.MinimumTemp.Temperature_F = RTD_SHORT;
        SystemUpdate |= (CH1_TEMP_MIN_UPDATE_REQ << ChannelNum);
        temp_ptr = (signed int *)(&pSPCValue[ChannelNum].SPCStatistics.MinimumTemp) + units;
        SetTempStatStr(temp_ptr,CH1_ACTURAL_MIN, ChannelNum);
        StaticsChange = 1;
      }
    }
    else
    {
      if((pSPCValue[ChannelNum].SPCStatistics.MinimumTemp.Temperature_C != RTD_SHORT) &&
          (StaticticsT->Temperature_C < pSPCValue[ChannelNum].SPCStatistics.MinimumTemp.Temperature_C))
      {
        pSPCValue[ChannelNum].SPCStatistics.MinimumTemp.Temperature_C = StaticticsT->Temperature_C;
        pSPCValue[ChannelNum].SPCStatistics.MinimumTemp.Temperature_F = StaticticsT->Temperature_F;
        SystemUpdate |= (CH1_TEMP_MIN_UPDATE_REQ << ChannelNum);
        temp_ptr = (signed int *)(&pSPCValue[ChannelNum].SPCStatistics.MinimumTemp) + units;
        SetTempStatStr(temp_ptr,CH1_ACTURAL_MIN, ChannelNum);
        StaticsChange = 1;
      }
    }
  }

  if(StaticsChange)
    EEPROM_set(0x01+2*sizeof(SPCSETPIONTS)+ChannelNum*sizeof(STATISTICS),sizeof(STATISTICS),(UCHAR*)(&pSPCValue[ChannelNum].SPCStatistics));
}

char Tempprocess(char ChannelNum)
{
  char duty_val, units, RTD_stat=RTD_OK;
  signed int temp_val;
  signed int *tempa_ptr, *tempb_ptr, *temp_ptr;
  signed int StatisticsTempHigh,StatisticsTempLow;
  char dispmodetemp;

  dispmodetemp = pSPCValue[ChannelNum].SPCSetPoints.system_valueb.bite.rtd_opr;


  if(ADC_busy[ChannelNum] == GETING_GFI_CURRENT)
  {
    ADC_busy[ChannelNum] = GETING_TEMP_REQ;
    return 0;
  }
  else
    ADC_busy[ChannelNum] = GETING_TEMP;

  units = pSPCValue[0].SPCSetPoints.system_valueb.bite.spc_units_c;
  tempa_ptr = (signed int *)(&pSPCValue[ChannelNum].SPCActual.TemperatureA) + units;
  tempb_ptr = (signed int *)(&pSPCValue[ChannelNum].SPCActual.TemperatureB) + units;
  temp_ptr = (signed int *)(&pSPCValue[ChannelNum].SPCActual.Temperature) + units;
  
  spc_system_flag.bite.temp_err = 0;

  GetTemperature(&pSPCValue[ChannelNum].SPCActual.TemperatureA, ChannelNum);

  if(dispmodetemp == ONE_RTD_MOD)
  {
    if(ActivedAlarms & (CH1_RTDBOPENALARM << ChannelNum))
      alarmoperate(CH1_RTDBOPENALARM << ChannelNum,DISALARM);
    if(ActivedAlarms & (CH1_RTDBSHORTALARM << ChannelNum))
      alarmoperate(CH1_RTDBSHORTALARM << ChannelNum,DISALARM);
  }
  else
  {
    if(*tempb_ptr == RTD_SHORT)
    {
      RTD_stat |= RTDB_ERR;
      if(ActivedAlarms & (CH1_RTDBOPENALARM << ChannelNum))
        alarmoperate(CH1_RTDBOPENALARM << ChannelNum,DISALARM);
      if(!(ActivedAlarms & (CH1_RTDBSHORTALARM << ChannelNum)))
        alarmoperate(CH1_RTDBSHORTALARM << ChannelNum,ENALARM);
    }
    else if(*tempb_ptr == RTD_OPNE)
    {
      RTD_stat |= RTDB_ERR;
      if(ActivedAlarms & (CH1_RTDBSHORTALARM << ChannelNum))
        alarmoperate(CH1_RTDBSHORTALARM << ChannelNum,DISALARM);
      if(!(ActivedAlarms & (CH1_RTDBOPENALARM << ChannelNum)))
        alarmoperate(CH1_RTDBOPENALARM << ChannelNum,ENALARM);
    }
    else
    {
      if(ActivedAlarms & (CH1_RTDBOPENALARM << ChannelNum))
        alarmoperate(CH1_RTDBOPENALARM << ChannelNum,DISALARM);
      if(ActivedAlarms & (CH1_RTDBSHORTALARM << ChannelNum))
        alarmoperate(CH1_RTDBSHORTALARM << ChannelNum,DISALARM);
    }
  }
  if(*tempa_ptr == RTD_SHORT)
  {
    RTD_stat |= RTDA_ERR;
    if(!(ActivedAlarms & (CH1_RTDASHORTALARM << ChannelNum)))
      alarmoperate(CH1_RTDASHORTALARM << ChannelNum,ENALARM);
    if(ActivedAlarms & (CH1_RTDAOPENALARM << ChannelNum))
      alarmoperate(CH1_RTDAOPENALARM << ChannelNum,DISALARM);
  }
  else if(*tempa_ptr == RTD_OPNE)
  {
    RTD_stat |= RTDA_ERR;
    if(!(ActivedAlarms & (CH1_RTDAOPENALARM << ChannelNum)))
      alarmoperate(CH1_RTDAOPENALARM << ChannelNum,ENALARM);
    if(ActivedAlarms & (CH1_RTDASHORTALARM << ChannelNum))
      alarmoperate(CH1_RTDASHORTALARM << ChannelNum,DISALARM);
  }
  else
  {
    if(ActivedAlarms & (CH1_RTDAOPENALARM << ChannelNum))
      alarmoperate(CH1_RTDAOPENALARM << ChannelNum,DISALARM);
    if(ActivedAlarms & (CH1_RTDASHORTALARM << ChannelNum))
      alarmoperate(CH1_RTDASHORTALARM << ChannelNum,DISALARM);
  }
  
  if(RTD_stat & RTDA_ERR)
  {
    if((RTD_stat & RTDB_ERR) || (pSPCValue[ChannelNum].SPCSetPoints.system_valueb.bite.rtd_opr == ONE_RTD_MOD))
    {
      RTD_stat |= RTDS_ERR;
      spc_system_flag.bite.temp_err = 1;
    }
  }
  
  if(pSPCValue[ChannelNum].SPCSetPoints.system_valueb.bite.rtd_opr == ONE_RTD_MOD)
  {
    StatisticsTempHigh = STATICTEMPHIGHA;
    StatisticsTempLow = STATICTEMPLOWA;
  }
  else
  {
    if((*tempa_ptr == RTD_SHORT) || (*tempb_ptr == RTD_SHORT))
    {
      StatisticsTempLow = STATICTEMPLOWA;
    }
    else
    {
      if(*tempa_ptr > *tempb_ptr)
        StatisticsTempLow = STATICTEMPLOWB;
      else
        StatisticsTempLow = STATICTEMPLOWA;
    }

    if((*tempa_ptr == RTD_OPNE) || (*tempb_ptr == RTD_OPNE))
    {
      StatisticsTempHigh = STATICTEMPHIGHA;
    }
    else
    {
      if(*tempa_ptr == RTD_SHORT)
      {
        if(*tempb_ptr == RTD_SHORT)
          StatisticsTempHigh = STATICTEMPHIGHA;
        else
          StatisticsTempHigh = STATICTEMPHIGHB;
      }
      else
      {
        if(*tempb_ptr == RTD_SHORT)
          StatisticsTempHigh = STATICTEMPHIGHA;
        else
        {
          if(*tempa_ptr > *tempb_ptr)
            StatisticsTempHigh = STATICTEMPHIGHA;
          else
            StatisticsTempHigh = STATICTEMPHIGHB;
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
    SystemUpdate |= (CH1_TEMP_UPDATE_REQ << ChannelNum);
    SetTempStatStr(temp_ptr, CH1_ACTURAL_ALL, ChannelNum);
    SetTempStatStr(tempa_ptr, CH1_ACTURAL_A, ChannelNum);
    SetTempStatStr(tempb_ptr, CH1_ACTURAL_B, ChannelNum);
    
    HighTempCutoffEn[ChannelNum] = 0;
    ForceSSROFFCondition[ChannelNum] &= ~HIGHTEMPCUTOFFFORCEOFF;

    ADC_busy[ChannelNum] = ADC_FREE;

    if(ActivedAlarms & (CH1_LOWTEMPALARM << ChannelNum))
      alarmoperate(CH1_LOWTEMPALARM << ChannelNum,DISALARM);

    if(ActivedAlarms & (CH1_HIGHTEMPALARM << ChannelNum))
      alarmoperate(CH1_HIGHTEMPALARM << ChannelNum,DISALARM);
    return 1;
  }
  else
  {
    TempErrorAction(ChannelNum, 0);
  }

  CalSystemTemp(ChannelNum, RTD_stat);
  SystemUpdate |= (CH1_TEMP_UPDATE_REQ << ChannelNum);
  SetTempStatStr(temp_ptr, CH1_ACTURAL_ALL, ChannelNum);
  SetTempStatStr(tempa_ptr, CH1_ACTURAL_A, ChannelNum);
  SetTempStatStr(tempb_ptr, CH1_ACTURAL_B, ChannelNum);
  
  //statistics

  //alarms
  if((pSPCValue[ChannelNum].SPCActual.Temperature.Temperature_C == RTD_SHORT) ||
     (pSPCValue[ChannelNum].SPCActual.Temperature.Temperature_C == RTD_OPNE))
  {
    ADC_busy[ChannelNum] = ADC_FREE;
    return 1;
  }
  
  if(pSPCValue[ChannelNum].SPCSetPoints.MaintainTemp.Temperature_C == SPC_SYSTEMVALUE_OFF)
  {
    asm nop;
    Spcssr[ChannelNum].SSR_cmd = 0;        //SET_SSR_DIS
    if(ActivedAlarms & (CH1_LOWTEMPALARM << ChannelNum))
      alarmoperate(CH1_LOWTEMPALARM << ChannelNum,DISALARM);

    if(ActivedAlarms & (CH1_HIGHTEMPALARM << ChannelNum))
      alarmoperate(CH1_HIGHTEMPALARM << ChannelNum,DISALARM);
  }
  else
  {
    if((pSPCValue[ChannelNum].SPCActual.Temperature.Temperature_C >
       pSPCValue[ChannelNum].SPCSetPoints.HighTemp.Temperature_C) &&
      (pSPCValue[ChannelNum].SPCSetPoints.HighTemp.Temperature_C != SPC_SYSTEMVALUE_OFF))
    {
      if(HighTempCutoffEn[ChannelNum] == 0)
      {
        if(!(ActivedAlarms & (CH1_HIGHTEMPALARM << ChannelNum)))
          alarmoperate(CH1_HIGHTEMPALARM << ChannelNum,ENALARM);
      }
        
      if(ActivedAlarms & (CH1_LOWTEMPALARM << ChannelNum))
        alarmoperate(CH1_LOWTEMPALARM << ChannelNum,DISALARM);
    }
    else if((pSPCValue[ChannelNum].SPCActual.Temperature.Temperature_C <
            pSPCValue[ChannelNum].SPCSetPoints.LowTemp.Temperature_C) &&
           (pSPCValue[ChannelNum].SPCSetPoints.LowTemp.Temperature_C != SPC_SYSTEMVALUE_OFF))
    {
      if(!(ActivedAlarms & (CH1_LOWTEMPALARM << ChannelNum)))
        alarmoperate(CH1_LOWTEMPALARM << ChannelNum,ENALARM);
      
      if(HighTempCutoffEn[ChannelNum] == 0)
      {
        if(ActivedAlarms & (CH1_HIGHTEMPALARM << ChannelNum))
          alarmoperate(CH1_HIGHTEMPALARM << ChannelNum,DISALARM);
      }
    }
    else
    {
      if(ActivedAlarms & (CH1_LOWTEMPALARM << ChannelNum))
        alarmoperate(CH1_LOWTEMPALARM << ChannelNum,DISALARM);

      if(HighTempCutoffEn[ChannelNum] == 0)
      {
        if(ActivedAlarms & (CH1_HIGHTEMPALARM << ChannelNum))
          alarmoperate(CH1_HIGHTEMPALARM << ChannelNum,DISALARM);
      }
    }
    
    if(pSPCValue[ChannelNum].SPCSetPoints.MaintainTemp.Temperature_C == SPC_SYSTEMVALUE_NONE)
    {
      asm nop;
      Spcssr[ChannelNum].SSR_cmd = 0;
      ADC_busy[ChannelNum] = ADC_FREE;
      return 1;
    }

    //RELAY operation
    //if(spc_system_flag.bite.load_forceop != LOAD_OK)
    if(SSRForceOp[ChannelNum] != LOAD_OK)
    {
      ADC_busy[ChannelNum] = ADC_FREE;
      return 1;
    }

    if(pSPCValue[ChannelNum].SPCSetPoints.system_valueb.bite.ctl_type)  //if it is pi control
    {
      asm nop;
      Spcssr[ChannelNum].SSR_cmd = 1;         //SET_SSR_EN
      if(Spcssr[ChannelNum].SSR_stat == 0)
      {
        temp_val_old[ChannelNum] = abs(pSPCValue[ChannelNum].SPCActual.Temperature.Temperature_C -
                      pSPCValue[ChannelNum].SPCSetPoints.MaintainTemp.Temperature_C);
      }
      if(Spcssr[ChannelNum].SSR_stat == 1)   //如果ssr已经打开，进行pi控制算法  SSR_EN
      {
        if(pSPCValue[ChannelNum].SPCActual.Temperature.Temperature_C >
           pSPCValue[ChannelNum].SPCSetPoints.MaintainTemp.Temperature_C)
        {
          //确认当前绝对温度差
          temp_val = (pSPCValue[ChannelNum].SPCActual.Temperature.Temperature_C -
                      pSPCValue[ChannelNum].SPCSetPoints.MaintainTemp.Temperature_C);
          //如果temp呈上升趋势  降低恒温pwm
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
          //确定pwm波duty值 从恒温pwm进行平移
          if(Spcpwm[ChannelNum].duty_point < duty_val)
            duty_index[ChannelNum] = 0;
          else
            duty_index[ChannelNum] = Spcpwm[ChannelNum].duty_point - duty_val;
            
          //pwm_duty = get_duty_table(duty_index);
        }
        else if(pSPCValue[ChannelNum].SPCActual.Temperature.Temperature_C <
                pSPCValue[ChannelNum].SPCSetPoints.MaintainTemp.Temperature_C)
        {
          //确认当前绝对温度差
          temp_val = (pSPCValue[ChannelNum].SPCSetPoints.MaintainTemp.Temperature_C -
                      pSPCValue[ChannelNum].SPCActual.Temperature.Temperature_C);
          //如果temp呈下降趋势  提升恒温pwm
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
          //确定pwm波duty值 从恒温pwm进行平移
          if(Spcpwm[ChannelNum].duty_point + duty_val > 10)
            duty_index[ChannelNum] = 10;
          else
            duty_index[ChannelNum] = Spcpwm[ChannelNum].duty_point + duty_val;
        }
        
        if(pSPCValue[ChannelNum].SPCSetPoints.LimitedCurrent != SPC_SYSTEMVALUE_OFF)
        {
          if(duty_index[ChannelNum] > pSPCValue[ChannelNum].SPCSetPoints.LimitedCurrent/10)
            duty_index[ChannelNum] =  pSPCValue[ChannelNum].SPCSetPoints.LimitedCurrent/10;
        }
        pwm_duty[ChannelNum] = get_duty_table(duty_index[ChannelNum]);

        if(pwm_duty[ChannelNum] == 0)
          SetHeatStatStr(HEAT_IS_OFF, ChannelNum);
        else
          SetHeatStatStr(HEAT_IS_ON, ChannelNum);
          
        dutyshadePI[ChannelNum] = duty_index[ChannelNum]*10;
        SystemUpdate |= (CH1_DUTY_UPDATE_REQ << ChannelNum);
        SetIntStr((int*)&dutyshadePI[ChannelNum], CH1_ACTURAL_DUTY+ChannelNum, UNIT_PERCENT, 1);
      }
    }
    else
    {

      if(pSPCValue[ChannelNum].SPCActual.Temperature.Temperature_C >
           pSPCValue[ChannelNum].SPCSetPoints.MaintainTemp.Temperature_C +
           pSPCValue[ChannelNum].SPCSetPoints.DeadBand.Temperature_C)
      {
        if(Spcssr[ChannelNum].SSR_cmd == 1)
          Spcssr[ChannelNum].SSR_cmd = 0;         //SET_SSR_DIS
      }
      else if(pSPCValue[ChannelNum].SPCActual.Temperature.Temperature_C <
                pSPCValue[ChannelNum].SPCSetPoints.MaintainTemp.Temperature_C -
                pSPCValue[ChannelNum].SPCSetPoints.DeadBand.Temperature_C)
      {
         if(Spcssr[ChannelNum].SSR_cmd == 0)
          Spcssr[ChannelNum].SSR_cmd = 1;        //SET_SSR_EN
      }
    }
  }

  ADC_busy[ChannelNum] = ADC_FREE;
  return 1;
}

//==============================================================================
//calculate system temperature
//input：RTD stat
//output：none
//==============================================================================
void BackupFunc(char ChannelNum, char RTDstats)
{
  if(RTDstats & RTDA_ERR)
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
    case ONE_RTD_MOD:
      HighTempCutoffEn[ChannelNum] = 0;
      ForceSSROFFCondition[ChannelNum] &= ~HIGHTEMPCUTOFFFORCEOFF;
      CopyTemp(&(pSPCValue[ChannelNum].SPCActual.TemperatureA),
               &(pSPCValue[ChannelNum].SPCActual.Temperature));
      break;
    case BACKUP_MOD:
      HighTempCutoffEn[ChannelNum] = 0;
      ForceSSROFFCondition[ChannelNum] &= ~HIGHTEMPCUTOFFFORCEOFF;
      BackupFunc(ChannelNum, RTDstat);
      break;
    case AVERAGE_MOD:
      HighTempCutoffEn[ChannelNum] = 0;
      ForceSSROFFCondition[ChannelNum] &= ~HIGHTEMPCUTOFFFORCEOFF;
      if(RTDstat == RTD_OK)
      {
        tempaverage(&(pSPCValue[ChannelNum].SPCActual.TemperatureA),
                  &(pSPCValue[ChannelNum].SPCActual.Temperature));
      }
      else
      {
        BackupFunc(ChannelNum, RTDstat);
      }
      break;
    case LOWEST_MOD:
      HighTempCutoffEn[ChannelNum] = 0;
      ForceSSROFFCondition[ChannelNum] &= ~HIGHTEMPCUTOFFFORCEOFF;
      if(RTDstat == RTD_OK)
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
    case HIGHEST_MOD:
      HighTempCutoffEn[ChannelNum] = 0;
      ForceSSROFFCondition[ChannelNum] &= ~HIGHTEMPCUTOFFFORCEOFF;
      if(RTDstat == RTD_OK)
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
    case HIGHTEMPCUTOFF_MOD:
      if(RTDstat == RTD_OK)
      {
        CopyTemp(&(pSPCValue[ChannelNum].SPCActual.TemperatureA),
               &(pSPCValue[ChannelNum].SPCActual.Temperature));
      }
      if(pSPCValue[ChannelNum].SPCSetPoints.HighTemp.Temperature_C == SPC_SYSTEMVALUE_OFF)
      {
        HighTempCutoffEn[ChannelNum] = 0;
        ForceSSROFFCondition[ChannelNum] &= ~HIGHTEMPCUTOFFFORCEOFF;
        BackupFunc(ChannelNum, RTDstat);
      }
      else
      {
        if(RTDstat & RTDB_ERR)
        {
          HighTempCutoffEn[ChannelNum] = 0;
          ForceSSROFFCondition[ChannelNum] &= ~HIGHTEMPCUTOFFFORCEOFF;
          BackupFunc(ChannelNum, RTDstat);
        }
        else
        {
          BackupFunc(ChannelNum, RTDstat);
          if(pSPCValue[ChannelNum].SPCActual.TemperatureB.Temperature_C >
           pSPCValue[ChannelNum].SPCSetPoints.HighTemp.Temperature_C)
          {
            HighTempCutoffEn[ChannelNum] = 1;
            ForceSSROFFCondition[ChannelNum] |= HIGHTEMPCUTOFFFORCEOFF;
            if(!(ActivedAlarms & (CH1_HIGHTEMPALARM << ChannelNum)))
              alarmoperate(CH1_HIGHTEMPALARM << ChannelNum,ENALARM);
          }
          else
          {
            HighTempCutoffEn[ChannelNum] = 0;
            ForceSSROFFCondition[ChannelNum] &= ~HIGHTEMPCUTOFFFORCEOFF;
          }
        }
      }
      break;
  }
}

//==============================================================================
//process for control based on current
//input：none
//output：none
//==============================================================================
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

//statistics
  if(Statis_flag[ChannelNum] & STATIS_CURRENT)      //MaximumCurrent is blank
  {
    Statis_flag[ChannelNum] &= ~STATIS_CURRENT;
    pSPCValue[ChannelNum].SPCStatistics.MaximumCurrent = pSPCValue[ChannelNum].SPCActual.Current_RMS;
    SystemUpdate |= (CH1_CURRENT_MAX_UPDATE_REQ << ChannelNum);
    SetCurrentStr((int*)&pSPCValue[ChannelNum].SPCStatistics.MaximumCurrent, CH1_ACTURAL_CURRENT_MAX+ChannelNum, UNIT_AMPER, 1);
    StaticsChange = 1;
  }
  
  if(Statis_flag[ChannelNum] & STATIS_GFI)          //MaximumGFCurrent is blank
  {
    Statis_flag[ChannelNum] &= ~STATIS_GFI;
    pSPCValue[ChannelNum].SPCStatistics.MaximumGFCurrent = pSPCValue[ChannelNum].SPCActual.GFICurrent;
    SystemUpdate |= (CH1_GFI_MAX_UPDATE_REQ << ChannelNum);
    SetIntStr((int*)&pSPCValue[ChannelNum].SPCStatistics.MaximumGFCurrent, CH1_ACTURAL_GFI_MAX+ChannelNum, UNIT_MILIAMPER, 2);
    StaticsChange = 1;
  }
  
  if(pSPCValue[ChannelNum].SPCStatistics.MaximumCurrent < pSPCValue[ChannelNum].SPCActual.Current_RMS)
  {
    pSPCValue[ChannelNum].SPCStatistics.MaximumCurrent = pSPCValue[ChannelNum].SPCActual.Current_RMS;
    SystemUpdate |= (CH1_CURRENT_MAX_UPDATE_REQ << ChannelNum);
    SetCurrentStr((int*)&pSPCValue[ChannelNum].SPCStatistics.MaximumCurrent, CH1_ACTURAL_CURRENT_MAX+ChannelNum, UNIT_AMPER, 1);
    StaticsChange = 1;
  }
    
  if(pSPCValue[ChannelNum].SPCStatistics.MaximumGFCurrent < pSPCValue[ChannelNum].SPCActual.GFICurrent)
  {
    pSPCValue[ChannelNum].SPCStatistics.MaximumGFCurrent = pSPCValue[ChannelNum].SPCActual.GFICurrent;
    SystemUpdate |= (CH1_GFI_MAX_UPDATE_REQ << ChannelNum);
    SetIntStr((int*)&pSPCValue[ChannelNum].SPCStatistics.MaximumGFCurrent, CH1_ACTURAL_GFI_MAX+ChannelNum, UNIT_MILIAMPER, 2);
    StaticsChange = 1;
  }
  if(StaticsChange)
    EEPROM_set(0x01+2*sizeof(SPCSETPIONTS)+ChannelNum*sizeof(STATISTICS),sizeof(STATISTICS),(UCHAR*)(&pSPCValue[ChannelNum].SPCStatistics));
 
//alarms
  //if(Spcssr[ChannelNum].SSR_actual_stat == RELAY_IS_OFF)
  if(SSRStatInMeas[ChannelNum] == RELAY_IS_OFF)
  {
    buff = CH1_CONTINUEFAILALARM << ChannelNum;
    if(ActivedAlarms & buff)
      alarmoperate(buff << ChannelNum,DISALARM);
  
    if(pSPCValue[ChannelNum].SPCActual.Current > 0)
    {
      if(ShortFailCount[ChannelNum] <= 20)
      {
        ShortFailCount[ChannelNum]++;
      }
      else
      {
        ShortFailCount[ChannelNum]=0;
        if(!(ActivedAlarms & (CH1_FAILEDSHORTALARM << ChannelNum)))
          alarmoperate(CH1_FAILEDSHORTALARM << ChannelNum,ENALARM);
      }
    }
    else
    {
      ShortFailCount[ChannelNum]=0;
    }
  }
  else
  {
    if(ActivedAlarms & (CH1_FAILEDSHORTALARM << ChannelNum))
      alarmoperate(CH1_FAILEDSHORTALARM << ChannelNum,DISALARM);
      
    if(pSPCValue[ChannelNum].SPCActual.Current == 0)
    {
      if(CountinueFailCount[ChannelNum] <= 20)
      {
        CountinueFailCount[ChannelNum]++;
      }
      else
      {
        CountinueFailCount[ChannelNum] = 0;
        if(!(ActivedAlarms & (CH1_CONTINUEFAILALARM << ChannelNum)))
          alarmoperate(CH1_CONTINUEFAILALARM << ChannelNum,ENALARM);
      }
    }
    else
    {
      CountinueFailCount[ChannelNum] = 0;
    }
  }

  if(SSRStatInMeas[ChannelNum] == RELAY_IS_OFF)
  {
    if(ActivedAlarms & (CH1_LOWCURRENTALARM << ChannelNum))
      alarmoperate(CH1_LOWCURRENTALARM << ChannelNum,DISALARM);
      
    if(ActivedAlarms & (CH1_HIGHCURRENTALARM << ChannelNum))
      alarmoperate(CH1_HIGHCURRENTALARM << ChannelNum,DISALARM);
  }
  else
  {
    if(pSPCValue[ChannelNum].SPCSetPoints.LowCurrent != SPC_SYSTEMVALUE_OFF)
    {
      if(pSPCValue[ChannelNum].SPCActual.Current < pSPCValue[ChannelNum].SPCSetPoints.LowCurrent)
      {
        if(!(ActivedAlarms & (CH1_LOWCURRENTALARM << ChannelNum)))
          alarmoperate(CH1_LOWCURRENTALARM << ChannelNum,ENALARM);
      }
      else
      {
        if(ActivedAlarms & (CH1_LOWCURRENTALARM << ChannelNum))
          alarmoperate(CH1_LOWCURRENTALARM << ChannelNum,DISALARM);
      }
    }
    else
    {
      if(ActivedAlarms & (CH1_LOWCURRENTALARM << ChannelNum))
        alarmoperate(CH1_LOWCURRENTALARM << ChannelNum,DISALARM);
    }
  
    if(pSPCValue[ChannelNum].SPCSetPoints.HighCurrent != SPC_SYSTEMVALUE_OFF)
    {
      if(pSPCValue[ChannelNum].SPCActual.Current > pSPCValue[ChannelNum].SPCSetPoints.HighCurrent)
      {
        EnableHighCurrentAlarmCount(ChannelNum);
      }
      else
      {
        DisableHighCurrentAlarmCount(ChannelNum);
        if(ActivedAlarms & (CH1_HIGHCURRENTALARM << ChannelNum))
          alarmoperate(CH1_HIGHCURRENTALARM << ChannelNum,DISALARM);
      }
    }
    else
    {
      DisableHighCurrentAlarmCount(ChannelNum);
      if(ActivedAlarms & (CH1_HIGHCURRENTALARM << ChannelNum))
        alarmoperate(CH1_HIGHCURRENTALARM << ChannelNum,DISALARM);
    }

  
    if(GFITestCmd[ChannelNum] == 1)
      GFITestbuff = 30;
    else
      GFITestbuff = pSPCValue[ChannelNum].SPCSetPoints.GFITrip;
    
    if(GFITestbuff != SPC_SYSTEMVALUE_OFF)
    {
      if(pSPCValue[ChannelNum].SPCActual.GFICurrent > GFITestbuff)
      {
        if((pSPCValue[ChannelNum].SPCSetPoints.system_valueb.bite.gfi_test_mod == GFI_TEST_AUTO) &&
          (AutoGFITestEN[ChannelNum] == 1))
        {
          AutoGFITestPass[ChannelNum] = 1;
          //LATF2_bit = 0;
                if(ChannelNum == CHANNEL1)
                  LATF2_bit = 1;
                else if(ChannelNum == CHANNEL2)
                  LATF1_bit = 1;
          ForceSSROFFCondition[ChannelNum] |= GFITRIPFORCEOFF;
        }
        else if((pSPCValue[ChannelNum].SPCSetPoints.system_valueb.bite.gfi_test_mod == GFI_TEST_NOW) &&
          (GFITestCmd[ChannelNum] == 1))
        {
          GFITestPass[ChannelNum] = 1;
          //LATF2_bit = 0;
                if(ChannelNum == CHANNEL1)
                  LATF2_bit = 1;
                else if(ChannelNum == CHANNEL2)
                  LATF1_bit = 1;
          ForceSSROFFCondition[ChannelNum] |= GFITRIPFORCEOFF;
        }
        else
        {
          //LATF2_bit = 0;
                if(ChannelNum == CHANNEL1)
                  LATF2_bit = 1;
                else if(ChannelNum == CHANNEL2)
                  LATF1_bit = 1;
          ForceSSROFFCondition[ChannelNum] |= GFITRIPFORCEOFF;
        
          if(!(ActivedAlarms & (CH1_GFITRIP << ChannelNum)))
          {
            if(ActivedAlarms & (CH1_GFIALARM << ChannelNum))
              alarmoperate(CH1_GFIALARM << ChannelNum,DISALARM);

            alarmoperate(CH1_GFITRIP << ChannelNum,ENALARM);
          }
        }
      }
      else
        GFIAlarmFlag |= TRIPNOTHAPPEN;
    }
    else
      GFIAlarmFlag |= TRIPNOTHAPPEN;

    if(pSPCValue[ChannelNum].SPCSetPoints.GFIAlarm != SPC_SYSTEMVALUE_OFF)
    {
      if(pSPCValue[ChannelNum].SPCActual.GFICurrent > pSPCValue[ChannelNum].SPCSetPoints.GFIAlarm)
      {
        if((pSPCValue[ChannelNum].SPCSetPoints.system_valueb.bite.gfi_test_mod == GFI_TEST_AUTO) &&
         (AutoGFITestEN[ChannelNum] == 1))
        {
          asm nop;
        }
        else if((pSPCValue[ChannelNum].SPCSetPoints.system_valueb.bite.gfi_test_mod == GFI_TEST_NOW) &&
          (GFITestCmd[ChannelNum] == 1))
        {
          asm nop;
        }
        else if(!(ActivedAlarms & (CH1_GFITRIP << ChannelNum)))
        {
          if(!(ActivedAlarms & (CH1_GFIALARM << ChannelNum)))
            alarmoperate(CH1_GFIALARM << ChannelNum,ENALARM);
        }
      }
      else
        GFIAlarmFlag |= ALARMNOTHAPPEN;
    }
    else
      GFIAlarmFlag |= ALARMNOTHAPPEN;

    if((GFIAlarmFlag & ALARMNOTHAPPEN) && (GFIAlarmFlag & TRIPNOTHAPPEN))
    {
      if(!(ActivedAlarms & (CH1_GFITRIP << ChannelNum)))
      {
        if(ActivedAlarms & (CH1_GFIALARM << ChannelNum))
          alarmoperate(CH1_GFIALARM << ChannelNum,DISALARM);
      }
    }
  }
}

void ActivateHighCurrentAlarm(char ChannelNum)
{
  if(HighCurrentEn[ChannelNum] == 2)
  {
    HighCurrentEn[ChannelNum] = 0;
    if(!(ActivedAlarms & (CH1_HIGHCURRENTALARM << ChannelNum)))
      alarmoperate(CH1_HIGHCURRENTALARM << ChannelNum,ENALARM);
  }
}

//==============================================================================
//process for control based on voltage
//input：none
//output：none
//==============================================================================
void Voltprocess()
{
  char StaticsChange=0;

  Getvoltage();
  if(pSPCValue[0].SPCActual.Voltage > MAX_SPCVOLT)
  {
    pSPCValue[0].SPCActual.Voltage = OUTOFRANGE;
  }
    
  spc_system_flag.bite.meas_VT_reach &= 0xfe;
  
  SystemUpdate |= VOLTAGE_UPDATE_REQ;
  SetIntStr((int*)&pSPCValue[0].SPCActual.Voltage, ACTURAL_VOLT, UNIT_ACVOLT, 1);
  
  
//statistics
  if(Statis_flag[0] & STATIS_MAX_VOLT)
  {
    Statis_flag[0] &= ~STATIS_MAX_VOLT;
    pSPCValue[0].SPCStatistics.MaximumVoltage = pSPCValue[0].SPCActual.Voltage;
    SystemUpdate |= VOLTAGE_MAX_UPDATE_REQ;
    SetIntStr((int*)&pSPCValue[0].SPCStatistics.MaximumVoltage, ACTURAL_VOLT_MAX, UNIT_ACVOLT, 1);
    StaticsChange = 1;
  }
  if(Statis_flag[0] & STATIS_MIN_VOLT)
  {
    Statis_flag[0] &= ~STATIS_MIN_VOLT;
    pSPCValue[0].SPCStatistics.MinimumVoltage = pSPCValue[0].SPCActual.Voltage;
    SystemUpdate |= VOLTAGE_MIN_UPDATE_REQ;
    SetIntStr((int*)&pSPCValue[0].SPCStatistics.MinimumVoltage, ACTURAL_VOLT_MIN, UNIT_ACVOLT, 1);
    StaticsChange = 1;
  }
  if(pSPCValue[0].SPCActual.Voltage > pSPCValue[0].SPCStatistics.MaximumVoltage)
  {
    pSPCValue[0].SPCStatistics.MaximumVoltage = pSPCValue[0].SPCActual.Voltage;
    SystemUpdate |= VOLTAGE_MAX_UPDATE_REQ;
    SetIntStr((int*)&pSPCValue[0].SPCStatistics.MaximumVoltage, ACTURAL_VOLT_MAX, UNIT_ACVOLT, 1);
    StaticsChange = 1;
  }
  else if(pSPCValue[0].SPCActual.Voltage < pSPCValue[0].SPCStatistics.MinimumVoltage)
  {
    pSPCValue[0].SPCStatistics.MinimumVoltage = pSPCValue[0].SPCActual.Voltage;
    SystemUpdate |= VOLTAGE_MIN_UPDATE_REQ;
    SetIntStr((int*)&pSPCValue[0].SPCStatistics.MinimumVoltage, ACTURAL_VOLT_MIN, UNIT_ACVOLT, 1);
    StaticsChange = 1;
  }
  if(StaticsChange)
    EEPROM_set(0x01+2*sizeof(SPCSETPIONTS),sizeof(STATISTICS),(UCHAR*)(&pSPCValue[0].SPCStatistics));
  
 //alarm
  if((pSPCValue[0].SPCActual.Voltage < pSPCValue[0].SPCSetPoints.LowVoltage) &&
     (pSPCValue[0].SPCSetPoints.LowVoltage != SPC_SYSTEMVALUE_OFF))
  {
    if(!(ActivedAlarms & LOWVOLTALARM))
      alarmoperate(LOWVOLTALARM,ENALARM);
      
    if(ActivedAlarms & HIGHVOLTALARM)
      alarmoperate(HIGHVOLTALARM,DISALARM);
  }
  else if((pSPCValue[0].SPCActual.Voltage > pSPCValue[0].SPCSetPoints.HighVoltage) &&
          (pSPCValue[0].SPCSetPoints.HighVoltage != SPC_SYSTEMVALUE_OFF))
  {
    if(!(ActivedAlarms & HIGHVOLTALARM))
      alarmoperate(HIGHVOLTALARM,ENALARM);
      
    if(ActivedAlarms & LOWVOLTALARM)
      alarmoperate(LOWVOLTALARM,DISALARM);
  }
  else
  {
    if(ActivedAlarms & HIGHVOLTALARM)
      alarmoperate(HIGHVOLTALARM,DISALARM);
      
    if(ActivedAlarms & LOWVOLTALARM)
      alarmoperate(LOWVOLTALARM,DISALARM);
  }
}

//==============================================================================
//calculate enegy
//input：none
//output：none
//==============================================================================
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
    if(pSPCValue[i].SPCStatistics.EnergyUsed == OUTOFRANGE)
    {
      MemeSet((char *)&Volt_acc[i], 0, sizeof(VALUEACC));
      MemeSet((char *)&Current_acc[i], 0, sizeof(VALUEACC));
      SkipCh[i] = 1;
      //return;
    }

    if(pSPCValue[0].SPCActual.Voltage == OUTOFRANGE)
      SkipCh[i] = 1;           //return;

    if(pSPCValue[i].SPCActual.Current_RMS == OUTOFRANGE)
      SkipCh[i] = 1;             //return;

    if(SkipCh[i] == 0)
    {
      if(Volt_acc[i].num >= 100)        //100
      {
        v_temp = Volt_acc[i].acc/100;              //100
        c_temp = Current_acc[i].acc/100;           //100
        TotalEnergyWh[i] += v_temp*c_temp;

        if(TotalEnergyWh[i] > 1000)
        {
          TotalEnergyKwh[i] += (TotalEnergyWh[i]/1000);
          TotalEnergyWh[i] %= 1000;

          if(TotalEnergyKwh[i] > 1000)
          {
            pSPCValue[i].SPCStatistics.EnergyUsed += (TotalEnergyKwh[i]/1000);
            TotalEnergyKwh[i] %= 1000;

            if(pSPCValue[i].SPCStatistics.EnergyUsed > MAX_SPCENEGY)
            {
              pSPCValue[i].SPCStatistics.EnergyUsed = OUTOFRANGE;
              pSPCValue[i].SPCStatistics.EnergyCost = COSTOUTOFRANGE;
            }
          }

          if(pSPCValue[i].SPCStatistics.EnergyCost != COSTOUTOFRANGE)
          {
            pSPCValue[i].SPCStatistics.EnergyCost = TotalEnergyKwh[i]*
                                  pSPCValue[i].SPCSetPoints.CostPerKWH/10;
            pSPCValue[i].SPCStatistics.EnergyCost += (unsigned long)pSPCValue[i].SPCStatistics.EnergyUsed*
                                  pSPCValue[i].SPCSetPoints.CostPerKWH * 100;
          }
          if(pSPCValue[i].SPCStatistics.EnergyCost > MAX_SPCOST_TOTAL)
            pSPCValue[i].SPCStatistics.EnergyCost = COSTOUTOFRANGE;
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
        SystemUpdate |= (CH1_ENEGY_UPDATE_REQ << i);
        SetCostStr(pSPCValue[i].SPCStatistics.EnergyUsed, CH1_ACTURAL_ENEGY+i);
        SetCostStr(pSPCValue[i].SPCStatistics.EnergyCost, CH1_ACTURAL_COST+i);
        EEPROM_set(0x01+2*sizeof(SPCSETPIONTS)+i*sizeof(STATISTICS),sizeof(STATISTICS),(UCHAR*)(&pSPCValue[i].SPCStatistics));
      }
    }
  }
}

//==============================================================================
//calculate time of SPC
//input：none
//output：none
//==============================================================================
void Timeprocess()
{
  char StaticsChange=0;
  char i;

  for(i=0;i<2;i++)
  {
    if(DataUpdate & (CH1_ONTIME_UPDATE_REQ << i))
    {
      DataUpdate &= ~(CH1_ONTIME_UPDATE_REQ << i);
      SystemUpdate |= (CH1_ONTIME_UPDATE_REQ << i);
      SetOntimeStr(pSPCValue[i].SPCStatistics.RunTime, CH1_ACTURAL_ONTIME+i);
      StaticsChange = 1;
    }

    if(DataUpdate & (CH1_ONTIME_UPDATE_PERCENT_REQ << i))
    {
      DataUpdate &= ~(CH1_ONTIME_UPDATE_PERCENT_REQ << i);
      SystemUpdate |= (CH1_ONTIME_UPDATE_PERCENT_REQ << i);

      pSPCValue[i].SPCStatistics.HeaterOnTime =
        (Heat_On_time[i].hour*60+Heat_On_time[i].minute)*100/(SYS_On_time.hour*60+SYS_On_time.minute);
      SetIntStr((int*)&pSPCValue[i].SPCStatistics.HeaterOnTime, CH1_ACTURAL_ONTIME_PERCENT+i, UNIT_PERCENT, 1);
      StaticsChange = 1;
    }

    if(StaticsChange)
      EEPROM_set(0x01+2*sizeof(SPCSETPIONTS)+i*sizeof(STATISTICS),sizeof(STATISTICS),(UCHAR*)(&pSPCValue[i].SPCStatistics));
  }
}