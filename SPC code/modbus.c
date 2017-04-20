#include "systemvalue.h"
#include "PIC18F6622.h"
#include "modbus.h"
#include "SpcValue.h"
#include "usart.h"
#include "String_op.h"
#include "function.h"
#include "EEPROM.h"
#include "Spcsystem.h"
#include "RTD.h"
#include "SSR.h"
#include "Calibration.h"

#define ERROR_FUNCTIONCODE 1
#define ERROR_REGISTER 2

#define PRODUCTCODE 0X5656

char ModbusRecived=0, ModbusValid=0;
unsigned int ModbusCounter=0;
TEMPERATURE TempBuff;

data char modbus_rcdata[100], modbus_txdata[100];
unsigned int modbus_rcn=0, modbus_txn=0;

int *ModbusList[] =
{
//setpoint
  (int *)&pSPCValue[0].SPCSetPoints.MaintainTemp.Temperature_F,                        //0
  (int *)&pSPCValue[1].SPCSetPoints.MaintainTemp.Temperature_F,                        //1
  (int *)&pSPCValue[0].SPCSetPoints.MaintainTemp.Temperature_C,                        //2
  (int *)&pSPCValue[1].SPCSetPoints.MaintainTemp.Temperature_C,                        //3
  (int *)&pSPCValue[0].SPCSetPoints.LowTemp.Temperature_F,                             //4
  (int *)&pSPCValue[1].SPCSetPoints.LowTemp.Temperature_F,                             //5
  (int *)&pSPCValue[0].SPCSetPoints.LowTemp.Temperature_C,                             //6
  (int *)&pSPCValue[1].SPCSetPoints.LowTemp.Temperature_C,                             //7
  (int *)&pSPCValue[0].SPCSetPoints.HighTemp.Temperature_F,                            //8
  (int *)&pSPCValue[1].SPCSetPoints.HighTemp.Temperature_F,                            //9
  (int *)&pSPCValue[0].SPCSetPoints.HighTemp.Temperature_C,                            //10
  (int *)&pSPCValue[1].SPCSetPoints.HighTemp.Temperature_C,                            //11
  (int *)&pSPCValue[0].SPCSetPoints.DeadBand.Temperature_F,                            //12
  (int *)&pSPCValue[1].SPCSetPoints.DeadBand.Temperature_F,                            //13
  (int *)&pSPCValue[0].SPCSetPoints.DeadBand.Temperature_C,                            //14
  (int *)&pSPCValue[1].SPCSetPoints.DeadBand.Temperature_C,                            //15
  (int *)&pSPCValue[0].SPCSetPoints.LowCurrent,                                        //16
  (int *)&pSPCValue[1].SPCSetPoints.LowCurrent,                                        //17
  (int *)&pSPCValue[0].SPCSetPoints.HighCurrent,                                       //18
  (int *)&pSPCValue[1].SPCSetPoints.HighCurrent,                                       //19
  (int *)&pSPCValue[0].SPCSetPoints.GFIAlarm,                                          //20
  (int *)&pSPCValue[1].SPCSetPoints.GFIAlarm,                                          //21
  (int *)&pSPCValue[0].SPCSetPoints.GFITrip,                                           //22
  (int *)&pSPCValue[1].SPCSetPoints.GFITrip,                                           //23
  (int *)&pSPCValue[0].SPCSetPoints.LimitedCurrent,                                    //24
  (int *)&pSPCValue[1].SPCSetPoints.LimitedCurrent,                                    //25
  (int *)&pSPCValue[0].SPCSetPoints.SoftStartTime,                                     //26
  (int *)&pSPCValue[1].SPCSetPoints.SoftStartTime,                                     //27
  (int *)&pSPCValue[0].SPCSetPoints.AlarmOutTest,                                      //28
  (int *)&pSPCValue[1].SPCSetPoints.AlarmOutTest,                                      //29
  (int *)&pSPCValue[0].SPCSetPoints.HeaterTest,                                        //30
  (int *)&pSPCValue[1].SPCSetPoints.HeaterTest,                                        //31
  (int *)&pSPCValue[0].SPCSetPoints.GFTest,                                            //32
  (int *)&pSPCValue[1].SPCSetPoints.GFTest,                                            //33
  (int *)&pSPCValue[0].SPCSetPoints.HeaterName[0],                                        //34
  (int *)&pSPCValue[0].SPCSetPoints.HeaterName[0]+1,                                      //35
  (int *)&pSPCValue[0].SPCSetPoints.HeaterName[0]+2,                                      //36
  (int *)&pSPCValue[0].SPCSetPoints.HeaterName[0]+3,                                      //37
  (int *)&pSPCValue[0].SPCSetPoints.HeaterName[0]+4,                                      //38
  (int *)&pSPCValue[0].SPCSetPoints.HeaterName[0]+5,                                      //39
  (int *)&pSPCValue[0].SPCSetPoints.HeaterName[0]+6,                                      //40
  (int *)&pSPCValue[0].SPCSetPoints.HeaterName[0]+7,                                      //41
  (int *)&pSPCValue[1].SPCSetPoints.HeaterName[0],                                        //42
  (int *)&pSPCValue[1].SPCSetPoints.HeaterName[0]+1,                                      //43
  (int *)&pSPCValue[1].SPCSetPoints.HeaterName[0]+2,                                      //44
  (int *)&pSPCValue[1].SPCSetPoints.HeaterName[0]+3,                                      //45
  (int *)&pSPCValue[1].SPCSetPoints.HeaterName[0]+4,                                      //46
  (int *)&pSPCValue[1].SPCSetPoints.HeaterName[0]+5,                                      //47
  (int *)&pSPCValue[1].SPCSetPoints.HeaterName[0]+6,                                      //48
  (int *)&pSPCValue[1].SPCSetPoints.HeaterName[0]+7,                                      //49
  (int *)&pSPCValue[0].SPCSetPoints.LowVoltage,                                        //50
  (int *)&pSPCValue[0].SPCSetPoints.HighVoltage,                                       //51
  (int *)&pSPCValue[0].SPCSetPoints.AutoTestTime,                                      //52
  (int *)&pSPCValue[0].SPCSetPoints.DisplayTime,                                       //53
  (int *)&pSPCValue[0].SPCSetPoints.CostPerKWH,                                        //54
  (int *)&pSPCValue[0].SPCSetPoints.system_valueb,                                     //55
  (int *)&pSPCValue[0].SPCSetPoints.system_valueb+1,                                   //56
  (int *)&pSPCValue[1].SPCSetPoints.system_valueb,                                     //57
  (int *)&pSPCValue[1].SPCSetPoints.system_valueb+1,                                   //58
//actual
  (int *)&pSPCValue[0].SPCActual.Temperature.Temperature_F,                            //59
  (int *)&pSPCValue[1].SPCActual.Temperature.Temperature_F,                            //60
  (int *)&pSPCValue[0].SPCActual.Temperature.Temperature_C,                            //61
  (int *)&pSPCValue[1].SPCActual.Temperature.Temperature_C,                            //62
  (int *)&pSPCValue[0].SPCActual.TemperatureA.Temperature_F,                           //63
  (int *)&pSPCValue[1].SPCActual.TemperatureA.Temperature_F,                           //64
  (int *)&pSPCValue[0].SPCActual.TemperatureA.Temperature_C,                           //65
  (int *)&pSPCValue[1].SPCActual.TemperatureA.Temperature_C,                           //66
  (int *)&pSPCValue[0].SPCActual.TemperatureB.Temperature_F,                           //67
  (int *)&pSPCValue[1].SPCActual.TemperatureB.Temperature_F,                           //68
  (int *)&pSPCValue[0].SPCActual.TemperatureB.Temperature_C,                           //69
  (int *)&pSPCValue[1].SPCActual.TemperatureB.Temperature_C,                           //70
  (int *)&pSPCValue[0].SPCActual.HeaterPow,                                            //71
  (int *)&pSPCValue[1].SPCActual.HeaterPow,                                            //72
  (int *)&pSPCValue[0].SPCActual.Current_RMS,                                          //73
  (int *)&pSPCValue[1].SPCActual.Current_RMS,                                          //74
  (int *)&pSPCValue[0].SPCActual.GFICurrent,                                           //75
  (int *)&pSPCValue[1].SPCActual.GFICurrent,                                           //76
//statistics
  (int *)&pSPCValue[0].SPCStatistics.MaximumTemp.Temperature_F,                        //77
  (int *)&pSPCValue[1].SPCStatistics.MaximumTemp.Temperature_F,                        //78
  (int *)&pSPCValue[0].SPCStatistics.MaximumTemp.Temperature_C,                        //79
  (int *)&pSPCValue[1].SPCStatistics.MaximumTemp.Temperature_C,                        //80
  (int *)&pSPCValue[0].SPCStatistics.MinimumTemp.Temperature_F,                        //81
  (int *)&pSPCValue[1].SPCStatistics.MinimumTemp.Temperature_F,                        //82
  (int *)&pSPCValue[0].SPCStatistics.MinimumTemp.Temperature_C,                        //83
  (int *)&pSPCValue[1].SPCStatistics.MinimumTemp.Temperature_C,                        //84
  (int *)&pSPCValue[0].SPCStatistics.MaximumCurrent,                                   //85
  (int *)&pSPCValue[1].SPCStatistics.MaximumCurrent,                                   //86
  (int *)&pSPCValue[0].SPCStatistics.MaximumGFCurrent,                                 //87
  (int *)&pSPCValue[1].SPCStatistics.MaximumGFCurrent,                                 //88
  (int *)&pSPCValue[0].SPCStatistics.EnergyUsed,                                       //89
  (int *)&pSPCValue[1].SPCStatistics.EnergyUsed,                                       //90
  (int *)&pSPCValue[0].SPCStatistics.EnergyCost,                                       //91
  (int *)&pSPCValue[0].SPCStatistics.EnergyCost+1,                                     //92
  (int *)&pSPCValue[1].SPCStatistics.EnergyCost,                                       //93
  (int *)&pSPCValue[1].SPCStatistics.EnergyCost+1,                                     //94
  (int *)&pSPCValue[0].SPCStatistics.RunTime,                                          //95
  (int *)&pSPCValue[0].SPCStatistics.RunTime+1,                                        //96
  (int *)&pSPCValue[1].SPCStatistics.RunTime,                                          //97
  (int *)&pSPCValue[1].SPCStatistics.RunTime+1,                                        //98
  (int *)&pSPCValue[0].SPCStatistics.HeaterOnTime,                                     //99
  (int *)&pSPCValue[1].SPCStatistics.HeaterOnTime,                                     //100
  (int *)&pSPCValue[0].SPCStatistics.MaximumVoltage,                                   //101
  (int *)&pSPCValue[0].SPCStatistics.MinimumVoltage,                                   //102
  (int *)&pSPCValue[0].SPCStatistics.Version                                           //103
};



