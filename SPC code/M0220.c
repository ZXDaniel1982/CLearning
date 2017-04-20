#include "systemvalue.h"
#include "M0220.h"
#include "PIC18F6622.h"

//==============================================================================
//send data
//input£∫none
//output£∫none
//==============================================================================
void nybble()
{
  LCD_EN = 1;
  Delay_us(50);
  LCD_EN = 0;
  Delay_us(50);
}

//==============================================================================
//write the command
//input£∫command
//output£∫none
//==============================================================================
void writecom(unsigned char command)
{
  LATE7_bit = (command >> 7) & 0x01;
  LATE6_bit = (command >> 6) & 0x01;
  LATE5_bit = (command >> 5) & 0x01;
  LATE4_bit = (command >> 4) & 0x01;
  LATF5_bit = 0;      //LCD_RS = 0;
  nybble();
  
  LATE7_bit = (command >> 3) & 0x01;
  LATE6_bit = (command >> 2) & 0x01;
  LATE5_bit = (command >> 1) & 0x01;
  LATE4_bit = command & 0x01;
  nybble();
}

//==============================================================================
//write the data
//input£∫data
//output£∫none
//==============================================================================
void writedata(unsigned char adata)
{
  LATE7_bit = (adata >> 7) & 0x01;
  LATE6_bit = (adata >> 6) & 0x01;
  LATE5_bit = (adata >> 5) & 0x01;
  LATE4_bit = (adata >> 4) & 0x01;
  LCD_RS = 1;
  nybble();
  
  LATE7_bit = (adata >> 3) & 0x01;
  LATE6_bit = (adata >> 2) & 0x01;
  LATE5_bit = (adata >> 1) & 0x01;
  LATE4_bit = adata & 0x01;
  nybble();
}

//==============================================================================
//LCD ‰≥ˆœ‘ æ
//input£∫lines to be displayed, charactors to be displayed
//output£∫none
//==============================================================================
void LcdOut(char num,char *line)
{
  char i;
  unsigned char com;

  if(num == 1) com = 0x01;
  else if(num == 2) com = 0xc0;

  writecom(com);

  for(i=0;i<16;i++)
  {
//    adata = line[i];
    writedata(line[i]);
  }
}

//==============================================================================
//LCD screen display
//input£∫pointer of first line, pointer of second line
//output£∫none
//==============================================================================
void LCD_output(UCHAR *txt1,UCHAR *txt2)
{
  char i;
  LcdOut(1, txt1);
  LcdOut(2, txt2);
  /*Lcd_Out(1,1,txt1);
  Lcd_Out(2,1,txt2);*/
  
  if(spc_system_flag.bite.char_flash)
  {
    Lcd_Cmd(_LCD_CURSOR_OFF);
    Lcd_Cmd(_LCD_SECOND_ROW);
    if(char_flash_loca > 1)
    {
      for(i=0; i<char_flash_loca-1; i++)
        Lcd_Cmd(_LCD_MOVE_CURSOR_RIGHT);
    }
      
    Lcd_Cmd(_LCD_BLINK_CURSOR_ON);
  }
}