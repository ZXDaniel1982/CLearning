#include "systemvalue.h"
#include "PIC18F6622.h"
#include "Menuoperation.h"
#include "QT60.h"
#include "Spcsystem.h"
#include "M0220.h"
#include "MCP3202.h"
#include "SpcValue.h"
#include "function.h"
#include "String_op.h"
#include "Spcinitial.h"
#include "SSR.h"

#define PSWRESETSTEP1 0
#define PSWRESETSTEP2 1
#define PSWRESETSTEPNONE 2

unsigned int KeyDetectCount=0,KeyValidCount=0;
//char KeyHoldCount=0;
char KeyDetectStat=KEYDEACT;
char KeyValidEn=0,KeyHoldEn=0;
char KeyBusy=0;
ULONG KeyValueshape = 0;

const char AlarmFullStr[17] = "Out Of Memory   ";
char ResetPasswordStep = 0;
unsigned int ResetPasswordCount=0;

char ChannelSelStat=0;

//==============================================================================
//key detection
//input£ºnone
//output£ºkey value
//==============================================================================
ULONG keyboard_get_value()
{
  UINT32 Key_Input;
  UCHAR i;
  
  ReadQtKeys();
  Key_Input.word = 0;
  for(i=0; i<NUM_QT_KEY_BYTES; i++)
  {
    Key_Input.byte[i] = GetQtKeys(i);
  }
  
  return Key_Input.word;
}

char KeyVerify(unsigned long KeyBuff)
{
  static unsigned long KeyVerifyBUff=0;
  static char KeyVerifyStatus=0,KeyVerifyCount=0,KeyHoldCount=0;
  static unsigned int KeyHoldStepCount=0;
  static char KeyErrorCount=0;
  char ret=0;
  
  switch(KeyVerifyStatus)
  {
    case 0://idel
      if(KeyBuff != 0)
      {
        KeyVerifyBUff = KeyBuff;
        KeyVerifyStatus = 1;
        KeyVerifyCount = 0;
        KeyHoldCount = 0;
        KeyHoldEn = 0;
        KeyHoldStep = 1;
        KeyHoldStepCount = 0;
        ret=1;
      }
      else
        ret=0;
      break;
    case 1://first push
      if(KeyVerifyBUff == KeyBuff)
      {
        KeyVerifyCount++;
        if(KeyVerifyCount > 20)
        {
          KeyVerifyCount = 0;
          ret = 1;
          if((KeyBuff == KEY_VALUE_UP) || (KeyBuff == KEY_VALUE_DOWN))
          {
            KeyHoldCount++;
            if(KeyHoldCount > 5)
            {
              KeyVerifyStatus = 3;  //enable hold
            }
          }
        }
        else
        {
          ret = 0;
        }
        
        if(KeyErrorCount++ > 2000)
        {
          KeyErrorCount = 0;
          KeyVerifyStatus = 4;
        }
      }
      else
      {
        KeyVerifyCount = 0;
        KeyVerifyStatus = 2;  //enable quit touch
        ret = 0;
      }
      break;
    case 2://quit touch
      KeyVerifyCount++;
      if(KeyVerifyCount > 5)
      {
        KeyVerifyBUff = 0;
        KeyVerifyStatus = 0;   //back to idel
        KeyVerifyCount = 0;
        KeyHoldCount = 0;
        KeyHoldEn = 0;
        KeyHoldStep = 1;
        KeyHoldStepCount = 0;
        ret=0;
      }
      else
        ret = 0;
      break;
    case 3://hold
      if(KeyVerifyBUff == KeyBuff)
      {
        //ret = 1;
        //KeyHoldEn = 1;
        KeyVerifyCount++;
        if(KeyVerifyCount > 4)
        {
          KeyVerifyCount = 0;
          ret = 1;
          KeyHoldEn = 1;
        }
        else
        {
          ret = 0;
          KeyHoldEn = 0;
        }
        
        if(KeyErrorCount++ > 2000)
        {
          KeyErrorCount = 0;
          KeyVerifyStatus = 4;
        }
      }
      else
      {
        KeyVerifyBUff = 0;
        KeyVerifyStatus = 0;   //back to idel
        KeyVerifyCount = 0;
        KeyHoldCount = 0;
        KeyHoldEn = 0;
        KeyHoldStep = 1;
        KeyHoldStepCount = 0;
        ret=0;
      }
      break;
    case 4://error
      KeyErrorCount = 0;
      KeyVerifyBUff = 0;
      KeyVerifyStatus = 0;   //back to idel
      KeyVerifyCount = 0;
      KeyHoldCount = 0;
      KeyHoldEn = 0;
      KeyHoldStep = 1;
      KeyHoldStepCount = 0;
      ret=0;
      QT60Initial();
      ReadQtSetup();
      break;
  }

  if(KeyHoldEn)
  {
    KeyHoldEn = 0;
    /*if(KeyHoldStepCount > 15)
    {
      KeyHoldStep = 100;
    }
    else*/
    if(KeyHoldStepCount > 5)
    {
      KeyHoldStepCount++;
      KeyHoldStep = 10;
    }
    else
    {
      KeyHoldStepCount++;
      KeyHoldStep = 1;
    }
  }

  return ret;
}