/*code unsigned int ResetCmd[] =
{
  (ACTURAL_MAX << 8) | STATIS_MAX_TEMP,
  (ACTURAL_MIN << 8) | STATIS_MIN_TEMP,
  (ACTURAL_CURRENT_MAX << 8) | STATIS_CURRENT,
  (ACTURAL_GFI_MAX << 8) | STATIS_GFI,
  (ACTURAL_VOLT_MAX << 8) | STATIS_MAX_VOLT,
  (ACTURAL_VOLT_MIN << 8) | STATIS_MIN_VOLT,
};*/


code char CRCHi_exp[] =
{
  0x00, 0xc1, 0x81, 0x40, 0x01, 0xc0, 0x80, 0x41, 0x01, 0xc0, 0x80, 0x41, 0x00, 0xc1, 0x81,
  0x40, 0x01, 0xc0, 0x80, 0x41, 0x00, 0xc1, 0x81, 0x40, 0x00, 0xc1, 0x81, 0x40, 0x01, 0xc0,
  0x80, 0x41, 0x01, 0xc0, 0x80, 0x41, 0x00, 0xc1, 0x81, 0x40, 0x00, 0xc1, 0x81, 0x40, 0x01,
  0xc0, 0x80, 0x41, 0x00, 0xc1, 0x81, 0x40, 0x01, 0xc0, 0x80, 0x41, 0x01, 0xc0, 0x80, 0x41,
  0x00, 0xc1, 0x81, 0x40, 0x01, 0xc0, 0x80, 0x41, 0x00, 0xc1, 0x81, 0x40, 0x00, 0xc1, 0x81,
  0x40, 0x01, 0xc0, 0x80, 0x41, 0x00, 0xc1, 0x81, 0x40, 0x01, 0xc0, 0x80, 0x41, 0x01, 0xc0,
  0x80, 0x41, 0x00, 0xc1, 0x81, 0x40, 0x00, 0xc1, 0x81, 0x40, 0x01, 0xc0, 0x80, 0x41, 0x01,
  0xc0, 0x80, 0x41, 0x00, 0xc1, 0x81, 0x40, 0x01, 0xc0, 0x80, 0x41, 0x00, 0xc1, 0x81, 0x40,
  0x00, 0xc1, 0x81, 0x40, 0x01, 0xc0, 0x80, 0x41, 0x01, 0xc0, 0x80, 0x41, 0x00, 0xc1, 0x81,
  0x40, 0x00, 0xc1, 0x81, 0x40, 0x01, 0xc0, 0x80, 0x41, 0x00, 0xc1, 0x81, 0x40, 0x01, 0xc0,
  0x80, 0x41, 0x01, 0xc0, 0x80, 0x41, 0x00, 0xc1, 0x81, 0x40, 0x00, 0xc1, 0x81, 0x40, 0x01,
  0xc0, 0x80, 0x41, 0x01, 0xc0, 0x80, 0x41, 0x00, 0xc1, 0x81, 0x40, 0x01, 0xc0, 0x80, 0x41,
  0x00, 0xc1, 0x81, 0x40, 0x00, 0xc1, 0x81, 0x40, 0x01, 0xc0, 0x80, 0x41, 0x00, 0xc1, 0x81,
  0x40, 0x01, 0xc0, 0x80, 0x41, 0x01, 0xc0, 0x80, 0x41, 0x00, 0xc1, 0x81, 0x40, 0x01, 0xc0,
  0x80, 0x41, 0x00, 0xc1, 0x81, 0x40, 0x00, 0xc1, 0x81, 0x40, 0x01, 0xc0, 0x80, 0x41, 0x01,
  0xc0, 0x80, 0x41, 0x00, 0xc1, 0x81, 0x40, 0x00, 0xc1, 0x81, 0x40, 0x01, 0xc0, 0x80, 0x41,
  0x00, 0xc1, 0x81, 0x40, 0x01, 0xc0, 0x80, 0x41, 0x01, 0xc0, 0x80, 0x41, 0x00, 0xc1, 0x81,
  0x40
} ;

