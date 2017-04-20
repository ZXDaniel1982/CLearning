//#include "_typedef.h"
//#include "PIC18F6622.h"
//#include "Spcinitial.h"
//#include "Spcsystem.h"

//#define testpart 1
//#define programmtest  1

//#define TEMP_RELATE 1

#define SYSTEST 1
#define SHOWOFF 1
//#define ADDITIONCALIBRATION 1

sbit LCD_RW at LATF6_bit;
sbit LCD_RW_Direction at TRISF6_bit;

sbit LCD_RS at LATF5_bit;
sbit LCD_EN at LATF7_bit;
sbit LCD_D4 at LATE4_bit;
sbit LCD_D5 at LATE5_bit;
sbit LCD_D6 at LATE6_bit;
sbit LCD_D7 at LATE7_bit;

sbit LCD_RS_Direction at TRISF5_bit;
sbit LCD_EN_Direction at TRISF7_bit;
sbit LCD_D4_Direction at TRISE4_bit;
sbit LCD_D5_Direction at TRISE5_bit;
sbit LCD_D6_Direction at TRISE6_bit;
sbit LCD_D7_Direction at TRISE7_bit;

//==============================================================================
//定义系统时钟
//==============================================================================
#define SYSTEM_CLOCK        20000000                 //20M时钟
#define SYSTEM_CLOCK_MHZ    20
#define TIME_UNIT           500                //时间片单位500US
#define TMRVAL              65535-TIME_UNIT*SYSTEM_CLOCK_MHZ/4   //定时调整值

#define DELAY_S             5000               //秒计时
#define DELAY_M             60                 //分计时
#define DELAY_H             60                 //小时计时
#define DELAY_D             24                 //天计时

#define DELAY_VT            10                 //电压测量时间间隔，10秒
#define DELAY_TEMP          10                 //温度测量时间间隔，10秒

#define DELAY_ENEG          DELAY_H            //耗电测量时间间隔，1小时

  //待定的
    #define DELAY_CURRENT       1              //电流测量时间间隔，1秒
    #define DELAY_GFI           1              //漏电流测量时间间隔，1秒

//==============================================================================
//SCAN TIME STATE
//
//==============================================================================
#define SCANTIME_START  1
#define SCANTIME_OPER  2
#define SCANTIME_IDLE  0

//==============================================================================
//定义系统软件延时
//需要进一步研究
//==============================================================================

//==============================================================================
//定义通信波特率
//==============================================================================
#define BAUDRATE_1200 0
#define BAUDRATE_2400 1
#define BAUDRATE_4800 2
#define BAUDRATE_9600 3
#define BAUDRATE_19200 4

#define I2C_BAUDRATE 100.0       //I2C通信波特率100KHz

//==============================================================================
//定义二进制通用定义
//==============================================================================
#define BIT0 0x01
#define BIT1 0x02
#define BIT2 0x04
#define BIT3 0x08
#define BIT4 0x10
#define BIT5 0x20
#define BIT6 0x40
#define BIT7 0x80

#define TRUE 1
#define FALSE 0

//Definition of channels
#define CHANNEL1 0
#define CHANNEL2 1
//==============================================================================
//定义LED端口
//==============================================================================
//#define LED_POWER                                   RE0_bit
#define LED_HEATER_ON                               LATE3_bit
#define LED_SYSTEM_FAIL                             LATE2_bit
#define LED_COMMUNICATION_FAIL                      LATE1_bit
#define LED_ALARM                                   LATE0_bit

//==============================================================================
//定义LCD端口
//==============================================================================

    //==========================================================================
    //LCD命令字
    //==========================================================================
    #define NEW_LINE 0x10
    #define LINE_1 0x01
    #define LINE_2 0x02
    
    #define CMD_ENTER 1
    #define CMD_RESET 2
    #define CMD_SWITCH 3
    #define CMD_ADJUST 4
    #define CMD_INIT 5
    
    #define CMD_FORWARD TRUE
    #define CMD_BACKWARD FALSE
    
    //LCD宽度
    #define LCDLENGTH 16

//==============================================================================
//定义KEYBOARD ID
//==============================================================================
#define KEYIDEL  0
#define KEYPUSH  1
#define KEYDELAY  2

//==============================================================================
//定义GFIC，RTD，KEYBOARD端口
//==============================================================================
#define GFIC_CHANNEL_CTL                            RD1_bit
#define RTD_CHANNEL_CTL                             RD3_bit

#define KEYBOARD_CHANNEL_CHECK                      RB0_bit

//==============================================================================
//定义GFIC，RTD，KEYBOARD端口
//==============================================================================
#define QT60160_ADDRESS 117

//==============================================================================
//定义参数标志位
//==============================================================================
#define SPC_SYSTEMVALUE_NONE 0X7ffe
#define SPC_SYSTEMVALUE_OFF 0X7fff
#define SPC_SYSTEMVALUE_NULL 0X7ff0

#define STATIS_MAX_TEMP 1
#define STATIS_MIN_TEMP 2
#define STATIS_MAX_VOLT 4
#define STATIS_MIN_VOLT 8
#define STATIS_CURRENT  16
#define STATIS_GFI      32

//==============================================================================
//定义菜单相关参数
//==============================================================================
#define MAX_MAINMENU_NUM 3
#define MAX_SUBMENU_NUM 4
#define MAX_SSUBMENU_NUM 20
#define MAX_MENU_NUM 61        //总菜单数
#define PSW_CHARACT_NUM 63
#define PSW_CHARACT_EX_NUM 31
#define MAX_CHARACT_REG 0X7D
#define MIN_CHARACT_REG 0X20

#define MAX_ALARMS 20
#define MAX_LOGS 20

//==============================================================================
//系统标志位
//==============================================================================
#define USR_ADV_REQ 0x01  //需要adv用户的参数
#define MAINT_REQ 0x02    //需要maintaintemp的参数
#define PROCTL_REQ 0x03   //不需要proportional的参数

