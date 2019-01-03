/* Includes ------------------------------------------------------------------*/
#include "lcd.h"
#include <stdarg.h>

static void lcd_rst(void);
static void LCD_Clear(void);
static void LCD_WR_REG(unsigned int index);
static void LCD_WR_Data(unsigned int val);
static void TFT_ShowChar(uint8_t x,uint16_t y,uint8_t num);
static void LCD_WR_CMD(unsigned int index,unsigned int val);
static void TFT_ShowString(uint8_t x,uint16_t y,const uint8_t *p);

static unsigned long color1=0;
static uint16_t POINT_COLOR;
static uint8_t blank[] = "                                                    ";
static uint16_t strIndex = 0;

const unsigned char asc2_1206[95][12]={
{0x00,0x00,0x00,0x00,0x00,0x00,0x00,0x00,0x00,0x00,0x00,0x00},/*" ",0*/
{0x00,0x00,0x04,0x04,0x04,0x04,0x04,0x04,0x00,0x04,0x00,0x00},/*"!",1*/
{0x00,0x14,0x0A,0x0A,0x00,0x00,0x00,0x00,0x00,0x00,0x00,0x00},/*""",2*/
{0x00,0x00,0x14,0x14,0x3F,0x14,0x0A,0x3F,0x0A,0x0A,0x00,0x00},/*"#",3*/
{0x00,0x04,0x1E,0x15,0x05,0x06,0x0C,0x14,0x15,0x0F,0x04,0x00},/*"$",4*/
{0x00,0x00,0x12,0x15,0x0D,0x0A,0x14,0x2C,0x2A,0x12,0x00,0x00},/*"%",5*/
{0x00,0x00,0x04,0x0A,0x0A,0x1E,0x15,0x15,0x09,0x36,0x00,0x00},/*"&",6*/
{0x00,0x02,0x02,0x01,0x00,0x00,0x00,0x00,0x00,0x00,0x00,0x00},/*"'",7*/
{0x00,0x20,0x10,0x08,0x08,0x08,0x08,0x08,0x08,0x10,0x20,0x00},/*"(",8*/
{0x00,0x02,0x04,0x08,0x08,0x08,0x08,0x08,0x08,0x04,0x02,0x00},/*")",9*/
{0x00,0x00,0x00,0x04,0x15,0x0E,0x0E,0x15,0x04,0x00,0x00,0x00},/*"*",10*/
{0x00,0x00,0x04,0x04,0x04,0x1F,0x04,0x04,0x04,0x00,0x00,0x00},/*"+",11*/
{0x00,0x00,0x00,0x00,0x00,0x00,0x00,0x00,0x00,0x02,0x02,0x01},/*",",12*/
{0x00,0x00,0x00,0x00,0x00,0x1F,0x00,0x00,0x00,0x00,0x00,0x00},/*"-",13*/
{0x00,0x00,0x00,0x00,0x00,0x00,0x00,0x00,0x00,0x02,0x00,0x00},/*".",14*/
{0x00,0x10,0x08,0x08,0x08,0x04,0x04,0x02,0x02,0x02,0x01,0x00},/*"/",15*/
{0x00,0x00,0x0E,0x11,0x11,0x11,0x11,0x11,0x11,0x0E,0x00,0x00},/*"0",16*/
{0x00,0x00,0x04,0x06,0x04,0x04,0x04,0x04,0x04,0x0E,0x00,0x00},/*"1",17*/
{0x00,0x00,0x0E,0x11,0x11,0x08,0x04,0x02,0x01,0x1F,0x00,0x00},/*"2",18*/
{0x00,0x00,0x0E,0x11,0x10,0x0C,0x10,0x10,0x11,0x0E,0x00,0x00},/*"3",19*/
{0x00,0x00,0x08,0x0C,0x0A,0x0A,0x09,0x1E,0x08,0x18,0x00,0x00},/*"4",20*/
{0x00,0x00,0x1F,0x01,0x01,0x0F,0x10,0x10,0x11,0x0E,0x00,0x00},/*"5",21*/
{0x00,0x00,0x0E,0x09,0x01,0x0F,0x11,0x11,0x11,0x0E,0x00,0x00},/*"6",22*/
{0x00,0x00,0x1F,0x09,0x08,0x04,0x04,0x04,0x04,0x04,0x00,0x00},/*"7",23*/
{0x00,0x00,0x0E,0x11,0x11,0x0E,0x11,0x11,0x11,0x0E,0x00,0x00},/*"8",24*/
{0x00,0x00,0x0E,0x11,0x11,0x11,0x1E,0x10,0x12,0x0E,0x00,0x00},/*"9",25*/
{0x00,0x00,0x00,0x00,0x04,0x00,0x00,0x00,0x00,0x04,0x00,0x00},/*":",26*/
{0x00,0x00,0x00,0x00,0x00,0x04,0x00,0x00,0x00,0x04,0x04,0x00},/*";",27*/
{0x00,0x20,0x10,0x08,0x04,0x02,0x04,0x08,0x10,0x20,0x00,0x00},/*"<",28*/
{0x00,0x00,0x00,0x00,0x1F,0x00,0x00,0x1F,0x00,0x00,0x00,0x00},/*"=",29*/
{0x00,0x02,0x04,0x08,0x10,0x20,0x10,0x08,0x04,0x02,0x00,0x00},/*">",30*/
{0x00,0x00,0x0E,0x11,0x11,0x08,0x04,0x04,0x00,0x04,0x00,0x00},/*"?",31*/
{0x00,0x00,0x0E,0x11,0x19,0x15,0x15,0x1D,0x01,0x1E,0x00,0x00},/*"@",32*/
{0x00,0x00,0x04,0x04,0x0C,0x0A,0x0A,0x1E,0x12,0x33,0x00,0x00},/*"A",33*/
{0x00,0x00,0x0F,0x12,0x12,0x0E,0x12,0x12,0x12,0x0F,0x00,0x00},/*"B",34*/
{0x00,0x00,0x1E,0x11,0x01,0x01,0x01,0x01,0x11,0x0E,0x00,0x00},/*"C",35*/
{0x00,0x00,0x0F,0x12,0x12,0x12,0x12,0x12,0x12,0x0F,0x00,0x00},/*"D",36*/
{0x00,0x00,0x1F,0x12,0x0A,0x0E,0x0A,0x02,0x12,0x1F,0x00,0x00},/*"E",37*/
{0x00,0x00,0x1F,0x12,0x0A,0x0E,0x0A,0x02,0x02,0x07,0x00,0x00},/*"F",38*/
{0x00,0x00,0x1C,0x12,0x01,0x01,0x39,0x11,0x12,0x0C,0x00,0x00},/*"G",39*/
{0x00,0x00,0x33,0x12,0x12,0x1E,0x12,0x12,0x12,0x33,0x00,0x00},/*"H",40*/
{0x00,0x00,0x1F,0x04,0x04,0x04,0x04,0x04,0x04,0x1F,0x00,0x00},/*"I",41*/
{0x00,0x00,0x3E,0x08,0x08,0x08,0x08,0x08,0x08,0x09,0x07,0x00},/*"J",42*/
{0x00,0x00,0x37,0x12,0x0A,0x06,0x0A,0x0A,0x12,0x37,0x00,0x00},/*"K",43*/
{0x00,0x00,0x07,0x02,0x02,0x02,0x02,0x02,0x22,0x3F,0x00,0x00},/*"L",44*/
{0x00,0x00,0x1B,0x1B,0x1B,0x1B,0x15,0x15,0x15,0x15,0x00,0x00},/*"M",45*/
{0x00,0x00,0x3B,0x12,0x16,0x16,0x1A,0x1A,0x12,0x17,0x00,0x00},/*"N",46*/
{0x00,0x00,0x0E,0x11,0x11,0x11,0x11,0x11,0x11,0x0E,0x00,0x00},/*"O",47*/
{0x00,0x00,0x0F,0x12,0x12,0x0E,0x02,0x02,0x02,0x07,0x00,0x00},/*"P",48*/
{0x00,0x00,0x0E,0x11,0x11,0x11,0x11,0x17,0x19,0x0E,0x18,0x00},/*"Q",49*/
{0x00,0x00,0x0F,0x12,0x12,0x0E,0x0A,0x12,0x12,0x37,0x00,0x00},/*"R",50*/
{0x00,0x00,0x1E,0x11,0x01,0x06,0x08,0x10,0x11,0x0F,0x00,0x00},/*"S",51*/
{0x00,0x00,0x1F,0x15,0x04,0x04,0x04,0x04,0x04,0x0E,0x00,0x00},/*"T",52*/
{0x00,0x00,0x33,0x12,0x12,0x12,0x12,0x12,0x12,0x0C,0x00,0x00},/*"U",53*/
{0x00,0x00,0x33,0x12,0x12,0x0A,0x0A,0x0C,0x04,0x04,0x00,0x00},/*"V",54*/
{0x00,0x00,0x15,0x15,0x15,0x0E,0x0A,0x0A,0x0A,0x0A,0x00,0x00},/*"W",55*/
{0x00,0x00,0x1B,0x0A,0x0A,0x04,0x04,0x0A,0x0A,0x1B,0x00,0x00},/*"X",56*/
{0x00,0x00,0x1B,0x0A,0x0A,0x04,0x04,0x04,0x04,0x0E,0x00,0x00},/*"Y",57*/
{0x00,0x00,0x1F,0x09,0x08,0x04,0x04,0x02,0x12,0x1F,0x00,0x00},/*"Z",58*/
{0x00,0x1C,0x04,0x04,0x04,0x04,0x04,0x04,0x04,0x04,0x1C,0x00},/*"[",59*/
{0x00,0x02,0x02,0x02,0x04,0x04,0x08,0x08,0x08,0x10,0x00,0x00},/*"\",60*/
{0x00,0x0E,0x08,0x08,0x08,0x08,0x08,0x08,0x08,0x08,0x0E,0x00},/*"]",61*/
{0x00,0x04,0x0A,0x00,0x00,0x00,0x00,0x00,0x00,0x00,0x00,0x00},/*"^",62*/
{0x00,0x00,0x00,0x00,0x00,0x00,0x00,0x00,0x00,0x00,0x00,0x3F},/*"_",63*/
{0x00,0x04,0x00,0x00,0x00,0x00,0x00,0x00,0x00,0x00,0x00,0x00},/*"`",64*/
{0x00,0x00,0x00,0x00,0x00,0x0C,0x12,0x1C,0x12,0x3C,0x00,0x00},/*"a",65*/
{0x00,0x00,0x03,0x02,0x02,0x0E,0x12,0x12,0x12,0x0E,0x00,0x00},/*"b",66*/
{0x00,0x00,0x00,0x00,0x00,0x1C,0x12,0x02,0x02,0x1C,0x00,0x00},/*"c",67*/
{0x00,0x00,0x18,0x10,0x10,0x1C,0x12,0x12,0x12,0x3C,0x00,0x00},/*"d",68*/
{0x00,0x00,0x00,0x00,0x00,0x0C,0x12,0x1E,0x02,0x1C,0x00,0x00},/*"e",69*/
{0x00,0x00,0x38,0x04,0x04,0x1E,0x04,0x04,0x04,0x1E,0x00,0x00},/*"f",70*/
{0x00,0x00,0x00,0x00,0x00,0x3C,0x12,0x0C,0x02,0x1E,0x22,0x1C},/*"g",71*/
{0x00,0x00,0x03,0x02,0x02,0x0E,0x12,0x12,0x12,0x37,0x00,0x00},/*"h",72*/
{0x00,0x00,0x04,0x00,0x00,0x06,0x04,0x04,0x04,0x0E,0x00,0x00},/*"i",73*/
{0x00,0x00,0x08,0x00,0x00,0x0C,0x08,0x08,0x08,0x08,0x08,0x07},/*"j",74*/
{0x00,0x00,0x03,0x02,0x02,0x3A,0x0A,0x0E,0x12,0x37,0x00,0x00},/*"k",75*/
{0x00,0x00,0x07,0x04,0x04,0x04,0x04,0x04,0x04,0x1F,0x00,0x00},/*"l",76*/
{0x00,0x00,0x00,0x00,0x00,0x0F,0x15,0x15,0x15,0x15,0x00,0x00},/*"m",77*/
{0x00,0x00,0x00,0x00,0x00,0x0F,0x12,0x12,0x12,0x37,0x00,0x00},/*"n",78*/
{0x00,0x00,0x00,0x00,0x00,0x0C,0x12,0x12,0x12,0x0C,0x00,0x00},/*"o",79*/
{0x00,0x00,0x00,0x00,0x00,0x0F,0x12,0x12,0x12,0x0E,0x02,0x07},/*"p",80*/
{0x00,0x00,0x00,0x00,0x00,0x1C,0x12,0x12,0x12,0x1C,0x10,0x38},/*"q",81*/
{0x00,0x00,0x00,0x00,0x00,0x1B,0x06,0x02,0x02,0x07,0x00,0x00},/*"r",82*/
{0x00,0x00,0x00,0x00,0x00,0x1E,0x02,0x0C,0x10,0x1E,0x00,0x00},/*"s",83*/
{0x00,0x00,0x00,0x04,0x04,0x0E,0x04,0x04,0x04,0x18,0x00,0x00},/*"t",84*/
{0x00,0x00,0x00,0x00,0x00,0x1B,0x12,0x12,0x12,0x3C,0x00,0x00},/*"u",85*/
{0x00,0x00,0x00,0x00,0x00,0x37,0x12,0x0A,0x0C,0x04,0x00,0x00},/*"v",86*/
{0x00,0x00,0x00,0x00,0x00,0x15,0x15,0x0E,0x0A,0x0A,0x00,0x00},/*"w",87*/
{0x00,0x00,0x00,0x00,0x00,0x1B,0x0A,0x04,0x0A,0x1B,0x00,0x00},/*"x",88*/
{0x00,0x00,0x00,0x00,0x00,0x37,0x12,0x0A,0x0C,0x04,0x04,0x03},/*"y",89*/
{0x00,0x00,0x00,0x00,0x00,0x1E,0x08,0x04,0x04,0x1E,0x00,0x00},/*"z",90*/
{0x00,0x18,0x08,0x08,0x08,0x04,0x08,0x08,0x08,0x08,0x18,0x00},/*"{",91*/
{0x08,0x08,0x08,0x08,0x08,0x08,0x08,0x08,0x08,0x08,0x08,0x08},/*"|",92*/
{0x00,0x06,0x04,0x04,0x04,0x08,0x04,0x04,0x04,0x04,0x06,0x00},/*"}",93*/
{0x02,0x25,0x18,0x00,0x00,0x00,0x00,0x00,0x00,0x00,0x00,0x00} /*"~",94*/
};

