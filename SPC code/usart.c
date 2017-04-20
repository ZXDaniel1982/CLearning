#include "systemvalue.h"
#include "PIC18F6622.h"
#include "usart.h"
#include "SpcValue.h"

//==============================================================================
//send data
//input：pointer of data, length
//output：none
//==============================================================================
void USART_send(UCHAR *bufout, char len)
{
  char i;

  en485tx();
  //Delay_ms(1000);
  for(i=0; i<len; i++)
  {
    TXREG1 = *(bufout+i);
    while(!(UART1_Tx_Idle()));
  }
  en485rx();
}

//==============================================================================
//enable RS485 tx/rx
//input：none
//output：none
//==============================================================================
void en485rx()      //使能485接收
{
  RE = 0;
  DE = 0;
  Delay_ms(100);
}

void en485tx()      //使能485发送
{
  RE = 1;
  DE = 1;
  Delay_ms(100);
}

void CommunicationErrorCheck()
{
  if(OERR_RCSTA_bit)
  {
    CREN_RCSTA_bit = 0;
    Delay_ms(10);
    CREN_RCSTA_bit = 1;
  }
}