//==============================================================================
//RTD工作模式
//==============================================================================
/*#define ONE_RTD_MOD 0
#define BACKUP_MOD 1
#define AVERAGE_MOD 2
#define LOWEST_MOD 3
#define HIGHEST_MOD 4
#define HIGHTEMPCUTOFF_MOD 5*/

//==============================================================================
//RELAY工作模式
//==============================================================================
#define RELAY_OFF 0
#define RELAY_ON 1

#define FORCE_LOAD_ON  1
#define FORCE_LOAD_OFF  2
#define LOAD_OK  0

#define FORCE_ALARMSSR_ON 1
#define ALARMSSR_OK 0

#define IDEL 0
#define RUNNING 1
#define DONES 2
#define GFICHECK 3

//==============================================================================
//ALARM
//==============================================================================
#define DISALARM 0
#define ENALARM 1

#define CH1_LOWTEMPALARM (unsigned long)0x00000001
#define CH2_LOWTEMPALARM (unsigned long)0x00000002
#define CH1_HIGHTEMPALARM (unsigned long)0x00000004
#define CH2_HIGHTEMPALARM (unsigned long)0x00000008
#define CH1_LOWCURRENTALARM (unsigned long)0x00000010
#define CH2_LOWCURRENTALARM (unsigned long)0x00000020
#define CH1_HIGHCURRENTALARM (unsigned long)0x00000040
#define CH2_HIGHCURRENTALARM (unsigned long)0x00000080
#define CH1_GFIALARM (unsigned long)0x00000100
#define CH2_GFIALARM (unsigned long)0x00000200
#define CH1_GFITRIP (unsigned long)0x00000400
#define CH2_GFITRIP (unsigned long)0x00000800
#define LOWVOLTALARM (unsigned long)0x00001000
#define HIGHVOLTALARM (unsigned long)0x00002000

#define CH1_CONTINUEFAILALARM (unsigned long)0x00004000
#define CH2_CONTINUEFAILALARM (unsigned long)0x00008000
#define CH1_FAILEDSHORTALARM (unsigned long)0x00010000
#define CH2_FAILEDSHORTALARM (unsigned long)0x00020000
#define CH1_RTDAOPENALARM (unsigned long)0x00040000
#define CH2_RTDAOPENALARM (unsigned long)0x00080000
#define CH1_RTDASHORTALARM (unsigned long)0x00100000
#define CH2_RTDASHORTALARM (unsigned long)0x00200000
#define CH1_RTDBOPENALARM (unsigned long)0x00400000
#define CH2_RTDBOPENALARM (unsigned long)0x00800000
#define CH1_RTDBSHORTALARM (unsigned long)0x01000000
#define CH2_RTDBSHORTALARM (unsigned long)0x02000000
#define CH1_GFITESTFAIL (unsigned long)0x04000000
#define CH2_GFITESTFAIL (unsigned long)0x08000000

#define SELFCHECKFAILURE (unsigned long)0x10000000
#define AUTOTESTALARM (unsigned long)0x20000000


//==============================================================================
//eep数据存储地址
//==============================================================================
#define MAINTAIN_FLASH_LACAL        0
#define LOWTEMP_FLASH_LACAL         4
#define HIGHTEMP_FLASH_LACAL        8
#define DEADBAND_FLASH_LACAL        12
#define LOWCURRENT_FLASH_LACAL      16
#define HIGHCURRENT_FLASH_LACAL     18
#define GFIALARM_FLASH_LACAL        20
#define GFITRIP_FLASH_LACAL         22
#define LOWVOLT_FLASH_LACAL         24
#define HIGHVOLT_FLASH_LACAL        26
#define LIMITCURRENT_FLASH_LACAL    28
#define SOFTSTART_FLASH_LACAL       30
#define AUTOTEST_FLASH_LACAL        32
#define TIMEOUT_FLASH_LACAL         34
#define COST_FLASH_LACAL            36
#define SCANSPEED_FLASH_LACAL       38
#define MODBUSADD_FLASH_LACAL       40
#define BAUDRATE_FLASH_LACAL        42
#define ALARMOUTTEST_FLASH_LACAL    44
#define HEATERTEST_FLASH_LACAL      46
#define GFITEST_FLASH_LACAL         48
#define HEATERNAME_FLASH_LACAL      50
#define PASSWORD_FLASH_LACAL        66
#define SYSTEMFLAG_FLASH_LACAL      84
//==============================================================================
//菜单
//==============================================================================
#define MENU_IN_ACTUAL 0
#define MENU_IN_PROGRAM 1

#define ACTUAL_IN_OPERVAL 0
#define ACTUAL_IN_STATISTIC 1

#define PROGRAM_IN_SETPOINT 0
#define PROGRAM_IN_HEATSET 1
#define PROGRAM_IN_SYSTEMSET 2
#define PROGRAM_IN_SYSTEMTEST 3

#define OPERVAL_WELCOM 0
#define OPERVAL_HEATSTAT 1
#define OPERVAL_TEMP 2
#define OPERVAL_TEMPA 3
#define OPERVAL_TEMPB 4
#define OPERVAL_HEATPOW 5
#define OPERVAL_CURRENT 6
#define OPERVAL_GFIC 7
#define OPERVAL_VOLT 8

#define STATISTIC_WELCOM 0
#define STATISTIC_MAXTEMP 1
#define STATISTIC_MINTEMP 2
#define STATISTIC_MAXCURRENT 3
#define STATISTIC_MAXGFIC 4
#define STATISTIC_MAXVOLT 5
#define STATISTIC_MINVOLT 6
#define STATISTIC_ENEGRY 7
#define STATISTIC_COST 8
#define STATISTIC_ONTIME 9
#define STATISTIC_ONTIMEDUTY 10
#define STATISTIC_RESET 11
#define STATISTIC_VERSION 12

