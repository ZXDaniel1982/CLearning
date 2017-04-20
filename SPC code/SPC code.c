#include "systemvalue.h"
#include "PIC18F6622.h"
#include "Spcinitial.h"
#include "Menuoperation.h"
#include "SpcValue.h"
#include "Mainprocess.h"
#include "modbus.h"
#include "function.h"
#include "SSR.h"
#include "ADC.h"
#include "I2C.h"
#include "systemtest.h"
#include "manual.h"
#include "Calibration.h"
#include "String_op.h"

//系统标志位
UCHAR Info_Line1[LCDLENGTH];
UCHAR Info_Line2[LCDLENGTH];
UCHAR Info_Line1_shape[LCDLENGTH];
UCHAR Info_Line2_shape[LCDLENGTH];
UCHAR Alarmstat = 0;
UCHAR Passwordbuff[LCDLENGTH];
UCHAR Menustat;
//keypad flags
UINT KeyHoldDelay=0;
UINT KeyHoldStep=1;
char Keyactived=0,Keyhold=0;
SYSTEM_FLAG spc_system_flag;
SPCVALUE pSPCValue[2];
char Cable_Channel=0;

SETPSHADE SetP_shade1;
SPCSETPIONTS SetP_shade;

CLIBRATIONCMD Cali_cmd;

SPCCOUNT spc_count;
SPCALARMBOX pSPCAlarm;

unsigned long ActivedAlarms = 0;

char bUpdate=0;
char LCDext = 0;  //lcd 外部操作(定时器)
SPCPWM Spcpwm[2];
SPCSSR Spcssr[2];
SOFTSTART SpcSstart[2];
signed int temp_val_old[2];
ACCUMULATE SpcAcc[2];

SPCTIME SYS_On_time;  //检测SPC打开时间
SPCTIME Heat_On_time[2];  //检测Heater打开时间

UINT rcdata;

UCHAR Statis_flag[2];

unsigned int pwm_duty[2],duty_index[2];

UINT freqency;
UINT freq_pori;

char char_flash_loca;

char reset_psw_en=0;

VALUEACC Volt_acc[2];
VALUEACC Current_acc[2];

char ADC_busy[2] = {0};

char Actural_disp_str[38][17];
ULONG SystemUpdate=0;
unsigned int DataUpdate=0;

char freq_en;
//int Cali_value[4];

char forceop_level;
char KeyEn;

unsigned char ForceSSRONCondition[2]={0};
unsigned char ForceSSROFFCondition[2]={0};

          unsigned long  ACheck=0;
          char ErrorCode=0;
          
char CheckError()
{
  if(ActivedAlarms)
    ACheck = ActivedAlarms;
  else
  {
    if(ACheck)
    {
      ACheck = 0;
      return 1;
    }
  }
  
  return 0;
}

