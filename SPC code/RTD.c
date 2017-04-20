#include "systemvalue.h"
#include "MCP3202.h"
#include "PIC18F6622.h"
#include "RTD.h"
#include "function.h"
#include "Calibration.h"

     #include "String_op.h"
     #include "Menuoperation.h"

#define MAX_RESIS 28430
#define MIN_RESIS 7673

code unsigned int g_RTDTableC[RTD_TEMP_C_TOTAL] =
{
//-59............................................................-50
  7673, 7712, 7752, 7792, 7832, 7872, 7911, 7951, 7991, 8031,
//-49............................................................-40
  8070, 8110, 8150, 8189, 8229, 8269, 8308, 8348, 8387, 8427,
//-39............................................................-30
  8467, 8506, 8546, 8585, 8625, 8664, 8704, 8743, 8783, 8822,
//-29............................................................-20
  8862, 8901, 8940, 8980, 9019, 9059, 9098, 9137, 9177, 9216,
//-19............................................................-10
  9255, 9295, 9334, 9373, 9412, 9452, 9491, 9530, 9569, 9609,
//-9.............................................................0
  9648,  9687,  9726,  9765,  9804,  9844,  9883,  9922,  9961,  10000,
//1..............................................................10
  10039, 10078, 10117, 10156, 10195, 10234, 10273, 10312, 10351, 10390,
//11.............................................................20
  10429, 10468, 10507, 10546, 10585, 10624, 10663, 10702, 10740, 10779,
//21.............................................................30
  10818, 10857, 10896, 10935, 10973, 11012, 11051, 11090, 11129, 11167,
//31.............................................................40
  11206, 11245, 11283, 11322, 11361, 11400, 11438, 11477, 11515, 11554,
//41.............................................................50
  11593, 11631, 11670, 11708, 11747, 11786, 11824, 11863, 11901, 11940,
//51.............................................................60
  11978, 12017, 12055, 12094, 12132, 12171, 12209, 12247, 12286, 12324,
//61.............................................................70
  12363, 12401, 12439, 12478, 12516, 12554, 12593, 12631, 12669, 12708,
//71.............................................................80
  12746, 12784, 12822, 12861, 12899, 12937, 12975, 13013, 13052, 13090,
//81.............................................................90
  13128, 13166, 13204, 13242, 13280, 13318, 13357, 13395, 13433, 13471,
//91.............................................................100
  13509, 13547, 13585, 13623, 13661, 13699, 13737, 13775, 13813, 13851,
//101............................................................110
  13888, 13926, 13964, 14002, 14040, 14078, 14116, 14154, 14191, 14229,
//111............................................................120
  14267, 14305, 14343, 14380, 14418, 14456, 14494, 14531, 14569, 14607,
//121............................................................130
  14644, 14682, 14720, 14757, 14795, 14833, 14870, 14908, 14946, 14983,
//131............................................................140
  15021, 15058, 15096, 15133, 15171, 15208, 15246, 15283, 15321, 15358,
//141............................................................150
  15396, 15433, 15471, 15508, 15546, 15583, 15620, 15658, 15695, 15733,
//151............................................................160
  15770, 15807, 15845, 15882, 15919, 15956, 15994, 16031, 16068, 16105,
//161............................................................170
  16143, 16180, 16217, 16254, 16291, 16329, 16366, 16403, 16440, 16477,
//171............................................................180
  16514, 16551, 16589, 16626, 16663, 16700, 16737, 16774, 16811, 16848,
//181............................................................190
  16885, 16922, 16959, 16996, 17033, 17070, 17107, 17143, 17180, 17217,
//191............................................................200
  17254, 17291, 17328, 17365, 17402, 17438, 17475, 17512, 17549, 17586,
//201............................................................210
  17622, 17659, 17696, 17733, 17769, 17806, 17843, 17879, 17916, 17953,
//211............................................................220
  17989, 18026, 18063, 18099, 18136, 18172, 18209, 18246, 18282, 18319,
//221............................................................230
  18355, 18392, 18428, 18465, 18501, 18538, 18574, 18611, 18647, 18684,
//231............................................................240
  18720, 18756, 18793, 18829, 18866, 18902, 18938, 18975, 19011, 19047,
//241............................................................250
  19084, 19120, 19156, 19192, 19229, 19265, 19301, 19337, 19374, 19410,
//251............................................................260
  19446, 19482, 19518, 19555, 19591, 19627, 19663, 19699, 19735, 19771,
//261............................................................270
  19807, 19843, 19879, 19915, 19951, 19987, 20023, 20059, 20095, 20131,
//271............................................................280
  20167, 20203, 20239, 20275, 20311, 20347, 20383, 20419, 20455, 20490,
//281............................................................290
  20526, 20562, 20598, 20634, 20670, 20705, 20741, 20777, 20813, 20848,
//291............................................................300
  20884, 20920, 20956, 20991, 21027, 21063, 21098, 21134, 21170, 21205,
//301............................................................310
  21241, 21276, 21312, 21348, 21383, 21419, 21454, 21490, 21525, 21561,
//311............................................................320
  21596, 21632, 21667, 21703, 21738, 21774, 21809, 21844, 21880, 21915,
//321............................................................330
  21951, 21986, 22021, 22057, 22092, 22127, 22163, 22198, 22233, 22268,
//331............................................................340
  22304, 22339, 22374, 22409, 22445, 22480, 22515, 22550, 22585, 22621,
//341............................................................350
  22656, 22691, 22726, 22761, 22796, 22831, 22866, 22902, 22937, 22972,
//351............................................................360
  23007, 23042, 23077, 23112, 23147, 23182, 23217, 23252, 23287, 23321,
//361............................................................370
  23356, 23391, 23426, 23461, 23496, 23531, 23566, 23600, 23635, 23670,
//371............................................................380
  23705, 23740, 23774, 23809, 23844, 23879, 23913, 23948, 23983, 24018,
//381............................................................390
  24052, 24087, 24122, 24156, 24191, 24226, 24260, 24295, 24329, 24364,
//391............................................................400
  24399, 24433, 24468, 24502, 24537, 24571, 24606, 24640, 24675, 24709,
//401............................................................410
  24744, 24778, 24813, 24847, 24881, 24916, 24950, 24985, 25019, 25053,
//411............................................................420
  25088, 25122, 25156, 25191, 25225, 25259, 25293, 25328, 25362, 25396,
//421............................................................430
  25430, 25465, 25499, 25533, 25567, 25601, 25635, 25670, 25704, 25738,
//431............................................................440
  25772, 25806, 25840, 25874, 25908, 25942, 25976, 26010, 26044, 26078,
//441............................................................450
  26112, 26146, 26180, 26214, 26248, 26282, 26316, 26350, 26384, 26418,
//451............................................................460
  26452, 26486, 26520, 26553, 26587, 26621, 26655, 26689, 26722, 26756,
//461............................................................470
  26790, 26824, 26857, 26891, 26925, 26959, 26992, 27026, 27060, 27093,
//471............................................................480
  27127, 27161, 27194, 27228, 27261, 27295, 27329, 27362, 27396, 27429,
//481............................................................490
  27463, 27496, 27530, 27563, 27597, 27630, 27664, 27697, 27731, 27764,
//491............................................................500
  27798, 27831, 27864, 27898, 27931, 27964, 27998, 28031, 28064, 28098,
//501............................................................510
  28131, 28164, 28198, 28231, 28264, 28297, 28331, 28364, 28397, 28430
};