#define SETPOINT_WELCOM 0
#define SETPOINT_TEMP 1
#define SETPOINT_LOWTEMP 2
#define SETPOINT_HIGHTEMP 3
#define SETPOINT_LOWCURRENT 4
#define SETPOINT_HIGHCURRENT 5
#define SETPOINT_GFIALARM 6
#define SETPOINT_GFITRIP 7
#define SETPOINT_LOWVOLT 8
#define SETPOINT_HIGHVOLT 9

#define HEATSET_WELCOM 0
#define HEATSET_HEATEN 1
#define HEATSET_HEATID 2
#define HEATSET_HEATYPE 3
#define HEATSET_CABLETYPE 4
#define HEATSET_MANUAL 5
#define HEATSET_DEADBAND 6
#define HEATSET_CTLTYPE 7
#define HEATSET_CURRENTLIMIT 8
#define HEATSET_SOFTSTART 9
#define HEATSET_AUTOTEST 10
#define HEATSET_RTDOPERATE 11
#define HEATSET_RTDFAILMODE 12

#define SYSTEMSET_WELCOM 0
#define SYSTEMSET_PSWEN 1
#define SYSTEMSET_NEWPSW 2
#define SYSTEMSET_UNITS 3
#define SYSTEMSET_COST 4
#define SYSTEMSET_DISPMODE 5
#define SYSTEMSET_DEFAULTDISP 6
#define SYSTEMSET_DISPTIMEOUT 7
#define SYSTEMSET_SCANSPEED 8
#define SYSTEMSET_MODBUS 9
#define SYSTEMSET_BAUDRATE 10
#define SYSTEMSET_RESET 11

#define SYSTEMTEST_WELCOM 0
#define SYSTEMTEST_ALARMOUTPUT 1
#define SYSTEMTEST_HEAT 2
#define SYSTEMTEST_GFI 3

#define MENUACTIVE 1
#define ADVANCEREQ 2
#define MAINTAINNONEFILIC 4
#define MAINTAINOFFFILIC 8
#define PROPORTCONFILIC 0x10
#define SELFREGULAFILIC 0X20
#define FIXRESISFILIC 0X40

#define TITLE_OPERATEVALUE 0
#define TITLE_STATISTIC 1
#define TITLE_SETPOINT 2
#define TITLE_HEATSET 3
#define TITLE_SYSTEMSET 4
#define TITLE_SYSTEMTEST 5

#define ONLYDISP 0X80
#define FLAG_UNIT 0
#define FLAG_HEATSTAT 1
  #define HEATSTAT_NUM 4
  #define HEATSTAT_STR 0
#define FLAG_HEATEN 1
#define FLAG_MANUAL 2
#define FLAG_CABLETYPE 18
#define FLAG_CTLTYPE 3
#define FLAG_RTDOPERATE 4
  #define RTDOPR_NUM 6
  #define RTDOPR_STR 25
#define FLAG_RTDFAILMODE 7
#define FLAG_PSWEN 8
#define FLAG_DISPMODE 9
#define FLAG_DEFAULTDISP 10
  #define DEFAULTDISP_NUM 3
  #define DEFAULTDISP_STR 22
#define FLAG_BAUDRATE 12
  #define BAUDRATE_NUM 5
  #define BAUDRATE_STR 6
#define FLAG_GFITEST 16
  #define GFITEST_NUM 3
  #define GFITEST_STR 17
#define FLAG_HEATYPE 15
  #define FIX_SEL_STR 31
  
#define TEMPRELAT 0X80
#define INTSHOW_TEMP 0
#define INTSHOW_TEMPA 2
#define INTSHOW_TEMPB 4
#define INTSHOW_HEATPOW 6
#define INTSHOW_CURRENT 7
#define INTSHOW_CURRENT_RMS 8
#define INTSHOW_GFIC 9
#define INTSHOW_VOLT 10
#define INTSHOW_MAXTEMP 12
#define INTSHOW_MINTEMP 14
#define INTSHOW_MAXCURRENT 16
#define INTSHOW_MAXGFIC 17
#define INTSHOW_MAXVOLT 18
#define INTSHOW_MINVOLT 19
#define INTSHOW_ENEGRY 20
#define INTSHOW_COST 21
#define INTSHOW_ONTIME 22
#define INTSHOW_ONTIMEDUTY 24

#define INTSET_LOWCURRENT              LOWCURRENT_FLASH_LACAL
#define INTSET_HIGHCURRENT             HIGHCURRENT_FLASH_LACAL
#define INTSET_GFIALARM                GFIALARM_FLASH_LACAL
#define INTSET_GFITRIP                 GFITRIP_FLASH_LACAL
#define INTSET_LOWVOLT                 LOWVOLT_FLASH_LACAL
#define INTSET_HIGHVOLT                HIGHVOLT_FLASH_LACAL
#define INTSET_CURRENTLIMIT            LIMITCURRENT_FLASH_LACAL
#define INTSET_SOFTSTART               SOFTSTART_FLASH_LACAL
#define INTSET_AUTOTEST                AUTOTEST_FLASH_LACAL
#define INTSET_DISPTIMEOUT             TIMEOUT_FLASH_LACAL
#define INTSET_COST                    COST_FLASH_LACAL
#define INTSET_SCANSPEED               SCANSPEED_FLASH_LACAL
#define INTSET_MODBUS                  MODBUSADD_FLASH_LACAL
#define INTSET_ALARMOUTPUT             ALARMOUTTEST_FLASH_LACAL
#define INTSET_HEAT                    HEATERTEST_FLASH_LACAL
#define INTSET_GFI                     GFITEST_FLASH_LACAL

#define YES_NO_SWITCH 2
//#define ON_OFF_STR 52+7
#define YES_NO_STR 4
#define C_F_STR 11
#define EN_DIS_STR 13
#define NOR_ADV_STR 15
#define ONOFF_PROP_STR 20
#define FIX_SELF_STR 31