void ErrorCheck(unsigned long KeyBuff)
{
  //unsigned long KeyTempBuff;
  static char ErrorDectect=0,ErrorDectectCount=0;
  if(ErrorDectect)
  {
    if(KeyBuff == 0)
    {
      ErrorDectect = 0;
      ErrorDectectCount++;
    }
    else
    {
      ErrorDectect = 0;
      ErrorDectectCount = 0;
    }
  }
  else
  {
    if(KeyBuff != 0)
    {
      ErrorDectect = 1;
      ErrorDectectCount++;
    }
    else
    {
      ErrorDectectCount = 0;
    }
  }
  
  if(ErrorDectectCount >= 8)
  {
    ErrorDectectCount = 0;
    ErrorDectect = 0;
    QT60Reset();
    //QT60Initial();
    //ReadQtSetup();
  }
}

void EnableTimeout()
{
  spc_system_flag.bite.default_diaped = 0;
  spc_count.Timeout_count = 0;
}
//==============================================================================
//menu operation
//input£ºnone
//output£ºnone
//==============================================================================
char ResetPSWSeq(char ResetStep)
{
  if(reset_psw_en)
  {
    ResetPasswordStep = 0;
    ResetPasswordCount = 0;
    return 0;
  }
  else
  {
    if(ResetStep == PSWRESETSTEP1)
    {
      if((ResetPasswordStep == 0)|| (ResetPasswordStep == 1))
      {
        ResetPasswordStep++;
        ResetPasswordCount = 0;
      }
      else
      {
        ResetPasswordStep = 0;
        ResetPasswordCount = 0;
      }
      return 0;
    }
    else if(ResetStep == PSWRESETSTEP2)
    {
      if(ResetPasswordStep == 2)
      {
        ResetPasswordStep++;
        ResetPasswordCount = 0;
        return 0;
      }
      else if(ResetPasswordStep == 3)
      {
        ResetPasswordStep = 0;
        ResetPasswordCount = 0;
        return 1;
      }
      else
      {
        ResetPasswordStep = 0;
        ResetPasswordCount = 0;
        return 0;
      }
    }
    else
    {
      ResetPasswordStep = 0;
      ResetPasswordCount = 0;
      return 0;
    }
  }
}

