#include "systemvalue.h"
#include "EEPROM.h"
#include "PIC18F6622.h"

//==============================================================================
//read from EEP
//input£ºread address,data length, pointer of data
//output£ºnone
//==============================================================================
void EEPROM_get(UINT EEPROM_READ_ADDRESS,UCHAR Len,UCHAR *readbuffer)
{
  UINT i;

  for(i=0; i<Len; i++)
    *(readbuffer+i) = EEPROM_Read(EEPROM_READ_ADDRESS+i);
}

//==============================================================================
//write EEP
//input£ºwrite address,data length, pointer of data
//output£ºnone
//==============================================================================
void EEPROM_set(UINT EEPROM_WRITE_ADDRESS,UCHAR Len,UCHAR *writebuffer)
{
  UINT i;

  for(i=0; i<Len; i++)
  {
      EEPROM_Write(EEPROM_WRITE_ADDRESS+i,*(writebuffer+i));
  }
}

//==============================================================================
//if it is the first time SPC run
//input£ºnone
//output£ºnone
//==============================================================================
UCHAR SPCIfFirstRun()
{
  volatile UCHAR temp;
  
  temp = EEPROM_Read(0x00);

  if(temp == 0x55)
    return FALSE;
  else
  {
    EEPROM_Write(0x00,0x55);
    return TRUE;
  }
}