void main()
{
  GlobalInterrupt_diable();                  //disable interrupt
  SPCSystemInitialize();
  SPC_Initial();
  selftest();                                //selftest for now
  GlobalInterrupt_enable();                  //enable interrupt
  
  spc_system_flag.bite.default_diaped = 1;   //initial to display default information
  spc_system_flag.bite.stat_update = 1;      //show system stat information
  Menustat = 0;
  
  SelfCheck();
  
  asm nop;
  
  //GetFreqency();
  
  freqency = 60;              //set the frequency to 60Hz
    //freqency = 50;
  freq_pori = 83;             //make a counter for 8.33ms
    //freq_pori = 100;
  //I2CError = 0;
#ifdef ADDITIONCALIBRATION
  if(SPCCalibrationEN != 0)
  {
    getParaChar(Info_Line1, NEED_CALIBRATION_STR);
    getParaChar(Info_Line2, BLANK_STR);
    LCDUpdate();
  }
  else if(SPCTestingEN != 0)
  {
    getParaChar(Info_Line1, NEED_CALIBRATION_STR);
    getParaChar(Info_Line2, BLANK_STR);
    LCDUpdate();
  }
#endif

#ifdef ADDITIONCALIBRATION
    SPCCalibration();
#else
    InitialCalibrationReg();
#endif
  
  while(1)
  {
    if((spc_system_flag.bite.keypushed == KEYPUSH) && (LCDext==0))
    {
    //detect the keys every 20ms
      spc_system_flag.bite.keypushed = KEYIDEL;
      SPCMenuOperation();
    }
    
    //ErrorCode = '1';

    if(bUpdate)
    {
    //redraw the lcd
      bUpdate = 0;

      if(SpcMenu[Menustat].func_mark == FUNC_HEATID)
      {//need to show ID setup
        spc_system_flag.bite.char_flash = 1;
        char_flash_loca = 1;
      }

      CopyStr(Info_Line1_shape, Info_Line1, 16);
      CopyStr(Info_Line2_shape, Info_Line2, 16);
      LCDUpdate();
    }
    
    //ErrorCode = '2';

    disp_default();
    
    //ErrorCode = '3';

    //flashing function
    if(spc_system_flag.bite.flashing_reach == 1)
    {
      spc_system_flag.bite.flashing_reach = 0;
      Flashing();
    }
    
    //ErrorCode = '4';

    if(spc_system_flag.bite.meas_VT_reach)
    {
      VTProcess();          //measure the voltage and temperature
    }
    
    //ErrorCode = '5';

#ifdef ROLLDISPLAY_MULTIHEATERS
    RollCharact();
#endif

    //ErrorCode = '6';
    CGProcess(CHANNEL1);            //measure the current and GFI
    //ErrorCode = '7';
    CGProcess(CHANNEL2);
    //ErrorCode = '8';
    Timeprocess();          //update the running time
    //ErrorCode = '9';
    enegy_acc();            //measure the enegy and cost
    //ErrorCode = 'a';
    systemtest(CHANNEL1);           //system test function
    //ErrorCode = 'b';
      systemtest(CHANNEL2);
      //ErrorCode = 'c';
    manual(CHANNEL1);               //override operation
      //ErrorCode = 'd';
       manual(CHANNEL2);               //override operation
       //ErrorCode = 'e';
    dispupdate();           //update the lcd screen
       //ErrorCode = 'f';
    alarmdispupdate();      //update the alarm information
       //ErrorCode = 'g';
    RSSoperation(CHANNEL1);         //relay operation
       //ErrorCode = 'h';
       RSSoperation(CHANNEL2);         //relay operation
       //ErrorCode = 'i';
    AlarmSSRoperation();    //alarm relay operation
       //ErrorCode = 'j';
    AlarmLedOperation();
       //ErrorCode = 'k';
    ActivateHighCurrentAlarm(0);
       //ErrorCode = 'l';
    modbusprocess();
       //ErrorCode = 'm';
    ConflictCorrection();
       //ErrorCode = 'n';
    AutoAutho();
       //ErrorCode = 'o';

    if(KeyResetEN)
    {
      KeyResetEN = 0;
      QT60Reset();
    }
    //ErrorCode = 'p';
    //ChannelIndicator(Cable_Channel);
  }
}

