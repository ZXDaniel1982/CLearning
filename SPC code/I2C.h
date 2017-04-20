sbit Soft_I2C_Scl at RC3_bit;
sbit Soft_I2C_Sda at RC4_bit;
sbit Soft_I2C_Scl_Direction at TRISC3_bit;
sbit Soft_I2C_Sda_Direction at TRISC4_bit;

void I2C_get(UCHAR QTAddress,UCHAR QTRegister,UCHAR *Keystate,UCHAR Length);
void I2C_write(UCHAR QTAddress,UCHAR QTRegister,UCHAR *Keystate,UCHAR Length);

void I2C_send(UCHAR DataToSlave);
UCHAR I2C_receive(void);
void I2C_start(void);
void I2C_stop(void);
void WaitI2CIdel(void);
void WaitSlaveACK(void);
void SendACKToSlave(void);
void SendNACKToSlave(void);

extern char I2CError;