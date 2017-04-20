#define SGL 0x80
#define SIGN 0x40
#define MSBF 0x20

//ADC
#define GFIC_CHANNEL1     BIT1
#define RTD_CHANNEL1      BIT3
#define GFIC_CHANNEL2     BIT0
#define RTD_CHANNEL2      BIT2

#define RTDA_AD_COMMND SGL+SIGN+MSBF
#define RTDB_AD_COMMND SGL+MSBF
#define GFI_AD_COMMND SGL+SIGN+MSBF
#define CURRENT_AD_COMMND SGL+MSBF  //  目前不清楚  sheet:2/7 中ch0:ch1的功能

static code char ADC_Channel[4] =
{
  GFIC_CHANNEL1,
  GFIC_CHANNEL2,
  RTD_CHANNEL1,
  RTD_CHANNEL2
};

UINT MCP3202_GET_AD_ONCE(UCHAR Spi_Channel,UCHAR Spi_AD_CMD);
UINT MCP3202_GET_AD(UCHAR Spi_Channel,UCHAR Spi_AD_CMD,  char NumOfSample);