void SPCMenuOperation()
{
  ULONG KeyValue=0;
  char bUpdate=0;
  //static char ChannelSelStat=0;

  KeyValue = keyboard_get_value();
  KeyValue &= 0x000001ff;
  
  bUpdate = KeyVerify(KeyValue);
  ErrorCheck(KeyValue);

  if(bUpdate)
  {
    switch(KeyValue)
    {
    case KEY_VALUE_UP:    //up key
      //ResetPSWSeq(PSWRESETSTEP1);
      ResetAutoAutho();
      if(spc_system_flag.bite.default_diaped == 1)
      {
        ResetPSWSeq(PSWRESETSTEP1);
        Reset_PSW(CMD_FORWARD,CMD_ADJUST);
        return;
      }

      EnableTimeout();

      if(reset_psw_en)
        Reset_PSW(CMD_FORWARD,CMD_ADJUST);          //reset password
      else if(ChannelSelStat != CH_SEL_RESET)
        ChannelConfig(CMD_FORWARD,CMD_ADJUST);
      else if(!(spc_system_flag.bite.alarm_actived))
      {
        set_menu_info(CMD_FORWARD,CMD_ADJUST);       //for normal navigation
        if(spc_system_flag.bite.flashing_en)
        {
          if(spc_system_flag.bite.flashing_state)
            spc_count.scanT = 0;
        }
      }

      LCDUpdate();
      break;
    case KEY_VALUE_DOWN:
      //ResetPSWSeq(PSWRESETSTEPNONE);
      ResetAutoAutho();
      if(spc_system_flag.bite.default_diaped == 1)
      {
        ResetPSWSeq(PSWRESETSTEPNONE);
        Reset_PSW(CMD_BACKWARD,CMD_ADJUST);
        return;
      }

      EnableTimeout();

      if(reset_psw_en)
        Reset_PSW(CMD_BACKWARD,CMD_ADJUST);                 //reset password
      else if(ChannelSelStat != CH_SEL_RESET)
        ChannelConfig(CMD_BACKWARD,CMD_ADJUST);
      else if(!(spc_system_flag.bite.alarm_actived))
      {
        set_menu_info(CMD_BACKWARD,CMD_ADJUST);             //for normal navigation
        if(spc_system_flag.bite.flashing_en)
        {
          if(spc_system_flag.bite.flashing_state)
            spc_count.scanT = 0;
        }
      }

      LCDUpdate();
      break;
    case KEY_VALUE_LEFT:
      ResetPSWSeq(PSWRESETSTEPNONE);
      ResetAutoAutho();
      if(spc_system_flag.bite.default_diaped == 1)
        return;
      EnableTimeout();

      Scantime_DIS();
      Flashing_DIS();

      if(spc_system_flag.bite.alarm_actived)
        AlarmRoll(CMD_BACKWARD,ALARM_SUBINDEX);        //for alarm navigation
      else if(spc_system_flag.bite.char_actived)
        set_menu_info(CMD_BACKWARD,CMD_SWITCH);        //for normal navigation
      else if(reset_psw_en)
        Reset_PSW(NULL,CMD_SWITCH);                    //reset password
      else if(ChannelSelStat != CH_SEL_RESET)
      {
        if(ChannelSelStat == CH_SEL_ACTUAL)
          MenuRoll(CMD_FORWARD,MENU_IN_ACTUAL,INDEX);
        else if(ChannelSelStat == CH_SEL_PROG)
          MenuRoll(CMD_FORWARD,MENU_IN_PROGRAM,INDEX);

        ChannelSelStat = CH_SEL_RESET;
      }
      else
        MenuRoll(CMD_BACKWARD,NULL,THIRDINDEX);

      LCDUpdate();
      break;
    case KEY_VALUE_RIGHT:
      ResetPSWSeq(PSWRESETSTEPNONE);
      ResetAutoAutho();
      if(spc_system_flag.bite.default_diaped == 1)
        return;
      if(ChannelSelStat != CH_SEL_RESET)
      {
        if(ChannelSelStat == CH_SEL_ACTUAL)
          MenuRoll(CMD_FORWARD,MENU_IN_ACTUAL,INDEX);
        else if(ChannelSelStat == CH_SEL_PROG)
          MenuRoll(CMD_FORWARD,MENU_IN_PROGRAM,INDEX);
          
        ChannelSelStat = CH_SEL_RESET;
      }
      else
      {
        rightkey_func();
      }
      EnableTimeout();
      break;
    case KEY_VALUE_ACTUAL:
      ResetPSWSeq(PSWRESETSTEPNONE);
      ResetAutoAutho();
      Alarmstat = 0;                                     //quit alarm display
      spc_system_flag.bite.char_actived = 0;             //quit ID or Password setting
      reset_psw_en = 0;                                  //quit reset password
      spc_system_flag.bite.char_flash = 0;               //stop flashing
      Lcd_Cmd(_LCD_CURSOR_OFF);
      Scantime_DIS();
      Flashing_DIS();
      if(ChannelSelStat!=CH_SEL_ACTUAL)
      {
        ChannelSelStat = CH_SEL_ACTUAL;
        ChannelConfig(CMD_FORWARD,CMD_RESET);
      }
      else
        MenuRoll(CMD_FORWARD,MENU_IN_ACTUAL,INDEX);         //for normal navigation
      LCDUpdate();
      EnableTimeout();
      break;
    case KEY_VALUE_PROGRAM:
      ResetPSWSeq(PSWRESETSTEPNONE);
      ResetAutoAutho();
      EnableTimeout();
      Alarmstat = 0;                                       //quit alarm display
      spc_system_flag.bite.alarm_actived = 0;
      spc_system_flag.bite.char_actived = 0;
      spc_system_flag.bite.char_flash = 0;
      reset_psw_en = 0;                                    //quit reset password
      Lcd_Cmd(_LCD_CURSOR_OFF);
      Flashing_DIS();
      Scantime_DIS();
      if(ChannelSelStat!=CH_SEL_PROG)
      {
        ChannelSelStat = CH_SEL_PROG;
        ChannelConfig(CMD_FORWARD,CMD_RESET);
      }
      else
        MenuRoll(CMD_FORWARD,MENU_IN_PROGRAM,INDEX);          //for normal navigation
      LCDUpdate();
      break;
    case KEY_VALUE_ALARM:
      ResetPSWSeq(PSWRESETSTEPNONE);
      ResetAutoAutho();
      EnableTimeout();
      Menustat = 0;                                         //quit normal display
      spc_system_flag.bite.char_actived = 0;
      spc_system_flag.bite.char_flash = 0;
      reset_psw_en = 0;                                     //quit reset password
      //Usr_Psw_en = 0;
      Lcd_Cmd(_LCD_CURSOR_OFF);
      Flashing_DIS();
      Scantime_DIS();
      ChannelSelStat = CH_SEL_RESET;
      AlarmRoll(CMD_FORWARD,ALARM_INDEX);                   //for alarm navigation
      LCDUpdate();
      break;
    case KEY_VALUE_RESET:
      ResetPSWSeq(PSWRESETSTEPNONE);
      ResetAutoAutho();
      if(spc_system_flag.bite.default_diaped == 1)
      {
        return;
      }

      EnableTimeout();

      Flashing_DIS();
      if(spc_system_flag.bite.alarm_actived)
        AlarmRoll(NULL,CMD_RESET);                          //for alarm navigation
      else if(reset_psw_en)
        Reset_PSW(NULL,CMD_RESET);                          //for reset password
      else if(ChannelSelStat != CH_SEL_RESET)
        ChannelConfig(CMD_FORWARD,CMD_RESET);
      else
        set_menu_info(NULL,CMD_RESET);                      //for normal navigation
      LCDUpdate();
      break;
    case KEY_VALUE_ENTER:
      ResetAutoAutho();
      if(ResetPSWSeq(PSWRESETSTEP2))
      {
        reset_psw_en = 1;
        Reset_PSW(NULL,CMD_INIT);
        LCDUpdate();
        return;
      }

      if(spc_system_flag.bite.default_diaped == 1)
      {
        Reset_PSW(NULL,CMD_ENTER);
        return;
      }

      if(spc_system_flag.bite.alarm_actived)
        return;
      EnableTimeout();

      if(reset_psw_en)
        Reset_PSW(NULL,CMD_ENTER);                          //for reset password
      else if(ChannelSelStat != CH_SEL_RESET)
        ChannelConfig(CMD_FORWARD,CMD_ENTER);
      else
      {
        set_menu_info(NULL,CMD_ENTER);                      //for normal navigation
      }
      Flashing_DIS();
      LCDUpdate();
      break;
    case KEY_CLEAR:
      if(spc_system_flag.bite.default_diaped == 1)
        return;

      KeyValueshape = 0;
      break;
    }

  }

  asm nop;
}