#define INFRONT 0X80
#define UNIT_COST 0+1
#define UNIT_TEMP 1+1
#define UNIT_AMPER 4
#define UNIT_AMPER_PERCENT 9
#define UNIT_MILIAMPER 4+1
#define UNIT_ACVOLT 5+1
#define UNIT_SECOND 6+1
#define UNIT_HOUR 7+1
#define UNIT_PERCENT 8+1
#define UNIT_DCVOLT 9+1
#define UNIT_ENEGRY 10+1
#define UNIT_ALARM 11+1
#define UNIT_LOG 13

#define INDEX 4
#define SUBINDEX  5
#define THIRDINDEX  6
#define ALARM_INDEX  0
#define ALARM_SUBINDEX  1
#define UPDATE_THIRDINDEX  2
#define UPDATE_INDEX 3
#define NOMSG 7
#define NULL 0

#define MAX_NOFIX 0X10
#define MIN_NOFIX 0X20

#define ONE_RTD_MOD 0
#define BACKUP_MOD 1
#define AVERAGE_MOD 2
#define LOWEST_MOD 3
#define HIGHEST_MOD 4
#define HIGHTEMPCUTOFF_MOD 5
#define RTD_FAILURE 0X80

#define SYSTEM_STATUS_MOD 0
#define HEATER_STATUS_MOD 1
#define HEATER_TEMP_MOD 2

#define GFI_TEST_DISABLE 2
#define GFI_TEST_NOW 1
#define GFI_TEST_AUTO 0
#define RTD_OPNE  0x7ffd
#define RTD_SHORT  0x7fff
#define OUTOFRANGE  0x7ffe
#define COSTOUTOFRANGE 0X7FFFFFFF
#define ONTIMEOUTOFRANGE  1500000
#define SPC_SYSTEMVALUE_DISABLE 0X7ffc
#define SPC_SYSTEMVALUE_CONTINU 0X7ffd

#define FUNC_FLAGSET  1
#define FUNC_INTSET  2
#define FUNC_SHOW 3
#define FUNC_TITLE 4
#define FUNC_RESET  5
#define FUNC_AUTHO  6
#define FUNC_RESET_MODULE 7
//==============================================================================
//系统数据点
//==============================================================================
#define MAX_MAINTAINTEMP_C  510
#define MIN_MAINTAINTEMP_C  -59
#define MAX_MAINTAINTEMP_F  950
#define MIN_MAINTAINTEMP_F  -74

#define MAX_TEMP_C  500
#define MIN_TEMP_C  -50
#define MAX_TEMP_F  932
#define MIN_TEMP_F  -58

#define MAX_SPCDEADBAND_C  5
#define MIN_SPCDEADBAND_C  1
#define MAX_SPCDEADBAND_F  10
#define MIN_SPCDEADBAND_F  1
  #define HIGHTEMPCUTOFF  0x01
  #define ONE_RTD  0x01
  #define SYSTEM_STATUS  0x01
  #define HEATER_TEMP  0x01
  #define GFITEST_AUTO 0x01
  #define GFITEST_DISABLE  0x01
#define MAX_SPCENEGY  10000     //1000.0MWh
#define MAX_SPCOST_TOTAL  100000000     //1000MWh
#define MAX_SPCOST  100
#define MIN_SPCOST  1
#define MAX_SCANSPEED  10
#define MIN_SCANSPEED  3
#define MAX_MODBUS  255
#define MIN_MODBUS  1
#define MIN_SPCCURRENT  1
#define MAX_SPCCURRENT  300
      #define MIN_SPCHIGHCURRENT  10
      #define MAX_SPCLOWCURRENT  290
#define MIN_SPCGFIALARM  10
#define MAX_SPCGFIALARM  500
      #define MIN_SPCHIGHGFIALARM  15
      #define MAX_SPCLOWGFIALARM  495
#define MIN_SPCVOLT  85
#define MAX_SPCVOLT  280
      #define MIN_SPCHIGHVOLT  95
      #define MAX_SPCLOWVOLT  270
#define MAX_ALARMOUT  24
#define MIN_ALARMOUT  1
#define MAX_HEATERTEST  24
#define MIN_HEATERTEST 1
#define MAX_CURRENTLIMIT  300
#define MIN_CURRENTLIMIT  5
#define MAX_SOFTSTART  999
#define MIN_SOFTSTART  10
#define MAX_AUTOTEST  720
#define MIN_AUTOTEST  1
#define MAX_TIMEOUT  600
#define MIN_TIMEOUT  5

//==============================================================================
//
//==============================================================================
#define CURRENT_DECIMAL 1
#define OPERATECOST_DECIMAL 2
#define TEMPERATURE_DECIMAL 1


#define FUNC_OPV  1
#define FUNC_HEATSTS  2
#define FUNC_TEMP  3
#define FUNC_TEMPA  4
#define FUNC_TEMPB  5
#define FUNC_HEATPOW  6
#define FUNC_LOADCUR  7
#define FUNC_GFICUR  8
#define FUNC_VOLT  9
#define FUNC_STIS  10
#define FUNC_MAXTEMP  11
#define FUNC_MINTEMP  12
#define FUNC_MAXCUR 13
#define FUNC_MAXGFI  14
#define FUNC_MAXVOLT  15
#define FUNC_MINVOLT  16
#define FUNC_OPTKWH  17
#define FUNC_OPTCOST  18
#define FUNC_ONTIME  19
#define FUNC_ONTIMEPER  20

