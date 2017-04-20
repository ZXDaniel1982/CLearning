#include "systemvalue.h"
#include "PIC18F6622.h"
#include "manual.h"

//==============================================================================
//override operation
//input��none
//output��none
//==============================================================================
void manual(char ChannelNum)
{
  char ManualInput;

  if(ChannelNum == CHANNEL1)
    ManualInput = RB3_bit;
  else if(ChannelNum == CHANNEL2)
    ManualInput = RD7_bit;

  if(pSPCValue[ChannelNum].SPCSetPoints.system_valueb.bite.man_on)
  {
    if(ManualInput)     //forceon1 �˿�
    {
      ForceSSROFFCondition[ChannelNum] &= ~MANUALFORCEOFF;
    }
    else
    {
      ForceSSROFFCondition[ChannelNum] |= MANUALFORCEOFF;
    }
  }
  else
  {
    ForceSSROFFCondition[ChannelNum] &= ~MANUALFORCEOFF;
  }
}