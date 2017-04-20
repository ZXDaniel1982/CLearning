#include "systemvalue.h"
#include "PIC18F6622.h"
#include "Menuoperation.h"
#include "QT60.h"
#include "Spcsystem.h"
#include "M0220.h"
#include "SpcValue.h"

//==============================================================================
//按键输入检测
//输入：无
//输出：按键状态值
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

//==============================================================================
//按键操作函数
//输入：无
//输出：无
//==============================================================================
void SPCMenuOperation()
{
  ULONG KeyValue;
  UCHAR KeyID;

  KeyValue = keyboard_get_value();

/*//测试直接法
  switch(SPCIndex)
  {
    case ActualValues:
      switch()
      break;
  }*/
  


  switch(KeyValue)
  {
    case KEY_VALUE_UP:
      KeyID = KEY_ID_UP;
      ValueRoll(KeyID);
      break;
    case KEY_VALUE_DOWN:
      KeyID = KEY_ID_DOWN;
      ValueRoll(KeyID);
      break;
    case KEY_VALUE_LEFT:
      KeyID = KEY_ID_LEFT;
      if(spc_system_flag.bite.alarm_actived)
        AlarmRoll(ALARM_SUBINDEX,0);
      else
        MenuRoll(0,KeyID,UPDATE_THIRDINDEX);
      break;
    case KEY_VALUE_RIGHT:
      KeyID = KEY_ID_RIGHT;
      if(spc_system_flag.bite.alarm_actived)
        AlarmRoll(ALARM_SUBINDEX,1);
      else
        MenuRoll(1,KeyID,UPDATE_THIRDINDEX);
      break;
    case KEY_VALUE_ACTUAL:
      KeyID = KEY_ID_ACTUAL;
      spc_system_flag.bite.alarm_actived = 0;
      #ifdef testpart
      MenuRoll(1,0,INDEX);
      #else
      MenuRoll(1,KeyID,INDEX);
      #endif
      break;
    case KEY_VALUE_PROGRAM:
      KeyID = KEY_ID_PROGRAM;
      spc_system_flag.bite.alarm_actived = 0;
      MenuRoll(1,1,INDEX);
      break;
    case KEY_VALUE_ALARM:
      KeyID = KEY_ID_ALARM;
      AlarmRoll(ALARM_INDEX,1);
      break;
    case KEY_VALUE_RESET:
      KeyID = KEY_ID_RESET;
      break;
    case KEY_VALUE_ENTER:
      KeyID = KEY_ID_ENTER;
      break;
  }

  LCDUpdate();
}

//==============================================================================
//更新非ALARM菜单
//输入：递增/减指令，当前菜单LEVEL，菜单level指令
//输出：Spi接收到得数据
//==============================================================================
void MenuRoll(UCHAR Forward,UCHAR Para,UCHAR Level)
{
  UCHAR mainloop = 1;
  UCHAR Index_temp,SubIndex_temp,ThirdIndex_temp;
  UCHAR Index_real,SubIndex_real,ThirdIndex_real;

  Index_temp = SpcMenu[Menustat].index;
  SubIndex_temp = SpcMenu[Menustat].subindex;
  ThirdIndex_temp = SpcMenu[Menustat].thirdindex;

  //当系统处于ACTUAL状态，按下ACTUAL按键，使指令level自动降等
  if(spc_system_flag.bite.default_diaped)
    spc_system_flag.bite.default_diaped = 0;
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
        Menustat = MAX_MENU_NUM;
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
        if(SubIndex_temp == SubIndex_real)
          mainloop = 1;
        else if(ThirdIndex_real == 0)
          mainloop = 0;
        else
          mainloop = 1;
      }
      else
        mainloop = 1;
    }
    else if(Level == THIRDINDEX)
    {
      if((Index_temp == Index_real) && (SubIndex_temp == SubIndex_real))
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

    if(MainTainTempDisable())
    {
      if(SpcMenu[Menustat].flag.bite.maintain_req)
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

    if(pSPCValue[Cable_Channel].SPCSetPoints.system_valueb.bite.usr_advanced == 0)
    {
      if(SpcMenu[Menustat].flag.bite.advanced_req)
        mainloop = 1;
      else
        mainloop |= 0;
    }
  }

  set_menu_info(SpcMenu[Menustat].func_mark);
}

