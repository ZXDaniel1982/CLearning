//OSCCON  系统时钟
#define PRIMARY_OSC      0x00
#define SECONDARY_OSC    0x01
#define INTERNAL_OSC     0x03
#define IOFS             0x04                  //内部时钟稳定标志位
#define OSTS             0x08                  //主时钟稳定标志位
#define IRCF_8M          (0x07<<4)
#define IRCF_4M          (0x06<<4)
#define IRCF_2M          (0x05<<4)
#define IRCF_1M          (0x04<<4)
#define IRCF_500K        (0x03<<4)
#define IRCF_250K        (0x02<<4)
#define IRCF_125K        (0x01<<4)
#define IRCF_31K         (0x00<<4)
#define IDLEN            0x80

//SSPxSTAT
#define BF   0x01
#define UA   0x02
#define RW   0x04
#define S    0x08
#define P    0x10
#define DA   0x20
#define CKE  0x40
#define SMP  0x80

//SSPxCON1
#define SPI_MASTER_4FOSC                0x00
#define SPI_MASTER_16FOSC               0x01
#define SPI_MASTER_64FOSC               0x02
#define SPI_MASTER_2TMR2                0x03
#define SPI_SLAVE_SSxEN                 0x04
#define SPI_SLAVE                       0x05
#define I2C_SLAVE_7ADD                  0x06
#define I2C_SLAVE_10ADD                 0x07
#define I2C_MASTER                      0x08
#define I2C_MASTER_FIRMWARE             0x0B
#define I2C_SLAVE_7ADD_INTERUPT         0x0E
#define I2C_SLAVE_10ADD_INTERUPT        0x0F
#define CKP                             0x10
#define SSPEN                           0x20
#define SSPOV                           0x40
#define WCOL                            0x80

//SSPxCON2
#define GCEM      0x01
#define ACKSTAT   0x02
#define ACKDT     0x04
#define ACKEN     0x08
#define RCEN      0x10
#define PEN       0x20
#define RSEM      0x40
#define SEN       0x80

//BAUDCONx
#define ABDEN        0x01
#define WUE          0x02
#define BRG16        0x08
#define SCKP         0x10
#define RCIDL        0x40
#define ABDOVF       0x80

//TXSTAx
#define TX9D       0x01
#define TRMT       0x02
#define BRGH       0x04
#define SENDB      0x08
#define SYNC       0x10
#define TXEN       0x20
#define TX9        0x40
#define CSRC       0x80

//RCSTAx
#define RX9D       0x01
#define OERR       0x02
#define FERR       0x04
#define ADDEN      0x08
#define CREN       0x10
#define SREN       0x20
#define RX9        0x40
#define SPEN       0x80

//PIR1
#define TMR1IF       0x01
#define TMR2IF       0x02
#define CCP1IF       0x04
#define SSP1IF       0x08
#define TX1IF        0x10
#define RC1IF        0x20
#define ADIF         0x40
#define PSPIF        0x80

//PIR3
#define CCP3IF       0x01
#define CCP4IF       0x02
#define CCP5IF       0x04
#define TMR4IF       0x08
#define TX2IF        0x10
#define RC2IF        0x20
#define BCL2IF       0x40
#define SSP2IF       0x80
