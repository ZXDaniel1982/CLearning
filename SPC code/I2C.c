#include "systemvalue.h"
#include "I2C.h"
#include "PIC18F6622.h"

#define I2C_CLK_DIRECT TRISC3_bit
#define I2C_SDA_DIRECT TRISC4_bit
#define I2C_CLK_READ RC3_bit
#define I2C_SDA_READ RC4_bit
#define I2C_CLK_WRITE LATC3_bit
#define I2C_SDA_WRITE LATC4_bit

#define I2C_READ_FLAG 1
#define I2C_WRITE_FLAG 0

char I2CError=0;

void I2CInitial()
{
  I2C_CLK_DIRECT = 0;
  I2C_CLK_WRITE = 1;
  I2C_SDA_DIRECT = 0;
  I2C_SDA_WRITE = 1;
  Delay_us(25);
}

void I2CStart()
{
  I2C_SDA_WRITE = 0;
  Delay_us(50);
  I2C_CLK_WRITE = 0;
  Delay_us(50);
}

void I2CStop()
{
  I2C_CLK_WRITE = 1;
  Delay_us(50);
  I2C_SDA_WRITE = 1;
  Delay_us(50);
}

void I2CSendBit(char BitData)
{
  I2C_SDA_WRITE = BitData;
  Delay_us(50);
  I2C_CLK_WRITE = 1;
  Delay_us(50);
  I2C_CLK_WRITE = 0;
  Delay_us(50);
}

void I2CGetAckFromSlave()
{
  volatile char AckFromSlave;

  I2C_SDA_DIRECT = 1;
  Delay_us(50);
  I2C_CLK_WRITE = 1;
  Delay_us(50);
  AckFromSlave = I2C_SDA_READ;
  I2C_CLK_WRITE = 0;
  Delay_us(50);
  I2C_SDA_DIRECT = 0;
  Delay_us(50);
}


void I2CSendByte(unsigned char ByteData)
{
  char i;
  char SendBit;

  for(i=0;i<8;i++)
  {
    if((ByteData << i) & 0x80)
      SendBit = 1;
    else
      SendBit = 0;

    I2CSendBit(SendBit);
  }
  I2CGetAckFromSlave();
}

char I2CReadBit()
{
  char BitData;

  I2C_CLK_WRITE = 1;
  Delay_us(50);
  BitData = I2C_SDA_READ;
  I2C_CLK_WRITE = 0;
  Delay_us(50);

  return BitData;
}

void I2CSendAckToSlave(char AckType)
{
  //char AckFromSlave;

  I2C_SDA_DIRECT = 0;
  Delay_us(50);
  I2C_SDA_WRITE = AckType;
  Delay_us(50);
  I2C_CLK_WRITE = 1;
  Delay_us(50);
  I2C_CLK_WRITE = 0;
  Delay_us(50);
}

unsigned char I2CReadByte(char AckCmd)
{
  char i;
  volatile unsigned char ReadBit;
  unsigned char ByteData = 0;;

  I2C_SDA_DIRECT = 1;
  Delay_us(25);

  for(i=0;i<8;i++)
  {
    ReadBit = I2CReadBit();
    ByteData |= (ReadBit << (7-i));
  }
  I2CSendAckToSlave(AckCmd);

  return ByteData;
}
//==============================================================================
//I2C read
//input：slave address，data register，data to send，data lenth
//output：none
//==============================================================================
/*void I2C_get(UCHAR QTAddress,UCHAR QTRegister,UCHAR *Keystate,UCHAR Length)
{
  char i;

  //I2C_start();
    Soft_I2C_Start();
  //I2C_send((QTAddress << 1) + I2C_WRITE_FLAG);
  //I2C_send(QTRegister);
    Soft_I2C_Write((QTAddress << 1) + I2C_WRITE_FLAG);
    Soft_I2C_Write(QTRegister);
  //I2C_stop();
    Soft_I2C_Stop();

  Delay_us(50);
//  delayMS(100);

  //I2C_start();
    Soft_I2C_Start();
  //I2C_send((QTAddress << 1) + I2C_READ_FLAG);
    Soft_I2C_Write((QTAddress << 1) + I2C_READ_FLAG);

    *Keystate++ = I2C_receive();
    for(i=0;i<Length-1;i++)
    {
      //SendACKToSlave();
        *(Keystate+i) = Soft_I2C_Read(0);
    }

      //SendNACKToSlave();
      *(Keystate+Length-1) = Soft_I2C_Read(1);

  //I2C_stop();
    Soft_I2C_Stop();
}*/

void I2C_get(UCHAR QTAddress,UCHAR QTRegister,UCHAR *Keystate,UCHAR Length)
{
  char j;

  I2CStart();
  I2CSendByte((QTAddress << 1) + I2C_WRITE_FLAG);      //117*2=234    17*2=34
  I2CSendByte(QTRegister);
  I2CStop();
  asm nop;
  Delay_us(2);

  I2CStart();
  I2CSendByte((QTAddress << 1) + I2C_READ_FLAG);      //117*2+1=235

  for(j=0;j<Length-1;j++)
  {
    *(Keystate+j) = I2CReadByte(0);
  }
  *(Keystate+Length-1) = I2CReadByte(1);

  I2CStop();
  asm nop;
}

