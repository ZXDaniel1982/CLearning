#include "systemvalue.h"
#include "function.h"
#include "PIC18F6622.h"
#include "SpcValue.h"
#include "Menuoperation.h"
#include "M0220.h"
#include "SSR.h"
#include "String_op.h"
#include "Spcsystem.h"
#include "systemtest.h"

//#define ROLLDISPLAY_MULTIHEATERS 1
char Channel1_Str[5] = "CH1:";
char Channel2_Str[6] = " CH2:";

char blank[17] = "                ";

char ScanTimeEN=0;
//char AutoUserSwitch=1;

char AlarmEn=0;

char ActualAlarmNum=0;

char LostAlarmNum=0;

char AutoAuthoEN = 0;
unsigned char AutoAuthoCount=0;

#ifdef ROLLDISPLAY_MULTIHEATERS
char RollCharactBuff[41];
char RollCharactEN=0;
int RollCharactCount=0;
char RollCharactPointer=0;
#endif

//==============================================================================
//copy temperature
//input：temp source, temp target
//output：none
//==============================================================================
void CopyTemp(TEMPERATURE *tempsource, TEMPERATURE *temptarget)
{
  temptarget->Temperature_C = tempsource->Temperature_C;
  temptarget->Temperature_F = tempsource->Temperature_F;
}

//==============================================================================
//convert temperature
//input：pointer of temp
//output：none
//==============================================================================
int ConvertCtoF(int sourse)
{

  return (int)(32 + ((long)sourse * 18) / 10);
}

int ConvertFtoC(int sourse)
{
  return (int)(((long)(sourse - 32)*10) / 18);
}

void ConvertTemp(TEMPERATURE *temptocon)
{
  char units;
  units = pSPCValue[0].SPCSetPoints.system_valueb.bite.spc_units_c;

  if(units)
    //temptocon->Temperature_F = (int)(32 + ((long)temptocon->Temperature_C * 18) / 10);
    temptocon->Temperature_F = ConvertCtoF(temptocon->Temperature_C);
  else
    //temptocon->Temperature_C = (int)(((long)(temptocon->Temperature_F - 32)*10) / 18);
    temptocon->Temperature_C = ConvertFtoC(temptocon->Temperature_F);
}

//==============================================================================
//convert deadband between C and F
//input：pointer of temp
//output：none
//==============================================================================
void ConvertDead(TEMPERATURE *temptocon)
{
  char units;
  units = pSPCValue[0].SPCSetPoints.system_valueb.bite.spc_units_c;

  if(units)
  {
    temptocon->Temperature_F = (int)(temptocon->Temperature_C * 2);
    if(temptocon->Temperature_F > 10)
      temptocon->Temperature_F = 10;
    if(temptocon->Temperature_F < 1)
      temptocon->Temperature_F = 1;
  }
  else
  {
    temptocon->Temperature_C = (int)(temptocon->Temperature_F / 2);
    if(temptocon->Temperature_C > 5)
      temptocon->Temperature_C = 5;
    if(temptocon->Temperature_C < 1)
      temptocon->Temperature_C = 1;
  }
}

//==============================================================================
//copy password title
//input：pointer of string, password setting state
//output：none
//==============================================================================
void CopyPSWTitle(char *target, char adder)
{
  char i;
  for(i=0; i<16; i++)
    *(target+i) = PSWTitle[adder][i];
}

//==============================================================================
//string comparation
//input：pointer of soure, pointer of target
//output：0-strings not same, 1-strings are same
//==============================================================================
char StrCompar(char *resoure,char *target)
{
  char i=0;
  while(i<16)
  {
    if(*(resoure+i) == *(target+i)) i++;
    else return FALSE;
  }
  return TRUE;
}