//==============================================================================
//normal navigation
//input£ºincrease/decrease£¬menu index£¬switch in Index/SubIndex/ThirdIndex
//output£ºnone
//==============================================================================
void MenuRoll(UCHAR Forward,UCHAR Para,UCHAR Level)
{
  UCHAR mainloop = 1;
  volatile UCHAR Index_temp,SubIndex_temp,ThirdIndex_temp;
  UCHAR Index_real,SubIndex_real,ThirdIndex_real;
  
  spc_system_flag.bite.char_flash = 0;

  Index_temp = SpcMenu[Menustat].index;
  SubIndex_temp = SpcMenu[Menustat].subindex;
  ThirdIndex_temp = SpcMenu[Menustat].thirdindex;
  
  if(spc_system_flag.bite.default_diaped)
  {
    spc_system_flag.bite.default_diaped = 0;
    if(Para == MENU_IN_ACTUAL)
    {
      Menustat = 0;
      mainloop = 0;
    }
  }
  else if(spc_system_flag.bite.alarm_actived)
    spc_system_flag.bite.alarm_actived = 0;
  else if((Level == INDEX) && (Para == SpcMenu[Menustat].index))
    Level = SUBINDEX;
  
  while(mainloop)
  {
    if(Forward)
    {
      Menustat++;
      Menustat = (Menustat%MAX_MENU_NUM);
    }
    else
    {
      if(Menustat == 0)
        Menustat = MAX_MENU_NUM-1;
      else
        Menustat--;
    }

    Index_real = SpcMenu[Menustat].index;
    SubIndex_real = SpcMenu[Menustat].subindex;
    ThirdIndex_real = SpcMenu[Menustat].thirdindex;
  
    if(Level == INDEX)
    {
      if((Para == Index_real) && (SubIndex_real == 0) && (ThirdIndex_real == 0))
        mainloop = 0;
      else
        mainloop = 1;
    }
    else if(Level == SUBINDEX)
    {
      if(Index_temp == Index_real)
      {
        if(ThirdIndex_real == 0)
          mainloop = 0;
        else
          mainloop = 1;
      }
      else
        mainloop = 1;
    }
    else if(Level == THIRDINDEX)
    {
      if(Index_temp == Index_real)
      {
        if(ThirdIndex_temp == ThirdIndex_real)
          mainloop = 1;
        if((ThirdIndex_real == 0) && (Forward == 0))
          mainloop = 1;
        else
          mainloop = 0;
      }
      else
        mainloop = 1;
    }
    
    if(SpcMenu[Menustat].flag.bite.menu_active)
      mainloop |= 0;
    else
      mainloop = 1;
    
    if(MainTainTempDisable(Cable_Channel) == 1)          //None
    {
      if(SpcMenu[Menustat].flag.bite.maintainnone_conflict)
        mainloop = 1;
      else
        mainloop |= 0;
    }
    
    if(MainTainTempDisable(Cable_Channel) == 2)          //Off
    {
      if(SpcMenu[Menustat].flag.bite.maintainoff_conflict)
        mainloop = 1;
      else
        mainloop |= 0;
    }
    
    if(ProCtlEnable(Cable_Channel))
    {
      if(SpcMenu[Menustat].flag.bite.proportional_conflict)
        mainloop = 1;
      else
        mainloop |= 0;
    }
    
    if(pSPCValue[0].SPCSetPoints.system_valueb.bite.usr_advanced == 0)
    {
      if(SpcMenu[Menustat].flag.bite.advanced_req)
        mainloop = 1;
      else
        mainloop |= 0;
    }
    
    if(SelfRegulaEnable(Cable_Channel))
    {
      if(SpcMenu[Menustat].flag.bite.SelfRegula_conflict)
        mainloop = 1;
      else
        mainloop |= 0;
    }
    else
    {
      if(SpcMenu[Menustat].flag.bite.FoxResis_conflict)
        mainloop = 1;
      else
        mainloop |= 0;
    }
  }
  
  set_menu_info(Forward,CMD_RESET);
}