static void lcd_rst(void){
    HAL_GPIO_WritePin(LCD_Rst_GPIO_Port, LCD_Rst_Pin, GPIO_PIN_RESET);
    HAL_Delay(10);
    HAL_GPIO_WritePin(LCD_Rst_GPIO_Port, LCD_Rst_Pin, GPIO_PIN_SET);
    HAL_Delay(10);

    HAL_GPIO_WritePin(LCD_Light_GPIO_Port, LCD_Light_Pin, GPIO_PIN_SET);
}

static void LCD_Clear(void)
{
    uint16_t i;
    for (i=0;i<=LCD_CLR_ROW;i++)
        TFT_ShowString(0,i*12,(uint8_t *)blank);
}

void LCD_Init(void)
{
    lcd_rst();                  //硬件复位

        //Driving ability Setting
    LCD_WR_CMD(0xEA,0x00); //PTBA[15:8]
    LCD_WR_CMD(0xEB,0x20); //PTBA[7:0]
    LCD_WR_CMD(0xEC,0x3C); //STBA[15:8]
    LCD_WR_CMD(0xED,0xC4); //STBA[7:0]
    LCD_WR_CMD(0xE8,0x48); //OPON[7:0]
    LCD_WR_CMD(0xE9,0x38); //OPON1[7:0]
    LCD_WR_CMD(0xF1,0x01); //OTPS1B
    LCD_WR_CMD(0xF2,0x08); //GEN
    //Gamma 2.2 Setting
    LCD_WR_CMD(0x40,0x01); //
    LCD_WR_CMD(0x41,0x07); //
    LCD_WR_CMD(0x42,0x09); //
    LCD_WR_CMD(0x43,0x19); //
    LCD_WR_CMD(0x44,0x17); //
    LCD_WR_CMD(0x45,0x20); //
    LCD_WR_CMD(0x46,0x18); //
    LCD_WR_CMD(0x47,0x61); //
    LCD_WR_CMD(0x48,0x00); //
    LCD_WR_CMD(0x49,0x10); //
    LCD_WR_CMD(0x4A,0x17); //
    LCD_WR_CMD(0x4B,0x19); //
    LCD_WR_CMD(0x4C,0x14); //
    LCD_WR_CMD(0x50,0x1F); //
    LCD_WR_CMD(0x51,0x28); //
    LCD_WR_CMD(0x52,0x26); //
    LCD_WR_CMD(0x53,0x36); //
    LCD_WR_CMD(0x54,0x38); //
    LCD_WR_CMD(0x55,0x3E); //
    LCD_WR_CMD(0x56,0x1E); //
    LCD_WR_CMD(0x57,0x67); //
    LCD_WR_CMD(0x58,0x0B); //
    LCD_WR_CMD(0x59,0x06); //
    LCD_WR_CMD(0x5A,0x08); //
    LCD_WR_CMD(0x5B,0x0F); //
    LCD_WR_CMD(0x5C,0x1F); //
    LCD_WR_CMD(0x5D,0xCC); //

    //Power Voltage Setting
    LCD_WR_CMD(0x1B,0x1B); //VRH=4.65V
    LCD_WR_CMD(0x1A,0x01); //BT (VGH~15V,VGL~-10V,DDVDH~5V)
    LCD_WR_CMD(0x24,0x70); //VMH(VCOM High voltage ~4.2V)
    LCD_WR_CMD(0x25,0x58); //VML(VCOM Low voltage -1.2V)

    //****VCOM offset**///
    LCD_WR_CMD(0x23,0x6E); //for Flicker adjust //can reload from OTP
    //Power on Setting
    LCD_WR_CMD(0x18,0x36); //I/P_RADJ,N/P_RADJ, Normal mode 70Hz
    LCD_WR_CMD(0x19,0x01); //OSC_EN='1', start Osc
    LCD_WR_CMD(0x01,0x00); //DP_STB='0', out deep sleep
    LCD_WR_CMD(0x1F,0xD0);// GAS=1, VOMG=10, PON=1, DK=0, XDK=0, DDVDH_TRI=0, STB=0
    LCD_WR_CMD(0x17,0x05); //default 0x06 262k color // 0x05 65k color
    //SET PANEL
    LCD_WR_CMD(0x36,0x09); //SS_P, GS_P,REV_P,BGR_P
    LCD_WR_CMD(0x28,0x3F); //GON=1, DTE=1, D=1100
    LCD_WR_CMD(0x16,0x50); //左上到右下   竖屏

    /*
     * Memory access control register (PAGE0 -16h)
     * MY: 0从上到下, 1从下到上
     * MX: 0从左到右, 1从右到左
     * MV选择横竖屏0竖屏1横屏
     * ML用于Partial Display Area Setting
     * BGR = 0, RGB color filter panel
     */
    LCD_WR_CMD(0x16,0XE0); //
    LCD_WR_CMD(0x02,0x00);
    LCD_WR_CMD(0x03,0x00); //Column Start
    LCD_WR_CMD(0x04,0x00);
    LCD_WR_CMD(0x05,0xEF); //Column End

    LCD_WR_CMD(0x06,0x00);
    LCD_WR_CMD(0x07,0x00); //Row Start
    LCD_WR_CMD(0x08,0x01);
    LCD_WR_CMD(0x09,0x3F); //Row End

    for(color1=0;color1<76800;color1++)     //用黑色清屏
    {
      LCD_WR_Data(0xffff);
    }
    color1=0;

    LCD_Clear();
    POINT_COLOR = RED;
}