/*code unsigned int GFICalibrationTable[12] =
{
  5400,
  3000,
  650,
  300,
  200,
  100,
  5560,
  3088,
  560,
  376,
  277,
  137
};

code unsigned int GFICalibrationADTable[12] =
{
  3450,
  1930,
  300,
  96,
  48,
  28,
  4077,
  2210,
  206,
  91,
  50,
  19
};

code signed int CurrentCalibrationTable[10] =
{
  2877,
  1796,
  500,
  162,
  35,
  2882,
  1797,
  550,
  162,
  26
};

code signed int CurrentCalibrationADTable[10] =
{
  3434,
  2253,
  629,
  152,
  26,
  3392,
  2233,
  690,
  153,
  26
};*/

unsigned int ADSampleA,ADSampleB;


//==============================================================================
//read TEMPERATURE both A channel and B channel
//input£ºpointer of actual value temp
//output£ºnone
//==============================================================================
void TempSend(unsigned int ADSample, char line)
{
  char String=0, i;
  char *ptr;
  
  if(line == 1)
    ptr = Info_Line2;
  else
    ptr = Info_Line1;
  
  ClearStr(ptr, 16);
  *ptr = ADSample/1000 + 0x30;
  *(ptr+1) = ADSample%1000/100 + 0x30;
  *(ptr+2) = ADSample%100/10 + 0x30;
  *(ptr+3) = ADSample%10 + 0x30;
}

