#include "Spcsystem.h"

#define SEPERATECHANNEL 1

typedef struct tagSPCMENU
{
  UCHAR index;
  UCHAR subindex;
  UCHAR thirdindex;

  SPCMENUFLAG flag;
  UCHAR func_mark;
  
  char offset;  //用于与pSPCValue相对应
  unsigned long  len;     //用于纯非数字量的计数
  char add;     //用于纯非数字量字符串的定位
  
  int MaxVal;
  int MinVal;
  
  char NumVal;  //用于数字量中非数字量个数 或者 非数字量function
  char Unit;     //用于指示单位
  
  char decimal;  //小数位数
  char edge_nofix;
}SPCMENU;

static code SPCMENU SpcMenu[MAX_MENU_NUM] =
{
//Actual
  //Operating value
  {MENU_IN_ACTUAL,     ACTUAL_IN_OPERVAL,      OPERVAL_WELCOM,
   MENUACTIVE,
   FUNC_TITLE,         TITLE_OPERATEVALUE,     NULL,     NULL,
   NULL,               NULL,                   NULL,     NULL,
   NULL,               NULL},//Operatingvalue wellcom     0
    
  {MENU_IN_ACTUAL,     ACTUAL_IN_OPERVAL,      OPERVAL_HEATSTAT,
   MENUACTIVE,
   FUNC_SHOW,          CH1_ACTURAL_HEAT,       CH1_HEAT_STAT_UPDATE_REQ|MULTI_CH_REQ,     NULL,
   NULL,               NULL,                   NULL,     NULL,
   NULL,               SEPERATECHANNEL},//Heater status  1
    
  {MENU_IN_ACTUAL,     ACTUAL_IN_OPERVAL,      OPERVAL_TEMP,
   MENUACTIVE|MAINTAINNONEFILIC|MAINTAINOFFFILIC,
   FUNC_SHOW,          CH1_ACTURAL_ALL,        CH1_TEMP_UPDATE_REQ|MULTI_CH_REQ,      NULL,
   NULL,               NULL,                   NULL,      NULL,
   NULL,               SEPERATECHANNEL},//Temperature     2
    
  {MENU_IN_ACTUAL,     ACTUAL_IN_OPERVAL,      OPERVAL_TEMPA,
   MENUACTIVE|MAINTAINOFFFILIC|ADVANCEREQ,
   FUNC_SHOW,          CH1_ACTURAL_A,          CH1_TEMP_UPDATE_REQ|MULTI_CH_REQ,      NULL,
   NULL,               NULL,                   NULL,      NULL,
   NULL,               SEPERATECHANNEL},//Temperature A    3
    
  {MENU_IN_ACTUAL,     ACTUAL_IN_OPERVAL,      OPERVAL_TEMPB,
   MENUACTIVE|MAINTAINOFFFILIC|ADVANCEREQ,
   FUNC_SHOW,          CH1_ACTURAL_B,          CH1_TEMP_UPDATE_REQ|MULTI_CH_REQ,      NULL,
   NULL,               NULL,                   NULL,      NULL,
   NULL,               SEPERATECHANNEL},//Temperature B      4
    
  {MENU_IN_ACTUAL,     ACTUAL_IN_OPERVAL,      OPERVAL_HEATPOW,
   MENUACTIVE|ADVANCEREQ,
   FUNC_SHOW,          CH1_ACTURAL_DUTY,       CH1_DUTY_UPDATE_REQ|MULTI_CH_REQ,      NULL,
   NULL,               NULL,                   NULL,      NULL,
   NULL,               SEPERATECHANNEL},//Heater power     5
    
  {MENU_IN_ACTUAL,     ACTUAL_IN_OPERVAL,      OPERVAL_CURRENT,
   MENUACTIVE,
   FUNC_SHOW,          CH1_ACTURAL_CURRENT,    CH1_CURRENT_GFI_UPDATE_REQ|MULTI_CH_REQ,      NULL,
   NULL,               NULL,                   NULL,      NULL,
   CURRENT_DECIMAL,               SEPERATECHANNEL},//Load current     6
    
  {MENU_IN_ACTUAL,     ACTUAL_IN_OPERVAL,      OPERVAL_GFIC,
   MENUACTIVE,
   FUNC_SHOW,          CH1_ACTURAL_GFI,        CH1_CURRENT_GFI_UPDATE_REQ|MULTI_CH_REQ,   NULL,
   NULL,               NULL,                   NULL,   NULL,
   NULL,               SEPERATECHANNEL},//Gound fault current   7
    
  {MENU_IN_ACTUAL,     ACTUAL_IN_OPERVAL,      OPERVAL_VOLT,
   MENUACTIVE,
   FUNC_SHOW,          ACTURAL_VOLT,           VOLTAGE_UPDATE_REQ,   NULL,
   NULL,               NULL,                   NULL,   NULL,
   NULL,               NULL},//Voltage            8

  //Statistics
  {MENU_IN_ACTUAL,     ACTUAL_IN_STATISTIC,    STATISTIC_WELCOM,
   MENUACTIVE|ADVANCEREQ,
   FUNC_TITLE,         TITLE_STATISTIC,        NULL,       NULL,
   NULL,               NULL,                   NULL,       NULL,
   NULL,               NULL},//Statistics wellcom      9
    
  {MENU_IN_ACTUAL,     ACTUAL_IN_STATISTIC,    STATISTIC_MAXTEMP,
   MENUACTIVE|ADVANCEREQ|MAINTAINOFFFILIC,
   FUNC_SHOW,          CH1_ACTURAL_MAX,        CH1_TEMP_MAX_UPDATE_REQ|MULTI_CH_REQ,  NULL,
   NULL,               NULL,                   NULL,  NULL,
   NULL,               SEPERATECHANNEL},//Maximum temp       10
    
  {MENU_IN_ACTUAL,     ACTUAL_IN_STATISTIC,    STATISTIC_MINTEMP,
   MENUACTIVE|ADVANCEREQ|MAINTAINOFFFILIC,
   FUNC_SHOW,          CH1_ACTURAL_MIN,        CH1_TEMP_MIN_UPDATE_REQ|MULTI_CH_REQ,  NULL,
   NULL,               NULL,                   NULL,  NULL,
   NULL,               SEPERATECHANNEL},//Minimum temp       11
    
  {MENU_IN_ACTUAL,     ACTUAL_IN_STATISTIC,    STATISTIC_MAXCURRENT,
   MENUACTIVE|ADVANCEREQ,
   FUNC_SHOW,          CH1_ACTURAL_CURRENT_MAX,   CH1_CURRENT_MAX_UPDATE_REQ|MULTI_CH_REQ,           NULL,
   NULL,               NULL,                   NULL,           NULL,
   CURRENT_DECIMAL,               SEPERATECHANNEL},//Maximum current     12
    
  {MENU_IN_ACTUAL,     ACTUAL_IN_STATISTIC,    STATISTIC_MAXGFIC,
   MENUACTIVE|ADVANCEREQ,
   FUNC_SHOW,          CH1_ACTURAL_GFI_MAX,    CH1_GFI_MAX_UPDATE_REQ|MULTI_CH_REQ,        NULL,
   NULL,               NULL,                   NULL,        NULL,
   NULL,               SEPERATECHANNEL},//Maximum ground fault leakage   13
    
  {MENU_IN_ACTUAL,     ACTUAL_IN_STATISTIC,    STATISTIC_MAXVOLT,
   MENUACTIVE|ADVANCEREQ,
   FUNC_SHOW,          ACTURAL_VOLT_MAX,                   VOLTAGE_MAX_UPDATE_REQ,        NULL,
   NULL,               NULL,                   NULL,        NULL,
   NULL,               NULL},//Maximum voltage     14
    
  {MENU_IN_ACTUAL,     ACTUAL_IN_STATISTIC,    STATISTIC_MINVOLT,
   MENUACTIVE|ADVANCEREQ,
   FUNC_SHOW,          ACTURAL_VOLT_MIN,                   VOLTAGE_MIN_UPDATE_REQ,        NULL,
   NULL,               NULL,                   NULL,        NULL,
   NULL,               NULL},//Minimum voltage    15
    
  {MENU_IN_ACTUAL,     ACTUAL_IN_STATISTIC,    STATISTIC_ENEGRY,
   MENUACTIVE|ADVANCEREQ,
   FUNC_SHOW,          CH1_ACTURAL_ENEGY,      CH1_ENEGY_UPDATE_REQ|MULTI_CH_REQ,       NULL,
   NULL,               NULL,                   NULL,       NULL,
   NULL,               SEPERATECHANNEL},//Operational kwh    16
    
  {MENU_IN_ACTUAL,     ACTUAL_IN_STATISTIC,    STATISTIC_COST,
   MENUACTIVE|ADVANCEREQ,
   FUNC_SHOW,          CH1_ACTURAL_COST,       CH1_ENEGY_UPDATE_REQ|MULTI_CH_REQ,     NULL,
   NULL,               NULL,                   NULL,     NULL,
   OPERATECOST_DECIMAL,               SEPERATECHANNEL},//Operational cost     17
    
  {MENU_IN_ACTUAL,     ACTUAL_IN_STATISTIC,    STATISTIC_ONTIME,
   MENUACTIVE|ADVANCEREQ,
   FUNC_SHOW,          CH1_ACTURAL_ONTIME,     CH1_ONTIME_UPDATE_REQ|MULTI_CH_REQ,       NULL,
   NULL,               NULL,                   NULL,       NULL,
   NULL,               SEPERATECHANNEL},//On time     18
    
  {MENU_IN_ACTUAL,     ACTUAL_IN_STATISTIC,    STATISTIC_ONTIMEDUTY,
   MENUACTIVE|ADVANCEREQ,
   FUNC_SHOW,          CH1_ACTURAL_ONTIME_PERCENT, CH1_ONTIME_UPDATE_PERCENT_REQ|MULTI_CH_REQ,           NULL,
   NULL,               NULL,                   NULL,           NULL,
   NULL,               SEPERATECHANNEL},//On time percentage    19
    
  {MENU_IN_ACTUAL,     ACTUAL_IN_STATISTIC,    STATISTIC_RESET,
   MENUACTIVE|ADVANCEREQ,
   FUNC_RESET,         NULL,                   NULL,      NULL,
   NULL,               NULL,                   NULL,      NULL,
   NULL,               NULL},//Reset statistics   20
    
  {MENU_IN_ACTUAL,     ACTUAL_IN_STATISTIC,    STATISTIC_VERSION,
   MENUACTIVE|ADVANCEREQ,
   FUNC_VERSION,       NULL,                   NULL,        NULL,
   NULL,               NULL,                   NULL,        NULL,
   NULL,               NULL},//Version      21

//Alarm
  //Alarms

  //Logs

//Program
  //Setpoints
  {MENU_IN_PROGRAM,    PROGRAM_IN_SETPOINT,    SETPOINT_WELCOM,
   MENUACTIVE   ,
   FUNC_TITLE,         TITLE_SETPOINT,         NULL,      NULL,
   NULL,               NULL,                   NULL,      NULL,
   NULL,               NULL},//Setpoints wellcom   22
   
  {MENU_IN_PROGRAM,    PROGRAM_IN_SETPOINT,    SETPOINT_TEMP,
   MENUACTIVE,
   FUNC_CHANNEL,       NULL,                   NULL,    NULL,
   NULL,               NULL,                   NULL,    NULL,
   NULL,               NULL},//Channel config   23
    
  {MENU_IN_PROGRAM,    PROGRAM_IN_SETPOINT,    SETPOINT_TEMP,
   MENUACTIVE,
   FUNC_MAINT,         NULL,                   NULL,    NULL,
   NULL,               NULL,                   NULL,    UNIT_TEMP,
   NULL,               SEPERATECHANNEL},//Maintain TEMPERATURE   24
    
  {MENU_IN_PROGRAM,    PROGRAM_IN_SETPOINT,    SETPOINT_LOWTEMP,
   MENUACTIVE|MAINTAINOFFFILIC,
   FUNC_LOWTEMP,       NULL,                   NULL,       NULL,
   NULL,               NULL,                   NULL,       UNIT_TEMP,
   NULL,               SEPERATECHANNEL},//Low temp alarm   25
    
  {MENU_IN_PROGRAM,    PROGRAM_IN_SETPOINT,    SETPOINT_HIGHTEMP,
   MENUACTIVE|MAINTAINOFFFILIC,
   FUNC_HIGHTEMP,      NULL,                   NULL,       NULL ,
   NULL,               NULL,                   NULL,       UNIT_TEMP,
   NULL,               SEPERATECHANNEL},//High temp alarm    26
    
  {MENU_IN_PROGRAM,    PROGRAM_IN_SETPOINT,    SETPOINT_LOWCURRENT,
   MENUACTIVE,
   FUNC_INTSET,        INTSET_LOWCURRENT,      10,          NULL,
   MAX_SPCLOWCURRENT,  MIN_SPCCURRENT,   1,             UNIT_AMPER,
   CURRENT_DECIMAL,    MAX_NOFIX}, //Low current    27
    
  {MENU_IN_PROGRAM,    PROGRAM_IN_SETPOINT,    SETPOINT_HIGHCURRENT,
   MENUACTIVE,
   FUNC_INTSET,        INTSET_HIGHCURRENT,     10,           NULL,
   MAX_SPCCURRENT,     MIN_SPCHIGHCURRENT,     1,              UNIT_AMPER,
   CURRENT_DECIMAL,    MIN_NOFIX},//High current    28
    
  {MENU_IN_PROGRAM,    PROGRAM_IN_SETPOINT,    SETPOINT_GFIALARM,
   MENUACTIVE,
   FUNC_INTSET,        INTSET_GFIALARM,        5,        NULL,
   MAX_SPCLOWGFIALARM, MIN_SPCGFIALARM,        1,           UNIT_MILIAMPER,
   NULL,               MAX_NOFIX},//GFI alarm        29
    
  {MENU_IN_PROGRAM,    PROGRAM_IN_SETPOINT,    SETPOINT_GFITRIP,
   MENUACTIVE,
   FUNC_INTSET,        INTSET_GFITRIP,         5,       NULL,
   MAX_SPCGFIALARM,    MIN_SPCHIGHGFIALARM,    1,          UNIT_MILIAMPER,
   NULL,               MIN_NOFIX},//GFI trip    30
    
  {MENU_IN_PROGRAM,    PROGRAM_IN_SETPOINT,    SETPOINT_LOWVOLT,
   MENUACTIVE,
   FUNC_INTSET,        INTSET_LOWVOLT,         10,       NULL,
   MAX_SPCLOWVOLT,     MIN_SPCVOLT,   1,          UNIT_ACVOLT,
   NULL,               MAX_NOFIX},//Low voltage   31
    
  {MENU_IN_PROGRAM,    PROGRAM_IN_SETPOINT,    SETPOINT_HIGHVOLT,
   MENUACTIVE,
   FUNC_INTSET,        INTSET_HIGHVOLT,        10,        NULL,
   MAX_SPCVOLT,        MIN_SPCHIGHVOLT,        1,           UNIT_ACVOLT,
   NULL,               MIN_NOFIX},//High voltage   32

  //Heater setup
  {MENU_IN_PROGRAM,    PROGRAM_IN_HEATSET,     HEATSET_WELCOM,
   MENUACTIVE,
   FUNC_TITLE,         TITLE_HEATSET,          NULL,     NULL,
   NULL,               NULL,                   NULL,     NULL,
   NULL,               NULL},//Heater setup wellcom     33
    
  {MENU_IN_PROGRAM,    PROGRAM_IN_HEATSET,     HEATSET_HEATEN,
   MENUACTIVE,
   FUNC_FLAGSET,       FLAG_HEATEN,            YES_NO_SWITCH,     YES_NO_STR,
   NULL,               NULL,                   NULL,              NULL,
   NULL,               SEPERATECHANNEL},//Enable heater     34
    
  {MENU_IN_PROGRAM,    PROGRAM_IN_HEATSET,     HEATSET_HEATID,
   MENUACTIVE|ADVANCEREQ,
   FUNC_HEATID,        NULL,                   NULL,     NULL,
   NULL,               NULL,                   NULL,     NULL,
   NULL,               SEPERATECHANNEL},//Heater id     35
   
  {MENU_IN_PROGRAM,    PROGRAM_IN_HEATSET,     HEATSET_HEATYPE,
   MENUACTIVE|ADVANCEREQ,
   FUNC_FLAGSET,       FLAG_HEATYPE,           YES_NO_SWITCH,     FIX_SEL_STR,
   NULL,               NULL,                   NULL,              NULL,
   NULL,               SEPERATECHANNEL},//Select Heater type     36
    
  {MENU_IN_PROGRAM,    PROGRAM_IN_HEATSET,     HEATSET_MANUAL,
   MENUACTIVE|ADVANCEREQ,
   FUNC_FLAGSET,       FLAG_MANUAL,            YES_NO_SWITCH,     ON_OFF_STR,
   NULL,               NULL,                   NULL,              NULL,
   NULL,               SEPERATECHANNEL},//Manual override    37

  {MENU_IN_PROGRAM,    PROGRAM_IN_HEATSET,     HEATSET_DEADBAND,
   MENUACTIVE|ADVANCEREQ|MAINTAINOFFFILIC|PROPORTCONFILIC,
   FUNC_DEADBAND,      NULL,                   NULL,      NULL ,
   NULL,               NULL,                   NULL,      UNIT_TEMP,
   NULL,               SEPERATECHANNEL},//Deadband    38
    
  {MENU_IN_PROGRAM,    PROGRAM_IN_HEATSET,     HEATSET_CTLTYPE,
   MENUACTIVE|ADVANCEREQ|MAINTAINOFFFILIC|SELFREGULAFILIC,
   FUNC_FLAGSET,       FLAG_CTLTYPE,           YES_NO_SWITCH,     ONOFF_PROP_STR,
   NULL,               NULL,                   NULL,              NULL,
   NULL,               SEPERATECHANNEL},//Control type     39
    
  {MENU_IN_PROGRAM,    PROGRAM_IN_HEATSET,     HEATSET_CURRENTLIMIT,
   MENUACTIVE|ADVANCEREQ|SELFREGULAFILIC,
   FUNC_INTSET,        INTSET_CURRENTLIMIT,    NULL,           NULL,
   100,                20,                     1,              UNIT_AMPER_PERCENT,
   NULL,               SEPERATECHANNEL},     //Current limiting      40
    
  {MENU_IN_PROGRAM,    PROGRAM_IN_HEATSET,     HEATSET_SOFTSTART,
   MENUACTIVE|ADVANCEREQ,
   FUNC_INTSET,        INTSET_SOFTSTART,       NULL,        NULL,
   MAX_SOFTSTART,      MIN_SOFTSTART,          1,           UNIT_SECOND,
   NULL,               SEPERATECHANNEL},    //Soft start        41
    
  {MENU_IN_PROGRAM,    PROGRAM_IN_HEATSET,     HEATSET_AUTOTEST,
   MENUACTIVE|ADVANCEREQ,
   FUNC_INTSET,        INTSET_AUTOTEST,        NULL,       NULL,
   MAX_AUTOTEST,       MIN_AUTOTEST,           1,          UNIT_HOUR,
   NULL,               NULL},//Auto test cycle     42
    
  {MENU_IN_PROGRAM,    PROGRAM_IN_HEATSET,     HEATSET_RTDOPERATE,
   MENUACTIVE|ADVANCEREQ|MAINTAINOFFFILIC,
   FUNC_FLAGSET,       FLAG_RTDOPERATE,        RTDOPR_NUM,        RTDOPR_STR ,
   NULL,               NULL,                   NULL,              NULL,
   NULL,               SEPERATECHANNEL},//RTD operation      43
    
  {MENU_IN_PROGRAM,    PROGRAM_IN_HEATSET,     HEATSET_RTDFAILMODE,
   MENUACTIVE|ADVANCEREQ|MAINTAINOFFFILIC,
   FUNC_FLAGSET,       FLAG_RTDFAILMODE,       YES_NO_SWITCH,     ON_OFF_STR,
   NULL,               NULL,                   NULL,              NULL,
   NULL,               SEPERATECHANNEL},//RTD failure mode    44

  //system setup
  {MENU_IN_PROGRAM,    PROGRAM_IN_SYSTEMSET,   SYSTEMSET_WELCOM,
   MENUACTIVE,
   FUNC_TITLE,         TITLE_SYSTEMSET,        NULL,       NULL,
   NULL,               NULL,                   NULL,       NULL,
   NULL,               NULL},//System setup wellcom    45
    
  {MENU_IN_PROGRAM,    PROGRAM_IN_SYSTEMSET,   SYSTEMSET_PSWEN,
   MENUACTIVE,
   FUNC_AUTHO,         FLAG_PSWEN,             YES_NO_SWITCH,     EN_DIS_STR,
   NULL,               NULL,                   NULL,              NULL,
   NULL,               NULL},//Enable password       46
    
  {MENU_IN_PROGRAM,    PROGRAM_IN_SYSTEMSET,   SYSTEMSET_NEWPSW,
   MENUACTIVE|ADVANCEREQ,
   FUNC_CHANGEPWD,     NULL,                   NULL,       NULL,
   NULL,               NULL,                   NULL,       NULL,
   NULL,               NULL},//Change password      47
    
  {MENU_IN_PROGRAM,    PROGRAM_IN_SYSTEMSET,   SYSTEMSET_UNITS,
   MENUACTIVE|ADVANCEREQ,
   FUNC_FLAGSET,       FLAG_UNIT,              YES_NO_SWITCH,     C_F_STR,
   NULL,               NULL,                   NULL,              NULL,
   NULL,               SEPERATECHANNEL},//Units     48
    
  {MENU_IN_PROGRAM,    PROGRAM_IN_SYSTEMSET,   SYSTEMSET_COST,
   MENUACTIVE|ADVANCEREQ,
   FUNC_INTSET,        INTSET_COST,            NULL,     NULL,
   MAX_SPCOST,         MIN_SPCOST,             0,        UNIT_COST|INFRONT,
   OPERATECOST_DECIMAL,               NULL},//Set operational costs    49
    
  {MENU_IN_PROGRAM,    PROGRAM_IN_SYSTEMSET,   SYSTEMSET_DISPMODE,
   MENUACTIVE,
   FUNC_FLAGSET,       FLAG_DISPMODE,          YES_NO_SWITCH,     NOR_ADV_STR,
   NULL,               NULL,                   NULL,              NULL,
   NULL,               NULL},//Display mode    50
    
  {MENU_IN_PROGRAM,    PROGRAM_IN_SYSTEMSET,   SYSTEMSET_DEFAULTDISP,
   MENUACTIVE|ADVANCEREQ,
   FUNC_FLAGSET,       FLAG_DEFAULTDISP,       DEFAULTDISP_NUM,   DEFAULTDISP_STR,
   NULL,               NULL,                   NULL,              NULL,
   NULL,               NULL},//Default diaplay    51
    
  {MENU_IN_PROGRAM,    PROGRAM_IN_SYSTEMSET,   SYSTEMSET_DISPTIMEOUT,
   MENUACTIVE|ADVANCEREQ,
   FUNC_INTSET,        INTSET_DISPTIMEOUT,     NULL,            NULL,
   MAX_TIMEOUT,        MIN_TIMEOUT,            1,               UNIT_SECOND,
   NULL,               NULL},//Display timeout    52
    
  {MENU_IN_PROGRAM,    PROGRAM_IN_SYSTEMSET,   SYSTEMSET_SCANSPEED,
   NULL,
   FUNC_INTSET,        INTSET_SCANSPEED,       NULL,          NULL,
   MAX_SCANSPEED,      MIN_SCANSPEED,          0,             UNIT_SECOND,
   NULL,               NULL},//Scan speed     53
    
  {MENU_IN_PROGRAM,    PROGRAM_IN_SYSTEMSET,   SYSTEMSET_MODBUS,
   MENUACTIVE|ADVANCEREQ,
   FUNC_INTSET,        INTSET_MODBUS,          NULL,       NULL,
   MAX_MODBUS,         MIN_MODBUS,             0,          NULL,
   NULL,               NULL},//Modbus address   54
    
  {MENU_IN_PROGRAM,    PROGRAM_IN_SYSTEMSET,   SYSTEMSET_BAUDRATE,
   MENUACTIVE|ADVANCEREQ,
   FUNC_FLAGSET,       FLAG_BAUDRATE,          BAUDRATE_NUM,      BAUDRATE_STR,
   NULL,               NULL,                   NULL,              NULL,
   NULL,               NULL},//Baud rate      55
    
  {MENU_IN_PROGRAM,    PROGRAM_IN_SYSTEMSET,   SYSTEMSET_RESET,
   MENUACTIVE|ADVANCEREQ,
   FUNC_RESET_MODULE,  NULL,                   NULL,      NULL,
   NULL,               NULL,                   NULL,      NULL,
   NULL,               NULL},//Reset module   56

  //system test
  {MENU_IN_PROGRAM,    PROGRAM_IN_SYSTEMTEST,  SYSTEMTEST_WELCOM,
   MENUACTIVE|ADVANCEREQ,
   FUNC_TITLE,         TITLE_SYSTEMTEST,       NULL,        NULL,
   NULL,               NULL,                   NULL,        NULL,
   NULL,               NULL},//System test wellcom   57
    
  {MENU_IN_PROGRAM,    PROGRAM_IN_SYSTEMTEST,  SYSTEMTEST_ALARMOUTPUT,
   MENUACTIVE|ADVANCEREQ,
   FUNC_INTSET,        INTSET_ALARMOUTPUT,     NULL,             NULL,
   MAX_ALARMOUT,       MIN_ALARMOUT,           2,                UNIT_HOUR,
   NULL,               SEPERATECHANNEL},//Alarm output test   58
    
  {MENU_IN_PROGRAM,    PROGRAM_IN_SYSTEMTEST,  SYSTEMTEST_HEAT,
   MENUACTIVE|ADVANCEREQ,
   FUNC_INTSET,        INTSET_HEAT,            NULL,      NULL,
   MAX_HEATERTEST,     MIN_HEATERTEST,         2,         UNIT_HOUR,
   NULL,               SEPERATECHANNEL},//Heat test       59
    
  {MENU_IN_PROGRAM,    PROGRAM_IN_SYSTEMTEST,  SYSTEMTEST_GFI,
   MENUACTIVE|ADVANCEREQ,
   FUNC_FLAGSET,       FLAG_GFITEST,           GFITEST_NUM,      GFITEST_STR,
   NULL,               NULL,                   2,        NULL,
   NULL,               SEPERATECHANNEL}//Ground fault test  60
};

