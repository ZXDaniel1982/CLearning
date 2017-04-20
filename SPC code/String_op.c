#include "systemvalue.h"
#include "SpcValue.h"

//==============================================================================
//get strings for certain parameters
//input��pointer of string, location of information
//output��none
//==============================================================================
void getParaChar(char *ptr, char locat)
{
  char i;
  for(i=0;i<16;i++)
    *(ptr+i) = ParaChar[locat][i];
}

//==============================================================================
//set strings to blank
//input��none
//output��none
//==============================================================================
void ClearStr(char *target, int len)
{
  int i;
  for(i=0; i<len; i++)
    *(target+i) = ' ';
}

void MemeSet(char *target, char Transdata, int len)
{
  int i;
  for(i=0; i<len; i++)
    *(target+i) = Transdata;
}