void GetTemperature(TEMPERATURE *RTDA_ptr, char ChannelNum)
{
  TEMPERATURE *ptr;
  unsigned int TempAD;
  //char ChannelTempCmd;
  
  /*if(ChannelNum == 0)
    ChannelTempCmd = RTD_CHANNEL1;
  else if(ChannelNum == 1)
    ChannelTempCmd = RTD_CHANNEL2;*/

  ptr = RTDA_ptr;
  TempAD = MCP3202_GET_AD(ADC_Channel[ChannelNum+2],RTDA_AD_COMMND, 100);
  ptr->Temperature_C = ConvertADtoTEMP(TempAD, CALI_RTDA_50, CALI_RTDA_500, ChannelNum);
  if((ptr->Temperature_C == RTD_SHORT) || (ptr->Temperature_C == RTD_OPNE))
    ptr->Temperature_F = ptr->Temperature_C;
  else
    ptr->Temperature_F = ConvertCtoF(ptr->Temperature_C);

  ptr++;
  TempAD = MCP3202_GET_AD(ADC_Channel[ChannelNum+2],RTDB_AD_COMMND, 100);
  ptr->Temperature_C = ConvertADtoTEMP(TempAD, CALI_RTDB_50, CALI_RTDB_500, ChannelNum);
  if((ptr->Temperature_C == RTD_SHORT) || (ptr->Temperature_C == RTD_OPNE))
    ptr->Temperature_F = ptr->Temperature_C;
  else
    ptr->Temperature_F = ConvertCtoF(ptr->Temperature_C);
}

//==============================================================================
//read GFI
//input£ºcommand of current or GFI
//output£ºresult
//==============================================================================
UINT GetGFI(char ChannelSelect, char cmd)
{
  return MCP3202_GET_AD_ONCE(ChannelSelect,cmd);
}

//==============================================================================
//calculate current
//input£ºADC sample
//output£ºreal current
//==============================================================================
signed int ConvertADtoCurrent(unsigned int ADcurrent, char ChannelNum)
{
  signed long ret,temp,tempL;
  char index=0;
  SPCCALIBRATIONREG *PtrForCalibrationData;

  PtrForCalibrationData = (SPCCALIBRATIONREG *)&SPCCalibrationStructure[ChannelNum];
  if(ADcurrent < GetCalibrationData(PtrForCalibrationData, CURRENTPOINT1, 0))
    return 0;
  else if(ADcurrent < GetCalibrationData(PtrForCalibrationData, CURRENTPOINT2, 0))     // SPCCalibrationReg[CURRENTPOINT2].CalibartionSetpoint   CurrentCalibrationADTable[1]
    index = 0;
  else if(ADcurrent < GetCalibrationData(PtrForCalibrationData, CURRENTPOINT3, 0))  // SPCCalibrationReg[CURRENTPOINT3].CalibartionSetpoint  CurrentCalibrationADTable[2]
    index = 1;
  else if(ADcurrent < GetCalibrationData(PtrForCalibrationData, CURRENTPOINT4, 0))  // SPCCalibrationReg[CURRENTPOINT4].CalibartionSetpoint  CurrentCalibrationADTable[3]
    index = 2;
  else    // if(ADcurrent < SPCCalibrationReg[CURRENTPOINT5].CalibartionSetpoint)  // SPCCalibrationReg[CURRENTPOINT5].CalibartionSetpoint   CurrentCalibrationADTable[4]
    index = 3;

  index += CURRENTPOINT1;
  temp = GetCalibrationData(PtrForCalibrationData, index+1, 1) - GetCalibrationData(PtrForCalibrationData, index, 1);
  tempL = GetCalibrationData(PtrForCalibrationData, index+1, 0) - GetCalibrationData(PtrForCalibrationData, index, 0);
  temp = temp* (ADcurrent - GetCalibrationData(PtrForCalibrationData, index, 0))/ tempL;
  ret = temp + GetCalibrationData(PtrForCalibrationData, index, 1);

  return ret/10;
}