//==============================================================================
//calculate temp by averaging
//input：pointer of soure, pointer of target
//output：0-strings not same, 1-strings are same
//==============================================================================
void tempaverage(TEMPERATURE *tempsource, TEMPERATURE *temptarget)
{
  TEMPERATURE *temp;
  temp = tempsource+1;
  temptarget->Temperature_C = (tempsource->Temperature_C
                              +temp->Temperature_C)/2;
  temptarget->Temperature_F = (tempsource->Temperature_F
                              +temp->Temperature_F)/2;
}

//==============================================================================
//alarm operation
//input：alarm command, 1-enable the alarm
//                      0-disable the alarm
//output：none
//==============================================================================
void AlarmLedOperation()
{
  if(ActualAlarmNum>0)
  {
    AlarmEn = 1;
  }
  else
  {
    if(spc_system_flag.bite.alarmssr_forceop == ALARMSSR_OK)
    {
      Alarm_SSR_off(0);
    }
    
    if(pSPCAlarm.spcalarms.num_alarms>0)
    {
      AlarmEn = 0;
      LED_ALARM = 1;
    }
    else
    {
      AlarmEn = 0;
      LED_ALARM = 0;
    }
  }
}

void alarmoperate(unsigned long alarmcommand, char active)
{
  char i,j; //flag指示抽取alarm的前部和后部
  int alarm_num_temp;
  unsigned long AlarmTypeBuff=0;
  char AlarmTypeCount=0;

  spc_system_flag.bite.stat_update = 1;
  if(active == ENALARM)
  {
    ActivedAlarms |= alarmcommand;

    if(pSPCAlarm.spcalarms.num_alarms == MAX_LOGS)
    {
      for(i=0;i<MAX_LOGS;i++)
      {
        AlarmTypeBuff = pSPCAlarm.spcalarms.alarm_typ[i];
        if(!(AlarmTypeBuff & (CH1_GFITRIP+CH2_GFITRIP+SELFCHECKFAILURE+AUTOTESTALARM)))
        {
          break;
        }
      }

      if(ActivedAlarms & AlarmTypeBuff)
      {
        for(j=0;j<MAX_LOGS;j++)
        {
          if(pSPCAlarm.spcalarms.alarm_typ[j] == AlarmTypeBuff)
            AlarmTypeCount++;
        }
        if(AlarmTypeCount == 1)
        {
          ActivedAlarms &= ~AlarmTypeBuff;
          ActualAlarmNum--;
        }
      }
    
      for(; i<MAX_LOGS-1; i++)
        pSPCAlarm.spcalarms.alarm_typ[i] = pSPCAlarm.spcalarms.alarm_typ[i+1];
        
      pSPCAlarm.spcalarms.alarm_typ[MAX_LOGS-1] = alarmcommand;
      ActualAlarmNum++;
      Alarm_SSR_on(0);
    }
    else
    {
      pSPCAlarm.spcalarms.alarm_typ[pSPCAlarm.spcalarms.num_alarms++] = alarmcommand;
      ActualAlarmNum++;
      Alarm_SSR_on(0);
      
      SystemUpdate |= ALARM_STAT_UPDATE_REQ;
      alarm_num_temp = pSPCAlarm.spcalarms.num_alarms;
      SetAlarmStr(Actural_disp_str[ACTURAL_ALARM], alarm_num_temp, NULL, UNIT_ALARM, 7, ALARM_INDEX);
    }
  }
  else if(active == DISALARM)
  {
    ActivedAlarms &= ~alarmcommand;
    ActualAlarmNum--;
  }
}

//==============================================================================
//copy strings
//input：pointer of source, point of target, length
//output：none
//==============================================================================
void CopyStr(char *resource, char *target, char len)
{
  char i;
  for(i=0; i<len; i++)
    *(target+i) = *(resource+i);
}

//==============================================================================
//en/dis scan time
//input：none
//output：none
//==============================================================================
void Scantime_EN()
{
  spc_count.scanT = 0;
  spc_system_flag.bite.scantime_en = SCANTIME_START;
}

void Scantime_DIS()
{
  spc_count.scanT = 0;
  spc_system_flag.bite.scantime_en = SCANTIME_IDLE;
}

