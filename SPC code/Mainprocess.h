#define RTD_OK 0
#define RTDA_ERR 1
#define RTDB_ERR 2
#define RTDS_ERR 4

void VTProcess(void);
void CGProcess(char ChannelNum);
char Tempprocess(char ChannelNum);
void CalSystemTemp(char ChannelNum, char RTDstat);
//void Currentprocess(int *target, int statisticoffset,int setpointoffset, char alarmcmd);
void Currentprocess(char ChannelNum);
void Voltprocess(void);
void enegy_acc(void);
void Timeprocess(void);
void modifytemp(TEMPERATURE *ptr);
char GetHighCurrentEn(char ChannelNum);
void SetHighCurrentEn(char ChannelNum, char HighCurrentCmd);
void ActivateHighCurrentAlarm(char ChannelNum);

extern unsigned int HighCurrentAlarmCount[2];
extern unsigned int energycount;
extern char energyacc;