#define FUNC_VERSION  22
#define FUNC_SETP  23
#define FUNC_CHANNEL 24
#define FUNC_MAINT  25
#define FUNC_LOWTEMP  26
#define FUNC_HIGHTEMP  27
#define FUNC_LOWCUR  28
#define FUNC_HIGHCUR  29
#define FUNC_GFIALARM  30
#define FUNC_GFITRIP  31
#define FUNC_LOWVOLT  32
#define FUNC_HIGHVOLT  33
#define FUNC_HEATSET  34
#define FUNC_ENHEAT  35
#define FUNC_HEATID  36
#define FUNC_MANRID  37
#define FUNC_DEADBAND  38
#define FUNC_CTLTYPE  39
#define FUNC_CURLIM  40
#define FUNC_SSTART  41
#define FUNC_AUTOTEST  42
#define FUNC_RTDOPT  43
#define FUNC_RTDFAILMOD  44
#define FUNC_SYSSET  45
#define FUNC_ENPWD  46
#define FUNC_CHANGEPWD  47
#define FUNC_UNITS  48
#define FUNC_SETOPTCOST  49
#define FUNC_DISPMOD  50
#define FUNC_DEFDISP  51
#define FUNC_DISPTO  52
#define FUNC_SCANSPD  53
#define FUNC_MODBUSADD  54
#define FUNC_BAUDRATE  55
#define FUNC_RESETSPC  56
#define FUNC_SYSTEST  57
#define FUNC_ALAOUTTEST  58
#define FUNC_HEATTEST  59
#define FUNC_GFITEST  60



//MCP3202的状态定义
#define GETING_TEMP  1
#define ADC_FREE  0
#define GETING_GFI_CURRENT  2
#define GETING_TEMP_REQ 3

//数据测量状态
#define DISABLE_MEASUREMENT 0    //relay关闭，无法测量
#define INITIAL_MEASUREMENT 1    //开始测量，等待信号稳定
#define START_MEASUREMENT 2      //初始化累加器，等待ADC开放
#define RUNING_MEASUREMENT 3     //进行一个周期的数据采集
#define FINISH_MEASUREMENT 4     //采集完成
#define IDEL_MEASUREMENT 5       //测量功能模块空闲

//数据更新指示
#define CH1_ONTIME_UPDATE_REQ (unsigned long)0x00000001
#define CH2_ONTIME_UPDATE_REQ (unsigned long)0x00000002
#define CH1_ONTIME_UPDATE_PERCENT_REQ (unsigned long)0x00000004
#define CH2_ONTIME_UPDATE_PERCENT_REQ (unsigned long)0x00000008
#define CH1_CURRENT_GFI_UPDATE_REQ (unsigned long)0x00000010
#define CH2_CURRENT_GFI_UPDATE_REQ (unsigned long)0x00000020
#define CH1_CURRENT_MAX_UPDATE_REQ (unsigned long)0x00000040
#define CH2_CURRENT_MAX_UPDATE_REQ (unsigned long)0x00000080
#define CH1_GFI_MAX_UPDATE_REQ (unsigned long)0x00000100
#define CH2_GFI_MAX_UPDATE_REQ (unsigned long)0x00000200
#define CH1_TEMP_UPDATE_REQ  (unsigned long)0x00000400
#define CH2_TEMP_UPDATE_REQ  (unsigned long)0x00000800
#define CH1_TEMP_MAX_UPDATE_REQ  (unsigned long)0x00001000
#define CH2_TEMP_MAX_UPDATE_REQ  (unsigned long)0x00002000
#define CH1_TEMP_MIN_UPDATE_REQ (unsigned long)0x00004000
#define CH2_TEMP_MIN_UPDATE_REQ (unsigned long)0x00008000
#define CH1_DUTY_UPDATE_REQ  (unsigned long)0x00010000
#define CH2_DUTY_UPDATE_REQ  (unsigned long)0x00020000
#define CH1_ENEGY_UPDATE_REQ  (unsigned long)0x00040000
#define CH2_ENEGY_UPDATE_REQ  (unsigned long)0x00080000
#define CH1_HEAT_STAT_UPDATE_REQ (unsigned long)0x00100000
#define CH2_HEAT_STAT_UPDATE_REQ (unsigned long)0x00200000
#define ALARM_STAT_UPDATE_REQ (unsigned long)0x00400000
#define CALIDISP_UPDATE_REQ (unsigned long)0x00800000
#define VOLTAGE_UPDATE_REQ (unsigned long)0x01000000
#define VOLTAGE_MAX_UPDATE_REQ (unsigned long)0x02000000
#define VOLTAGE_MIN_UPDATE_REQ (unsigned long)0x04000000

#define MULTI_CH_REQ (unsigned long)0x80000000


//寄存器位置
#define CH1_ACTURAL_ONTIME 0
#define CH2_ACTURAL_ONTIME 1
#define CH1_ACTURAL_GFI 2
#define CH2_ACTURAL_GFI 3
#define CH1_ACTURAL_CURRENT 4
#define CH2_ACTURAL_CURRENT 5
#define CH1_ACTURAL_ALL 6
#define CH2_ACTURAL_ALL 7
#define CH1_ACTURAL_A 8
#define CH2_ACTURAL_A 9
#define CH1_ACTURAL_B 10
#define CHE_ACTURAL_B 11
#define CH1_ACTURAL_MAX 12
#define CH2_ACTURAL_MAX 13
#define CH1_ACTURAL_MIN 14
#define CH2_ACTURAL_MIN 15
#define CH1_ACTURAL_HEAT 16
#define CH2_ACTURAL_HEAT 17
#define CH1_ACTURAL_DUTY 18
#define CH2_ACTURAL_DUTY 19
#define CH1_ACTURAL_CURRENT_MAX 20
#define CH2_ACTURAL_CURRENT_MAX 21
#define CH1_ACTURAL_GFI_MAX 22
#define CH2_ACTURAL_GFI_MAX 23
#define CH1_ACTURAL_ENEGY 24
#define CH2_ACTURAL_ENEGY 25
#define CH1_ACTURAL_COST 26
#define CH2_ACTURAL_COST 27
#define ACTURAL_ALARM 28
#define CH2_ACTURAL_ALARM 29
#define ACTURAL_VOLT 30
#define CH2_ACTURAL_VOLT 31
#define ACTURAL_VOLT_MAX 32
#define CH2_ACTURAL_VOLT_MAX 33
#define ACTURAL_VOLT_MIN 34
#define CH2_ACTURAL_VOLT_MIN 35
#define CH1_ACTURAL_ONTIME_PERCENT 36
#define CH2_ACTURAL_ONTIME_PERCENT 37