//==============================================================================
//set menu information
//input£ºincrease/decrease, command
//output£ºnone
//==============================================================================
void set_menu_info(UCHAR direction,UCHAR command)
{
  char i;
  char temp;
  for(i=0; i<16; i++)
    Info_Line1[i] = SpcTxtLine1[Menustat][i];
    
  temp = SpcMenu[Menustat].func_mark;
    
  switch(temp)
  {
    case FUNC_TITLE:
      TitleSet(direction,command);
      break;
    case FUNC_CHANNEL:
      ChannelConfig(direction,command);
      break;
    case FUNC_MAINT:
      MaintainTempSet(direction,command);
      break;
    case FUNC_LOWTEMP:
      LowTempAlarmSet(direction,command);
      break;
    case FUNC_HIGHTEMP:
      HighTempAlarmSet(direction,command);
      break;
    case FUNC_DEADBAND:
      DeadbandSet(direction,command);
      break;
    case FUNC_HEATID:
      HeaterIDSet(direction,command);
      break;
    case FUNC_CHANGEPWD:
      PasswordEidtorSet(direction,command);
      break;
    case FUNC_RESET_MODULE:
    case FUNC_RESET:
      ResetSPCSet(direction,command);
      break;
    case FUNC_FLAGSET:            //Para_Flag_Set_Show
      Para_Flag_Set(direction,command);
      break;
    case FUNC_INTSET:             //Para_int_Set
      Para_int_Set(direction,command);
      break;
    case FUNC_SHOW:
      Para_show(direction,command);
      break;
    case FUNC_AUTHO:             //change users
      Authority_Set(direction,command);
      break;
    case FUNC_VERSION:
      Version_show(direction,command);
      break;
  }
     
   asm nop;
}

