#ifndef __spc_def_H
#define __spc_def_H

//Program value define
//****************** Temperature ******************
#define MAINTAINTEMP_LOW_C            -50     /*C*/
#define MAINTAINTEMP_HIGH_C           500     /*C*/
#define MAINTAINTEMP_DEF_C            10      /*C*/
#define MAINTAINTEMP_LOW_F            -58     /*F*/
#define MAINTAINTEMP_HIGH_F           932     /*F*/
#define MAINTAINTEMP_DEF_F            50      /*F*/
#define LOWTEMPALARM_DEF_C            5       /*C*/
#define LOWTEMPALARM_DEF_F            41      /*F*/
//****************** Current ******************
#define CURRENTALARM_LOW              1       /*0.1A*/
#define CURRENTALARM_HIGH             300     /*0.1A*/
#define CURRENT_MAX_LOAD              400     /*0.1A*/
#define CURRENT_MAX_RECORD            500     /*0.1A*/

#define GFI_CURRENT_LOW               10      /*mA*/
#define GFI_ALARM_DEF                 30      /*mA*/
#define GFI_TRIP_DEF                  50      /*mA*/
#define GFI_CURRENT_HIGH              500     /*mA*/
//****************** Voltage ******************
#define VOLTAGEALARM_LOW              85      /*V*/
#define VOLTAGEALARM_HIGH             280     /*V*/
#define VOLTAGE_MAX                      310     /*V*/
//****************** Deadband ******************
#define DEADBAND_LOW_C                1       /*C*/
#define DEADBAND_HIGH_C               5       /*C*/
#define DEADBAND_DEF_C                2       /*C*/
#define DEADBAND_LOW_F                1       /*F*/
#define DEADBAND_HIGH_F               10      /*F*/
#define DEADBAND_DEF_F                5       /*F*/
//****************** Current limit ******************
#define CURRENTLIMITING_LOW            5      /*0.1A*/
#define CURRENTLIMITING_HIGH           300    /*0.1A*/
#define CURRENTLIMITING_STEP           5      /*0.1A*/
#define CURRENTINCREAMENT_STEP         3
//****************** Timing ******************
#define SOFTSTARTMODE_LOW              10     /*Second*/
#define SOFTSTARTMODE_HIGH             999    /*Second*/
#define SOFTSTARTMODE_DEF              300    /*Second*/
#define AUTOTESTCYCLE_LOW              1      /*Hour*/
#define AUTOTESTCYCLE_HIGH             720    /*Hour*/
#define AUTOTESTCYCLE_DEF              24     /*Hour*/
#define DISPLAY_TIME_LOW               5
#define DISPLAY_TIME_HIGH              600
#define DISPLAY_TIME_DEF               120
#define SCANSPEED_LOW                  3
#define SCANSPEED_HIGH                 10
//****************** Password ****************
#define SET_PSW_START                  0
#define SET_OLD_PSW                    1
#define SET_NEW_PSW                    2
#define SET_NEW_PSW_AGAIN              3
#define SET_PSW_SUCCED                 4
#define SET_PSW_INVALID                5
#define SET_PSW_FAIL                   6
//****************** Others ******************
#define COSTPERKWH_LOW                 1      /*$0.01*/
#define COSTPERKWH_HIGH                200
#define COSTPERKWH_DEF                 5

#define MODBUSADD_LOW                  1      /*$0.01*/
#define MODBUSADD_HIGH                 255
//****************** Calibration ******************
#define CALI_DEF_VOLT_A                0.008723
#define CALI_DEF_VOLT_B                19.66
#define CALI_DEF_VOLT_C                1750.0445

#define CALI_DEF_VOLT_HIGH             0
#define CALI_DEF_VOLT_MID              0
#define CALI_DEF_VOLT_LOW              0

#define CALI_DEF_TEMP_RTDA_HIGH        3790//S3:3885 in XiAn    //S2:3790 in Gary     //3812
#define CALI_DEF_TEMP_RTDA_LOW         1175//S3:1273 in XiAn    //S2:1175 in Gary     //1204
#define CALI_DEF_TEMP_RTDB_HIGH        3682//S3:3787 in XiAn    //S2:3682 in Gary     //3756
#define CALI_DEF_TEMP_RTDB_LOW         1068//S3:1172 in XiAn    //S2:1068 in Gary     //1144

#define CALI_DEF_CURRENT_HIGH          0
#define CALI_DEF_CURRENT_LOW           0

#define CALI_DEF_GFI_HIGH              0
#define CALI_DEF_GFI_LOW               0

#endif // __spc_def_H