#include "systemvalue.h"
#include "delay.h"
#include "PIC18F6622.h"

//==============================================================================
//��ʱ����
//���룺��ʱʱ�� ��λUS
//�������
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