code char CRCLo_exp[] =
{
  0x00, 0xc0, 0xc1, 0x01, 0xc3, 0x03, 0x02, 0xc2, 0xc6, 0x06, 0x07, 0xc7, 0x05, 0xc5, 0xc4,
  0x04, 0xcc, 0x0c, 0x0d, 0xcd, 0x0f, 0xcf, 0xce, 0x0e, 0x0a, 0xca, 0xcb, 0x0b, 0xc9, 0x09,
  0x08, 0xc8, 0xd8, 0x18, 0x19, 0xd9, 0x1b, 0xdb, 0xda, 0x1a, 0x1e, 0xde, 0xdf, 0x1f, 0xdd,
  0x1d, 0x1c, 0xdc, 0x14, 0xd4, 0xd5, 0x15, 0xd7, 0x17, 0x16, 0xd6, 0xd2, 0x12, 0x13, 0xd3,
  0x11, 0xd1, 0xd0, 0x10, 0xf0, 0x30, 0x31, 0xf1, 0x33, 0xf3, 0xf2, 0x32, 0x36, 0xf6, 0xf7,
  0x37, 0xf5, 0x35, 0x34, 0xf4, 0x3c, 0xfc, 0xfd, 0x3d, 0xff, 0x3f, 0x3e, 0xfe, 0xfa, 0x3a,
  0x3b, 0xfb, 0x39, 0xf9, 0xf8, 0x38, 0x28, 0xe8, 0xe9, 0x29, 0xeb, 0x2b, 0x2a, 0xea, 0xee,
  0x2e, 0x2f, 0xef, 0x2d, 0xed, 0xec, 0x2c, 0xe4, 0x24, 0x25, 0xe5, 0x27, 0xe7, 0xe6, 0x26,
  0x22, 0xe2, 0xe3, 0x23, 0xe1, 0x21, 0x20, 0xe0, 0xa0, 0x60, 0x61, 0xa1, 0x63, 0xa3, 0xa2,
  0x62, 0x66, 0xa6, 0xa7, 0x67, 0xa5, 0x65, 0x64, 0xa4, 0x6c, 0xac, 0xad, 0x6d, 0xaf, 0x6f,
  0x6e, 0xae, 0xaa, 0x6a, 0x6b, 0xab, 0x69, 0xa9, 0xa8, 0x68, 0x78, 0xb8, 0xb9, 0x79, 0xbb,
  0x7b, 0x7a, 0xba, 0xbe, 0x7e, 0x7f, 0xbf, 0x7d, 0xbd, 0xbc, 0x7c, 0xb4, 0x74, 0x75, 0xb5,
  0x77, 0xb7, 0xb6, 0x76, 0x72, 0xb2, 0xb3, 0x73, 0xb1, 0x71, 0x70, 0xb0, 0x50, 0x90, 0x91,
  0x51, 0x93, 0x53, 0x52, 0x92, 0x96, 0x56, 0x57, 0x97, 0x55, 0x95, 0x94, 0x54, 0x9c, 0x5c,
  0x5d, 0x9d, 0x5f, 0x9f, 0x9e, 0x5e, 0x5a, 0x9a, 0x9b, 0x5b, 0x99, 0x59, 0x58, 0x98, 0x88,
  0x48, 0x49, 0x89, 0x4b, 0x8b, 0x8a, 0x4a, 0x4e, 0x8e, 0x8f, 0x4f, 0x8d, 0x4d, 0x4c, 0x8c,
  0x44, 0x84, 0x85, 0x45, 0x87, 0x47, 0x46, 0x86, 0x82, 0x42, 0x43, 0x83, 0x41, 0x81, 0x80,
  0x40
} ;

