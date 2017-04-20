#include "systemvalue.h"
#include "Spcinitial.h"
#include "PIC18F6622.h"
#include "M0220.h"
#include "usart.h"
#include "Menuoperation.h"
#include "QT60.h"
#include "RTD.h"
#include "SpcValue.h"
#include "String_op.h"
#include "I2C.h"
#include "MCP3202.h"
#include "function.h"

int KeyResetCount = 0;
char KeyResetEN = 0;

//==============================================================================
//SPC initial
//input：none
//output：none
//==============================================================================
void SPC_Initial()
{
  System_clock_initial();
  Timer_initial();
  Port_initial();
  Spi_initial();
  //I2C_initial();
    //Soft_I2C_Init();

  Uart_initial();
  ADC_initial();
  LCD_initial();
  //QT60Initial();
}

void QT60Initial()
{
  setkeyhold();          //enable hold mode for all keys
  Delay_ms(200);
  setkeysence();         //set key sensitive
  Delay_ms(200);
  setkeysenceaks();      //disable muli-key detection
  Delay_ms(200);
  enablekeys();          //disable keys that not used*/
  calikey();             //calibrate keys
}

void QT60Reset()
{
  calikey();
}

//==============================================================================
//en/dis global interrupt
//input：none
//output：none
//==============================================================================
void GlobalInterrupt_diable()
{
  GIE_bit = FALSE;       //全局中断关闭
}

void GlobalInterrupt_enable()
{
  GIE_bit = TRUE;       //全局中断打开
}

//==============================================================================
//init system clock
//input：none
//output：none
//==============================================================================
void System_clock_initial()
{
  OSCCON = PRIMARY_OSC;       //00 = Primary oscillator
  while(!(OSCCON & OSTS));    //wait for clock to stable
}

//==============================================================================
//PIC18F6622定时器设置
//input：none
//output：none
//        TMR = 0Xfc18 = 64536
//        65536-64536 = 1000
//        1000 * 0.2us = 0.2ms
//==============================================================================
void Timer_initial()
{
  T0CON = 0;
  PSA_bit = 1;     //set timer0 as 16bit timer
  
  ////TMR0H = 0XFc;
  //TMR0L = 0x18;
                      //TEST
                      TMR0H = 0XFC;
                      TMR0L = 0xCD;
  TMR0IE_bit = 1;
  TMR0IP_bit = 1;
  TMR0IF_bit = 0;
  TMR0ON_bit = 1;
}

//==============================================================================
//PIC18F6622 IO config
//input：none
//output：none
//==============================================================================
void Port_initial()
{
                          //TEST
                          TRISG1_bit = 0;

//LED config
  PORTE = 0;
  TRISE = 0;
//LCD config
  PORTF = 0;
  TRISF &= ~(RS + LCD_RW_BIT + E);
  LATF6_bit = 0;                         //always set RW as 0
//MANUAL config
  TRISB3_bit = 1;
  TRISD7_bit = 1;
//alarm ssr config
  TRISB4_bit = 0;
  TRISB5_bit = 0;
  TRISB1_bit = 0;
  TRISB2_bit = 0;
//GFI config
  TRISF2_bit = 0;
  TRISF1_bit = 0;
//ADC config

//SSR config
  TRISC2_bit = 0;
  LATC2_bit = 0;
  TRISC5_bit = 0;
  LATC5_bit = 0;
//KEYBOARD config
//I2C config
  TRISC3_bit = 0;
  LATC3_bit = 1;
  TRISC4_bit = 0;
  LATC4_bit = 1;
  Delay_ms(2);
#ifdef SYSTEST
  TRISB0_bit = 1;   //change pin
  INTEDG0_bit = 1;
  INT0IE_bit = 1;
#else
  TRISB |= KEYBOARD_CHANNEL;
  INT0E_bit = 1;              //使能外部中断
  INTEDG0_bit = 1;            //上升沿触发
  INT0F_bit = 0;              //清中断标志
#endif
}