//==============================================================================
//en/dis flashing
//input：none
//output：none
//==============================================================================
void Flashing_EN()
{
  spc_system_flag.bite.flashing_en = 1;
}

void Flashing_DIS()
{
  spc_system_flag.bite.flashing_en = 0;
  spc_system_flag.bite.flashing_reach = 0;
}

void Flashing()
{
  spc_system_flag.bite.flashing_state ^= 1;
  if(spc_system_flag.bite.flashing_state)
    LcdOut(2,Info_Line2);
  else
    LcdOut(2,blank);
}

//==============================================================================
//default display
//input：none
//output：none
//==============================================================================
void EnableRollInformation()
{
  RollCharactEN=1;
  RollCharactCount=0;
}

void DisableRollInformation()
{
  RollCharactEN=0;
  RollCharactCount=0;
}

#ifdef ROLLDISPLAY_MULTIHEATERS
void RollCharact()
{
  char temp;
  if(spc_system_flag.bite.default_diaped)
  {
    if((RollCharactEN == 0) && (pSPCValue[0].SPCSetPoints.system_valueb.bite.def_display != SYSTEM_STATUS_MOD))
    {
      RollCharactEN = 1;
      RollCharactCount = 0;
    }
  }
  else
  {
    RollCharactEN = 0;
    RollCharactCount = 0;
  }

  if(RollCharactEN == 2)
  {
    RollCharactEN = 1;
    if(RollCharactPointer <= 25)
    {
      CopyStr(RollCharactBuff+RollCharactPointer, Info_Line2, 16);
      RollCharactPointer++;
    }
    else if(RollCharactPointer <= 40)
    {
      temp = 41-RollCharactPointer;
      CopyStr(RollCharactBuff+RollCharactPointer, Info_Line2, temp);
      CopyStr(RollCharactBuff, Info_Line2+temp, RollCharactPointer-25);
      RollCharactPointer++;
    }
    else
    {
      RollCharactPointer = 0;
      CopyStr(RollCharactBuff+RollCharactPointer, Info_Line2, 16);
    }
    LCDUpdate();
  }
}
#endif

void SetDefaultInformation()
{
  char pointer=0;
  char i=0;
  
  for(i=0;i<4;i++)
    RollCharactBuff[pointer++] = Channel1_Str[i];
  
  pointer+=16;
  for(i=0;i<5;i++)
    RollCharactBuff[pointer++] = Channel2_Str[i];
    
  pointer = 4;

  if(pSPCValue[0].SPCSetPoints.system_valueb.bite.def_display == HEATER_TEMP_MOD)
  {
    if(pSPCValue[0].SPCSetPoints.MaintainTemp.Temperature_C == SPC_SYSTEMVALUE_OFF)
      getParaChar(RollCharactBuff+pointer, NONEVALUE_STR);
    else
      CopyStr(Actural_disp_str[CH1_ACTURAL_ALL],RollCharactBuff+pointer,16);
      
    pointer += 21;

    if(pSPCValue[1].SPCSetPoints.MaintainTemp.Temperature_C == SPC_SYSTEMVALUE_OFF)
      getParaChar(RollCharactBuff+pointer, NONEVALUE_STR);
    else
      CopyStr(Actural_disp_str[CH2_ACTURAL_ALL],RollCharactBuff+pointer,16);
  }
  else if(pSPCValue[0].SPCSetPoints.system_valueb.bite.def_display == HEATER_STATUS_MOD)
  {
    CopyStr(Actural_disp_str[CH1_ACTURAL_HEAT],RollCharactBuff+pointer,16);
    pointer += 21;
    CopyStr(Actural_disp_str[CH2_ACTURAL_HEAT],RollCharactBuff+pointer,16);
  }
}

