#include "systemvalue.h"
#include "SSR.h"
#include "PIC18F6622.h"
#include "function.h"
#include "EEPROM.h"

#define PERIORS_IN_CYCAL 6

#define ENABLE_ALARM_SSR_CH1 LATB4_bit = 1;  LATB5_bit = 1;
#define ENABLE_ALARM_SSR_CH2 LATB1_bit = 1;  LATB2_bit = 1;
#define DISABLE_ALARM_SSR_CH1 LATB4_bit = 0;  LATB5_bit = 0;
#define DISABLE_ALARM_SSR_CH2 LATB1_bit = 0;  LATB2_bit = 0;

code unsigned int duty_table[11] =
{
  0x0000,
  0x8000,  //0x8000,
  0xa000,  //0xa000,
  0xa800,  //0xa800,
  0xaa00,  //0xaa00,
  0xaa80,  //0xaa80,
  0xacc0,  //0xacc0,
  0xabc0,  //0xabc0,
  0xafc0,  //0xafc0,
  0xbfc0,  //0xbfc0,
  0xffc0,  //0xffc0
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
//==============================================================================
//turn on/off alarm relay
//input：none
//output：none
//==============================================================================
void Alarm_SSR_on(char ChannelNum)
{
  if(ChannelNum == CHANNEL1)
  {
    ENABLE_ALARM_SSR_CH1
  }
  else if(ChannelNum == CHANNEL2)
  {
    ENABLE_ALARM_SSR_CH2
  }
}

void Alarm_SSR_off(char ChannelNum)
{
  if(ChannelNum == CHANNEL1)
  {
    DISABLE_ALARM_SSR_CH1
  }
  else if(ChannelNum == CHANNEL2)
  {
    DISABLE_ALARM_SSR_CH2
  }
}

//==============================================================================
//turn on/off load relay
//input：none
//output：none
//==============================================================================
char relay_on(char ChannelNum)
{
  if(Spcssr[ChannelNum].SSR_actual_stat == RELAY_IS_OFF)
  {
    if(ChannelNum)
      LATC5_bit = 1;     //channel 2
    else
      LATC2_bit = 1;     //channel 1
    Spcssr[ChannelNum].SSR_actual_stat = RELAY_IS_ON;
    return 1;
  }
  else
    return 0;
}

char relay_off(char ChannelNum)
{
  if(Spcssr[ChannelNum].SSR_actual_stat == RELAY_IS_ON)
  {
    if(ChannelNum)
      LATC5_bit = 0;     //channel 2
    else
      LATC2_bit = 0;     //channel 1
    Spcssr[ChannelNum].SSR_actual_stat = RELAY_IS_OFF;
    return 1;
  }
  else
    return 0;
//  LED_HEATER_ON = 0;
}

char relay_on_ISR(char ChannelNum)
{
  if(Spcssr[ChannelNum].SSR_actual_stat == RELAY_IS_OFF)
  {
    if(ChannelNum)
      LATC5_bit = 1;     //channel 2
    else
      LATC2_bit = 1;     //channel 1
    Spcssr[ChannelNum].SSR_actual_stat = RELAY_IS_ON;
    return 1;
  }
  else
    return 0;
}

char relay_off_ISR(char ChannelNum)
{
  if(Spcssr[ChannelNum].SSR_actual_stat == RELAY_IS_ON)
  {
    if(ChannelNum)
      LATC5_bit = 0;     //channel 2
    else
      LATC2_bit = 0;     //channel 1
    Spcssr[ChannelNum].SSR_actual_stat = RELAY_IS_OFF;
    return 1;
  }
  else
    return 0;
//  LED_HEATER_ON = 0;
}

//==============================================================================
//process of softstart
//input：none
//output：none
//==============================================================================
char softstart(char ChannelNum)
{
  char dutychange=0;
  char temp;

  if(SpcSstart[ChannelNum].SOFTSTART_stat == 0)          //IDEL
  {
    duty_index[ChannelNum] = 1;
    temp = duty_index[ChannelNum];
    pwm_duty[ChannelNum] = duty_table[temp];
    dutychange = 1;
    SpcSstart[ChannelNum].SOFTSTART_cmd = 1;      //SOFTSTART_EN
    SpcSstart[ChannelNum].SOFTSTART_stat = 1;       //RUNNING
    Spcpwm[ChannelNum].pwm_cmd = 1;
    if(pSPCValue[ChannelNum].SPCSetPoints.LimitedCurrent == SPC_SYSTEMVALUE_OFF)
      SoftStartElement[ChannelNum] = pSPCValue[ChannelNum].SPCSetPoints.SoftStartTime/10;
    else
      SoftStartElement[ChannelNum] = pSPCValue[ChannelNum].SPCSetPoints.SoftStartTime*10/pSPCValue[ChannelNum].SPCSetPoints.LimitedCurrent;
      
    if(dutychange)
    {
      dutyshadeSOFTSATRT = duty_index[ChannelNum]*10;
      SystemUpdate |= (CH1_DUTY_UPDATE_REQ << ChannelNum);
      SetIntStr((int*)&dutyshadeSOFTSATRT, CH1_ACTURAL_DUTY+ChannelNum, UNIT_PERCENT, 1);
    }
  }
  else if(SpcSstart[ChannelNum].SOFTSTART_stat == 1)          //RUNNING
  {
    if(SpcSstart[ChannelNum].SOFTSTART_reach == 1)     //每过1秒
    {
      SpcSstart[ChannelNum].SOFTSTART_reach = 0;
      if(SpcSstart[ChannelNum].SOFTSTART_count >= pSPCValue[ChannelNum].SPCSetPoints.SoftStartTime)     //如果客户定义的softstart时间到了
      {
        SpcSstart[ChannelNum].SOFTSTART_count = 0;
        SoftStartElementCount[ChannelNum] = 0;
        SpcSstart[ChannelNum].SOFTSTART_cmd = 0;       //SOFTSTART_DIS
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
      SystemUpdate |= (CH1_DUTY_UPDATE_REQ << ChannelNum);
      SetIntStr((int*)&dutyshadeSOFTSATRT, CH1_ACTURAL_DUTY+ChannelNum, UNIT_PERCENT, 1);
    }

    if(SpcSstart[ChannelNum].SOFTSTART_cmd == 0)      //softstart结束    SOFTSTART_DIS
    {
      SpcSstart[ChannelNum].SOFTSTART_stat = 0;       //IDEL
      return 1;
    }
  }
  
  return 0;
}

//==============================================================================
//system relay operation
//input：none
//output：none
//==============================================================================
void RSSoperation(char ChannelNum)
{
  char LoadForce;

  if(pSPCValue[ChannelNum].SPCSetPoints.system_valueb.bite.heater_en == 0)
  {
    ForceSSROFFCondition[ChannelNum] |= HEATERDISABLEFORCEOFF;
  }
  else
  {
    ForceSSROFFCondition[ChannelNum] &= ~HEATERDISABLEFORCEOFF;
  }
  


  if(ForceSSROFFCondition[ChannelNum] & (GFITRIPFORCEOFF+HIGHTEMPCUTOFFFORCEOFF+MANUALFORCEOFF+HEATERDISABLEFORCEOFF))
    LoadForce = FORCE_LOAD_OFF;
  else
  {
    if(ForceSSRONCondition[ChannelNum] & (GFITESTFORCEON+HEATERTESTFORCEON+FAILUREMODEFORCEON))
      LoadForce = FORCE_LOAD_ON;
    else
    {
      if(ForceSSROFFCondition[ChannelNum] & FAILUREMODEFORCEOFF)
        LoadForce = FORCE_LOAD_OFF;
      else
      {
        if(ForceSSRONCondition[ChannelNum] & AUTOTESTFORCEON)
          LoadForce = FORCE_LOAD_ON;
        else
          LoadForce = LOAD_OK;
      }
    }
  }

  if(LoadForce == FORCE_LOAD_ON)
  {
    SSRForceOp[ChannelNum] = FORCE_LOAD_ON;
    if(ForceSSRONCondition[ChannelNum] & (HEATERTESTFORCEON + FAILUREMODEFORCEON))
    {
      if(pSPCValue[ChannelNum].SPCSetPoints.LimitedCurrent != SPC_SYSTEMVALUE_OFF)
      {
        SetHeatStatStr(HEAT_IS_ON, ChannelNum);
        Spcpwm[ChannelNum].meas_cmd = IDEL_MEASUREMENT;
        Spcssr[ChannelNum].SSR_stat = 1;
        Spcpwm[ChannelNum].pwm_cmd = 1;
        return;
      }
    }
  
    if(relay_on(ChannelNum))
    {
      SystemUpdate |= (CH1_HEAT_STAT_UPDATE_REQ << ChannelNum);
      SetHeatStatStr(HEAT_IS_ON, ChannelNum);

      SystemUpdate |= (CH1_DUTY_UPDATE_REQ << ChannelNum);
      duty_index[ChannelNum] = 10;
      dutyshadeNORMAL = duty_index[ChannelNum]*10;
      SetIntStr((int*)&dutyshadeNORMAL, CH1_ACTURAL_DUTY+ChannelNum, UNIT_AMPER_PERCENT, 1);
        
      Spcpwm[ChannelNum].meas_cmd = IDEL_MEASUREMENT;
      Spcssr[ChannelNum].SSR_stat = 1;
    }
      
    return;
  }
  else if(LoadForce == FORCE_LOAD_OFF)
  {
    SSRForceOp[ChannelNum] = FORCE_LOAD_OFF;
    if(relay_off(ChannelNum))
    {
      SystemUpdate |= (CH1_HEAT_STAT_UPDATE_REQ << ChannelNum);
      
      if(pSPCValue[ChannelNum].SPCSetPoints.system_valueb.bite.man_on)
        SetHeatStatStr(HEAT_IS_MANOFF, ChannelNum);
      else
        SetHeatStatStr(HEAT_IS_OFF, ChannelNum);
        
      SystemUpdate |= (CH1_DUTY_UPDATE_REQ << ChannelNum);
      duty_index[ChannelNum] = 0;
      dutyshadeNORMAL = duty_index[ChannelNum];
      SetIntStr((int*)&dutyshadeNORMAL, CH1_ACTURAL_DUTY+ChannelNum, UNIT_AMPER_PERCENT, 1);
        
      Spcpwm[ChannelNum].meas_cmd = IDEL_MEASUREMENT;
      Spcssr[ChannelNum].SSR_stat = 0;
    }
    
    return;
  }
  else
    SSRForceOp[ChannelNum] = LOAD_OK;

  if(Spcssr[ChannelNum].SSR_cmd == 1)   //SET_SSR_EN
  {//需要打开ssr
    if(Spcssr[ChannelNum].SSR_stat == 0)   //SSR_DIS
    {//ssr还没有打开
      if((pSPCValue[ChannelNum].SPCSetPoints.SoftStartTime == SPC_SYSTEMVALUE_OFF) || (SoftStartDisable[ChannelNum]))
      {//如果SOFTSTART被禁止
        if(pSPCValue[ChannelNum].SPCSetPoints.system_valueb.bite.ctl_type == 0)
        {
          relay_on(ChannelNum);
          SystemUpdate |= (CH1_HEAT_STAT_UPDATE_REQ << ChannelNum);
          SetHeatStatStr(HEAT_IS_ON, ChannelNum);
          Spcpwm[ChannelNum].pwm_cmd = 0;
          Spcpwm[ChannelNum].meas_cmd = IDEL_MEASUREMENT;
          

          duty_index[ChannelNum] = 10;
          dutyshadeNORMAL = duty_index[ChannelNum]*10;
          if(pSPCValue[ChannelNum].SPCSetPoints.LimitedCurrent != SPC_SYSTEMVALUE_OFF)
          {
            duty_index[ChannelNum] = pSPCValue[ChannelNum].SPCSetPoints.LimitedCurrent/10;
            dutyshadeNORMAL = pSPCValue[ChannelNum].SPCSetPoints.LimitedCurrent;
            pwm_duty[ChannelNum] = get_duty_table(duty_index[ChannelNum]);
            Spcpwm[ChannelNum].pwm_cmd = 1;
          }
          
          SystemUpdate |= (CH1_DUTY_UPDATE_REQ << ChannelNum);
          SetIntStr((int*)&dutyshadeNORMAL, CH1_ACTURAL_DUTY+ChannelNum, UNIT_AMPER_PERCENT, 1);
        }
        else
          Spcpwm[ChannelNum].pwm_cmd = 1;

        Spcssr[ChannelNum].SSR_stat = 1;          // SSR_EN
        SoftStartDisable[ChannelNum] = 1;
      }
      else
      {//如果SOFTSTART被使能
        if(softstart(ChannelNum))    //是否完成softstart
        {
          if(pSPCValue[ChannelNum].SPCSetPoints.system_valueb.bite.ctl_type == 0)
          {
            relay_on(ChannelNum);
            SystemUpdate |= (CH1_HEAT_STAT_UPDATE_REQ << ChannelNum);
            SetHeatStatStr(HEAT_IS_ON, ChannelNum);
            Spcpwm[ChannelNum].pwm_cmd = 0;
            Spcpwm[ChannelNum].meas_cmd = IDEL_MEASUREMENT;
            

            duty_index[ChannelNum] = 10;
            dutyshadeNORMAL = duty_index[ChannelNum]*10;
            if(pSPCValue[ChannelNum].SPCSetPoints.LimitedCurrent != SPC_SYSTEMVALUE_OFF)
            {
              duty_index[ChannelNum] = pSPCValue[ChannelNum].SPCSetPoints.LimitedCurrent/10;
              dutyshadeNORMAL = pSPCValue[ChannelNum].SPCSetPoints.LimitedCurrent;
              pwm_duty[ChannelNum] = get_duty_table(duty_index[ChannelNum]);
              Spcpwm[ChannelNum].pwm_cmd = 1;
            }

            SystemUpdate |= (CH1_DUTY_UPDATE_REQ << ChannelNum);
            SetIntStr((int*)&dutyshadeNORMAL, CH1_ACTURAL_DUTY+ChannelNum, UNIT_AMPER_PERCENT, 1);
          }
          else
            Spcpwm[ChannelNum].pwm_cmd = 1;
            
          Spcssr[ChannelNum].SSR_stat = 1;          // SSR_EN
          SoftStartDisable[ChannelNum] = 1;
        }
      }
    }
    else
    {
      asm nop;
      if((pSPCValue[ChannelNum].SPCSetPoints.system_valueb.bite.ctl_type == 1) ||
         (pSPCValue[ChannelNum].SPCSetPoints.LimitedCurrent != SPC_SYSTEMVALUE_OFF))
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
  else if(Spcssr[ChannelNum].SSR_cmd == 0)        //SET_SSR_DIS
  {//如果需要关闭ssr
    if(Spcssr[ChannelNum].SSR_stat == 1)           //SSR_EN
    {
      relay_off(ChannelNum);
      SystemUpdate |= (CH1_HEAT_STAT_UPDATE_REQ << ChannelNum);
      Spcssr[ChannelNum].SSR_stat = 0;        //SSR_DIS
      SetHeatStatStr(HEAT_IS_OFF, ChannelNum);
      Spcpwm[ChannelNum].pwm_cmd = 0;
      Spcpwm[ChannelNum].meas_cmd = IDEL_MEASUREMENT;
      
      SystemUpdate |= (CH1_DUTY_UPDATE_REQ << ChannelNum);
      duty_index[ChannelNum] = 0;
      dutyshadeNORMAL = duty_index[ChannelNum];
      SetIntStr((int*)&dutyshadeNORMAL, CH1_ACTURAL_DUTY+ChannelNum, UNIT_AMPER_PERCENT, 1);
    }
    SpcSstart[ChannelNum].SOFTSTART_stat = 0;
    SpcSstart[ChannelNum].SOFTSTART_cmd = 0;
    Spcpwm[ChannelNum].pwm_cmd = 0;
  }
}

//==============================================================================
//alarm relay operation
//input：none
//output：none
//==============================================================================
void AlarmSSRoperation()
{
  if(AlarmForce[0] == FORCE_ALARMSSR_ON)                  //(spc_system_flag.bite.alarmssr_forceop == FORCE_ALARMSSR_ON)
  {
    Alarm_SSR_on(0);
  }
  
  if(AlarmForce[1] == FORCE_ALARMSSR_ON)                  //(spc_system_flag.bite.alarmssr_forceop == FORCE_ALARMSSR_ON)
  {
    Alarm_SSR_on(1);
  }
}

//==============================================================================
//pwm generation
//input：none
//output：none
//==============================================================================
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
    WavesPerPerior = PERIORS_IN_CYCAL;
    
  if(Spcpwm[ChannelNum].pwm_count.element_count++ > WavesPerPerior*freq_pori)            //ELEMENT_TIMER
  {
    if(shift(pwm_duty[ChannelNum], ChannelNum))
    {
/*//确定下10个周期的duty
      if(Spcpwm.pwm_count.shift_count < (pwm_duty%1))
        pwm_duty = duty_table[duty_index/1+1];
      else
        pwm_duty = duty_table[duty_index/1];

      if(Spcpwm.pwm_count.shift_count == 1)     //当一次pwm生成完毕
        Spcpwm.pwm_count.shift_count = 0;

      else Spcpwm.pwm_count.shift_count++;*/
    }
    
    Spcpwm[ChannelNum].pwm_count.element_count = 0;
  }
}

//==============================================================================
//every cycle generation
//input：duty
//output：0-not finish, 1- finish
//==============================================================================
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
        Spcpwm[ChannelNum].meas_cmd = INITIAL_MEASUREMENT;
        Spcpwm[ChannelNum].pwm_count.meas_count = 0;
      }
    }
    else
    {
      if(relay_off_ISR(ChannelNum))
        Spcpwm[ChannelNum].meas_cmd = DISABLE_MEASUREMENT;
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

//==============================================================================
//time sequence for current and GFI measurement
//input：none
//output：none
//==============================================================================
void countformeasurement(char ChannelNum)
{
  if(Spcpwm[ChannelNum].meas_cmd == IDEL_MEASUREMENT)
  {
    if(Spcpwm[ChannelNum].pwm_count.meas_count++ > 100*freq_pori)   //没等待500ms
    {
      asm nop;
      Spcpwm[ChannelNum].pwm_count.meas_count = 0;
      Spcpwm[ChannelNum].meas_cmd = INITIAL_MEASUREMENT;      //等待初始化adc累加器并等待数据采集开始
    }
  }
  else if(Spcpwm[ChannelNum].meas_cmd == INITIAL_MEASUREMENT)    //如果要求数据采集
  {
    if(Spcpwm[ChannelNum].pwm_count.meas_count++ > 3*freq_pori)   //等待信号稳定
    {
      asm nop;
      Spcpwm[ChannelNum].pwm_count.meas_count = 0;
      Spcpwm[ChannelNum].meas_cmd = START_MEASUREMENT;      //等待初始化adc累加器并等待数据采集开始
    }
  }
  else if(Spcpwm[ChannelNum].meas_cmd == RUNING_MEASUREMENT)
  {
    if(ADC_busy[ChannelNum] == GETING_GFI_CURRENT)
    {
      if(Spcpwm[ChannelNum].pwm_count.meas_count++ > freq_pori)   //计数一个周期
      {
        asm nop;
        Spcpwm[ChannelNum].pwm_count.meas_count = 0;
        Spcpwm[ChannelNum].meas_cmd = FINISH_MEASUREMENT;
        SSRStatInMeas[ChannelNum] = Spcssr[ChannelNum].SSR_actual_stat;
      }
    }
    else
      Spcpwm[ChannelNum].meas_cmd = IDEL_MEASUREMENT;
  }
}
//==============================================================================
//get duty cycle
//input：duty index
//output：duty cycle
//==============================================================================
unsigned int get_duty_table(char index)
{
  volatile unsigned int dtemp;
  dtemp = duty_table[index];
  return dtemp;
}