//==============================================================================
//PIC18F6622 SPI config
//input：none
//output：none
//==============================================================================
void Spi_initial()
{
  TRISD &= ~(GFIC_CHANNEL1 + RTD_CHANNEL1 + GFIC_CHANNEL2 + RTD_CHANNEL2);     //   BIT1 + BIT3

  SSP2CON1 &= ~SSPEN;
  TRISD &= ~(SDO2 + SCK2);
  TRISD |= SDI2;
  SSP2CON1 = SSPEN + SPI_MASTER_16FOSC + CKP;
  SSP2STAT = SMP;
  
  LATD |= (GFIC_CHANNEL1 + RTD_CHANNEL1 + GFIC_CHANNEL2 + RTD_CHANNEL2);
}

//==============================================================================
//PIC18F6622 I2C config
//input：none
//output：none
//==============================================================================
void I2C_initial()
{
#ifdef SYSTEST
  TRISC3_bit = 1;   //clk
  TRISC4_bit = 1;   //data

  SSP1CON1 = 0x28;
  SSP1CON2 = 0;
  SSP1ADD = 63;
  SSP1STAT = 0x80;
  SSPEN_SSP1CON1_bit = 1;
#else
  SSP1CON1 = ~SSPEN;
  TRISC |= (SDA1 + SDO1);
  SSP1CON1 = SSPEN + I2C_MASTER;
  SSP1STAT |= SMP;
  SSP1ADD = (unsigned char)((SYSTEM_CLOCK/I2C_BAUDRATE)/4 - 1);
#endif
}

//==============================================================================
//PIC18F6622 UART config
//input：none
//output：none
//==============================================================================
void Uart_initial()
{
    TRISF3_bit = 0;
  TRISF4_bit = 0;

  SYNC_TXSTA_bit = 0;
  SPEN_RCSTA_bit = 1;
  CREN_RCSTA_bit = 1;
  RC1IE_bit = 1;
  TRISC7_bit = 1;
  TRISC6_bit = 0;
  BRG16_bit = 0;
  
  switch(pSPCValue[Cable_Channel].SPCSetPoints.system_valueb.bite.baud)
  {
    case BAUDRATE_1200:
      SPBRGH1 = 1;
      SPBRG1 = 0X03;
      break;
    case BAUDRATE_2400:
      SPBRGH1 = 0;
      SPBRG1 = 0X81;
      break;
    case BAUDRATE_4800: 
      SPBRGH1 = 0;
      SPBRG1 = 0X40;
      break;
    case BAUDRATE_9600:
      SPBRGH1 = 0;
      SPBRG1 = 0X20;
      break;
    case BAUDRATE_19200:
      SPBRGH1 = 0;
      SPBRG1 = 0X0F;
      break;
  }

  TXEN_TXSTA_bit = 1;
  RC1IE_bit = 1;
  PEIE_bit = 1;

  en485rx();
  //en485tx();
}

//==============================================================================
//on chip 10bit ADC config
//input：none
//output：none
//==============================================================================
void ADC_initial()
{
  TRISA0_bit = 1;
  TRISA1_bit = 1;
  ADCON1 = 0x0d;  //AN0 AN1
  //ADCON0 = B2;    //AN1
  ADCON2 = B2 + B0 + B5;  //8Tad Focs/16
  ADFM_bit = 1;
  ADON_bit = 1;
}

//==============================================================================
//VACUUM DISPLAY
//input：none
//output：none
//==============================================================================
void LCD_initial()
{
//  LcdInit();
  Lcd_Init();
  Lcd_Cmd(_LCD_CLEAR);
  Lcd_Cmd(_LCD_CURSOR_OFF);
}