//code int ProductCode = 0x5656;

//==============================================================================
//modbus处理函数
//输入：无
//输出：无
//==============================================================================
int* getRegisterAddr(char RegisterAdrr)
{
  int *ret;

  if(RegisterAdrr < 44)
  {
    ret = (int *)&pSPCValue[Cable_Channel].SPCSetPoints;
    ret += RegisterAdrr;
  }
  else if(RegisterAdrr < 56)
  {
    ret = (int *)&pSPCValue[Cable_Channel].SPCActual;
    ret += (RegisterAdrr-44);
  }
  else if(RegisterAdrr < 70)
  {
    ret = (int *)&pSPCValue[Cable_Channel].SPCStatistics;
    ret += (RegisterAdrr-56);
  }
  else if(RegisterAdrr < 90)
  {
    ret = (int *)&pSPCAlarm.spcalarms.alarm_typ;
    ret += (RegisterAdrr-70);
  }
  else if(RegisterAdrr == 90)
  {
    //ret = (int *)&ActivedLogs;
  }

  return ret;
}

char SetErrorMessage(char *ptr, char errortype)
{
  unsigned int crc_temp;
  char len=0;

  *(ptr++) = 1;
  len++;
  *(ptr++) = 1;
  len++;
  *(ptr++) = errortype;
  len++;

  crc_temp =  CRCChecksum(ptr, 3);
  *(ptr++) = (crc_temp >> 8) & 0xff;
  len++;
  *ptr = crc_temp & 0xff;
  len++;
  
  return len;
}

