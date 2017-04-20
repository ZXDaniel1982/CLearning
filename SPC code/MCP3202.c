#include "systemvalue.h"
#include "MCP3202.h"
#include "PIC18F6622.h"
#include "Spi.h"

//==============================================================================
//get one sample by ADC
//input£ºADC channel,  ADC command
//output£ºresult
//==============================================================================
UINT MCP3202_GET_AD_ONCE(UCHAR Spi_Channel,UCHAR Spi_AD_CMD)
{
  unsigned int temp,rcdataH,rcdataL;
  unsigned int i;
  volatile char dummy;

  LATD &= ~Spi_Channel;          //chip select

  for(i=0; i<0xff; i++);

  SSP2BUF = 0x01;
  while(!(SSP2IF_bit));
  SSP2IF_bit = 0;
  
  dummy = SSP2BUF;

  SSP2BUF = Spi_AD_CMD;        //  1110 0000
  while(!(SSP2IF_bit));
  SSP2IF_bit = 0;

  rcdataH = SSP2BUF & 0x0f;
  temp = rcdataH & 0x0f;
  temp = temp << 8;

  SSP2BUF = 0;
  while(!(SSP2IF_bit));
  SSP2IF_bit = 0;

  rcdataL = SSP2BUF;
  temp |= rcdataL;

  LATD |= Spi_Channel;

  asm nop;

  return temp;
}


//==============================================================================
//get multi samples by ADC
//input£ºADC channel,  ADC command , number of samples
//output£ºresult
//==============================================================================
UINT MCP3202_GET_AD(UCHAR Spi_Channel,UCHAR Spi_AD_CMD, char NumOfSample)
{
  char i;
  unsigned int rcdata,rcdatamax=0,rcdatamin=0;
  unsigned long rcdatatemp=0;
  
  for(i=0; i<NumOfSample; i++)
  {
    rcdata = MCP3202_GET_AD_ONCE(Spi_Channel,Spi_AD_CMD);
    rcdatatemp += (unsigned long)rcdata;

    if(i==0)
    {
      rcdatamax = rcdata;
      rcdatamin = rcdata;
    }
    else
    {
      if(rcdata > rcdatamax) rcdatamax = rcdata;
      if(rcdata < rcdatamin) rcdatamin = rcdata;
    }
  }
  rcdata = (unsigned int)((rcdatatemp-rcdatamax-rcdatamin)/98.0);
  return rcdata;
}