void disp_default()
{
  char i;
  static char DisplayApp=0;
  
  if(GFITestCmd[0] || GFITestCmd[1])
    return;
  
  if(DisplayApp == 0)
  {
    if(spc_system_flag.bite.default_diaped == 1)
    {
      DisplayApp = 1;
      ChannelSelStat = CH_SEL_RESET;
    }
    else
    {
      DisplayApp = 0;
      return;
    }
  }
  else
  {
    if(spc_system_flag.bite.default_diaped == 0)
    {
      DisplayApp = 0;
    }
    return;
  }
  
  Menustat = 0;
  Alarmstat = 0;
  spc_system_flag.bite.alarm_actived = 0;
  reset_psw_en = 0;
  spc_system_flag.bite.char_actived = 0;
  Flashing_DIS();
  spc_system_flag.bite.char_flash = 0;
  DisablePSWInputing();
  Lcd_Cmd(_LCD_CURSOR_OFF);
  
  if(pSPCValue[0].SPCSetPoints.system_valueb.bite.def_display == HEATER_TEMP_MOD)
  {
    if(spc_system_flag.bite.stat_update)
    {
      spc_system_flag.bite.stat_update = 0;     
      getParaChar(Info_Line1, DEFAULT_HEATERTEMP_STR);
#ifdef ROLLDISPLAY_MULTIHEATERS
      ClearStr(RollCharactBuff,41);
      SetDefaultInformation();
#else
      if(pSPCValue[Cable_Channel].SPCSetPoints.MaintainTemp.Temperature_C == SPC_SYSTEMVALUE_OFF)
        getParaChar(Info_Line2, BLANK_STR);
      else
        CopyStr(Actural_disp_str[CH1_ACTURAL_ALL+Cable_Channel],Info_Line2,16);
#endif
      LCDUpdate();
    }
  }
  else if(pSPCValue[0].SPCSetPoints.system_valueb.bite.def_display == HEATER_STATUS_MOD)
  {
    if(spc_system_flag.bite.stat_update)
    {
      spc_system_flag.bite.stat_update = 0;     
      getParaChar(Info_Line1, DEFAULT_HEATERSTATUS_STR);
#ifdef ROLLDISPLAY_MULTIHEATERS
      ClearStr(RollCharactBuff,41);
      SetDefaultInformation();
      EnableRollInformation();
#else
      CopyStr(Actural_disp_str[CH1_ACTURAL_HEAT+Cable_Channel],Info_Line2,16);
#endif
      LCDUpdate();
    }
  }
  else
  {
    if(spc_system_flag.bite.stat_update)
    {
    
      spc_system_flag.bite.stat_update = 0;
      getParaChar(Info_Line1, DEFAULT_SYSTEMSTATUS_STR);
      SetAlarmStr(Info_Line2, pSPCAlarm.spcalarms.num_alarms, NULL, UNIT_ALARM, 7, ALARM_INDEX);
      LCDUpdate();
    }
  }
}