//==============================================================================
//设置MENU信息
//输入：alarm号
//输出：无
//==============================================================================
void set_menu_info(UCHAR MenuCMD)
{
  //strcpy(Info_Line1, SpcMenu[Menustat].text_line1);
  //strcpy(Info_Line2, SpcMenu[Menustat].text_line2);

  //strcpy(Info_Line1, SpcTxtLine1[Menustat]);
  char i;
  for(i=0; i<16; i++)
    Info_Line1[i] = SpcTxtLine1[Menustat][i];

  funcSet1[Menustat](1,1);

   asm nop;
}

//==============================================================================
//更新ALARM菜单
//输入：菜单level指令，递增/减指令
//输出：无
//==============================================================================
void AlarmRoll(UINT Alarmcmd,UINT Forward)
{
  UCHAR index;

    if(Alarmcmd == ALARM_INDEX)
    {
      if(spc_system_flag.bite.alarm_actived)
      {
      //如果正在显示alarm，则跳转到log
        spc_system_flag.bite.alarm_displayed ^= TRUE;
      }
      else
      {
      //否则显示alarm
        spc_system_flag.bite.alarm_actived = 1;
        spc_system_flag.bite.alarm_displayed = 1;
      }
      Alarmstat = 0;
    }
    else
    {
      index = spc_system_flag.bite.alarm_displayed;
      if(Forward)
      {
        if((Alarmstat >= ALARM_NUM[index]) || (Alarmstat >= MAX_ALARMS))
          Alarmstat = 1;
        else
          Alarmstat++;
      }
      else
      {
        if((Alarmstat == 0) || (Alarmstat == 1))
          Alarmstat = ALARM_NUM[index];
        else
          Alarmstat--;
      }
    }
    set_alarm_info(Alarmstat);
}

//==============================================================================
//设置ALARM信息
//输入：alarm号
//输出：无
//==============================================================================
void set_alarm_info(UCHAR AlarmIndex)
{
  UCHAR temp;
  temp = spc_system_flag.bite.alarm_displayed;

  if(temp)
    strcpy(Info_Line1, " 0/2 Alarms     ");
  else
    strcpy(Info_Line1, " 0/2 Logs       ");

  switch(Alarmtype[AlarmIndex])
  {
    case 0:
      if(temp)
      {
        strcpy(Info_Line1, " Actived alarms ");
        strcpy(Info_Line2, " 0 alarms       ");
      }
      else
      {
        strcpy(Info_Line1, "   Alarm logs   ");
        strcpy(Info_Line2, " 0 logs         ");
      }
      break;
    case 1:
      strcpy(Info_Line2, " Low TEMPERATURE");
      break;
    case 2:
      strcpy(Info_Line2, "High TEMPERATURE");
      break;
    case 3:
      strcpy(Info_Line2, "Low  Current    ");
      break;
    case 4:
      strcpy(Info_Line2, "High Current    ");
      break;
    case 5:
      strcpy(Info_Line2, "Low Voltage     ");
      break;
    case 6:
      strcpy(Info_Line2, "High Voltage    ");
      break;
    case 7:
      strcpy(Info_Line2, "GFI Alarm       ");
      break;
    case 8:
      strcpy(Info_Line2, "GFI Trip        ");
      break;
    case 9:
      strcpy(Info_Line2, "ALARM DURING    ");
      break;
    case 10:
      strcpy(Info_Line2, "AUTO TEST       ");
      break;
    case 11:
      strcpy(Info_Line1, "Out of memory   ");
      strcpy(Info_Line2, "                ");
      break;
  }
}

//==============================================================================
//更新LCD显示
//输入：方向
//输出：无
//==============================================================================
void ValueRoll(UCHAR Valuekey)
{
/*  if(SpcMenu[Menustat].index == 1) && (SpcMenu[Menustat].thirdindex != 0)
  {

  }  */
}

//==============================================================================
//更新LCD显示
//输入：无
//输出：无
//==============================================================================
void LCDUpdate()
{
  LCD_output(NEW_LINE | LINE_1,0,20,Info_Line1);
  LCD_output(NEW_LINE | LINE_2,0,20,Info_Line2);
}

UCHAR GetFuncMark(void)
{
  return SpcMenu[Menustat].func_mark;
}