//==============================================================================
//Self test
//input：none
//output：none
//==============================================================================
void selftest()
{
  char i;

  LED_HEATER_ON = 1;
  LED_SYSTEM_FAIL = 1;
  LED_ALARM = 1;
  LED_COMMUNICATION_FAIL = 1;

  MemeSet(Info_Line1, 0x14, 16);
  MemeSet(Info_Line2, 0x14, 16);
  LCDUpdate();
  
  Delay_ms(2000);
  
  LED_HEATER_ON = 0;
  LED_SYSTEM_FAIL = 0;
  LED_ALARM = 0;
  LED_COMMUNICATION_FAIL = 0;
  
  MemeSet(Info_Line1, ' ', 16);
  MemeSet(Info_Line2, ' ', 16);
  LCDUpdate();
  
  Delay_ms(2000);
  for(i=0; i<16; i++) Info_Line1[i] = Version_title[i];
  for(i=0; i<16; i++) Info_Line2[i] = Version_content[i];
  LCDUpdate();
  Delay_ms(2000);
}

void SelfCheck()
{
  char RTDACheck=0,RTDBCheck=0,i;
  char SystemFailureEn=0;
  signed int *tempa_ptr, *tempb_ptr, *temp_ptr;
  signed int GFITestValue;
  unsigned long GFITestBUff=0;
  
  for(i=0;i<16;i++)
  {
    Info_Line1[i] = Selfcheck_str[i];
  }
  ClearStr(Info_Line2, 16);
  LCDUpdate();
  
  QT60Initial();

  freqency = 60;
  freq_pori = 83;
  
//RTD test
  for(i=0;i<2;i++)
  {
    RTDACheck = 0;
    RTDBCheck = 0;
  
    tempa_ptr = (signed int *)(&pSPCValue[i].SPCActual.TemperatureA);
    tempb_ptr = (signed int *)(&pSPCValue[i].SPCActual.TemperatureB);
    temp_ptr = (signed int *)(&pSPCValue[i].SPCActual.Temperature);

    GetTemperature(&pSPCValue[i].SPCActual.TemperatureA, i);

    if((*tempa_ptr == RTD_SHORT) || (*tempa_ptr == RTD_OPNE))
      RTDACheck = 1;
    if((*tempb_ptr == RTD_SHORT) || (*tempb_ptr == RTD_OPNE))
      RTDBCheck = 1;

    if(RTDACheck)
    {
      if(RTDBCheck || (pSPCValue[i].SPCSetPoints.system_valueb.bite.rtd_opr == ONE_RTD_MOD))
        SystemFailureEn = 1;
    }
  }
//GFI test
  //channel 1
  LATC2_bit = 1;      //SSR on
  Delay_ms(1000);
  LATF2_bit = 1;      //GFI generater on
  Delay_ms(500);
  
  for(i=0;i<5;i++)
  {
    GFITestBUff += GetGFI(GFIC_CHANNEL1,GFI_AD_COMMND);
  }
  GFITestValue = ConvertADtoGFI(GFITestBUff/5, 0);
  
  if(GFITestValue < 20)
    SystemFailureEn = 1;

  LATC2_bit = 0;
  LATF2_bit = 0;
  
  //channel 2
  GFITestBUff = 0;
  LATC5_bit = 1;      //SSR on
  Delay_ms(1000);
  LATF1_bit = 1;      //GFI generater on
  Delay_ms(500);

  for(i=0;i<5;i++)
  {
    GFITestBUff += GetGFI(GFIC_CHANNEL2,GFI_AD_COMMND);
  }
  GFITestValue = ConvertADtoGFI(GFITestBUff/5, 1);

  if(GFITestValue < 20)
    SystemFailureEn = 1;

  LATC5_bit = 0;
  LATF1_bit = 0;
    
//SetAlarm
  Delay_ms(2000);
  if(SystemFailureEn)
  {
    if(!(ActivedAlarms & SELFCHECKFAILURE))
      alarmoperate(SELFCHECKFAILURE,ENALARM);

    LED_SYSTEM_FAIL = 1;
    getParaChar(Info_Line1, ALARM_SELFCHECKFAIL_STR);
    ClearStr(Info_Line2, 16);
    LCDUpdate();
  }
  Delay_ms(2000);
  asm nop;
}