//==============================================================================
//calculate GFI
//input£ºADC sample
//output£ºreal GFI
//==============================================================================
unsigned int ConvertADtoGFI(unsigned int ADcurrent, char ChannelNum)
{
  signed long ret,temp, tempL;
  char index=0;
  SPCCALIBRATIONREG *PtrForCalibrationData;

  PtrForCalibrationData = (SPCCALIBRATIONREG *)&SPCCalibrationStructure[ChannelNum];
  if(ADcurrent < GetCalibrationData(PtrForCalibrationData, GFIPOINT1, 0))
    return 0;
  else if(ADcurrent < GetCalibrationData(PtrForCalibrationData, GFIPOINT2, 0))     // SPCCalibrationReg[CURRENTPOINT2].CalibartionSetpoint   CurrentCalibrationADTable[1]
    index = 0;
  else if(ADcurrent < GetCalibrationData(PtrForCalibrationData, GFIPOINT3, 0))  // SPCCalibrationReg[CURRENTPOINT3].CalibartionSetpoint  CurrentCalibrationADTable[2]
    index = 1;
  else if(ADcurrent < GetCalibrationData(PtrForCalibrationData, GFIPOINT4, 0))  // SPCCalibrationReg[CURRENTPOINT4].CalibartionSetpoint  CurrentCalibrationADTable[3]
    index = 2;
  else if(ADcurrent < GetCalibrationData(PtrForCalibrationData, GFIPOINT5, 0))  // SPCCalibrationReg[CURRENTPOINT5].CalibartionSetpoint   CurrentCalibrationADTable[4]
    index = 3;
  else
    index = 4;

  index += GFIPOINT1;
  temp = GetCalibrationData(PtrForCalibrationData, index+1, 1) - GetCalibrationData(PtrForCalibrationData, index, 1);
  tempL = GetCalibrationData(PtrForCalibrationData, index+1, 0) - GetCalibrationData(PtrForCalibrationData, index, 0);
  temp = temp* (ADcurrent - GetCalibrationData(PtrForCalibrationData, index, 0))/ tempL;
  ret = temp + GetCalibrationData(PtrForCalibrationData, index, 1);

  return ret/10;
}

//==============================================================================
//calculate temperature
//input£ºADC sample, calibrated -50C, calibrated 500C
//output£ºreal temperature
//==============================================================================
long ConvertADtoTEMP(UINT ADtemp, char paraL, char paraH, char ChannelNum)
{
  unsigned int resis;
  signed long ret,tempH, tempL;
  long tempresult,tempcount=0, temp;
  SPCCALIBRATIONREG *PtrForCalibrationData;

  PtrForCalibrationData = (SPCCALIBRATIONREG *)&SPCCalibrationStructure[ChannelNum];
  tempH = GetCalibrationData(PtrForCalibrationData, paraH, 1) - GetCalibrationData(PtrForCalibrationData, paraL, 1);
  tempL = GetCalibrationData(PtrForCalibrationData, paraH, 0) - GetCalibrationData(PtrForCalibrationData, paraL, 0);
  tempH = tempH* ((signed int)ADtemp - GetCalibrationData(PtrForCalibrationData, paraL, 0))/ tempL;
  resis = tempH + GetCalibrationData(PtrForCalibrationData, paraL, 1);

  if(resis > MAX_RESIS)
    return RTD_OPNE;
  else if(resis < MIN_RESIS)
    return RTD_SHORT;

  while(1)
  {
    if(resis < g_RTDTableC[tempcount])
    {
      if(tempcount)
      {
        temp =  (long)tempcount *10;
        tempresult = (long)(temp - (g_RTDTableC[tempcount] - resis)*
                         10.0/(g_RTDTableC[tempcount] - g_RTDTableC[tempcount-1]));
        tempresult -= 590;
      }
      else
        tempresult = -590;

      if(tempresult > 0)
        return (tempresult+5)/10;
      else
        return (tempresult-5)/10;

    }
    else
      tempcount++;
  }

}