//==============================================================================
//alarm index navigation
//input£ºswitch command between alarm/log
//output£ºnone
//==============================================================================
void AlarmRoll_Index(char trige)
{
  UCHAR index,i;
  char ALARM_NUM, ALARM_UNIT;

  if(spc_system_flag.bite.alarm_actived)
  {
  //show alarm or logs
    if(trige)
      spc_system_flag.bite.alarm_displayed ^= TRUE;
      
    index = spc_system_flag.bite.alarm_displayed;
    if(index) 
    {
      ALARM_NUM = pSPCAlarm.spclogs.num_logs;
      ALARM_UNIT = UNIT_LOG;
      
      if(ALARM_NUM >= MAX_LOGS)
      {
        for(i=0;i<16;i++)
          Info_Line1[i] = AlarmFullStr[i];
        ClearStr(Info_Line2, 16);

        LCDUpdate();
        Delay_ms(1000);
      }
    }
    else  
    { 
      ALARM_NUM = pSPCAlarm.spcalarms.num_alarms;
      ALARM_UNIT = UNIT_ALARM;
      
      if(ALARM_NUM >= MAX_LOGS)
      {
        for(i=0;i<16;i++)
          Info_Line1[i] = AlarmFullStr[i];
        ClearStr(Info_Line2, 16);

        LCDUpdate();
        Delay_ms(1000);
      }
    }

    SetAlarmStr(Info_Line1, ALARM_NUM, NULL, ALARM_UNIT, 7, ALARM_INDEX);
    ClearStr(Info_Line2, 16);
  }
  else
  {
  //enter alarm/log display mod
    spc_system_flag.bite.alarm_actived = 1;
    spc_system_flag.bite.alarm_displayed = 0;
    ALARM_NUM = pSPCAlarm.spcalarms.num_alarms;
    ALARM_UNIT = UNIT_ALARM;
    
    if(ALARM_NUM >= MAX_LOGS)
    {
      for(i=0;i<16;i++)
        Info_Line1[i] = AlarmFullStr[i];
      ClearStr(Info_Line2, 16);

      LCDUpdate();
      Delay_ms(1000);
    }
    
    SetAlarmStr(Info_Line1, ALARM_NUM, NULL, ALARM_UNIT, 7, ALARM_INDEX);
    ClearStr(Info_Line2, 16);
  }
  Alarmstat = 0;
  return;
}

