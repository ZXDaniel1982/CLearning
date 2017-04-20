#define ALARM_TEST_IDLE   0
#define ALARM_TEST_REQ    1
#define ALARM_TEST_START  2
#define ALARM_TEST_END    3

void systemtest(char ChannelNum);

extern char AlarmTestCount[2], HeaterTestCount[2];
extern char AlarmTestCmd[2];
extern char HeaterTestCmd[2];
extern int GFITestCount[2];
extern char GFITestCmd[2], GFITestStat;
extern char GFITestPass[2];
extern char AutoGFITestPass[2];
extern char AutoGFITestEN[2];

extern char TestEN[2];