#include "systemvalue.h"
#include "PIC18F6622.h"
#include "Calibration.h"
#include "MCP3202.h"
#include "RTD.h"
#include "String_op.h"
#include "Menuoperation.h"
#include "EEPROM.h"
#include "modbus.h"

#define GETCURRENTFORCALIBRATION 1
#define GETGFIFORCALIBRATION 0

#define CURRENT_LOW 1
#define GFI_LOW 0


char SPCCalibrationEN=1;
char SPCTestingEN=1;
char ChannelSwitch=0;
SPCCALIBRATIONSTRTCTURE SPCCalibrationStructure[2];
SPCCALIBRATIONBOX SPCCalibrationBox;

char CalibrationCommand[5] = {0};
char CalibrationCount=0;
int LowValueBuff[2] = {0};


code signed int ConstCalibrationBuff[60] =
{
  139, 19, 259, 47,  369, 91,  534,  195,  3092, 2242, 5230, 3838,
  22,  28, 162, 161, 552, 700, 1757, 2184, 2542, 2970,
  0, 1083, 0, 3678, 0, 1071, 0, 3670,
  139, 19, 259, 47,  369, 91,  534,  195,  3092, 2242, 5230, 3838,
  22,  28, 162, 161, 552, 700, 1757, 2184, 2542, 2970,
  0, 1063, 0, 3663, 0, 1057, 0, 3661
};

/*char CurrentCalibrationStep=0;
char GFICalibrationStep=0;*/

//temperature cali
/*
int TempHighResistorPointRTDA
int TempLowResistorPointRTDA
int TempHighResistorPointRTDB
int TempLowResistorPointRTDB

int TempHighPointRTDA
int TempLowPointRTDA
int TempHighPointRTDB
int TempLowPointRTDB
*/
//current cali
/*
int currentActuralPoint1
int currentActuralPoint2
int currentActuralPoint3
int currentActuralPoint4
int currentActuralPoint5

int currentPoint1
int currentPoint2
int currentPoint3
int currentPoint4
int currentPoint5
*/
//GFI cali
/*
int GFIActuralPoint1
int GFIActuralPoint2
int GFIActuralPoint3
int GFIActuralPoint4
int GFIActuralPoint5
int GFIActuralPoint6

int GFIPoint1
int GFIPoint2
int GFIPoint3
int GFIPoint4
int GFIPoint5
int GFIPoint6
*/

/*void SetCalibrationCmd(char CalibrationCmd)
{
  SPCCalibrationCmd = CalibrationCmd;
}

char GetCalibrationCmd()
{
  return SPCCalibrationCmd;
}*/

int GetCalibrationData(SPCCALIBRATIONREG *Ptr,char Location, char ActualReq)
{
  SPCCALIBRATIONREG *TempPtr;
  TempPtr = Ptr + Location;
  
  if(ActualReq)
    return TempPtr->CalibartionActural;
  else
    return TempPtr->CalibartionSetpoint;
}

void SetCommand(char CommandType, char CommandData)
{
  CalibrationCommand[CommandType] = CommandData;
}

char GetCommand(char CommandType)
{
  return CalibrationCommand[CommandType];
}

int MeasureCG(char CalibrateCGCmd)
{
  int CurrentBuff,GFIBuff;
  long CurrentAcc=0, GFIAcc=0;
  int SampleNum=0;
  char MeasureEn=0;
  
  MeasureEn = 1;
  CalibrationCommand[CURRENTGFI_MEASURE] = INITIAL_COMMAND;
  CalibrationCount = 0;
  
  while(MeasureEn)
  {
    CurrentAcc += GetGFI(ChannelSwitch, CURRENT_AD_COMMND);
    GFIAcc += GetGFI(ChannelSwitch, GFI_AD_COMMND);
    SampleNum++;
    
    if(CalibrationCommand[CURRENTGFI_MEASURE] == FINISH_COMMAND)
      MeasureEn = 0;
  }
  
  CalibrationCommand[CURRENTGFI_MEASURE] = 0;
  CalibrationCount = 0;
  if(CurrentAcc == 0)
    CurrentBuff = 0;
  else
    CurrentBuff = CurrentAcc/SampleNum;

  if(GFIAcc == 0)
    GFIBuff = 0;
  else
    GFIBuff = GFIAcc/SampleNum;

  if(CalibrateCGCmd)
    return CurrentBuff;
  else
    return GFIBuff;
}