void Tcount(SPCTIME *time ,char cmd)
{
  char i;

  if(time->second++ > DELAY_M)
  {
    time->second = 0;
    if(cmd == 0)
    {
      DataUpdate |= (CH1_ONTIME_UPDATE_PERCENT_REQ+CH2_ONTIME_UPDATE_PERCENT_REQ);
    
      if(KeyResetCount++ > 5)
      {
        KeyResetCount = 0;
        KeyResetEN = 1;
      }

      if(GetAutoAutho() == 1)
      {
        AutoAuthoCount++;
        if(AutoAuthoCount >= 15)
        {
          AutoAuthoCount = 0;
          SetAutoAutho(2);
        }
      }
    }
    
    if(time->minute++ > DELAY_H)
    {
                           //test
                           //KeyBusy = 1;
      time->minute = 0;
      if(time->hour < 0xffffffff)
        time->hour++;
        
      if(cmd)
      {
        if(time->hour < 1000000)
          pSPCValue[cmd-1].SPCStatistics.RunTime = time->hour;
        else
          pSPCValue[cmd-1].SPCStatistics.RunTime = ONTIMEOUTOFRANGE;
          
        DataUpdate |= (CH1_ONTIME_UPDATE_REQ << (cmd-1));
      }

      if(cmd == 0)
      {
        for(i=0;i<2;i++)
        {
          if(HeaterTestCmd[i] == 1)                      //(spc_system_flag.bite.heatest_req)
          {
            if(HeaterTestCount[i]++ >= pSPCValue[i].SPCSetPoints.HeaterTest)
            {
              HeaterTestCount[i] = 0;
              //spc_system_flag.bite.heatest_reach = 1;
              HeaterTestCmd[i] = 2;
            }
          }
          
          if(AlarmTestCmd[i] == 1)                      //(spc_system_flag.bite.heatest_req)
          {
            if(AlarmTestCount[i]++ >= pSPCValue[i].SPCSetPoints.AlarmOutTest)
            {
              AlarmTestCount[i] = 0;
              //spc_system_flag.bite.heatest_reach = 1;
              AlarmTestCmd[i] = 2;
            }
          }
        }
      
        if(pSPCValue[0].SPCSetPoints.AutoTestTime == SPC_SYSTEMVALUE_OFF)
          return;

        spc_count.AutoTest_count++;
        if(spc_count.AutoTest_count >= pSPCValue[0].SPCSetPoints.AutoTestTime)
        {
          spc_count.AutoTest_count = 0;
          if(spc_system_flag.bite.autotest_req == IDEL)
          {
            if((ActivedAlarms & CH1_HIGHTEMPALARM) || (ActivedAlarms & CH2_HIGHTEMPALARM))
              return;

            if(spc_system_flag.bite.load_forceop != FORCE_LOAD_OFF)
              spc_system_flag.bite.autotest_req = RUNNING;
          }
        }
      }
    }
  }
}