void modbusprocess()
{
  volatile int modbus_data, index, length;
  volatile unsigned int crc_check, crc_rx, crc_tx, AlarmType;
  char i,j, ErrorDetected=0;
  int *Ptr;
  char *PtrTemp;
  volatile unsigned char StringLocate, ResetLocate;
  char ParameterChanged = 0;
  int temp;
  
  CommunicationErrorCheck();
  
  if(ModbusValid == 0)
    return;
  ModbusValid = 0;
  RC1IE_bit = 0;
  //en485tx();

  modbus_txn = 0;
  index = (((UINT)(modbus_rcdata[2]) << 8) | modbus_rcdata[3]);
  length = (((UINT)(modbus_rcdata[4]) << 8) | modbus_rcdata[5]);
  crc_rx = (((unsigned int)(modbus_rcdata[modbus_rcn-2]) << 8) | modbus_rcdata[modbus_rcn-1]);

  if((modbus_rcdata[0] == pSPCValue[Cable_Channel].SPCSetPoints.ModbusAdd) || (modbus_rcdata[0] == 255))
  {
    crc_check = CRCChecksum(modbus_rcdata, modbus_rcn-2);
    
    if(crc_check == crc_rx)
    {
      modbus_txdata[modbus_txn] = modbus_rcdata[modbus_txn];                     //0
      modbus_txn++;
      modbus_txdata[modbus_txn] = modbus_rcdata[modbus_txn];                     //1
      modbus_txn++;

      switch(modbus_rcdata[1])
      {
        case 0x03:     //读bytes
          if(modbus_rcn == 8)
          {
            modbus_txdata[modbus_txn++] = length*2;

            for(i=0; i<length ;i++)
            {
              if(((index+i)>=0) && ((index+i)<104))                         //(((index+i)>0) && ((index+i)<90))
              {
                //Ptr = getRegisterAddr(index+i);
                Ptr = ModbusList[index+i];
                modbus_txdata[modbus_txn++] = (*Ptr>>8) & 0xff;
                modbus_txdata[modbus_txn++] = *Ptr & 0xff;
              }
              else if((index+i)<104+40)
              {
                Ptr = (int *)&pSPCAlarm.spcalarms.alarm_typ;
                modbus_txdata[modbus_txn++] = (*Ptr>>8) & 0xff;
                modbus_txdata[modbus_txn++] = *Ptr & 0xff;
              }
              else if((index+i)<104+80)
              {
                Ptr = (int *)&pSPCAlarm.spclogs.log_typ;
                modbus_txdata[modbus_txn++] = (*Ptr>>8) & 0xff;
                modbus_txdata[modbus_txn++] = *Ptr & 0xff;
              }
              else if((index+i)==0x7fff0)
              {
                *Ptr = PRODUCTCODE;
                modbus_txdata[modbus_txn++] = (*Ptr>>8) & 0xff;
                modbus_txdata[modbus_txn++] = *Ptr & 0xff;
              }
              else
              {
                //地址错误
                modbus_txn = SetErrorMessage(modbus_txdata, ERROR_REGISTER);
                ErrorDetected = 1;
                break;
              }
            }

            if(ErrorDetected == 0)
            {
              crc_tx = CRCChecksum(modbus_txdata, modbus_txn);
              modbus_txdata[modbus_txn++] = (crc_tx >> 8) & 0xff;
              modbus_txdata[modbus_txn++] = crc_tx & 0xff;
            }
          }
          else          //长度不匹配
          {}
          break;
        case 0x05:     //写bit
          if(modbus_rcn == 8)
          {
            modbus_data = (((unsigned int)(modbus_rcdata[4]) << 8) | modbus_rcdata[5]);
            if(modbus_data == 0xff00)       //确定
            {
              if(index < 184)
              {
                //错误地址
                modbus_txn = SetErrorMessage(modbus_txdata, ERROR_REGISTER);
                ErrorDetected = 1;
              }
              else if(index < 186)
              {
                temp = index-184;
                if(temp == 0)
                {
                  MemeSet((char *)&pSPCAlarm.spcalarms, 0, sizeof(SPCALARM));
                  ForceSSROFFCondition[0] &= ~GFITRIPFORCEOFF;
                  ForceSSROFFCondition[1] &= ~GFITRIPFORCEOFF;
                  ActivedAlarms = 0;
                }
                else
                {
                  MemeSet((char *)&pSPCAlarm.spclogs, 0, sizeof(SPCALARM));
                }
              }
              else if(index < 188)
              {
                temp = index-186;
                if(temp < 6)
                {
                  PtrTemp = &Statis_flag[0];
                  StringLocate = (ResetCmd[temp]>>8) & 0xff;
                }
                else
                {
                  temp -= 6;
                  PtrTemp = &Statis_flag[1];
                  StringLocate = (ResetCmd[temp]>>8) & 0xff;
                  StringLocate++;
                }
                ResetLocate = ResetCmd[temp] & 0xff;
                *PtrTemp |= ResetLocate;
                ClearStr(Actural_disp_str[StringLocate], 16);
              }
              else if(index < 190)
              {
                temp = index-188;
                pSPCValue[temp].SPCStatistics.EnergyUsed = 0;
                SetIntStr((int*)&pSPCValue[temp].SPCStatistics.EnergyUsed, CH1_ACTURAL_ENEGY+temp, UNIT_ENEGRY, 3);
              }
              else if(index < 192)
              {
                temp = index-190;
                pSPCValue[temp].SPCStatistics.EnergyCost = 0;
                SetCostStr(0, CH1_ACTURAL_COST+temp);
              }
              else if(index < 194)
              {
                temp = index-192;
                pSPCValue[temp].SPCStatistics.RunTime = 0;
                SetOntimeStr(0, CH1_ACTURAL_ONTIME+temp);
              }
              else if(index < 196)
              {
                temp = index-194;
                pSPCValue[temp].SPCStatistics.HeaterOnTime = 0;
                SetIntStr((int*)&pSPCValue[temp].SPCStatistics.HeaterOnTime, CH1_ACTURAL_ENEGY+temp, UNIT_ENEGRY, 3);
              }
              else if(index == 196)
              {
                MemeSet((char *)&pSPCValue[0].SPCStatistics, 0, sizeof(STATISTICS));
                MemeSet((char *)&pSPCValue[1].SPCStatistics, 0, sizeof(STATISTICS));
                for(i=10; i<20;i++)
                  ClearStr(Actural_disp_str[i], 16);
                Statis_flag[0] = (STATIS_MAX_TEMP + STATIS_MIN_TEMP + STATIS_MAX_VOLT + STATIS_MIN_VOLT + STATIS_CURRENT + STATIS_GFI);
                Statis_flag[1] = (STATIS_MAX_TEMP + STATIS_MIN_TEMP + STATIS_MAX_VOLT + STATIS_MIN_VOLT + STATIS_CURRENT + STATIS_GFI);
                SetIntStr((int*)&pSPCValue[0].SPCStatistics.EnergyUsed, CH1_ACTURAL_ENEGY, UNIT_ENEGRY, 3);
                SetIntStr((int*)&pSPCValue[1].SPCStatistics.EnergyUsed, CH1_ACTURAL_ENEGY, UNIT_ENEGRY, 3);
                SetIntStr((int*)&pSPCValue[0].SPCStatistics.HeaterOnTime, CH1_ACTURAL_ENEGY, UNIT_ENEGRY, 3);
                SetIntStr((int*)&pSPCValue[1].SPCStatistics.HeaterOnTime, CH1_ACTURAL_ENEGY, UNIT_ENEGRY, 3);
                SetCostStr(0, CH1_ACTURAL_COST);
                SetOntimeStr(0, CH1_ACTURAL_ONTIME);
                SetCostStr(0, CH2_ACTURAL_COST);
                SetOntimeStr(0, CH2_ACTURAL_ONTIME);
              }
              else if(index == 197)
              {
                if(Alarmstat == 0)
                {
                  Alarm_SSR_off(0);
                }
              }
            }
            else         //错误数据
            {

            }
            
            if(ErrorDetected == 0)
            {
              modbus_txn = 8;
              for(i=0;i<8;i++)
                modbus_txdata[i] = modbus_rcdata[i];
            }
          }
          else          //长度不匹配
          {}
          break;
        case 0x06:     //写byte
          if(modbus_rcn == 8)
          {
            if(index < 59)
            {
              Ptr = ModbusList[index+i];
              
              if(modbus_rcdata[0] == 255)
              {
                //modbusaddr = (((unsigned int)(modbus_rcdata[4]) << 8) | modbus_rcdata[5]);
              }
              else
              {
                modbus_data = (((int)(modbus_rcdata[4]) << 8) | modbus_rcdata[5]);
                *Ptr = modbus_data;
                ParameterChanged = 1;
              }

              modbus_txn = 8;
              for(i=0;i<8;i++)
                modbus_txdata[i] = modbus_rcdata[i];
            }
            else
            {
              //错误地址
              modbus_txn = SetErrorMessage(modbus_txdata, ERROR_REGISTER);
            }
          }
          else          //长度不匹配
          {}
          break;
        case 0x10:     //写bytes
          if(modbus_rcdata[6] == (length*2))
          {
            if((index+length) < 59)
            {
              Ptr = ModbusList[index+i];
              i=0;
              j=7;
              for(;i<length;i++)
              {
                *Ptr = (unsigned int)modbus_rcdata[j++] << 8;
                *Ptr |= modbus_rcdata[j++];
                Ptr++;
              }
              ParameterChanged = 1;
            }
            else
            {
              //地址错误
              modbus_txn = SetErrorMessage(modbus_txdata, ERROR_REGISTER);
              ErrorDetected = 1;
            }
          }

          if(ErrorDetected == 0)
          {
            for(i=0;i<4;i++)
            {
              modbus_txdata[modbus_txn] = modbus_rcdata[modbus_txn];
              modbus_txn++;
            }

            crc_tx = CRCChecksum(modbus_txdata, modbus_txn);
            modbus_txdata[modbus_txn++] = (crc_tx >> 8) & 0xff;
            modbus_txdata[modbus_txn++] = crc_tx & 0xff;
          }

          break;
        case 0x16:    //read measured value
          for(i=0;i<15;i++)
          {
            //temp = SPCCalibrationReg[i].CalibartionSetpoint;
            modbus_txdata[modbus_txn++] = (temp >> 8) & 0xff;
            modbus_txdata[modbus_txn++] = temp & 0xff;
          }
          /*modbus_txdata[modbus_txn++] = (ADSampleA >> 8) & 0xff;
          modbus_txdata[modbus_txn++] = ADSampleA & 0xff;
          modbus_txdata[modbus_txn++] = (ADSampleB >> 8) & 0xff;
          modbus_txdata[modbus_txn++] = ADSampleB & 0xff;
          modbus_txdata[modbus_txn++] = (Cali_value[CALI_RTDA_50] >> 8) & 0xff;
          modbus_txdata[modbus_txn++] = Cali_value[CALI_RTDA_50] & 0xff;
          modbus_txdata[modbus_txn++] = (Cali_value[CALI_RTDA_500] >> 8) & 0xff;
          modbus_txdata[modbus_txn++] = Cali_value[CALI_RTDA_500] & 0xff;
          modbus_txdata[modbus_txn++] = (Cali_value[CALI_RTDB_50] >> 8) & 0xff;
          modbus_txdata[modbus_txn++] = Cali_value[CALI_RTDB_50] & 0xff;
          modbus_txdata[modbus_txn++] = (Cali_value[CALI_RTDB_500] >> 8) & 0xff;
          modbus_txdata[modbus_txn++] = Cali_value[CALI_RTDB_500] & 0xff;*/
          crc_tx = CRCChecksum(modbus_txdata, modbus_txn);
          modbus_txdata[modbus_txn++] = (crc_tx >> 8) & 0xff;
          modbus_txdata[modbus_txn++] = crc_tx & 0xff;
          break;
        /*case 0x17:    //set compensation
          Cali_value[CALI_RTDA_50] = index;
          Cali_value[CALI_RTDA_500] = length;
          Cali_value[CALI_RTDB_50] = (((int)(modbus_rcdata[6]) << 8) | modbus_rcdata[7]);
          Cali_value[CALI_RTDB_500] = (((int)(modbus_rcdata[8]) << 8) | modbus_rcdata[9]);
          EEPROM_set(0x300,8,(UCHAR*)Cali_value);
          modbus_txdata[modbus_txn++] = 0x00;
          modbus_txdata[modbus_txn++] = 0x00;
          crc_tx = CRCChecksum(modbus_txdata, modbus_txn);
          modbus_txdata[modbus_txn++] = (crc_tx >> 8) & 0xff;
          modbus_txdata[modbus_txn++] = crc_tx & 0xff;
          break;*/
#ifdef ADDITIONCALIBRATION
        case 0x20:
          SPCCalibrationBox.CalibartionType = modbus_rcdata[2];
          SPCCalibrationBox.CalibartionAddress = modbus_rcdata[3];
          SPCCalibrationBox.CalibartionData = ((unsigned int)modbus_rcdata[4] << 8) + modbus_rcdata[5];
          //RC1IE_bit = 1;
          return;
          break;
#endif
        default:      //错误功能吗
          modbus_txn = SetErrorMessage(modbus_txdata, ERROR_FUNCTIONCODE);
          break;
      }
    }
    else         //crc校验错误
    {

    }
    
    modbus_respond();
  }
  else
  {
    modbus_txn = 0;
    modbus_rcn = 0;
  }
  
  RC1IE_bit = 1;
  
  if(ParameterChanged)
  {
    Ptr = (int *)&pSPCValue[Cable_Channel].SPCSetPoints;
    for(i=0;i<4;i++)
    {
      EEPROM_get(1+i*sizeof(TEMPERATURE),sizeof(TEMPERATURE),(unsigned char*)&TempBuff);
      if(*(Ptr+i*2) != TempBuff.Temperature_F)
      {
        if((*(Ptr+i*2) == SPC_SYSTEMVALUE_OFF) || (*(Ptr+i*2) == SPC_SYSTEMVALUE_NONE))
          *(Ptr+i*2+1) = *(Ptr+i*2);
        else
          *(Ptr+i*2+1) = ConvertFtoC(*(Ptr+i*2));
      }
      else if(*(Ptr+i*2+1) != TempBuff.Temperature_C)
      {
        if((*(Ptr+i*2+1) == SPC_SYSTEMVALUE_OFF) || (*(Ptr+i*2+1) == SPC_SYSTEMVALUE_NONE))
          *(Ptr+i*2) = *(Ptr+i*2+1);
        else
          *(Ptr+i*2) = ConvertCtoF(*(Ptr+i*2+1));
      }
    }

    ParametersChanged = 1;
  }
}