static void TFT_ShowChar(uint8_t x,uint16_t y,uint8_t num)
{
    uint8_t temp;
    uint8_t pos,t;
    if(x>MAX_CHAR_POSX||y>MAX_CHAR_POSY)return;
    //设定一个字符所占的窗口大小


    LCD_WR_CMD(0x02,0);
    LCD_WR_CMD(0x03,x); //Column Start
    LCD_WR_CMD(0x04,0);
    LCD_WR_CMD(0x05,x+5); //Column End

    LCD_WR_CMD(0x06,y>>8);
    LCD_WR_CMD(0x07,(uint8_t)y); //Row Start
    LCD_WR_CMD(0x08,(y+11)>>8);
    LCD_WR_CMD(0x09,(uint8_t)(y+11)); //Row End

    LCD_WR_CMD(0x02, 0);            //水平显示区起始地址 0-239
    LCD_WR_CMD(0x03, x);           //水平显示区结束地址 0-239
    LCD_WR_CMD(0x06, y>>8);     //垂直显示区起始地址 0-319
    LCD_WR_CMD(0x07, (uint8_t)y);         //垂直显示区结束地址 0-319



    LCD_WR_REG(34);
    num=num-' ';                        //得到偏移后的值
    for(pos=0;pos<12;pos++) {
        temp=asc2_1206[num][pos];       //获得字模数组的值
        for(t=0;t<6;t++)
        {
            if(temp&0x01)LCD_WR_Data(POINT_COLOR);    //位为1 用指定颜色写入到像素
            else LCD_WR_Data(0xffff);                 //位为0 用白色写入到像素
            temp>>=1;
        }
    }
}

