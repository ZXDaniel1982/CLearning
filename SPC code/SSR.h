#define RELAY_IS_OFF 0
#define RELAY_IS_ON 1

#define ALARMSSR_OFF 0
#define ALARMSSR_ON 1


void RSSoperation(char ChannelNum);
void AlarmSSRoperation(void);
/*char relay_on(char ChannelNum);
char relay_off(char ChannelNum);*/
void Alarm_SSR_on(char ChannelNum);
void Alarm_SSR_off(char ChannelNum);
char softstart(char ChannelNum);
char shift(unsigned int dduty, char ChannelNum);
char pwm(char ChannelNum);
unsigned int get_duty_table(char index);
void countformeasurement(char ChannelNum);

extern char AlarmForce[2];
extern char SSRStatInMeas[2];
extern char SSRForceOp[2];