void WaitForValue(char LowValueType)
{
  char Loop=1;
  int ValueTemp=0;

  while(Loop)
  {
    ValueTemp = MeasureCG(LowValueType);
    if(ValueTemp < 50)
      Loop = 0;
  }
}

void SPCCalibration()
{
  int ADBuff;
  SPCCALIBRATIONREG *Ptr;

  Ptr = (SPCCALIBRATIONREG *)&SPCCalibrationStructure[0];
  if(SPCCalibrationEN == 0)
    return;
  else
  {
    while(SPCCalibrationEN)
    {
      modbusprocess();
      switch(SPCCalibrationBox.CalibartionType)
      {
        case 0:
          getParaChar(Info_Line1, NOW_CALIBRATION_STR);
          getParaChar(Info_Line2, BLANK_STR);
          LCDUpdate();
          SPCCalibrationBox.CalibartionType = 25;
          SetModbusTxData(0);
          modbus_respond();
          break;
        case 1:  //temp cali A channel
          Delay_ms(600);
          ADBuff = MCP3202_GET_AD(RTD_CHANNEL1+ChannelSwitch,RTDA_AD_COMMND, 100);
          //SPCCalibrationReg[SPCCalibrationBox.CalibartionAddress].CalibartionSetpoint =  ADBuff;
          Ptr += SPCCalibrationBox.CalibartionAddress;
          Ptr->CalibartionSetpoint = ADBuff;
          Ptr->CalibartionActural = SPCCalibrationBox.CalibartionData;
          SPCCalibrationBox.CalibartionType = 25;
          SetModbusTxData(ADBuff);
          modbus_respond();
          break;
        case 2:  //temp cali B channel
          Delay_ms(600);
          ADBuff = MCP3202_GET_AD(RTD_CHANNEL1+ChannelSwitch,RTDB_AD_COMMND, 100);
          //SPCCalibrationReg[SPCCalibrationBox.CalibartionAddress].CalibartionSetpoint =  ADBuff;
          Ptr += SPCCalibrationBox.CalibartionAddress;
          Ptr->CalibartionSetpoint = ADBuff;
          Ptr->CalibartionActural = SPCCalibrationBox.CalibartionData;
          SPCCalibrationBox.CalibartionType = 25;
          SetModbusTxData(ADBuff);
          modbus_respond();
          break;
        case 3:  //current cali
          if(CalibrationCommand[CURRENT_CALIBRATION_STEP] == 0)
          {
            WaitForValue(CURRENT_LOW);
            SetModbusTxData(0);
          }
          else
          {
            Delay_ms(600);
            ADBuff = MeasureCG(GETCURRENTFORCALIBRATION);
            //SPCCalibrationReg[SPCCalibrationBox.CalibartionAddress].CalibartionSetpoint =  ADBuff;
            Ptr += SPCCalibrationBox.CalibartionAddress;
            Ptr->CalibartionSetpoint = ADBuff;
            Ptr->CalibartionActural = SPCCalibrationBox.CalibartionData;
            SetModbusTxData(ADBuff);
          }
          CalibrationCommand[CURRENT_CALIBRATION_STEP] ^= 1;
          SPCCalibrationBox.CalibartionType = 25;
          modbus_respond();
          break;
        case 4:  //GFI cali
          if(CalibrationCommand[GFI_CALIBRATION_STEP] == 0)
          {
            WaitForValue(GFI_LOW);
            SetModbusTxData(0);
          }
          else
          {
            Delay_ms(600);
            ADBuff = MeasureCG(GETGFIFORCALIBRATION);
            //SPCCalibrationReg[SPCCalibrationBox.CalibartionAddress].CalibartionSetpoint =  ADBuff;
            Ptr += SPCCalibrationBox.CalibartionAddress;
            Ptr->CalibartionSetpoint = ADBuff;
            Ptr->CalibartionActural = SPCCalibrationBox.CalibartionData;
            SetModbusTxData(ADBuff);
          }
          CalibrationCommand[GFI_CALIBRATION_STEP] ^= 1;
          SPCCalibrationBox.CalibartionType = 25;
          modbus_respond();
          break;
        case 5:  //temp a test
          Delay_ms(600);
          ADBuff = MCP3202_GET_AD(RTD_CHANNEL1+ChannelSwitch,RTDA_AD_COMMND, 100);
          ADBuff = ConvertADtoTEMP(ADBuff, CALI_RTDA_50, CALI_RTDA_500, 0);
          SPCCalibrationBox.CalibartionType = 25;
          SetModbusTxData(ADBuff);
          modbus_respond();
          break;
        case 6:  //temp b test
          Delay_ms(600);
          ADBuff = MCP3202_GET_AD(RTD_CHANNEL1+ChannelSwitch,RTDB_AD_COMMND, 100);
          ADBuff = ConvertADtoTEMP(ADBuff, CALI_RTDB_50, CALI_RTDB_500, 0);
          SPCCalibrationBox.CalibartionType = 25;
          SetModbusTxData(ADBuff);
          modbus_respond();
          break;
        case 7:  //current test
          if(CalibrationCommand[CURRENT_CALIBRATION_STEP] == 0)
          {
            WaitForValue(CURRENT_LOW);
            SetModbusTxData(0);
          }
          else
          {
            Delay_ms(600);
            ADBuff = MeasureCG(GETCURRENTFORCALIBRATION);
            ADBuff = ConvertADtoCurrent(ADBuff,0);
            SetModbusTxData(ADBuff*10);
          }
          CalibrationCommand[CURRENT_CALIBRATION_STEP] ^= 1;
          SPCCalibrationBox.CalibartionType = 25;
          modbus_respond();
          break;
        case 8:  //gfi test
          if(CalibrationCommand[GFI_CALIBRATION_STEP] == 0)
          {
            WaitForValue(GFI_LOW);
            SetModbusTxData(0);
          }
          else
          {
            Delay_ms(600);
            ADBuff = MeasureCG(GETGFIFORCALIBRATION);
            ADBuff = ConvertADtoGFI(ADBuff, 0);
            SetModbusTxData(ADBuff*10);
          }
          CalibrationCommand[GFI_CALIBRATION_STEP] ^= 1;
          SPCCalibrationBox.CalibartionType = 25;
          modbus_respond();
          break;
        case 9:  //SSR test
          LATC2_bit = 1;
          Delay_ms(600);
          ADBuff = MeasureCG(GETCURRENTFORCALIBRATION);
          ADBuff = ConvertADtoCurrent(ADBuff,0);
          SetModbusTxData(ADBuff*10);
          LATC2_bit = 0;
          SPCCalibrationBox.CalibartionType = 25;
          modbus_respond();
          break;
        case 10:
          LATB4_bit = 1;
          LATB5_bit = 1;
          ADBuff = 0;
          SPCCalibrationBox.CalibartionType = 25;
          SetModbusTxData(ADBuff);
          modbus_respond();
          Delay_ms(600);
          LATB4_bit = 0;
          LATB5_bit = 0;
          break;
        case 11:
          Delay_ms(600);
          ADBuff = RB3_bit;
          SPCCalibrationBox.CalibartionType = 25;
          SetModbusTxData(ADBuff);
          modbus_respond();
          break;
        case 12:  //finish cali
          getParaChar(Info_Line1, NEED_TESTING_STR);
          getParaChar(Info_Line2, BLANK_STR);
          EEPROM_set(0x300,sizeof(SPCCALIBRATIONREG)*30,(UCHAR*)&SPCCalibrationStructure[0]);
          LCDUpdate();
          SPCCalibrationBox.CalibartionType = 25;
          SetModbusTxData(0);
          modbus_respond();
          break;
        case 13:  //start test
          getParaChar(Info_Line1, NOW_TESTING_STR);
          getParaChar(Info_Line2, BLANK_STR);
          LCDUpdate();
          SPCCalibrationBox.CalibartionType = 25;
          SetModbusTxData(0);
          modbus_respond();
          break;
        case 14:
          SPCTestingEN = 0;
          SPCCalibrationEN = 0;
          EEPROM_set(0x2f1, 1, (char*)&SPCTestingEN);
          EEPROM_set(0x2f0, 1, (char*)&SPCCalibrationEN);
          SetModbusTxData(0);
          modbus_respond();
          break;
        default:
          break;
      }
    }
  }
    
  if(SPCTestingEN == 0)
    return;
  else
  {
  
  }
}

void InitialCalibrationReg()
{
  signed int *Ptr;
  char i;
  
  Ptr = (signed int *)&SPCCalibrationStructure[0];
  for(i=0;i<60;i++)
  {
    *(Ptr+i) = ConstCalibrationBuff[i];
  }
}