//==============================================================================
//alarm navigation
//input£ºincrease/decrease, command
//output£ºnone
//==============================================================================
void AlarmRoll(UINT Forward,UINT Alarmcmd)
{
  UCHAR index,i=0;
  char  ALARM_NUM, ALARM_UNIT;
  char AlarmTypeCount=0;
  unsigned long AlarmTypeBuff=0;

    if(Alarmcmd == ALARM_INDEX)
    {
      AlarmRoll_Index(1);
      return;
    }
    else if(Alarmcmd == CMD_RESET)
    {
      if(Alarmstat == 0)
      {
        Alarm_SSR_off(0);
        return;
      }

      if(spc_system_flag.bite.alarm_displayed)  //showing log information
      {
        if(pSPCValue[0].SPCSetPoints.system_valueb.bite.password_en==0)
          return;
      
        if(pSPCAlarm.spclogs.num_logs > 1)
        {
          AlarmTypeBuff = pSPCAlarm.spclogs.log_typ[Alarmstat-1];
          for(i=Alarmstat; i<pSPCAlarm.spclogs.num_logs; i++)
            pSPCAlarm.spclogs.log_typ[i-1] = pSPCAlarm.spclogs.log_typ[i];
            
          pSPCAlarm.spclogs.num_logs--;
            
          if(Alarmstat == (pSPCAlarm.spclogs.num_logs+1))
            Alarmstat = 1;
        }
        else if(pSPCAlarm.spclogs.num_logs == 1)
        {
          AlarmTypeBuff = pSPCAlarm.spclogs.log_typ[Alarmstat-1];
          pSPCAlarm.spclogs.num_logs = 0;
          Alarmstat = 0;
          AlarmRoll_Index(0);

          return;
        }
        else
          return;
      }
      else   //showing alarm information
      {
        if(pSPCAlarm.spcalarms.num_alarms > 1)
        {
          AlarmTypeBuff = pSPCAlarm.spcalarms.alarm_typ[Alarmstat-1];
          for(i=Alarmstat-1;i<pSPCAlarm.spcalarms.num_alarms;i++)
          {
            if(pSPCAlarm.spcalarms.alarm_typ[i] == AlarmTypeBuff)
              AlarmTypeCount++;
          }
          if(AlarmTypeCount == 1)
          {
            switch(AlarmTypeBuff)
            {
              asm nop;
              case CH1_GFITRIP:
                ForceSSROFFCondition[0] &= ~GFITRIPFORCEOFF;
                alarmoperate(AlarmTypeBuff,DISALARM);
                break;
              case CH2_GFITRIP:
                ForceSSROFFCondition[1] &= ~GFITRIPFORCEOFF;
              case SELFCHECKFAILURE:
              case AUTOTESTALARM:
              case CH1_GFITESTFAIL:
              case CH2_GFITESTFAIL:
                alarmoperate(AlarmTypeBuff,DISALARM);
                break;
              default:
                if(ActivedAlarms & AlarmTypeBuff)
                  return;
                break;
            }
          }

          for(i=Alarmstat; i<pSPCAlarm.spcalarms.num_alarms; i++)
            pSPCAlarm.spcalarms.alarm_typ[i-1] = pSPCAlarm.spcalarms.alarm_typ[i];

          pSPCAlarm.spcalarms.num_alarms--;
          if(Alarmstat == (pSPCAlarm.spcalarms.num_alarms+1))
            Alarmstat = 1;

          if(pSPCAlarm.spclogs.num_logs == MAX_LOGS)
          {
            for(i=0; i<MAX_LOGS-1; i++)
              pSPCAlarm.spclogs.log_typ[i] = pSPCAlarm.spclogs.log_typ[i+1];

            pSPCAlarm.spclogs.log_typ[MAX_LOGS-1] = AlarmTypeBuff;
          }
          else
          {
            pSPCAlarm.spclogs.log_typ[pSPCAlarm.spclogs.num_logs++] = AlarmTypeBuff;
          }
        }
        else if(pSPCAlarm.spcalarms.num_alarms == 1)
        {
          AlarmTypeBuff = pSPCAlarm.spcalarms.alarm_typ[Alarmstat-1];
          switch(AlarmTypeBuff)
          {
            case CH1_GFITRIP:
                ForceSSROFFCondition[0] &= ~GFITRIPFORCEOFF;
                alarmoperate(AlarmTypeBuff,DISALARM);
                break;
            case CH2_GFITRIP:
                ForceSSROFFCondition[1] &= ~GFITRIPFORCEOFF;
            case SELFCHECKFAILURE:
            case AUTOTESTALARM:
            case CH1_GFITESTFAIL:
            case CH2_GFITESTFAIL:
                alarmoperate(AlarmTypeBuff,DISALARM);
                break;
            default:
                if(ActivedAlarms & AlarmTypeBuff)
                  return;
                break;
          }

          pSPCAlarm.spcalarms.num_alarms = 0;
          Alarmstat = 0;

          AlarmRoll_Index(0);

          if(pSPCAlarm.spclogs.num_logs == MAX_LOGS)
          {
            for(i=0; i<MAX_LOGS-1; i++)
              pSPCAlarm.spclogs.log_typ[i] = pSPCAlarm.spclogs.log_typ[i+1];

            pSPCAlarm.spclogs.log_typ[MAX_LOGS-1] = AlarmTypeBuff;
          }
          else
          {
            pSPCAlarm.spclogs.log_typ[pSPCAlarm.spclogs.num_logs++] = AlarmTypeBuff;
          }
          return;
        }
        else
          return;
      }
    }
    else
    {//right key
      index = spc_system_flag.bite.alarm_displayed;
      if(index) 
      {
        ALARM_NUM = pSPCAlarm.spclogs.num_logs;
        ALARM_UNIT = UNIT_LOG;
      }
      else
      {
        ALARM_NUM = pSPCAlarm.spcalarms.num_alarms;
        ALARM_UNIT = UNIT_ALARM;
      }

      if(ALARM_NUM == 0)
      {
        SetAlarmStr(Info_Line1, ALARM_NUM, NULL, ALARM_UNIT, 7, ALARM_INDEX);
        ClearStr(Info_Line2, 16);
        return;
      }

      if(Forward)
      {
        if((Alarmstat >= ALARM_NUM) || (Alarmstat >= MAX_LOGS))
          Alarmstat = 1;
        else
          Alarmstat++;
      }
      else
      {
        if(Alarmstat <= 1)
          Alarmstat = ALARM_NUM;
        else
          Alarmstat--;
      }
    }
    set_alarm_info(Alarmstat);
}