static code char SpcTxtLine1[MAX_MENU_NUM][17] =
{
  "Actual          ",       //0
  "Heater Status   ",       //1
  "Temperature     ",       //2
  "RTD-A Actual    ",       //3
  "RTD-B Actual    ",       //4
  "Heater Power    ",       //5
  "Heater Current  ",       //6
  "Gound Fault     ",       //7
  "Heater Voltage  ",       //8
  "Actual          ",       //9
  "Max Temperature ",       //10
  "Min Temperature ",       //11
  "Max Current     ",       //12
  "Max Ground Fault",       //13
  "Max Voltage     ",       //14
  "Min Voltage     ",       //15
  "Total Energy    ",       //16
  "Total Cost      ",       //17
  "Heater On Time  ",       //18
  "Heater On Perc  ",       //19
  "Reset Statistics",       //20
  "Firmware Version",       //21
  "Program         ",       //22
  "Channel Config  ",       //23
  "Maintain Temp   ",       //24
  "Low Temp Alarm  ",       //25
  "High Temp Alarm ",       //26
  "Low Current Alm ",       //27
  "High Current Alm",       //28
  "GFI Alarm       ",       //29
  "GFI Trip        ",       //30
  "Low Volt Alarm  ",       //31
  "High Volt Alarm ",       //32
  "Program         ",       //33
  "Enable Heater   ",       //34
  "Heater ID       ",       //35
  "Sel Heater Type ",       //36
  "External Disable",       //37
  "Deadband        ",       //38
  "Control Type    ",       //39
  "Power Limiting  ",       //40
  "Soft Start Mode ",       //41
  "Auto Test Cycle ",       //42
  "RTD Operation   ",       //43
  "RTD Failure Mode",       //44
  "Program         ",       //45
  "Password        ",       //46
  "Change Password ",       //47
  "Units           ",       //48
  "Operational Cost",       //49
  "Display Mode    ",       //50
  "Default Display ",       //51
  "Display Timeout ",       //52
  "Scan Speed      ",       //53
  "Modbus Address  ",       //54
  "Baud Rate       ",       //55
  "Reset Module    ",       //56
  "Program         ",       //57
  "Alarm Test      ",       //58
  "Heater Test     ",       //59
  "GFI Test        "        //60
};

