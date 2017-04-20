#define KEY_VALUE_UP        16
#define KEY_VALUE_DOWN      4
#define KEY_VALUE_LEFT      64
#define KEY_VALUE_RIGHT     0x0100
#define KEY_VALUE_ACTUAL    128
#define KEY_VALUE_PROGRAM   32
#define KEY_VALUE_ALARM     2
#define KEY_VALUE_RESET     1
#define KEY_VALUE_ENTER     8
#define KEY_CLEAR           0

#define TITLE_CALING  0

#define KEYDEACT 0
#define KEYACTIVE 1
#define KEYHOLD 2

#define CH_SEL_RESET 0
#define CH_SEL_PROG 2
#define CH_SEL_ACTUAL 1

void AlarmRoll(UINT Forward,UINT Alarmcmd);
void MenuRoll(UCHAR Forward,UCHAR Para,UCHAR Level);
void CaliRoll(UCHAR Forward,UCHAR Level);
void LCDUpdate(void);
void SPCMenuOperation(void);
ULONG keyboard_get_value(void);
void set_alarm_info(UCHAR AlarmIndex);
void set_menu_info(UCHAR direction,UCHAR command);
UINT GetAlarmType(UCHAR index, char cmd);
void rightkey_func(void);

extern unsigned int KeyDetectCount;
extern unsigned int KeyValidCount;
extern char KeyHoldCount;
extern char KeyDetectStat;
extern ULONG KeyValueshape;
extern char KeyValidEn;
extern char KeyHoldEn;
extern char KeyBusy;
extern unsigned int ResetPasswordCount;
extern char ResetPasswordStep;
extern char ChannelSelStat;