//HEATER状态字符位置
#define HEAT_IS_OFF 0
#define HEAT_IS_ON 1
#define HEAT_IS_MANON 2
#define HEAT_IS_MANOFF 3

//Calibration显示信息位置
#define CALIBRATION_TITLE  33
#define CALIBRATE_RTDA_50_STR  34
#define CALIBRATE_RTDA_500_STR  35
#define CALIBRATE_RTDB_50_STR  36
#define CALIBRATE_RTDB_500_STR  37

#define CALIBRATING_STR 38
#define BLANK_STR 39

#define RTD_SHORT_STR 40
#define RTD_OPEN_STR 41
#define OUTOFRANGE_STR 42

#define VERSION_TITLE_STR 43
#define VERSION_CONTENT_STR 44

#define CALI_RTDA_50     0
#define CALI_RTDA_500    1
#define CALI_RTDB_50     2
#define CALI_RTDB_500    3

//Alarms显示信息位置
#define CH1_ALARM_LOWTEMP_STR  43
#define CH2_ALARM_LOWTEMP_STR  44
#define CH1_ALARM_HIGTEMP_STR  45
#define CH2_ALARM_HIGTEMP_STR  46
#define CH1_ALARM_LOWCURRENT_STR  47
#define CH2_ALARM_LOWCURRENT_STR  48
#define CH1_ALARM_HIGHCURRENT_STR  49
#define CH2_ALARM_HIGHCURRENT_STR  50
#define CH1_ALARM_GFI_STR  51
#define CH2_ALARM_GFI_STR  52
#define CH1_ALARM_GFITRIP_STR  53
#define CH2_ALARM_GFITRIP_STR  54
#define ALARM_LOWVOLT_STR  55
#define ALARM_HIGHVOLT_STR  56
#define CH1_ALARM_CONTINUEFAIL_STR  57
#define CH2_ALARM_CONTINUEFAIL_STR  58
#define CH1_ALARM_SWITCHFAIL_STR  59
#define CH2_ALARM_SWITCHFAIL_STR  60
#define CH1_ALARM_RTDAOPEN_STR  61
#define CH2_ALARM_RTDAOPEN_STR  62
#define CH1_ALARM_RTDASHORT_STR  63
#define CH2_ALARM_RTDASHORT_STR  64
#define CH1_ALARM_RTDBOPEN_STR  65
#define CH2_ALARM_RTDBOPEN_STR  66
#define CH1_ALARM_RTDBSHORT_STR  67
#define CH2_ALARM_RTDBSHORT_STR  68
#define CH1_ALARM_GFITESTFAIL_STR  69
#define CH2_ALARM_GFITESTFAIL_STR  70


#define ALARM_SELFCHECKFAIL_STR  71
#define ALARM_AUTOTEST_STR  72


//off/none显示信息位置
#define NO_STR  4
#define YES_STR  5
#define OFF_STR  73
#define ON_STR  74
#define NONE_STR  75
#define COUNTINU_STR 76
#define DISABLE_STR 77
          #define ON_OFF_STR OFF_STR

//密码显示信息位置
#define DEFAULT_PSW_STR  78
#define ENTER_PSW_STR  79
#define RESET_REQ_PSW_STR  80
#define RESET_SUCCESS_PSW_STR  81
#define RESET_FAILT_PSW_STR  82

//存储显示信息位置
#define STORE_STR  83

//RESET STATISTICS
#define CONFIRM_CHANGE_STR 84
#define CHANGE_COMPLETE_STR 85

//default display information
#define DEFAULT_HEATERTEMP_STR  86
#define DEFAULT_HEATERSTATUS_STR  87
#define DEFAULT_SYSTEMSTATUS_STR  88

//blank value
#define NONEVALUE_STR  89

//calibration and testing display
#define NEED_CALIBRATION_STR  90
#define NOW_CALIBRATION_STR  91
#define FINISH_CALIBRATION_STR  92

#define NEED_TESTING_STR  93
#define NOW_TESTING_STR  94
#define FINISH_TESTING_STR  95

//channel config
#define CHANNEL1_STR  96
#define CHANNEL2_STR  97


//SSR强制操作命令
#define FORCE_LEVEL_LOW  0
#define FORCE_LEVEL_MID  1
#define FORCE_LEVEL_HIGH  2

#define GFITRIPFORCEOFF  0x01
#define HIGHTEMPCUTOFFFORCEOFF  0x02
#define FAILUREMODEFORCEOFF  0x04
#define MANUALFORCEOFF  0x08
#define HEATERDISABLEFORCEOFF  0x10

#define GFITESTFORCEON       0x01
#define HEATERTESTFORCEON    0x02
#define AUTOTESTFORCEON      0x04
#define FAILUREMODEFORCEON   0x08

typedef unsigned char UCHAR;
typedef unsigned int UINT;
typedef unsigned long ULONG;

typedef struct tagUCHAR_BIT
{
  UCHAR bit0:1;
  UCHAR bit1:1;
  UCHAR bit2:1;
  UCHAR bit3:1;
  UCHAR bit4:1;
  UCHAR bit5:1;
  UCHAR bit6:1;
  UCHAR bit7:1;
}UCHAR_BIT;

typedef union tagUCHAR_BYTE
{
  UCHAR byte;
  UCHAR_BIT bite;
}UCHAR_BYTE;

typedef union tagUINT16
{
  UCHAR byte[2];
  UINT  word;
}UINT16;

typedef union tagUINT32
{
  UCHAR byte[4];
  UINT  inte[2];
  ULONG word;
}UINT32;

typedef struct tagSPCTRING
{
  UCHAR SPCtring[20];
}SPCTRING;