static code char ParaChar[98][17] =
{
  "Heater is Off   ",       //0
  "Heater is On    ",       //1
  "Heater is ManOn ",       //2
  "Heater is ManOff",       //3
  "no              ",       //4
  "yes             ",       //5
  "1200            ",       //6
  "2400            ",       //7
  "4800            ",       //8
  "9600            ",       //9
  "19200           ",       //10
  "Fahrenheit      ",       //11
  "Celcius         ",       //12
  "Enable          ",       //13
  "Disable         ",       //14
  "Normal          ",       //15
  "Advanced        ",       //16
  "Autotest Cycle  ",       //17
  "Now             ",       //18
  "Disable         ",       //19
  "On_off          ",       //20
  "Proportional    ",       //21
  "System Status   ",       //22
  "Heater Status   ",       //23
  "Heater Temp     ",       //24
  "One RTD Mode    ",       //25
  "Backup Mode     ",       //26
  "Average Mode    ",       //27
  "Lowest Mode     ",       //28
  "Highest Mode    ",       //29
  "High Temp Cutoff",       //30
  "Fix-Res         ",       //31
  "Self-Reg        ",       //32
//Calibrate需要显示的信息
  "Calibrate       ",       //33
  "RTD-A -50C      ",       //34
  "RTD-A 500C      ",       //35
  "RTD-B -50C      ",       //36
  "RTD-B 500C      ",       //37
  "Calibrating     ",       //38
  "                ",       //39
//SPCFail_str
  "RTD Short       ",       //40
  "RTD Open        ",       //41
  "Out Of Range    ",       //42
//Alarms字符串
  "CH1 LowTemp Alm ",       //43
  "CH2 LowTemp Alm ",       //44
  "CH1 HighTemp Alm",       //45
  "CH2 HighTemp Alm",       //46
  "CH1 LowCur Alm  ",       //47
  "CH2 LowCur Alm  ",       //48
  "CH1 HighCur Alm ",       //49
  "CH2 HighCur Alm ",       //50
  "CH1 GFI Alarm   ",       //51
  "CH2 GFI Alarm   ",       //52
  "CH1 GFI Trip    ",       //53
  "CH2 GFI Trip    ",       //54
  "Low Volt Alarm  ",       //55
  "High Volt Alarm ",       //56
  "CH1 ContinueFail",       //57
  "CH2 ContinueFail",       //58
  "CH1 Switch Fail ",       //59
  "CH2 Switch Fail ",       //60
  "CH1 RTDA Open   ",       //61
  "CH2 RTDA Open   ",       //62
  "CH1 RTDA Short  ",       //63
  "CH2 RTDA Short  ",       //64
  "CH1 RTDB Open   ",       //65
  "CH2 RTDB Open   ",       //66
  "CH1 RTDB Short  ",       //67
  "CH2 RTDB Short  ",       //68
  "CH1 GFITest Fail",       //69
  "CH2 GFITest Fail",       //70
  "Self Check Fail ",       //71
  "Auto Test Alarm ",       //72
//SPC参数on/off/none显示
  "Off             ",        //73
  "On              ",        //74
  "None            ",        //75
  "Continuously    ",        //76
  "Disabled        ",        //77
  
//密码相关
  "1234            ",        //78
  "Enter Password  ",        //79
  "Reset Password? ",        //80
  "Reset Success   ",        //81
  "Wrong Password  ",        //82
  
//存储显示
  "STORED          ",         //83

//Reset 显示
  "Comfirm Reset?  ",         //84
  "Reset Complete  ",          //85
  
//default display information
  "Heater Temp     ",        //86
  "Heater Status   ",        //87
  "System Status   ",        //88
  
//none value string
  "--              ",        //89
  
//calibration and testing display
  "System Need Cali",         //90
  "Calibrating     ",         //91
  "Finish Calibrate",         //92
  
  "System Need Test",         //93
  "Testing         ",         //94
  "Finish Testing  ",         //95
  
//channel config
  "Channel 1       ",         //96
  "Channel 2       "          //97
};