void interrupt()
{
  static UINT timereset=0,trige = 0;
  
  if(TMR0IF_bit)
  {
#ifdef SYSTEST
    if(freq_en)
    {
      spc_count.freq_count++;
      if(spc_count.freq_count > 100)
        freq_en = 0;
      else if(spc_count.freq_count > 50)
        freq_en = 2;
    }
    else
    {
      pwm(CHANNEL1);
        pwm(CHANNEL2);
      countformeasurement(CHANNEL1);
        countformeasurement(CHANNEL2);
      
      if(ModbusRecived)
      {
        LED_COMMUNICATION_FAIL = 1;
        ModbusCounter++;
        if(ModbusCounter >= 100)
        {
          ModbusRecived = 0;
          LED_COMMUNICATION_FAIL = 0;
          ModbusValid = 1;
        }
      }
      
      /*if(GetCommand(CURRENTGFI_MEASURE) == INITIAL_COMMAND)
      {
        CalibrationCount++;
        if(CalibrationCount >= freq_pori)
        {
          CalibrationCount = 0;
          SetCommand(CURRENTGFI_MEASURE, FINISH_COMMAND);
        }
      }*/
      
      if(RollCharactEN == 1)
      {
        RollCharactCount++;
        if(RollCharactCount >= 600)
        {
          RollCharactCount = 0;
          RollCharactEN = 2;
        }
      }
    
      spc_count.secout++;
      if(spc_count.secout >= DELAY_S)
      {
        LATG1_bit ^= 1;
        spc_count.secout = 0;
        SpcSstart[0].SOFTSTART_reach = 1;
        SpcSstart[1].SOFTSTART_reach = 1;


        if(ResetPasswordStep)
        {
          if(ResetPasswordCount++ > 10)
          {
            ResetPasswordStep = 0;
            ResetPasswordCount = 0;
          }
        }

        if(spc_system_flag.bite.default_diaped == 0)
        {
          if(pSPCValue[0].SPCSetPoints.DisplayTime != SPC_SYSTEMVALUE_OFF)
          {
            if(spc_count.Timeout_count++ >= pSPCValue[0].SPCSetPoints.DisplayTime)
            {
              spc_count.Timeout_count = 0;
              spc_system_flag.bite.default_diaped = 1;
              spc_system_flag.bite.stat_update = 1;
            }
          }
        }

        if(spc_count.meas_VT_count++ >= DELAY_VT)
        {
          spc_count.meas_VT_count = 0;
          spc_system_flag.bite.meas_VT_reach = 0x03;
        }

        if(energycount++ >= 36)
        {
          energycount = 0;
          energyacc = 1;
        }

        if(GFITestCmd[0] == 1)
        {
          if(GFITestCount[0]++ >= 10)
          {
            GFITestCount[0] = 0;
            GFITestCmd[0] = 2;
            LATF2_bit = 0;
          }
        }
        
        if(GFITestCmd[1] == 1)
        {
          if(GFITestCount[1]++ >= 10)
          {
            GFITestCount[1] = 0;
            GFITestCmd[1] = 2;
            LATF1_bit = 0;
          }
        }

        if(spc_system_flag.bite.autotest_req == RUNNING)
        {
          if(spc_count.AutoTest_last_count++ >= 320)             //320
          {
            spc_count.AutoTest_last_count = 0;
            spc_system_flag.bite.autotest_req = DONES;
          }
        }

        if(GetHighCurrentEn(0) == 1)
        {
          if(HighCurrentAlarmCount[0]++ >= 300)
          {
            HighCurrentAlarmCount[0] = 0;
            SetHighCurrentEn(2,0);
          }
        }
        
        if(GetHighCurrentEn(1) == 1)
        {
          if(HighCurrentAlarmCount[1]++ >= 300)
          {
            HighCurrentAlarmCount[1] = 0;
            SetHighCurrentEn(2,1);
          }
        }

        if(GetAlarmEn())
        {
          LED_ALARM ^= 1;
        }

        Tcount(&SYS_On_time, 0);    //进行auto test计数
        if(Spcssr[0].SSR_stat == 1)
          Tcount(&Heat_On_time[0], 1);
        if(Spcssr[1].SSR_stat == 1)
          Tcount(&Heat_On_time[1], 2);
      }

      if(LCDext)
      {
        if(spc_count.toutT++ >= DELAY_S)
        {
          LCDext = 0;
          spc_count.toutT = 0;
          if(reset_psw_en)
            spc_system_flag.bite.default_diaped = 1;
          else
            bUpdate = 1;
        }
      }

      if(spc_system_flag.bite.flashing_en == 1)
      {
        if(spc_count.scanT++ >= 5000)
        {
          spc_count.scanT = 0;
          spc_system_flag.bite.flashing_reach = 1;
        }
      }
    
      if(KeyEn)
      {
        if(KeyDetectCount++ >= 150)
        {
          KeyDetectCount = 0;
          spc_system_flag.bite.keypushed = KEYPUSH;
        }
      }
    }
#else
    timereset = TMRVAL;
    TMR0H = (timereset>>8) & 0XFF;
    TMR0L = timereset & 0XFF;
#endif
    //TMR0H = 0XFc;
    //TMR0L = 0xCD;
    TMR0H = 0XFe;
    TMR0L = 0x84;
    TMR0IF_bit = 0;
  }
  else if(INT0IF_bit)
  {//有按键发生
    INT0IF_bit = 0;
  }
  else if(RC1IF_bit)
  {
    if(ModbusRecived == 0)
      ModbusRecived = 1;

    modbus_rcdata[modbus_rcn] = RCREG1;
    modbus_rcn++;
    ModbusCounter = 0;

    RC1IF_bit = 0;
  }
}