typedef struct tagSYSTEM_FLAG_INT
{
  ULONG keypushed:1;
  ULONG meas_VT_reach:2;
  ULONG freq_en:1;
  ULONG lcd_line1_needupdate:1;
  ULONG lcd_line2_needupdate:1;
  ULONG mainmenuroll:1;
  ULONG alarm_displayed:1;     //正在显示ALARM
  ULONG alarm_actived:1;       //有ALARM存在
  ULONG log_displayed:1;
  ULONG default_diaped:1;
  ULONG char_actived:1;
  ULONG modebus_rx:1;
  ULONG scantime_en:2;         //enable scantime
  ULONG flashing_en:1;
  ULONG flashing_reach:1;
  ULONG flashing_state:1;
  ULONG temp_err:1;
  ULONG temp_update:1;
  ULONG load_forceop:2;    //1:强制打开 0：强制关闭
  ULONG alarmssr_forceop:1;
  ULONG alarmssr_stat:1;
  ULONG alarmtest_cmd:2;
  ULONG heatest_reach:1;
  ULONG heatest_req:1;
  ULONG autotest_req:2;
  ULONG char_flash:1;
  ULONG stat_update:1;
}SYSTEM_FLAG_INT;

typedef union tagSYSTEM_FLAG
{
  ULONG word;
  SYSTEM_FLAG_INT bite;
}SYSTEM_FLAG;

typedef struct tagTEMPERATURE
{
  int Temperature_F;
  int Temperature_C;
}TEMPERATURE;

typedef struct tagSYSTEM_VALUE_SHORT
{

//SPC设置参数
  ULONG spc_units_c:1;          //UNITS                                         0
  ULONG heater_en:1;           //                                               1
  ULONG man_on:1;             //0:禁止手动控制  1:使能手动控制                  2
  ULONG ctl_type:1;              //Control type  0:on/off  1:proportional       3
  ULONG rtd_opr:3;            //rtd operation                                   4
                             //    0:one rtd  1:backup  2:average
                             //    3:lowest   4:highest 5:high temp cutoff
  ULONG rtd_fail_mod:1;       //  0:off                                         7
  ULONG password_en:1;        //                                                8
  ULONG usr_advanced:1;        //                                               9
  ULONG def_display:2;         //default display  0:system status               10
                                 //  1:heater status  2:heater temp
  ULONG baud:3;                 //                                              12
  ULONG gfi_test_mod:2;        //GFI test mode   0:atuo cycle                   15
                               //     1:now  2:Disable
  ULONG heater_type:1;         //heater type    0:fix resister heater           17
                               //               1:self regulater heater
  ULONG cable_type:1;         //0:fix resistor  1:self regulate                 18
  ULONG reservd:13;
}SYSTEM_VALUE_SHORT;

typedef union tagSYSTEM_VALUEB
{
  ULONG word;
  SYSTEM_VALUE_SHORT bite;
}SYSTEM_VALUEB;

typedef struct tagSPCSETPIONTS
{
//Set points
  TEMPERATURE   MaintainTemp;          //0
  TEMPERATURE   LowTemp;               //4
  TEMPERATURE   HighTemp;              //8
  TEMPERATURE   DeadBand;              //12
  
  int   LowCurrent;                    //16
  int   HighCurrent;                   //18

  int   GFIAlarm;                      //20
  int   GFITrip;                       //22

  int   LowVoltage;                    //24
  int   HighVoltage;                   //26


  int   LimitedCurrent;                //28

  int   SoftStartTime;                 //30
  int   AutoTestTime;                  //32

  int   DisplayTime;                   //34

  int  CostPerKWH;                     //36
  int  ScanSpeed;                       //38
  int  ModbusAdd;                       //40
  int  BaudRate;                        //42
  
  int   AlarmOutTest;                   //44
  int   HeaterTest;                     //46
  int   GFTest;                         //48

  char    HeaterName[16];               //50
  char    Password[16];                 //66
  char    CharacNum;     //表示正在输入第几个字符        82
  char    StringNum;     //字符轮转计数                 83

  SYSTEM_VALUEB system_valueb;  //系统短数据             84
}SPCSETPIONTS;

typedef struct tagSTATISTICS
{
//Statistics
  TEMPERATURE   MaximumTemp;      //12
  TEMPERATURE   MinimumTemp;      //14
  int   MaximumCurrent;           //16
  int   MaximumGFCurrent;         //17
  int   MaximumVoltage;           //18
  int   MinimumVoltage;           //19
  int   EnergyUsed;               //20
  ULONG EnergyCost;               //21
  ULONG RunTime;                  //22
  int   HeaterOnTime;             //24
  int   Version;                  //25
}STATISTICS;

typedef struct tagSPCACTUAL
{
//Actual
  TEMPERATURE   Temperature;  //0
  TEMPERATURE   TemperatureA;   //2
  TEMPERATURE   TemperatureB;  //4
  int   HeaterPow;             //6
  int   Current;               //7
  int   Current_RMS;           //8
  int   GFICurrent;            //9
  int   Voltage;               //10
  int   HeaterStatus;          //11
}SPCACTUAL;

typedef struct tagSPCVALUE
{
  SPCACTUAL SPCActual;
  STATISTICS SPCStatistics;
  SPCSETPIONTS SPCSetPoints;
} SPCVALUE;

typedef struct tagSPCMENUFLAG_BIT
{
  UCHAR menu_active:1;
  UCHAR advanced_req:1;
  UCHAR maintainnone_conflict:1;
  UCHAR maintainoff_conflict:1;
  UCHAR proportional_conflict:1;
  UCHAR SelfRegula_conflict:1;
  UCHAR FoxResis_conflict:1;
  UCHAR reservd:1;
}SPCMENUFLAG_BIT;

typedef union tagSPCMENUFLAG
{
  UCHAR word;
  SPCMENUFLAG_BIT bite;
}SPCMENUFLAG;