static code char SPCTitle[6][20] =
{
  "Operating values",
  "Statistics      ",
  "Setpoints       ",
  "Heater setup    ",
  "System setup    ",
  "System test     "
};

static code char PSWTitle[7][20] =
{
  "Change password ",
  "Enter Old Psw   ",
  "Enter New Psw   ",
  "Enter Again     ",
  "Operate success ",
  "Invalid password",
  "Not match       "
};

static code long Chr_str[8] =
      {
        10000000,
        1000000,
        100000,
        10000,
        1000,
        100,
        10,
        1
      };

static code char SPCUnit[14][9] =
{
  "        ",
  "$       ",
  {0x1b, 0x20, 0x20, 0x20, 0x20, 0x20, 0x20, 0x20},                   //"F       ",
  {0x1a, 0x20, 0x20, 0x20, 0x20, 0x20, 0x20, 0x20},                   //"C       ",
  "A       ",
  "mA      ",
  "VAC     ",
  "seconds ",
  "hours   ",
  "%       ",
  "V       ",
  "MWh     ",
  "Alarms  ",
  "Logs    "
};

static code char num[10] =
{
  '0','1','2','3','4','5','6','7','8','9'
};

static code char flag_num[16] =
{
  0,1,1,2,2,3,3,3,3,4,4,4,4,4,4,4
};

