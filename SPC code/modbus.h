#define MODBUS_IDLE  0
#define MODBUS_BUSY  1

typedef struct tagMODBUSREGLIST
{
  int ModbusAddress;
  int *DataAddress;
}MODBUSREGLIST;

extern unsigned char modbus_rcdata[20];
extern unsigned int modbus_rcn;
extern char ModbusRecived,ModbusValid;
extern unsigned int ModbusCounter;

static code char ModbusExarea[] =
{
  0,
  30,   //1200
  15,   //2400
  8,    //4800
  4,    //9600
  2,    //19200
} ;

void Split(unsigned int source, unsigned char *target);
UINT Combine(unsigned char * source);
void Copydata(unsigned char *source, unsigned char *target, char len);
unsigned int CRCChecksum(unsigned char *chkbuf, unsigned char len);
void modbusprocess(void);
void modbus_respond(void);
void SetModbusTxData(int TransData);