typedef struct tagSPCCOUNT
{
  unsigned int secout;         //conter for 1second
  unsigned int toutT;         //counter for timeout
  unsigned int Timeout_count;
  unsigned int modbus_count;  //modbus end check
  unsigned int scanT;         //scan time
  char meas_VT_count;         //Vlot & Temp measure counter
  char meas_CG_count[2];         //Current & GFI measure counter
  unsigned int freq_count;
  char AlarmOutTest_count;
  char HeaterTest_count;
  unsigned int AutoTest_count;     //每隔一定时间进行一次autotest
  unsigned int AutoTest_last_count;     //每次autotest持续一段时间
  char KeyValue_count;      //hold key操作的计数
}SPCCOUNT;

typedef struct tagSPCALARM
{
  UCHAR num_alarms;
  unsigned long alarm_typ[20];
}SPCALARM;

typedef struct tagSPCLOG
{
  UCHAR num_logs;
  unsigned long log_typ[20];
}SPCLOG;

typedef struct tagSPCALARMBOX
{
  SPCALARM spcalarms;
  SPCLOG spclogs;
}SPCALARMBOX;

typedef struct tagACCUMULATE
{
  ULONG Current_acc;
  ULONG GFI_acc;
  ULONG Volt_acc;
}ACCUMULATE;

typedef struct tagSPCTIME
{
  char second;
  char minute;
  ULONG hour;
}SPCTIME;

/*typedef struct tagSPCALARMTYPE
{
  UCHAR alarmtype;
  UCHAR text_line1[16];
  UCHAR text_line2[16];
}SPCALARMTYPE;

static code SPCALARMTYPE Alarmtype[20]
{
  {0, " Actived alarms ", " 0 alarms       "},
  {0, "   Alarm logs   ", " 0 logs         "},
  {0, " 0/2 Alarms     ", " 0 alarms       "},
  {0, " Actived alarms ", " 0 alarms       "},
  {0, " Actived alarms ", " 0 alarms       "},
  {0, " Actived alarms ", " 0 alarms       "},
  {0, " Actived alarms ", " 0 alarms       "},
  {0, " Actived alarms ", " 0 alarms       "},
  {0, " Actived alarms ", " 0 alarms       "},
  {0, " Actived alarms ", " 0 alarms       "},
  {0, " Actived alarms ", " 0 alarms       "},
}; */

typedef struct tagSETPSHADE
{
  unsigned char chare;
  int inte;
}SETPSHADE;

typedef struct tagSPCSSR
{
  char SSR_cmd;         //SSR指令
  char SSR_stat;        //SSR状态
  char SSR_actual_stat;
}SPCSSR;

typedef struct tagSOFTSTART
{
  char SOFTSTART_cmd;         //SOFTSTART指令
  char SOFTSTART_stat;        //SOFTSTART状态
  char SOFTSTART_reach;       //1秒周期到
  unsigned int SOFTSTART_count;       //1秒周期检测
}SOFTSTART;

typedef struct tagPWMCOUNT
{
  char shift_count;           //duty的位数，如果step为1%，duty为10*10=100个周期，10个int型数据
  char duty_count;        //单个int数据移位用的计数器
  unsigned int element_count;   //工频周期计数器
  unsigned int meas_forbid_count;
  unsigned int meas_count;
}PWMCOUNT;

typedef struct tagSPCPWM
{
  char pwm_cmd;           //启动或关闭pwm
  char duty_point;        //恒温pwm点
  char meas_cmd;
  PWMCOUNT pwm_count;
}SPCPWM;

typedef struct tagVALUEACC
{
  unsigned char num;
  unsigned long acc;
}VALUEACC;

typedef struct tagCLIBRATIONBOX
{
  char index;
  char subindex;
}CLIBRATIONBOX;

typedef struct tagCLIBRATIONCMD
{
  char enable;
  char index;
  char command;
}CLIBRATIONCMD;

extern SYSTEM_FLAG spc_system_flag;
extern SPCVALUE pSPCValue[2];
extern char Cable_Channel;
extern UCHAR Menustat;
extern SPCPWM Spcpwm[2];
extern SPCSSR Spcssr[2];
extern SOFTSTART SpcSstart[2];
extern ACCUMULATE SpcAcc[2];

//extern CLIBRATION SPCClibration;

extern UCHAR Info_Line1[LCDLENGTH];
extern UCHAR Info_Line2[LCDLENGTH];
extern UCHAR Info_Line1_shape[LCDLENGTH];
extern UCHAR Info_Line2_shape[LCDLENGTH];

extern UCHAR Alarmstat,Alarmtype[19];
extern UCHAR ALARM_NUM[2];
extern SETPSHADE SetP_shade1;
extern SPCSETPIONTS SetP_shade;
extern SPCCOUNT spc_count;
extern SPCALARMBOX pSPCAlarm;
extern UCHAR Passwordbuff[16];

extern SPCTIME SYS_On_time;
extern SPCTIME Heat_On_time[2];

extern unsigned long ActivedAlarms;
//extern UINT ActivedLogs;
extern UINT KeyHoldStep;
extern UINT KeyHoldDelay;
extern char Keyactived,Keyhold;
extern char bUpdate;
extern char LCDext;

extern UCHAR Statis_flag[2];

extern signed int temp_val_old[2];

extern unsigned int pwm_duty[2],duty_index[2];

extern UINT freqency;
extern UINT freq_pori;
extern char char_flash_loca;

extern char reset_psw_en;

extern CLIBRATIONCMD Cali_cmd;

extern VALUEACC Volt_acc[2];
extern VALUEACC Current_acc[2];

extern char ADC_busy[2];

extern char Actural_disp_str[38][17];
extern ULONG SystemUpdate;
extern char freq_en;

extern int Cali_value[4];

extern unsigned int DataUpdate;

extern char forceop_level;
extern char KeyEn;

extern unsigned char ForceSSRONCondition[2];
extern unsigned char ForceSSROFFCondition[2];