//==============================================================================
//modbus从机响应
//输入：无
//输出：FUNC值
//==============================================================================
void modbus_respond()
{
  LED_COMMUNICATION_FAIL = 1;
  USART_send(modbus_txdata, modbus_txn);
  LED_COMMUNICATION_FAIL = 0;
  modbus_txn = 0;
  modbus_rcn = 0;
}

//==============================================================================
//把int型拆分为2个char型
//输入：数据源， 拆分后的数据
//输出：无
//==============================================================================
/*void Split(UINT source, UCHAR *target)
{
  *target++ = (source >> 8) & 0xff;
  *target = source & 0xff;
}*/

//==============================================================================
//把2个char型组合为1个int型
//输入：数据源
//输出：组合后的数据
//==============================================================================
/*UINT Combine(UCHAR * source)
{
  UINT target;

  target = *source;
  target = (target << 8) | *source;
  return target;
}*/

//==============================================================================
//数据传递
//输入：数据源， 目标地址， 数据长度
//输出：组合后的数据
//==============================================================================
void Copydata(UCHAR *source, UCHAR *target, char len)
{
  char i;
  
  for(i=0; i<len; i++)
    *target = *source;
}

//==============================================================================
//CRC校验
//输入：需要校验的数据， 数据长度
//输出：CRC校验码
//==============================================================================
unsigned int CRCChecksum(unsigned char *chkbuf, unsigned char len)
{
  unsigned char    uchCRCHi = 0xff ;
  unsigned char    uchCRCLo = 0xff ;
  volatile unsigned int  uIndex ;
  volatile unsigned int  temp_code;

  while (len)
  {
    uIndex = (unsigned int)(uchCRCHi ^ *chkbuf++) ;
    uchCRCHi = (unsigned char)(uchCRCLo ^ CRCHi_exp[uIndex]) ;
    uchCRCLo = CRCLo_exp[uIndex] ;
    len-- ;
  }

  temp_code = (unsigned int) uchCRCHi;
  temp_code = (unsigned int)(temp_code << 8);
  return (unsigned int)(temp_code | uchCRCLo) ;
}

void SetModbusTxData(int TransData)
{
  int CRCBuff;

  modbus_txdata[modbus_txn] = modbus_rcdata[modbus_txn];
  modbus_txn++;
  modbus_txdata[modbus_txn] = modbus_rcdata[modbus_txn];
  modbus_txn++;

  modbus_txdata[modbus_txn++] = (TransData >> 8) & 0x00ff;   
  modbus_txdata[modbus_txn++] = TransData & 0x00ff;
  
  CRCBuff = CRCChecksum(modbus_txdata, modbus_txn);
  modbus_txdata[modbus_txn++] = (CRCBuff >> 8) & 0xff;
  modbus_txdata[modbus_txn++] = CRCBuff & 0xff;
}