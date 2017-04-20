#include "systemvalue.h"
#include "PIC18F6622.h"
#include "SpcValue.h"
#include "systemtest.h"
#include "SSR.h"
#include "function.h"
#include "Menuoperation.h"

unsigned int AlarmTestCount[2]={0}, HeaterTestCount[2]={0};
char AlarmTestCmd[2]={0};
char HeaterTestCmd[2]={0};

int GFITestCount[2]={0};
char GFITestCmd[2]={0};
char GFITestStat=0;
char AutoGFITestPass[2]={0}, AutoGFITestEN[2]={0};
char GFITestPass[2]={0};
char TestEN[2]={0};

code char GFITestPassStr[17] = "Pass            ";
code char GFITestFailStr[17] = "Fail            ";

//==============================================================================
//process of system test
//input£ºnone
//output£ºnone
//==============================================================================
void systemtest(char ChannelNum)
{
  char i;

  //alarm output test
  if(pSPCValue[ChannelNum].SPCSetPoints.AlarmOutTest == SPC_SYSTEMVALUE_DISABLE)
  {
    //spc_system_flag.bite.alarmssr_forceop = ALARMSSR_OK;
    //spc_system_flag.bite.alarmtest_cmd = ALARM_TEST_IDLE;
    AlarmForce[ChannelNum] = ALARMSSR_OK;
    AlarmTestCmd[ChannelNum] = ALARM_TEST_IDLE;
    AlarmTestCount[ChannelNum] = 0;
  }
  else if(pSPCValue[ChannelNum].SPCSetPoints.AlarmOutTest == SPC_SYSTEMVALUE_CONTINU)
  {
    //spc_system_flag.bite.alarmssr_forceop = FORCE_ALARMSSR_ON;
    //spc_system_flag.bite.alarmtest_cmd == ALARM_TEST_IDLE;
    AlarmForce[ChannelNum] = FORCE_ALARMSSR_ON;
    AlarmTestCmd[ChannelNum] = ALARM_TEST_IDLE;
    AlarmTestCount[ChannelNum] = 0;
  }
  else
  {
    if(AlarmTestCmd[ChannelNum] == ALARM_TEST_IDLE)
    {
      AlarmForce[ChannelNum] = FORCE_ALARMSSR_ON;
      AlarmTestCmd[ChannelNum] = ALARM_TEST_START;
      AlarmTestCount[ChannelNum] = 0;
      //spc_system_flag.bite.alarmtest_cmd = ALARM_TEST_START;
      //spc_system_flag.bite.alarmssr_forceop = FORCE_ALARMSSR_ON;
    }
    else if(AlarmTestCmd[ChannelNum] == ALARM_TEST_END)
    {
      AlarmTestCmd[ChannelNum] = ALARM_TEST_IDLE;
      AlarmForce[ChannelNum] = ALARMSSR_OK;
      pSPCValue[ChannelNum].SPCSetPoints.AlarmOutTest = SPC_SYSTEMVALUE_DISABLE;
      //spc_system_flag.bite.alarmssr_forceop = ALARMSSR_OK;
      Savedata(SYSTEMFLAG_FLASH_LACAL+ChannelNum*sizeof(SPCSETPIONTS),
               sizeof(SYSTEM_VALUEB),
               (UCHAR *)(&pSPCValue[ChannelNum].SPCSetPoints.system_valueb),
               0);
    }
  }
  
  //heater test
  if(pSPCValue[ChannelNum].SPCSetPoints.HeaterTest == SPC_SYSTEMVALUE_CONTINU)
  {
    ForceSSRONCondition[ChannelNum] |= HEATERTESTFORCEON;
  }
  else if(pSPCValue[ChannelNum].SPCSetPoints.HeaterTest == SPC_SYSTEMVALUE_DISABLE)
  {
    ForceSSRONCondition[ChannelNum] &= ~HEATERTESTFORCEON;
  }
  else
  {
      if(HeaterTestCmd[ChannelNum] == 0)                                      //(spc_system_flag.bite.heatest_req == 0)
      {
      
        ForceSSRONCondition[ChannelNum] |= HEATERTESTFORCEON;
        HeaterTestCount[ChannelNum] = 0;
        HeaterTestCmd[ChannelNum] = 1;
        //spc_system_flag.bite.heatest_req = 1;
        //spc_system_flag.bite.heatest_reach = 0;

        //TestEN[0] = 1;
      }
      else if(HeaterTestCmd[ChannelNum] == 2)                                      //(spc_system_flag.bite.heatest_reach)
      {
        //TestEN[ChannelNum] = 0;
        ForceSSRONCondition[ChannelNum] &= ~HEATERTESTFORCEON;
        //spc_system_flag.bite.heatest_req = 0;
        HeaterTestCmd[ChannelNum] = 0;
        pSPCValue[ChannelNum].SPCSetPoints.HeaterTest = SPC_SYSTEMVALUE_DISABLE;
        Savedata(SYSTEMFLAG_FLASH_LACAL+ChannelNum*sizeof(SPCSETPIONTS),
                 sizeof(SYSTEM_VALUEB),
                 (UCHAR *)(&pSPCValue[ChannelNum].SPCSetPoints.system_valueb),
                 0);
      }    
  }
  
  //groud fault test
    if(pSPCValue[ChannelNum].SPCSetPoints.system_valueb.bite.gfi_test_mod == GFI_TEST_NOW)
    {
      if(GFITestCmd[ChannelNum] == 0)
      {
        ForceSSRONCondition[ChannelNum] |= GFITESTFORCEON;
        if(ChannelNum == CHANNEL1)
          LATF2_bit = 1;
        else if(ChannelNum == CHANNEL2)
          LATF1_bit = 1;

        GFITestCmd[ChannelNum] = 1;
        GFITestCount[ChannelNum] = 0;
        KeyEn = 0;
      }
      else if(GFITestCmd[ChannelNum] == 2)
      {
        if(Cable_Channel == CHANNEL1)
          LATF2_bit = 0;
        else if(Cable_Channel == CHANNEL2)
          LATF1_bit = 0;
          
        ForceSSRONCondition[ChannelNum] &= ~GFITESTFORCEON;
        ForceSSROFFCondition[ChannelNum] &= ~GFITRIPFORCEOFF;
        if(GFITestPass[ChannelNum])
        {
          GFITestPass[ChannelNum] = 0;
          for(i=0; i<16; i++)
            Info_Line2[i] = GFITestPassStr[i];
        }
        else
        {
          for(i=0; i<16; i++)
            Info_Line2[i] = GFITestFailStr[i];
          if(!(ActivedAlarms & (CH1_GFITESTFAIL << ChannelNum)))
            alarmoperate(CH1_GFITESTFAIL << ChannelNum,ENALARM);
        }
        LCDUpdate();
        Delay_ms(2000);
        GFITestCmd[ChannelNum] = 0;
        pSPCValue[ChannelNum].SPCSetPoints.system_valueb.bite.gfi_test_mod = GFI_TEST_DISABLE;
        Savedata(SYSTEMFLAG_FLASH_LACAL+ChannelNum*sizeof(SPCSETPIONTS),
               sizeof(SYSTEM_VALUEB),
               (UCHAR *)(&pSPCValue[ChannelNum].SPCSetPoints.system_valueb),
               0);
        for(i=0; i<16; i++)
            Info_Line2[i] = ParaChar[DISABLE_STR][i];
        LCDUpdate();
        KeyEn = 1;
      }
    }

  //auto test cycle
  if(spc_system_flag.bite.autotest_req == RUNNING)
  {
    if(pSPCValue[ChannelNum].SPCSetPoints.system_valueb.bite.gfi_test_mod != GFI_TEST_AUTO)
      ForceSSRONCondition[ChannelNum] |= AUTOTESTFORCEON;
    else
    {
      ForceSSRONCondition[ChannelNum] &= ~AUTOTESTFORCEON;
      spc_system_flag.bite.autotest_req = DONES;
      spc_count.AutoTest_last_count = 0;
    }
  }
  else if(spc_system_flag.bite.autotest_req == DONES)
  {
    spc_system_flag.bite.autotest_req = IDEL;
    if(pSPCValue[ChannelNum].SPCSetPoints.system_valueb.bite.gfi_test_mod != GFI_TEST_AUTO)
    {
      asm nop;
      Spcssr[ChannelNum].SSR_cmd = 0;
      if(!(ActivedAlarms & AUTOTESTALARM))
      {
        if(ActivedAlarms)
          alarmoperate(AUTOTESTALARM,ENALARM);
      }
      ForceSSRONCondition[ChannelNum] &= ~AUTOTESTFORCEON;
    }         //if(pSPCValue.SPCSetPoints.system_valueb.bite.gfi_test_mod == GFI_TEST_AUTO)
    else
    {
      if(pSPCValue[ChannelNum].SPCSetPoints.GFITrip != SPC_SYSTEMVALUE_OFF)
      {
        if(GFITestCmd == 0)
        {
          LATF2_bit = 1;
          ForceSSRONCondition[ChannelNum] |= AUTOTESTFORCEON;
          GFITestCmd[ChannelNum] = 1;
          GFITestCount[ChannelNum] = 0;
          AutoGFITestEN[ChannelNum] = 1;
        }
      }
      else
      {
        LATF2_bit = 0;
        GFITestCmd[ChannelNum] = 0;
        GFITestCount[ChannelNum] = 0;
        AutoGFITestEN[ChannelNum] = 0;
        ForceSSRONCondition[ChannelNum] &= ~AUTOTESTFORCEON;
        ForceSSROFFCondition[ChannelNum] &= ~GFITRIPFORCEOFF;
      }
    }
  }
  
  if(AutoGFITestEN)
  {
    if(GFITestCmd[ChannelNum] == 2)
    {
      LATF2_bit = 0;
      AutoGFITestEN[ChannelNum] = 0;
      GFITestCmd[ChannelNum] = 0;
      if(AutoGFITestPass[ChannelNum])   //fail
        AutoGFITestPass[ChannelNum] = 0;
      else
      {
        if(!(ActivedAlarms & AUTOTESTALARM))
        {
          if(ActivedAlarms)
            alarmoperate(AUTOTESTALARM,ENALARM);
        }
      }
      ForceSSRONCondition[ChannelNum] &= ~AUTOTESTFORCEON;
      ForceSSROFFCondition[ChannelNum] &= ~GFITRIPFORCEOFF;
    }
  }
}