//==============================================================================
//update the lcd screen
//input：none
//output：none
//==============================================================================
void dispupdate()
{
  static char AlarmIndex=0, AlarmMax;
  volatile char Alarmtype;
  char temp;
  char bUpdate=0;
  unsigned long Length=0;
  volatile unsigned long LTemp;


  if(spc_system_flag.bite.alarm_actived)
    return;
  if(reset_psw_en)
    return;
  if(GFITestCmd[0] || GFITestCmd[1])
    return;

  if(spc_system_flag.bite.default_diaped == 1)
  {
    if(pSPCValue[0].SPCSetPoints.system_valueb.bite.def_display == HEATER_TEMP_MOD)
    {
      /*if(pSPCValue[Cable_Channel].SPCSetPoints.MaintainTemp.Temperature_C == SPC_SYSTEMVALUE_OFF)
        return;*/
        
      if(SystemUpdate & CH1_TEMP_UPDATE_REQ)
      {
#ifdef ROLLDISPLAY_MULTIHEATERS
        SetDefaultInformation();
#else
        CopyStr(Actural_disp_str[CH1_ACTURAL_ALL+Cable_Channel],Info_Line2,16);
#endif
        SystemUpdate &= ~CH1_TEMP_UPDATE_REQ;
        bUpdate = 1;
        //LCDUpdate();
      }
      
      if(SystemUpdate & CH2_TEMP_UPDATE_REQ)
      {
#ifdef ROLLDISPLAY_MULTIHEATERS
        SetDefaultInformation();
#else
        CopyStr(Actural_disp_str[CH1_ACTURAL_ALL+Cable_Channel],Info_Line2,16);
#endif
        SystemUpdate &= ~CH2_TEMP_UPDATE_REQ;
        bUpdate = 1;
      }
    }
    else if(pSPCValue[Cable_Channel].SPCSetPoints.system_valueb.bite.def_display == HEATER_STATUS_MOD)
    {
      if(SystemUpdate & CH1_HEAT_STAT_UPDATE_REQ)
      {
#ifdef ROLLDISPLAY_MULTIHEATERS
        SetDefaultInformation();
#else
        CopyStr(Actural_disp_str[CH1_ACTURAL_HEAT+Cable_Channel],Info_Line2,16);
#endif
        SystemUpdate &= ~CH1_HEAT_STAT_UPDATE_REQ;
        //LCDUpdate();
        bUpdate = 1;
      }
      
      if(SystemUpdate & CH2_HEAT_STAT_UPDATE_REQ)
      {
#ifdef ROLLDISPLAY_MULTIHEATERS
        SetDefaultInformation();
#else
        CopyStr(Actural_disp_str[CH1_ACTURAL_HEAT+Cable_Channel],Info_Line2,16);
#endif
        SystemUpdate &= ~CH2_HEAT_STAT_UPDATE_REQ;
        //LCDUpdate();
        bUpdate = 1;
      }
    }
    else
    {
      AlarmMax = pSPCAlarm.spcalarms.num_alarms;

      if(SystemUpdate & ALARM_STAT_UPDATE_REQ)
      {
        CopyStr(Actural_disp_str[ACTURAL_ALARM],Info_Line2,16);
        SystemUpdate &= ~ALARM_STAT_UPDATE_REQ;
        //LCDUpdate();
        bUpdate = 1;
      }
    }
    
    if(bUpdate)
      LCDUpdate();
    return;
  }
    
  if(SpcMenu[Menustat].index == MENU_IN_ACTUAL)
  {
    if(SpcMenu[Menustat].len & MULTI_CH_REQ)
    {
      Length =  SpcMenu[Menustat].len;
      LTemp = MULTI_CH_REQ;
      Length &= ~LTemp;
      Length <<= Cable_Channel;
      if(SystemUpdate & Length)
      {
        temp = SpcMenu[Menustat].offset+Cable_Channel;
        CopyStr(Actural_disp_str[temp],Info_Line2,16);
        SystemUpdate &= ~Length;
        Info_Line2[14] = 'C';
        Info_Line2[15] = Cable_Channel+0X31;
        LCDUpdate();
      }
    }
    else
    {
      if(SystemUpdate & SpcMenu[Menustat].len)
      {
        temp = SpcMenu[Menustat].offset;
        CopyStr(Actural_disp_str[temp],Info_Line2,16);
        SystemUpdate &= ~SpcMenu[Menustat].len;
        LCDUpdate();
      }
    }
  }
}

//==============================================================================
//update alarm information
//input：none
//output：none
//==============================================================================
void alarmdispupdate()
{
  if(spc_system_flag.bite.alarm_actived)
  {
    if(spc_system_flag.bite.alarm_displayed == 0)
    {
      if(SystemUpdate & ALARM_STAT_UPDATE_REQ)
      {
        CopyStr(Actural_disp_str[ACTURAL_ALARM],Info_Line1,16);
        SystemUpdate &= ~ALARM_STAT_UPDATE_REQ;
        LCDUpdate();
      }
    }
    
    if(SystemUpdate & ALARM_STAT_UPDATE_REQ)
    {
      if(spc_system_flag.bite.alarm_displayed)
      {
        SystemUpdate &= ~ALARM_STAT_UPDATE_REQ;
      }
      else
      {
        CopyStr(Actural_disp_str[ACTURAL_ALARM],Info_Line1,16);
        SystemUpdate &= ~ALARM_STAT_UPDATE_REQ;
        LCDUpdate();
      }
    }
  }
}