//==============================================================================
//set alarm information
//input£ºalarm or logs
//output£ºnone
//==============================================================================
void set_alarm_info(UCHAR AlarmIndex)
{
  UCHAR index;
  volatile UINT Alarmtype=0;
  char  ALARM_NUM, ALARM_UNIT;
  
  index = spc_system_flag.bite.alarm_displayed;
  
  if(index)
  {
    ALARM_NUM = pSPCAlarm.spclogs.num_logs;
    ALARM_UNIT = UNIT_LOG;
  }
  else
  {
    ALARM_NUM = pSPCAlarm.spcalarms.num_alarms;
    ALARM_UNIT = UNIT_ALARM;
  }
  
  SetAlarmStr(Info_Line1, AlarmIndex, ALARM_NUM, ALARM_UNIT, 7, ALARM_SUBINDEX);
  Alarmtype = GetAlarmType(AlarmIndex-1,index);
  getParaChar(Info_Line2, Alarmtype+43);
}

//==============================================================================
//get alarm type
//input£ºtype code, alarm or logs
//output£ºnone
//==============================================================================
UINT GetAlarmType(UCHAR index, char cmd)
{
  char index_bit=0;
  UINT count=0;
  while(count < 32)
  {
    if(cmd)
      index_bit = (pSPCAlarm.spclogs.log_typ[index] >> count) & 0x01;
    else
      index_bit = (pSPCAlarm.spcalarms.alarm_typ[index] >> count) & 0x01;
      
    if(index_bit)
      return count;
    else
      count++;
  }
}

//==============================================================================
//update lcd screen
//input£ºnone
//output£ºnone
//==============================================================================
void LCDUpdate()
{
  LCD_output(Info_Line1,Info_Line2);
}

//==============================================================================
//right key function
//input£ºnone
//output£ºnone
//==============================================================================
void rightkey_func()
{
  Scantime_DIS();
  Flashing_DIS();

  if(spc_system_flag.bite.alarm_actived)
    AlarmRoll(CMD_FORWARD,ALARM_SUBINDEX);
  else if(spc_system_flag.bite.char_actived)
    set_menu_info(CMD_FORWARD,CMD_SWITCH);
  else if(reset_psw_en)
    Reset_PSW(CMD_FORWARD,CMD_SWITCH);
  else
  {
    MenuRoll(CMD_FORWARD,NULL,THIRDINDEX);
  }

  LCDUpdate();
}