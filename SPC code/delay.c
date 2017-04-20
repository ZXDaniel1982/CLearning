#include "systemvalue.h"
#include "delay.h"
#include "PIC18F6622.h"

//==============================================================================
//延时程序
//输入：延时时间 单位US
//输出：无
//==============================================================================
void delayMS(unsigned int delayCounter)
{
  unsigned int i,j;
  for(j=0; j<delayCounter; j++)
  {
    for(i=0; i<5000; i++);
  }
}

void Delay()
{
  unsigned int i;

  for(i = 0; i < 0xffff; i++);
  for(i = 0; i < 0xffff; i++);
  for(i = 0; i < 0xffff; i++);
}