//==============================================================================
//show heater state
//input：none
//output：none
//==============================================================================
void SetHeatStatStr(char Strlocat, char ChannelNum)
{
  static char SSRLedStat[2] = {0};
  getParaChar(Actural_disp_str[CH1_ACTURAL_HEAT+ChannelNum], Strlocat);
  if((Strlocat == HEAT_IS_ON) || (Strlocat == HEAT_IS_MANON))
  {
    //LED_HEATER_ON = 1;
    SSRLedStat[ChannelNum] = 1;
  }
  else if((Strlocat == HEAT_IS_OFF) || (Strlocat == HEAT_IS_MANOFF))
  {
    //LED_HEATER_ON = 0;
    SSRLedStat[ChannelNum] = 0;
  }
  
  if((SSRLedStat[0]==0) && (SSRLedStat[1]==0))
    LED_HEATER_ON = 0;
  else
    LED_HEATER_ON = 1;
}

//==============================================================================
//show temp information
//input：pointer of temp, string location
//output：none
//==============================================================================
void SetTempStatStr(int *temp, char strlocat, char ChannelNum)
{
  char units, strbuf;
  char j=0,i;
  int buffer;
  int MaxTemp,MinTemp;

  units = pSPCValue[0].SPCSetPoints.system_valueb.bite.spc_units_c;
  strlocat += ChannelNum;

  if(units)
  {
    strbuf = 0x1a;
    MaxTemp = MAX_TEMP_C;
    MinTemp = MIN_TEMP_C;
  }
  else
  {
    strbuf = 0x1b;
    MaxTemp = MAX_TEMP_F;
    MinTemp = MIN_TEMP_F;
  }

  for(i=0; i<16; i++)
    Actural_disp_str[strlocat][i] = ' ';

  buffer = *temp;
  if(buffer == RTD_SHORT)
  {
    //getParaChar(Actural_disp_str[strlocat], RTD_SHORT_STR);                  
                    for(i=0; i<16; i++)
                    Actural_disp_str[strlocat][i] = ParaChar[RTD_SHORT_STR][i];

    return;
  }
  else if(buffer == RTD_OPNE)
  {
    //getParaChar(Actural_disp_str[strlocat], RTD_OPEN_STR);
                  for(i=0; i<16; i++)
                    Actural_disp_str[strlocat][i] = ParaChar[RTD_OPEN_STR][i];
    return;
  }
  else
  {
    if(buffer > MaxTemp)
      buffer = MaxTemp;
    if(buffer < MinTemp)
      buffer = MinTemp;
  }
  
  

  if(buffer < 0)
  {
    Actural_disp_str[strlocat][j++] = '-';
    buffer = -buffer;
  }

  if(buffer > 99)
  {
    Actural_disp_str[strlocat][j++] = buffer/100 +0x30;
    Actural_disp_str[strlocat][j++] = buffer%100/10 +0x30;
    Actural_disp_str[strlocat][j++] = buffer%10 +0x30;
  }
  else if(buffer > 9)
  {
    Actural_disp_str[strlocat][j++] = buffer/10 +0x30;
    Actural_disp_str[strlocat][j++] = buffer%10 +0x30;
  }
  else
    Actural_disp_str[strlocat][j++] = buffer +0x30;

    Actural_disp_str[strlocat][j++] = ' ';
    Actural_disp_str[strlocat][j++] = strbuf;
}