static void TFT_ShowString(uint8_t x,uint16_t y,const uint8_t *p)
{
    while(*p!='\0')
    {
        TFT_ShowChar(x,y,*p);
        x+=6;
        p++;
    }
}

void tftprintf(const char* fmt, ...)
{
    uint8_t cmd[40] = {0};

    va_list ap;
    va_start(ap, fmt);
    vsnprintf((char *)cmd, sizeof(cmd), fmt, ap);

    if (strIndex > LCD_STR_NUM_MAX) {
        strIndex = 0;
        LCD_Clear();
    }
    TFT_ShowString(2,(strIndex*14+2),cmd);
    strIndex++;
    va_end(ap);
}

//写寄存器数据函数
//输入：dbw 数据位数，1为16位，0为8位。
static void LCD_WR_CMD(unsigned int index,unsigned int val)
{
    *(__IO uint16_t *) (Bank1_LCD_C)= index;
    *(__IO uint16_t *) (Bank1_LCD_D)= val;
}
//写16位像素数据函数
static void LCD_WR_Data(unsigned int val)
{
    *(__IO uint16_t *) (Bank1_LCD_D)= val;
}
//写寄存器地址函数
static void LCD_WR_REG(unsigned int index)
{
    *(__IO uint16_t *) (Bank1_LCD_C)= index;
}


/************************ (C) COPYRIGHT STMicroelectronics *****END OF FILE****/
