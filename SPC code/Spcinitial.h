//LED
#define POWER BIT0
#define HEATER_ON BIT1
#define SYSTEM_FAIL BIT2
#define ALARM BIT3
#define COMMUNICATION_FAIL BIT4

//LCD
#define DB4 BIT4
#define DB5 BIT5
#define DB6 BIT6
#define DB7 BIT7

#define RS BIT5
#define LCD_RW_BIT BIT6
#define E BIT7

//ALARM OUTPUT
#define ALARM_DC BIT4
#define ALARM_AC BIT5

//LOAD
#define LOAD BIT3

//SPI
#define SDO2   BIT4
#define SDI2   BIT5
#define SCK2   BIT6

//I2C
#define SDA1   BIT4
#define SDO1   BIT5
#define RE LATF4_bit
#define DE LATF3_bit

//ADC
#define GFIC_CHANNEL     BIT1
#define RTD_CHANNEL      BIT3

//KEYBOARD
#define KEYBOARD_CHANNEL BIT0

void SPC_Initial(void);
void QT60Reset(void);
void System_clock_initial(void);
void Timer_initial(void);
void Port_initial(void);
void Spi_initial(void);
void I2C_initial(void);
void Uart_initial(void);
void ADC_initial(void);
void LCD_initial(void);
void selftest(void);
void SelfCheck(void);
void QT60Initial(void);

void GlobalInterrupt_diable(void);
void GlobalInterrupt_enable(void);

extern int KeyResetCount;
extern char KeyResetEN;