//==============================================================================
//show int data information
//input：pointer of data, string location , string about unit, length
//output：none
//==============================================================================
void SetIntStr(int *ptr, char strlocat, char unitlocar, char len)
{
  char j=0, i;
  volatile int temp;
  
  temp = *ptr;

  for(i=0; i<16; i++)
    Actural_disp_str[strlocat][i] = ' ';

  if(*ptr == OUTOFRANGE)
  {
                  for(i=0; i<16; i++)
                    Actural_disp_str[strlocat][i] = ParaChar[OUTOFRANGE_STR][i];
    return;
  }

  if(*ptr > 999)
  {
    Actural_disp_str[strlocat][j++] = *ptr/1000 +0x30;
    Actural_disp_str[strlocat][j++] = *ptr%1000/100 +0x30;
    Actural_disp_str[strlocat][j++] = *ptr%100/10 +0x30;
    Actural_disp_str[strlocat][j++] = *ptr%10 +0x30;
  }
  else if(*ptr > 99)
  {
    Actural_disp_str[strlocat][j++] = *ptr/100 +0x30;
    Actural_disp_str[strlocat][j++] = *ptr%100/10 +0x30;
    Actural_disp_str[strlocat][j++] = *ptr%10 +0x30;
  }
  else if(*ptr > 9)
  {
    Actural_disp_str[strlocat][j++] = *ptr/10 +0x30;
    Actural_disp_str[strlocat][j++] = *ptr%10 +0x30;
  }
  else
    Actural_disp_str[strlocat][j++] = *ptr +0x30;
    
  Actural_disp_str[strlocat][j++] = ' ';

  for(i=0;i<len;i++)
    Actural_disp_str[strlocat][j++] = SPCUnit[unitlocar][i];
}

//==============================================================================
//show current information
//input：pointer of current, string location ,string about unit, length
//output：none
//==============================================================================
void SetCurrentStr(int *ptr, char strlocat, char unitlocar, char len)
{
  char j=0, i;
  int value_H,value_L;

  for(i=0; i<16; i++)
    Actural_disp_str[strlocat][i] = ' ';

  if(*ptr == OUTOFRANGE)
  {
    //getParaChar(Actural_disp_str[strlocat], OUTOFRANGE_STR);
                  for(i=0; i<16; i++)
                    Actural_disp_str[strlocat][i] = ParaChar[OUTOFRANGE_STR][i];
    return;
  }

  value_H = *ptr/10;
  value_L = *ptr%10;

  if(value_H > 9)
  {
    Actural_disp_str[strlocat][j++] = value_H/10 +0x30;
    Actural_disp_str[strlocat][j++] = value_H%10 +0x30;
  }
  else
    Actural_disp_str[strlocat][j++] = value_H +0x30;

  Actural_disp_str[strlocat][j++] = '.';
  Actural_disp_str[strlocat][j++] = value_L +0x30;
  
  Actural_disp_str[strlocat][j++] = ' ';
  for(i=0;i<len;i++)
    Actural_disp_str[strlocat][j++] = SPCUnit[unitlocar][i];
}

//==============================================================================
//show cost information
//input：cost value, string location
//output：none
//==============================================================================
void SetCostStr(ULONG databuff, char strlocat)
{
  char j=0, i;
  ULONG value_H;
  int value_L;
  char Divider;

  for(i=0; i<16; i++)
    Actural_disp_str[strlocat][i] = ' ';

  if((databuff == OUTOFRANGE) || (databuff == COSTOUTOFRANGE))
  {
    //getParaChar(Actural_disp_str[strlocat], OUTOFRANGE_STR);
                  for(i=0; i<16; i++)
                    Actural_disp_str[strlocat][i] = ParaChar[OUTOFRANGE_STR][i];
    return;
  }
  
  if((strlocat == CH1_ACTURAL_COST) || (strlocat == CH2_ACTURAL_COST))
    Divider = 100;
  else
    Divider = 10;

  value_H = databuff/Divider;
  value_L = databuff%Divider;

  if((strlocat == CH1_ACTURAL_COST) || (strlocat == CH2_ACTURAL_COST))
    Actural_disp_str[strlocat][j++] = '$';

  for(i=0; i<8; i++)
  {
    if(value_H / Chr_str[i])
      break;
    else
      value_H %= Chr_str[i];

    if(i == 7)
      Actural_disp_str[strlocat][j++] = value_H + 0x30;
  }

  for(; i<8; i++)
  {
    Actural_disp_str[strlocat][j++] = value_H / Chr_str[i] + 0x30;
    value_H %= Chr_str[i];
  }
  
  Actural_disp_str[strlocat][j++] = '.';

  if((strlocat == CH1_ACTURAL_COST) || (strlocat == CH2_ACTURAL_COST))
  {
    Actural_disp_str[strlocat][j++] = value_L/10 +0x30;
    Actural_disp_str[strlocat][j++] = value_L%10 +0x30;
  }
  else
  {
    Actural_disp_str[strlocat][j++] = value_L +0x30;
    Actural_disp_str[strlocat][j++] = ' ';
    for(i=0;i<3;i++)
      Actural_disp_str[strlocat][j++] = SPCUnit[UNIT_ENEGRY][i];
  }
}

