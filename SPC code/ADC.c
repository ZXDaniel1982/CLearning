#include "systemvalue.h"
#include "MCP3202.h"
#include "PIC18F6622.h"
#include "ADC.h"
#include "usart.h"

UINT voltage_buf[2] = {0}, voltage_max, voltage_count=0;
char voltage_flag=0,voltage_trige = 0;

//==============================================================================
//get one byte sample from on chip 10bit ADC
//input£ºnone
//output£ºresult
//==============================================================================
unsigned int read_adc()
{
  char tt;
  unsigned int result=0;

  //ADCON0 &= ~(B2+B3+B4+B5);
  CHS1_bit = 0;
  CHS2_bit = 0;
  CHS3_bit = 0;
  CHS0_bit = 1;
  //ADCON0 |= B2;    //AN1
  for(tt=0; tt<100; tt++);
  GO_bit = 1;
  while(GO_bit);
  result = ADRESH;
  result = (result<<8) + ADRESL;

  asm nop;
  asm nop;
  asm nop;
  return result;
}

//==============================================================================
//read the voltage
//input£ºnone
//output£ºnone
//==============================================================================
void Getvoltage(void)
{
  char i;
  volatile unsigned int volt = 0;
  unsigned long Voltbuff=0;

  for(i=0;i<40;i++)
  {
    volt = read_adc();
    Voltbuff += volt;
    
    if(freqency == 60)
      Delay_us(190);       //60Hz
    else
      Delay_us(232);       //50Hz
  }
  
  volt = Voltbuff/40;
  Voltbuff = 0;

  pSPCValue[0].SPCActual.Voltage = ConvertADtoVoltage(volt,freqency);
}

//==============================================================================
//calculate the voltage
//input£ºad sample for voltage, freqency
//output£ºreal voltage
//==============================================================================
signed int ConvertADtoVoltage(unsigned int ADVolt, char freq)
{
   signed int ADLow , ADHigh;
   signed int VLow , VHigh;
   signed int ret;

   if(freq == 50)
   {
     ADHigh = 576;
     VHigh  = 2407;
     ADLow  = 211;
     VLow   = 910;
   }
   else
   {
     ADHigh = 589;
     VHigh  = 2403;
     ADLow  = 216;
     VLow   = 902;
   }

   ret =  (signed int)((signed long)((signed int)ADVolt - ADLow) * (VHigh - VLow)/(ADHigh - ADLow)) + VLow;
   
   if(ret < 0)
     ret = 0;

   return ret/10;
}


//==============================================================================
//measure the minimun voltage in one cycle
//input£ºnone
//output£ºtime point
//==============================================================================
unsigned int GetMinVoltpoint()
{
  char non_val=0;
  char old_freq_en;
  int volt_ad_min, volt_ad;
  unsigned int freq_count_temp;
  
  old_freq_en = freq_en;
  while(freq_en == old_freq_en)
  {
    volt_ad = read_adc();
    
    if(non_val == 0)
    {
      volt_ad_min = volt_ad;
      freq_count_temp = spc_count.freq_count;
      non_val = 1;
    }
    else
    {
      if(volt_ad < volt_ad_min)
      {
        volt_ad_min = volt_ad;
        freq_count_temp = spc_count.freq_count;
      }
    }
  }
  
  return freq_count_temp;
}

//==============================================================================
//measure the frequency
//input£ºnone
//output£ºnone
//==============================================================================
void GetFreqency()
{
  volatile unsigned int freq_val, freq_num_min1=0,freq_num_min2=0;
  
  while(1)
  {
    freq_en = 1;
    spc_count.freq_count = 0;
    
    freq_num_min1 = GetMinVoltpoint();
    freq_num_min2 = GetMinVoltpoint();
    
    freq_val = abs(freq_num_min1 - freq_num_min2);
    if((freq_val > 35) && (freq_val < 45))
    {
      freqency = 60;
      freq_pori = 83;
      return;
    }
    else if((freq_val > 45) && (freq_val < 55))
    {
      freqency = 50;
      freq_pori = 100;
      return;
    }
  }
}