//==============================================================================
//I2C write
//intput：slave address，data register，data to send，data lenth
//output：none
//==============================================================================
/*void I2C_write(UCHAR QTAddress,UCHAR QTRegister,UCHAR *Keystate,UCHAR Length)
{
  char i;

  //I2C_start();
        Soft_I2C_Start();
  //I2C_send(QTAddress * 2 + I2C_WRITE_FLAG);
  //I2C_send(QTRegister);
        Soft_I2C_Write(QTAddress * 2 + I2C_WRITE_FLAG);
        Soft_I2C_Write(QTRegister);

  for(i=0;i<Length;i++)
  {
    //I2C_send(*Keystate++);
        Soft_I2C_Write(*(Keystate+i));
  }

  //I2C_stop();
    Soft_I2C_Stop();
}*/
void I2C_write(unsigned char QTAddress,
               unsigned char QTRegister,
               unsigned char *Keystate,
               unsigned char Length)
{
  char i;
  
  /*I2CStart();
  I2CSendByte(QTAddress * 2 + I2C_WRITE_FLAG);
  I2CSendByte(130);
  I2CSendByte(0x55);
  I2CStop();
  Delay_ms(2);*/

  I2CStart();
  I2CSendByte(QTAddress * 2 + I2C_WRITE_FLAG);
  I2CSendByte(QTRegister);

  for(i=0;i<Length;i++)
  {
    I2CSendByte(*(Keystate+i));
    Delay_ms(200);
  }
  I2CStop();
}

//==============================================================================
//I2C send one byte
//input：data to send
//output：none
//==============================================================================
void I2C_send(UCHAR DataToSlave)
{
  volatile char dummy;
  dummy =  SSP1BUF;
  //WaitI2CIdel();
  SSP1BUF = DataToSlave;
  WaitSlaveACK();
}

//==============================================================================
//I2C receive one byte
//input：none
//output：data received
//           switched to soft simulate
//==============================================================================
UCHAR I2C_receive()
{
  unsigned char DataFromSlave;
  unsigned int protect=0xffff;
  
  RCEN_SSP1CON2_bit = 1;
  while((!(BF_SSP1STAT_bit)) && (--protect));
  protect = 0xffff;
  DataFromSlave = SSP1BUF;
  while((!(SSP1IF_bit)) && (--protect));
  SSP1IF_bit = 0;
  
  if(protect == 0)
  {
    //超时，添加响应程序
    I2CError = 1;
  }

  return DataFromSlave;
}

//==============================================================================
//input：none
//output：none
//           switched to soft simulate
//==============================================================================
void I2C_start()
{
  unsigned int protect = 0xffff;
  //WaitI2CIdel();
  SEN_SSP1CON2_bit = 1;
  while((!(SSP1IF_bit)) && (--protect));
  SSP1IF_bit = 0;
  
  if(protect == 0)
  {
    //超时，添加响应程序
    I2CError = 1;
  }
}

//==============================================================================
//input：none
//output：none
//           switched to soft simulate
//==============================================================================
void I2C_stop()
{
  unsigned int protect = 0xffff;
  
  //WaitI2CIdel();
  PEN_SSP1CON2_bit = 1;
  while((!(SSP1IF_bit)) && (--protect));
  SSP1IF_bit = 0;
  
  if(protect == 0)
  {
    //超时，添加响应程序
    I2CError = 1;
  }
}

//==============================================================================
//input：none
//output：none
//           switched to soft simulate
//==============================================================================
void WaitI2CIdel()
{
  UCHAR SSP1CON2_Idel;
  SSP1CON2_Idel = SEN + RSEN + PEN + RCEN + ACKEN;
  while((SSP1CON2 & SSP1CON2_Idel) | R_W_SSP1STAT_bit);
}

//==============================================================================
//input：none
//output：none
//           switched to soft simulate
//==============================================================================
void WaitSlaveACK()
{
  unsigned int protect = 0xffff;

  while((!(SSP1IF_bit)) && (--protect));
  SSP1IF_bit = 0;
  protect = 0xffff;

  while((ACKSTAT_SSP1CON2_bit) && (--protect));
  ACKSTAT_SSP1CON2_bit = 1;
  
  if(protect == 0)
  {
    //超时，添加响应程序
    I2CError = 1;
  }
}

//==============================================================================
//input：none
//output：none
//           switched to soft simulate
//==============================================================================
void SendACKToSlave()
{
  unsigned int protect = 0xffff;

  //WaitI2CIdel();
  ACKEN_SSP1CON2_bit = 1;
  ACKDT_SSP1CON2_bit = 0;
  while((!(SSP1IF_bit)) && (--protect));
  SSP1IF_bit = 0;
  
  if(protect == 0)
  {
    //超时，添加响应程序
    I2CError = 1;
  }
}

//==============================================================================
//input：none
//output：none
//           switched to soft simulate
//==============================================================================
void SendNACKToSlave()
{
  unsigned int protect = 0xffff;

  //WaitI2CIdel();
  ACKEN_SSP1CON2_bit = 1;
  ACKDT_SSP1CON2_bit = 1;
  while((!(SSP1IF_bit)) && (--protect));
  SSP1IF_bit = 0;
  
  if(protect == 0)
  {
    //超时，添加响应程序
    I2CError = 1;
  }
}