//==============================================================================
//show system on time information
//input：system on time value, string location
//output：none
//==============================================================================
void SetOntimeStr(ULONG databuff, char strlocat)
{
  char j=0, i;

  for(i=0; i<16; i++)
    Actural_disp_str[strlocat][i] = ' ';

  if(databuff == ONTIMEOUTOFRANGE)
  {
    //getParaChar(Actural_disp_str[strlocat], OUTOFRANGE_STR);
                  for(i=0; i<16; i++)
                    Actural_disp_str[strlocat][i] = ParaChar[OUTOFRANGE_STR][i];
    return;
  }

  for(i=0; i<8; i++)
  {
    if(databuff / Chr_str[i])
      break;
    else
      databuff %= Chr_str[i];

    if(i == 7)
      Actural_disp_str[strlocat][j++] = databuff + 0x30;
  }

  for(; i<8; i++)
  {
    Actural_disp_str[strlocat][j++] = databuff / Chr_str[i] + 0x30;
    databuff %= Chr_str[i];
  }

  Actural_disp_str[strlocat][j++] = ' ';
  for(i=0;i<5;i++)
    Actural_disp_str[strlocat][j++] = SPCUnit[UNIT_HOUR][i];
}

//==============================================================================
//show alarm information
//input：pointer of strings of alarms, number of alarms occured, index of alarm showed,
//       type of unit, length, command
//output：none
//==============================================================================
void SetAlarmStr(char *ptr, char datasouce, char datatotle,
                 char unitype, char len, char cmd)
{
  char i;
  
  ClearStr(ptr, 16);

  if(datasouce > 9)
  {
    *(ptr++) = datasouce/10 + 0x30;
    *(ptr++) = datasouce%10 + 0x30;
  }
  else
    *(ptr++) = datasouce + 0x30;
    
  *(ptr++) = '/';
    
  if(cmd == ALARM_SUBINDEX)
  {
    if(datatotle > 9)
    {
      *(ptr++) = datatotle/10 + 0x30;
      *(ptr++) = datatotle%10 + 0x30;
    }
    else
      *(ptr++) = datatotle + 0x30;
  }

  for(i=0;i<len;i++)
    *(ptr+i) = SPCUnit[unitype][i];
}

char GetAlarmEn()
{
  return AlarmEn;
}

void AutoAutho()
{
  if(pSPCValue[0].SPCSetPoints.system_valueb.bite.password_en)
  {
    if(AutoAuthoEN == 0)
    {
      AutoAuthoEN = 1;
      AutoAuthoCount = 0;
    }
    else if(AutoAuthoEN == 2)
    {
      AutoAuthoEN = 0;
      AutoAuthoCount = 0;
    }
  }
  else
  {
    AutoAuthoEN = 0;
    AutoAuthoCount = 0;
  }
}

void ResetAutoAutho()
{
  AutoAuthoCount = 0;
}

char GetAutoAutho()
{
  return AutoAuthoEN;
}

void SetAutoAutho(char AutoAuthoCmd)
{
  AutoAuthoEN = AutoAuthoCmd;
}