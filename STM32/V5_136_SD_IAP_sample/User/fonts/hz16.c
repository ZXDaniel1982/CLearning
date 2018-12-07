/*
*********************************************************************************************************
*
*	模块名称 : 汉字点阵字库。有效显示区 高16x宽15, 最右一列留白
*	文件名称 : hz16.c
*	版    本 : V1.0
*	说    明 : 只包含本程序用到汉字字库
*	修改记录 :
*		版本号  日期       作者    说明
*		v1.0    2011-09-08 armfly  ST固件库V3.5.0版本。
*
*	Copyright (C), 2010-2011, 安富莱电子 www.armfly.com
*
*********************************************************************************************************
*/

#include "fonts.h"

/*
	FLASH中内嵌小字库，只包括本程序用到的汉字点阵
	每行点阵数据，头2字节是汉子的内码，后面32字节是16点阵汉子的字模数据。
*/

#ifdef USE_SMALL_FONT
/* 
	、±√°′℃←！（）安按拔败板版保北背倍被本闭标表采操册测长厂成程持出触传磁打大当到道灯地电调定东动度
	耳发返范放风服富杆感格功关光国过海号和华环换回机集计加检键件节经境拒据绝卡开可克空块莱力连量亮了列
	临录率螺络码麦漫没秒摸模默南能拟盘频屏起启器气前切请全认入商上摄设声失时始式示试收输数松搜速台太态
	停通头陀网围为纬未位温无务西息下闲显像小校效信序选寻压掩扬样摇仪已以益音引营硬游有右预运在噪择增照
	正值指止置质中重注装状准子最左作坐
*/
unsigned char const g_Hz16[] = {
0xB0,0xB2, 0x02,0x00,0x01,0x00,0x7F,0xFE,0x40,0x02,0x82,0x04,0x02,0x00,0x02,0x04,0xFF,0xFE,// 安 //
           0x04,0x20,0x08,0x20,0x18,0x20,0x06,0x40,0x01,0x80,0x02,0x40,0x0C,0x30,0x30,0x10,

0xB0,0xB4, 0x10,0x40,0x10,0x20,0x10,0x00,0x13,0xFE,0xFA,0x02,0x14,0x44,0x10,0x40,0x3F,0xFE,// 按 //
           0xD0,0x88,0x10,0x88,0x11,0x08,0x10,0x90,0x10,0x60,0x10,0x50,0x50,0x8C,0x23,0x04,

0xB2,0xD9, 0x10,0x10,0x11,0xF8,0x11,0x10,0x11,0xF0,0xFC,0x04,0x17,0xBE,0x14,0xA4,0x1F,0xBC,// 操 //
           0x30,0x40,0xD0,0x44,0x1F,0xFE,0x10,0xE0,0x11,0x50,0x12,0x4E,0x54,0x44,0x20,0x40,

0xB3,0xCC, 0x08,0x04,0x1D,0xFE,0xF1,0x04,0x11,0x04,0x11,0x04,0xFF,0x04,0x11,0xFC,0x38,0x00,// 程 //
           0x37,0xFE,0x54,0x20,0x50,0x28,0x91,0xFC,0x10,0x20,0x10,0x24,0x17,0xFE,0x10,0x00,

0xB4,0xCE, 0x00,0x80,0x40,0x80,0x30,0x80,0x11,0x08,0x01,0xFC,0x02,0x08,0x08,0x50,0x10,0x40,// 次 //
           0x20,0x40,0xE0,0x40,0x20,0xA0,0x20,0xA0,0x21,0x10,0x22,0x08,0x24,0x0E,0x28,0x04,

0xB5,0xA5, 0x10,0x10,0x08,0x20,0x04,0x48,0x3F,0xFC,0x21,0x08,0x21,0x08,0x3F,0xF8,0x21,0x08,// 单 //
           0x21,0x08,0x3F,0xF8,0x21,0x00,0x01,0x04,0xFF,0xFE,0x01,0x00,0x01,0x00,0x01,0x00,

0xB5,0xCD, 0x10,0x08,0x10,0x3C,0x17,0xC0,0x24,0x40,0x24,0x40,0x64,0x40,0xA4,0x44,0x27,0xFE,// 低 //
           0x24,0x20,0x24,0x20,0x24,0x20,0x24,0x90,0x25,0x12,0x26,0x4A,0x24,0x2A,0x20,0x04,

0xB6,0xAF, 0x00,0x40,0x08,0x40,0x7C,0x40,0x00,0x44,0x05,0xFE,0xFE,0x44,0x10,0x44,0x10,0x44,// 动 //
           0x20,0x44,0x24,0x44,0x42,0x84,0xFE,0x84,0x41,0x04,0x01,0x04,0x02,0x28,0x04,0x10,

0xB7,0xA2, 0x01,0x00,0x11,0x20,0x11,0x10,0x21,0x04,0x7F,0xFE,0x02,0x00,0x02,0x00,0x07,0xF0,// 发 //
           0x06,0x10,0x0A,0x20,0x09,0x40,0x10,0x80,0x21,0x40,0x42,0x30,0x8C,0x0E,0x30,0x04,

0xB8,0xBB, 0x02,0x00,0x01,0x00,0x7F,0xFE,0x40,0x22,0x9F,0xF4,0x00,0x00,0x1F,0xF0,0x10,0x10,// 富 //
           0x1F,0xF0,0x00,0x08,0x3F,0xFC,0x21,0x08,0x3F,0xF8,0x21,0x08,0x3F,0xF8,0x20,0x08,

0xB8,0xCB, 0x10,0x00,0x10,0x08,0x11,0xFC,0x10,0x20,0xFC,0x20,0x10,0x20,0x30,0x24,0x3B,0xFE,// 杆 //
           0x54,0x20,0x50,0x20,0x90,0x20,0x10,0x20,0x10,0x20,0x10,0x20,0x10,0x20,0x10,0x20,

0xB8,0xDF, 0x02,0x00,0x01,0x04,0xFF,0xFE,0x00,0x00,0x1F,0xF0,0x10,0x10,0x10,0x10,0x1F,0xF0,// 高 //
           0x00,0x04,0x7F,0xFE,0x40,0x04,0x4F,0xE4,0x48,0x24,0x48,0x24,0x4F,0xE4,0x40,0x0C,

0xB8,0xF4, 0x00,0x08,0x7F,0xFC,0x48,0x00,0x53,0xF8,0x52,0x08,0x62,0x08,0x53,0xF8,0x48,0x04,// 隔 //
           0x4F,0xFE,0x4D,0x14,0x6C,0xA4,0x57,0xFC,0x44,0x44,0x44,0x44,0x44,0x54,0x44,0x08,

0xB8,0xFC, 0x00,0x04,0xFF,0xFE,0x01,0x08,0x3F,0xFC,0x21,0x08,0x21,0x08,0x3F,0xF8,0x21,0x08,// 更 //
           0x21,0x08,0x3F,0xF8,0x29,0x08,0x05,0x00,0x02,0x00,0x05,0x80,0x18,0x70,0xE0,0x0E,

0xB9,0xA4, 0x00,0x00,0x00,0x08,0x7F,0xFC,0x01,0x00,0x01,0x00,0x01,0x00,0x01,0x00,0x01,0x00,// 工 //
           0x01,0x00,0x01,0x00,0x01,0x00,0x01,0x00,0x01,0x04,0xFF,0xFE,0x00,0x00,0x00,0x00,

0xBB,0xBB, 0x10,0x80,0x10,0x80,0x11,0xF0,0x12,0x20,0xFC,0x48,0x13,0xFC,0x12,0x48,0x1E,0x48,// 换 //
           0x32,0x48,0xD2,0x48,0x1F,0xFE,0x10,0x40,0x10,0xA0,0x11,0x10,0x52,0x0E,0x2C,0x04,

0xBB,0xF2, 0x00,0x50,0x00,0x48,0x00,0x40,0xFF,0xFE,0x00,0x40,0x02,0x40,0x3F,0x48,0x22,0x48,// 或 //
           0x22,0x48,0x22,0x50,0x3E,0x50,0x20,0x20,0x07,0x22,0x78,0x52,0x00,0x8A,0x03,0x04,

0xBC,0xE4, 0x20,0x04,0x1B,0xFE,0x08,0x04,0x40,0x24,0x4F,0xF4,0x48,0x24,0x48,0x24,0x48,0x24,// 间 //
           0x4F,0xE4,0x48,0x24,0x48,0x24,0x48,0x24,0x4F,0xE4,0x48,0x24,0x40,0x14,0x40,0x08,

0xBC,0xFC, 0x20,0x10,0x27,0x10,0x39,0x7C,0x41,0x14,0x82,0xFE,0x7A,0x14,0x24,0x7C,0x27,0x10,// 键 //
           0xF9,0x7C,0x21,0x10,0x25,0x14,0x22,0xFE,0x2A,0x10,0x35,0x10,0x28,0x96,0x00,0x7C,

0xBD,0xB5, 0x00,0x80,0x7C,0x80,0x45,0xF8,0x4A,0x10,0x48,0xA0,0x50,0x40,0x49,0xB0,0x4A,0x4E,// 降 //
           0x44,0x44,0x45,0xF0,0x45,0x40,0x69,0x48,0x53,0xFC,0x40,0x40,0x40,0x40,0x40,0x40,

0xBD,0xD3, 0x10,0x80,0x10,0x48,0x17,0xFC,0x10,0x00,0xFD,0x10,0x10,0xA0,0x17,0xFC,0x18,0x80,// 接 //
           0x30,0x84,0xDF,0xFE,0x10,0x90,0x11,0x10,0x10,0xA0,0x10,0x60,0x50,0x98,0x23,0x08,

0xBD,0xDA, 0x04,0x40,0x04,0x44,0xFF,0xFE,0x04,0x40,0x04,0x48,0x7F,0xFC,0x02,0x08,0x02,0x08,// 节 //
           0x02,0x08,0x02,0x08,0x02,0x48,0x02,0x28,0x02,0x10,0x02,0x00,0x02,0x00,0x02,0x00,

0xBE,0xDD, 0x10,0x04,0x13,0xFE,0x12,0x04,0x12,0x04,0xFF,0xFC,0x12,0x20,0x16,0x24,0x1B,0xFE,// 据 //
           0x32,0x20,0xD2,0x24,0x13,0xFE,0x15,0x04,0x15,0x04,0x15,0x04,0x59,0xFC,0x21,0x04,

0xC0,0xB3, 0x08,0x20,0x08,0x24,0xFF,0xFE,0x09,0x20,0x01,0x08,0x7F,0xFC,0x01,0x00,0x09,0x20,// 莱 //
           0x05,0x44,0xFF,0xFE,0x03,0x80,0x05,0x40,0x09,0x30,0x31,0x0E,0xC1,0x04,0x01,0x00,

0xC0,0xFD, 0x10,0x04,0x10,0x44,0x1F,0xE4,0x22,0x04,0x22,0x14,0x67,0xD4,0xA4,0x54,0x28,0x54,// 例 //
           0x34,0x94,0x22,0x94,0x21,0x14,0x22,0x04,0x24,0x04,0x28,0x04,0x20,0x14,0x20,0x08,

0xC1,0xAC, 0x00,0x80,0x40,0x88,0x2F,0xFC,0x21,0x00,0x01,0x40,0x02,0x50,0xE7,0xF8,0x20,0x40,// 连 //
           0x20,0x40,0x20,0x48,0x2F,0xFC,0x20,0x40,0x20,0x40,0x50,0x46,0x8F,0xFC,0x00,0x00,

0xC3,0xBF, 0x10,0x00,0x10,0x08,0x1F,0xFC,0x20,0x10,0x5F,0xF8,0x12,0x10,0x11,0x10,0x10,0x14,// 每 //
           0xFF,0xFE,0x12,0x10,0x21,0x10,0x20,0x10,0x3F,0xF8,0x00,0x20,0x00,0xA0,0x00,0x40,

0xC3,0xF7, 0x00,0x04,0x04,0xFE,0x7E,0x84,0x44,0x84,0x44,0x84,0x44,0xFC,0x7C,0x84,0x44,0x84,// 明 //
           0x44,0x84,0x44,0xFC,0x7C,0x84,0x44,0x84,0x01,0x04,0x01,0x04,0x02,0x14,0x04,0x08,

0xC4,0xA3, 0x11,0x10,0x11,0x14,0x1F,0xFE,0x11,0x10,0xFD,0x18,0x13,0xFC,0x32,0x08,0x3B,0xF8,// 模 //
           0x56,0x08,0x53,0xF8,0x90,0x40,0x1F,0xFE,0x10,0x40,0x10,0xB0,0x11,0x0E,0x16,0x04,

0xC6,0xDA, 0x22,0x04,0x22,0x7E,0x22,0x44,0x7F,0x44,0x22,0x44,0x3E,0x7C,0x22,0x44,0x3E,0x44,// 期 //
           0x22,0x44,0x22,0x7C,0xFF,0xC4,0x00,0x44,0x24,0x44,0x22,0x84,0x41,0x14,0x82,0x08,

0xC6,0xF4, 0x01,0x00,0x00,0x84,0x1F,0xFE,0x10,0x04,0x10,0x04,0x10,0x04,0x1F,0xFC,0x10,0x00,// 启 //
           0x10,0x04,0x1F,0xFE,0x18,0x04,0x28,0x04,0x28,0x04,0x48,0x04,0x8F,0xFC,0x08,0x04,

0xC7,0xD0, 0x10,0x00,0x10,0x04,0x11,0xFE,0x10,0x44,0x14,0x44,0x1E,0x44,0xF0,0x44,0x10,0x44,// 切 //
           0x10,0x44,0x12,0x44,0x14,0x44,0x18,0x84,0x10,0x84,0x01,0x04,0x02,0x28,0x0C,0x10,

0xCA,0xB1, 0x00,0x08,0x04,0x08,0x7E,0x08,0x44,0x08,0x47,0xFE,0x44,0x08,0x44,0x08,0x7C,0x88,// 时 //
           0x44,0x48,0x44,0x48,0x44,0x08,0x44,0x08,0x7C,0x08,0x44,0x48,0x00,0x28,0x00,0x10,

0xCA,0xBD, 0x00,0x80,0x00,0xA0,0x00,0x90,0x00,0x84,0xFF,0xFE,0x00,0x80,0x00,0x80,0x3E,0x80,// 式 //
           0x08,0x80,0x08,0x40,0x08,0x40,0x09,0x20,0x0E,0x22,0x70,0x12,0x20,0x0A,0x00,0x04,

0xCA,0xD5, 0x08,0x80,0x08,0x80,0x08,0x80,0x48,0x84,0x48,0xFE,0x49,0x08,0x49,0x88,0x4A,0x88,// 收 //
           0x48,0x88,0x58,0x50,0x68,0x50,0x48,0x20,0x08,0x50,0x08,0x88,0x09,0x0E,0x0E,0x04,

0xCA,0xFD, 0x08,0x40,0x49,0x40,0x2A,0x40,0x08,0x84,0xFF,0xFE,0x19,0x08,0x2C,0x88,0x4A,0x88,// 数 //
           0x10,0x88,0xFE,0x90,0x22,0x50,0x22,0x20,0x14,0x50,0x18,0x88,0x25,0x0E,0x42,0x04,

0xCB,0xB5, 0x00,0x00,0x22,0x08,0x11,0x10,0x10,0xA0,0x03,0xF8,0x02,0x08,0xF2,0x08,0x12,0x08,// 说 //
           0x13,0xF8,0x12,0xA8,0x10,0xA0,0x10,0xA0,0x15,0x22,0x19,0x22,0x12,0x1E,0x04,0x00,

0xCB,0xCD, 0x02,0x08,0x41,0x10,0x30,0xA0,0x17,0xFC,0x00,0x40,0x00,0x40,0xF0,0x44,0x1F,0xFE,// 送 //
           0x10,0x40,0x10,0x40,0x10,0x80,0x10,0xA0,0x11,0x18,0x2A,0x08,0x44,0x06,0x03,0xFC,

0xCC,0xAC, 0x01,0x00,0x01,0x04,0xFF,0xFE,0x01,0x00,0x02,0x80,0x04,0x40,0x0A,0x30,0x31,0x0E,// 态 //
           0xC0,0x04,0x02,0x00,0x29,0x10,0x29,0x08,0x28,0x24,0x48,0x24,0x07,0xE0,0x00,0x00,

0xCC,0xE1, 0x10,0x08,0x11,0xFC,0x11,0x08,0x11,0x08,0xFD,0xF8,0x11,0x08,0x15,0x08,0x19,0xF8,// 提 //
           0x30,0x00,0xD7,0xFE,0x10,0x20,0x11,0x28,0x11,0x3C,0x11,0x20,0x52,0xA6,0x24,0x7C,

0xCD,0xA3, 0x10,0x80,0x10,0x48,0x17,0xFC,0x20,0x00,0x23,0xF8,0x62,0x08,0xA3,0xF8,0x20,0x00,// 停 //
           0x2F,0xFE,0x28,0x02,0x33,0xF4,0x20,0x40,0x20,0x40,0x20,0x40,0x21,0x40,0x20,0x80,

0xCE,0xB4, 0x01,0x00,0x01,0x00,0x01,0x08,0x7F,0xFC,0x01,0x00,0x01,0x00,0x01,0x04,0xFF,0xFE,// 未 //
           0x03,0x80,0x05,0x40,0x09,0x20,0x11,0x10,0x21,0x0E,0x41,0x04,0x01,0x00,0x01,0x00,

0xD0,0xC2, 0x10,0x08,0x0A,0x1C,0x7F,0x60,0x00,0x40,0x22,0x40,0x14,0x44,0xFF,0xFE,0x0A,0x48,// 新 //
           0x7F,0x48,0x08,0x48,0x0A,0x48,0x29,0x88,0x48,0x88,0x89,0x08,0x28,0x08,0x10,0x08,

0xD2,0xA1, 0x10,0x08,0x10,0x3C,0x17,0xC0,0x12,0x48,0xFD,0x48,0x11,0x50,0x16,0x00,0x1B,0xFC,// 摇 //
           0x34,0x40,0xD0,0x44,0x1F,0xFE,0x10,0x40,0x12,0x48,0x12,0x48,0x53,0xF8,0x22,0x08,

0xD2,0xD1, 0x00,0x10,0x7F,0xF8,0x00,0x10,0x00,0x10,0x20,0x10,0x20,0x10,0x3F,0xF0,0x20,0x10,// 已 //
           0x20,0x00,0x20,0x00,0x20,0x00,0x20,0x04,0x20,0x04,0x20,0x04,0x1F,0xFC,0x00,0x00,

0xD3,0xC3, 0x00,0x08,0x3F,0xFC,0x21,0x08,0x21,0x08,0x21,0x08,0x3F,0xF8,0x21,0x08,0x21,0x08,// 用 //
           0x21,0x08,0x3F,0xF8,0x21,0x08,0x21,0x08,0x21,0x08,0x41,0x08,0x41,0x28,0x80,0x10,

0xD3,0xDA, 0x00,0x10,0x3F,0xF8,0x01,0x00,0x01,0x00,0x01,0x00,0x01,0x04,0xFF,0xFE,0x01,0x00,// 于 //
           0x01,0x00,0x01,0x00,0x01,0x00,0x01,0x00,0x01,0x00,0x01,0x00,0x05,0x00,0x02,0x00,

0xD5,0xDF, 0x02,0x00,0x02,0x10,0x3F,0xE0,0x02,0x40,0x02,0x84,0xFF,0xFE,0x02,0x00,0x04,0x10,// 者 //
           0x0F,0xF8,0x18,0x10,0x28,0x10,0x4F,0xF0,0x88,0x10,0x08,0x10,0x0F,0xF0,0x08,0x10,

0xD6,0xB9, 0x01,0x00,0x01,0x00,0x01,0x00,0x11,0x00,0x11,0x00,0x11,0x10,0x11,0xF8,0x11,0x00,// 止 //
           0x11,0x00,0x11,0x00,0x11,0x00,0x11,0x00,0x11,0x00,0x11,0x04,0xFF,0xFE,0x00,0x00,

0xD6,0xDC, 0x00,0x08,0x3F,0xFC,0x21,0x08,0x21,0x48,0x2F,0xE8,0x21,0x08,0x21,0x28,0x3F,0xF8,// 周 //
           0x20,0x48,0x27,0xE8,0x24,0x48,0x24,0x48,0x24,0x48,0x47,0xC8,0x84,0x28,0x00,0x10,

0xD7,0xB4, 0x08,0x40,0x08,0x50,0x08,0x48,0x48,0x40,0x28,0x44,0x2F,0xFE,0x08,0x40,0x08,0x40,// 状 //
           0x18,0xA0,0x28,0xA0,0x49,0x10,0xC9,0x10,0x09,0x08,0x0A,0x0E,0x0C,0x04,0x08,0x00,

0xD7,0xD4, 0x01,0x00,0x02,0x00,0x04,0x10,0x1F,0xF8,0x10,0x10,0x10,0x10,0x1F,0xF0,0x10,0x10,// 自 //
           0x10,0x10,0x10,0x10,0x1F,0xF0,0x10,0x10,0x10,0x10,0x10,0x10,0x1F,0xF0,0x10,0x10,

0xD7,0xD6, 0x02,0x00,0x01,0x00,0x3F,0xFC,0x20,0x04,0x40,0x08,0x1F,0xE0,0x00,0x40,0x00,0x80,// 字 //
           0x01,0x04,0xFF,0xFE,0x01,0x00,0x01,0x00,0x01,0x00,0x01,0x00,0x05,0x00,0x02,0x00,

0xD7,0xF7, 0x09,0x00,0x09,0x00,0x09,0x04,0x11,0xFE,0x12,0x80,0x32,0x80,0x54,0x90,0x98,0xF8,// 作 //
           0x10,0x80,0x10,0x80,0x10,0x88,0x10,0xFC,0x10,0x80,0x10,0x80,0x10,0x80,0x10,0x80,

/* 最后一行必须用0xFF,0xFF结束，这是字库数组结束标志 */
0xFF,0xFF

};

#else
	unsigned char const g_Hz16[] = {0xFF, 0xFF};
#endif