static code char SpcCharactors[PSW_CHARACT_NUM+PSW_CHARACT_EX_NUM] =
{
  ' ', '0','1','2','3','4','5','6','7','8','9',
  'A','B','C','D','E','F','G','H','I','J','K','L','M','N','O',
  'P','Q','R','S','T','U','V','W','X','Y','Z',
  'a','b','c','d','e','f','g','h','i','j','k','l','m','n','o',
  'p','q','r','s','t','u','v','w','x','y','z',
  0x21, 0x22, 0x23, 0x24, 0x25, 0x26, 0x27, 0x28, 0x29, 0x2a,
  0x2b, 0x2c, 0x2d, 0x2e, 0x2f, 0x3a, 0x3b, 0x3c, 0x3d, 0x3e,
  0x3f, 0x40, 0x5b, 0x5c, 0x5d, 0x5e, 0x5f, 0x60, 0x7b, 0x7c,
  0x7d
};

static code unsigned int ResetCmd[6] =
{
  (CH1_ACTURAL_MAX << 8) | STATIS_MAX_TEMP,
  (CH1_ACTURAL_MIN << 8) | STATIS_MIN_TEMP,
  (CH1_ACTURAL_CURRENT_MAX << 8) | STATIS_CURRENT,
  (CH1_ACTURAL_GFI_MAX << 8) | STATIS_GFI,
  (ACTURAL_VOLT_MAX << 8) | STATIS_MAX_VOLT,
  (ACTURAL_VOLT_MIN << 8) | STATIS_MIN_VOLT
};

//static code char Default_temp_str[17] = "Heater Temp     ";
static code char Version_title[17] =    "DPC firmware    ";
static code char Version_content[17] =  "Version 1.0     ";
static code char Selfcheck_str[17] =    "System Check... ";