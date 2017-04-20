#include "systemvalue.h"
#include "Spi.h"
#include "PIC18F6622.h"

//==============================================================================
//Spi send one byte
//input��data to send
//output��none
//==============================================================================
void Spi_send(UCHAR SpiTXdata)
{
  volatile char dummy;
  
  dummy = SSP2BUF;
  SSP2BUF = SpiTXdata;
  while(!(SSP2IF_bit));
  SSP2IF_bit = 0;
}

//==============================================================================
//Spi receive one byte
//input��Spi Command
//output��data received
//==============================================================================
UCHAR Spi_receive(UCHAR SpiCommand)
{
  volatile char dummy;
  UCHAR SpiRCdata;

  dummy = SSP2BUF;
  SSP2BUF = SpiCommand;
  while(!(SSP2IF_bit));
  SSP2IF_bit = 0;
  SpiRCdata = SSP2BUF;
  
  return(SpiRCdata);
}