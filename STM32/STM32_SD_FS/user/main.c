/****************************************************************************
* Copyright (C), 2011 奋斗嵌入式工作室 www.ourstm.net
*
* 本例程在 奋斗版STM32开发板V2,V2.1，V3及MINI上调试通过           
* QQ: 9191274, 旺旺：sun68, Email: sun68@163.com 
* 淘宝店铺：ourstm.taobao.com  
*
* 文件名: main.c
* 内容简述:	
*       
*	TF卡上的的Tini-FatFs0.08b实现，测试了将TF卡根目录下的txt类型文件内容通过串口输出
	支持长文件名， 支持中文文件名
*	辅助软件：PC机上需要运行串口调试助手软件。
    
	基于MDK版本：        3.8
	基于官方外设库版本： 3.5
	基于Tiny-FatFs版本： 0.08B
*
* 文件历史:
* 版本号  日期       作者    说明
* v0.3    2011-8-17 sun68  创建该文件
*
*/
/* Includes ------------------------------------------------------------------*/

#define GLOBALS

#include "sdio_sdcard.h"
#include "integer.h"
#include "ff.h"
#include "ffconf.h"
#include "diskio.h"
#include "demo.h"

#define _DF1S	0x81

SD_CardInfo SDCardInfo;
uint32_t Buffer_Block_Tx[512], Buffer_Block_Rx[512]; 
SD_Error Status = SD_OK;


void RCC_Configuration(void);
void NVIC_Configuration(void);
void USART_OUT(USART_TypeDef* USARTx, uint8_t *Data,...);
void Usart1_Init(void);		

FATFS fs;                      // 逻辑驱动器的标志
FIL fsrc, fdst;                // 文件标志 
unsigned char buffer[512];     // 文件内容缓冲区
FRESULT res;                   // FatFs 功能函数返回结果变量
unsigned int br, bw;           // 文件读/写计数器
    


/****************************************************************************
* 名    称：void RCC_Configuration(void)
* 功    能：系统时钟配置为72MHZ， 外设时钟配置
* 入口参数：无
* 出口参数：无
* 说    明：
* 调用方法：无 
****************************************************************************/ 
void RCC_Configuration(void){

  SystemInit(); 
  RCC_APB2PeriphClockCmd(RCC_APB2Periph_AFIO, ENABLE);
  RCC_APB2PeriphClockCmd(RCC_APB2Periph_GPIOA | RCC_APB2Periph_GPIOB | RCC_APB2Periph_GPIOC 
  						| RCC_APB2Periph_GPIOD| RCC_APB2Periph_GPIOE , ENABLE);
}

/*-----------例程所用到的文件系统函数原型------------------------

---------------在文件系统中注册/注销 工作区（0-9)-----------------------------------------------------------------
FRESULT f_mount (
  BYTE  Drive,                 	//Logical drive number 
  FATFS*  FileSystemObject  	// Pointer to the work area 
);
参数：
Drive：用逻辑驱动器号(0-9) 去注册/注销 工作区 
FileSystemObject：文件系统工作区的标识。 
--------------------------------------------------------------------------------

---------------打开目录------------------------------------------------------------------
FRESULT f_opendir (
  DIR* DirObject,       	//空目录结构指针
  const TCHAR* DirName  	//目录名指针
)
返回值：
FR_OK (0)  打开目录成功
--------------------------------------------------------------------------------
---------------读取目录下的文件名 --------------------------------------------------------
FRESULT f_readdir (
  DIR* DirObject,             // 目录结构指针
  FILINFO* FileInfo           // 文件信息指针 
);
返回值：
FR_OK (0)  读取文件名成功
-------------------------------------------------------------------------------------------
----------------为了存取数据，打开文件目标----------------------------------------------------------
FRESULT f_open (
  FIL* FileObject,       	 // 文件结构型指针 
  const TCHAR* FileName, 	 // 文件名指针
  BYTE ModeFlags             // 模式标志 
);
ModeFlags：
FA_OPEN_EXISTING： 指定为文件不存在的话，返回错误
FA_READ：          指定为文件读
FA_CREATE_ALWAYS： 文件不存在的话，直接建立
FA_WRITE: 		   指定为文件写

--------------------------------------------------------------------------
-----------------读文件数据--------------------------------------------------------------
FRESULT f_read (
  FIL* FileObject,    // 文件结构型指针 
  void* Buffer,       // 读数据缓冲区指针
  UINT ByteToRead,    // 要读取的字节数 
  UINT* ByteRead      // 返回的所读取的可变字节数的指针 
);
----------------------------------------------------------------------------------

-----------------写文件数据-------------------------------------------------------
FRESULT f_write (
  FIL* FileObject,     // 文件结构型指针 
  const void* Buffer,  // 写数据缓冲区指针
  UINT ByteToWrite,    // 要写入的字节数 
  UINT* ByteWritten    // 返回的所写入的可变字节数的指针 
);
----------------------------------------------------------------------------------
-----------------关闭打开的文件---------------------------------------------------
FRESULT f_close (
  FIL* FileObject     // 文件结构型指针 
);

-------------------------------------------------------------------------------
*/ 

/****************************************************************************
* 名    称：void OutPutFile(void)
* 功    能：TXT文件输出函数
* 入口参数：无
* 出口参数：无
* 说    明：
* 调用方法：无 
****************************************************************************/ 
void OutPutFile(void)
{ unsigned int a;
  FILINFO finfo;
  DIR dirs;

  char path[50]={""}; 	  						 //目录名为空，表示是根目录
  char *result1, *result2; 
  char EXT1[4]=".txt"; 	 
  char EXT2[4]=".TXT"; 	
  /*开启长文件名功能时， 要预先初始化文件名缓冲区的长度 */
  #if _USE_LFN
    static char lfn[_MAX_LFN * (_DF1S ? 2 : 1) + 1];
    finfo.lfname = lfn;
    finfo.lfsize = sizeof(lfn);
  #endif
  USART_OUT(USART1,"\n奋斗STM32开发板文件系统(Tini-FatFS0.08b)启动成功! \n");
  
  disk_initialize(0);						     //fatfs可以管理多个介质的分区， 所以把物理存储介质SST25VF016B标示为0区，相当于磁盘编号
    
  f_mount(0, &fs);							     //将文件系统设置到0区 

 if (f_opendir(&dirs, path) == FR_OK)            //读取该磁盘的根目录        
  {
    while (f_readdir(&dirs, &finfo) == FR_OK)  	 //循环依次读取文件名
    {	 
      if (finfo.fattrib & AM_ARC) 			     //判断文件属性是否为存档型	 TXT文件一般都为存档型
      {
        if(!finfo.fname[0])	 break;    		     //如果是文件名为空表示到目录的末尾。退出	 
		if(finfo.lfname[0]){	 											 //长文件名	
			USART_OUT(USART1,"\r\n文件名是:\n   %s\n",finfo.lfname);	     //输出长文件名
			result1=strstr(finfo.lfname,EXT1);								 //判断是否是txt（小写）后缀的文件名
			result2=strstr(finfo.lfname,EXT2);	     						 //比较后缀是否TXT（大写）后缀的文件名
			
		}
		else{						  			    	                     //8.3格式文件名
			USART_OUT(USART1,"\r\n文件名是:\n   %s\n",finfo.fname);	         //输出8.3格式文件名
			result1=strstr(finfo.fname,EXT1);								 //判断是否是txt（小写）后缀的文件名
			result2=strstr(finfo.fname,EXT2);	     						 //比较后缀是否TXT（大写）后缀的文件名		
		}			
		if(result1!=NULL||result2!=NULL){	 								  //是的话就输出文件的内容 
        	if(finfo.lfname[0]){	 										  //长文件名		
				res = f_open(&fsrc, finfo.lfname, FA_OPEN_EXISTING | FA_READ);//以读的方式打开文件
			}
			else{										  		 			  //8.3格式文件名
				res = f_open(&fsrc, finfo.fname, FA_OPEN_EXISTING | FA_READ); //以读的方式打开文件
			}
			//res1 = f_open(&fdst, "a2.txt", FA_CREATE_ALWAYS | FA_WRITE);	  //以写的方式打开文件，如果不存在，就直接建立，如果存在就覆盖掉
																			  //注释掉是为了如果有学习文件拷贝功能，也同样具有了
																			  //文件建立及增加内容。
       	 	br=1;
			a=0;
			for (;;) {														  //循环读出被打开文件的扇区
				for(a=0; a<512; a++) buffer[a]=0; 							  //因为可以一次读出512字节，先清空数据缓冲区 
    	    	res = f_read(&fsrc, buffer, sizeof(buffer), &br);			  //将文件内容读出到数据缓冲区
				USART_OUT(USART1,"%s\n",buffer);							  //将缓冲区的内容输出到串口1
				//printf("\r\n@@@@@res=%2d  br=%6d  bw=%6d",res1,br,bw);
    	    	if (res || br == 0) break;   // error or eof				  //判断是否到文件结束
       	    	//res1 = f_write(&fdst, buffer, br, &bw);					  //将缓冲区的内容写入到目标文件 也就是a2.txt
		    	//USART_OUT(USART1,"\r\n$$$$$res=%2d  br=%6d  bw=%6d",res1,br,bw);
            	//if (res1 || bw < br) break;   // error or disk full		  //如果写入时异常，或者磁盘满，退出
        	}
			f_close(&fsrc);													   //关闭源文件
		  }												   
    	  //f_close(&fdst);	    											   //关闭目标文件
      	}
    } 
    
  } 
}
/****************************************************************************
* 名    称：void SD_TEST(void)
* 功    能：SD卡测试函数
* 入口参数：无
* 出口参数：无
* 说    明：
* 调用方法：无 
****************************************************************************/ 
void SD_TEST(void){
	Status = SD_Init();
    Status = SD_GetCardInfo(&SDCardInfo);
    Status = SD_SelectDeselect((uint32_t) (SDCardInfo.RCA << 16));
    Status = SD_EnableWideBusOperation(SDIO_BusWide_4b);
    Status = SD_SetDeviceMode(SD_DMA_MODE);  
 	if (Status == SD_OK)
  	{
        // 从地址0开始读取512字节  
    	Status = SD_ReadBlock(Buffer_Block_Rx, 0x00,  512); 
  	}
  	if (Status == SD_OK)
    {	 
       // 返回成功的话，串口输出SD卡测试成功信息 
	    USART_OUT(USART1,"\r\nSD 奋斗STM32开发板 SDIO-4bit模式 测试TF卡成功！ \n ");
    } 
}
/****************************************************************************
* 名    称：int main(void)
* 功    能：主函数
* 入口参数：无
* 出口参数：无
* 说    明：
* 调用方法：无 
****************************************************************************/ 
int main(void)
{
  RCC_Configuration();	   //设置内部时钟及外设时钟使能
  NVIC_Configuration();	   //中断源配置
  Usart1_Init();		   //串口1初始化
  SD_TEST();               //SD卡测试函数
  OutPutFile();			   //TXT文件通过串口输出函数        
  USART_OUT(USART1,"\r\n 所有TXT类型文件输出完成!\n");
  while (1);
}


/****************************************************************************
* 名    称：void Usart1_Init(void)
* 功    能：串口1初始化函数
* 入口参数：无
* 出口参数：无
* 说    明：
* 调用方法：无 
****************************************************************************/
void Usart1_Init(void)
{
  GPIO_InitTypeDef GPIO_InitStructure;
  USART_InitTypeDef USART_InitStructure;
 
  RCC_APB2PeriphClockCmd( RCC_APB2Periph_USART1 , ENABLE);	 //使能串口1时钟

  GPIO_InitStructure.GPIO_Pin = GPIO_Pin_9;	         		 //USART1 TX
  GPIO_InitStructure.GPIO_Speed = GPIO_Speed_50MHz;
  GPIO_InitStructure.GPIO_Mode = GPIO_Mode_AF_PP;    		 //复用推挽输出
  GPIO_Init(GPIOA, &GPIO_InitStructure);		    		 //A端口 

  GPIO_InitStructure.GPIO_Pin = GPIO_Pin_10;	         	 //USART1 RX
  GPIO_InitStructure.GPIO_Mode = GPIO_Mode_IN_FLOATING;   	 //复用开漏输入
  GPIO_Init(GPIOA, &GPIO_InitStructure);		         	 //A端口 

  USART_InitStructure.USART_BaudRate = 115200;						//速率115200bps
  USART_InitStructure.USART_WordLength = USART_WordLength_8b;		//数据位8位
  USART_InitStructure.USART_StopBits = USART_StopBits_1;			//停止位1位
  USART_InitStructure.USART_Parity = USART_Parity_No;				//无校验位
  USART_InitStructure.USART_HardwareFlowControl = USART_HardwareFlowControl_None;   //无硬件流控
  USART_InitStructure.USART_Mode = USART_Mode_Rx | USART_Mode_Tx;					//收发模式

  /* Configure USART1 */
  USART_Init(USART1, &USART_InitStructure);							//配置串口参数函数   
   /* Enable the USART1 */
  USART_Cmd(USART1, ENABLE);	
  
}


/****************************************************************************
* 名    称：void NVIC_Configuration(void)
* 功    能：中断源配置函数
* 入口参数：无
* 出口参数：无
* 说    明：
* 调用方法：无 
****************************************************************************/
void NVIC_Configuration(void)
{
  NVIC_InitTypeDef NVIC_InitStructure;

  /* 优先级组1 */
  NVIC_PriorityGroupConfig(NVIC_PriorityGroup_1);	  

  NVIC_InitStructure.NVIC_IRQChannel = SDIO_IRQn;			     //SDIO中断
  NVIC_InitStructure.NVIC_IRQChannelPreemptionPriority = 0;		 //抢先优先级0  范围：0或1
  NVIC_InitStructure.NVIC_IRQChannelSubPriority = 0;			 //子优先级0	范围：0-7
  NVIC_InitStructure.NVIC_IRQChannelCmd = ENABLE;
  NVIC_Init(&NVIC_InitStructure);
}

/******************************************************
		整形数据转字符串函数
        char *itoa(int value, char *string, int radix)
		radix=10 标示是10进制	非十进制，转换结果为0;  

	    例：d=-379;
		执行	itoa(d, buf, 10); 后
		
		buf="-379"							   			  
**********************************************************/
char *itoa(int value, char *string, int radix)
{
    int     i, d;
    int     flag = 0;
    char    *ptr = string;

    /* This implementation only works for decimal numbers. */
    if (radix != 10)
    {
        *ptr = 0;
        return string;
    }

    if (!value)
    {
        *ptr++ = 0x30;
        *ptr = 0;
        return string;
    }

    /* if this is a negative value insert the minus sign. */
    if (value < 0)
    {
        *ptr++ = '-';

        /* Make the value positive. */
        value *= -1;
    }

    for (i = 10000; i > 0; i /= 10)
    {
        d = value / i;

        if (d || flag)
        {
            *ptr++ = (char)(d + 0x30);
            value -= (d * i);
            flag = 1;
        }
    }

    /* Null terminate the string. */
    *ptr = 0;

    return string;

} /* NCL_Itoa */
/****************************************************************************
* 名    称：void USART_OUT(USART_TypeDef* USARTx, uint8_t *Data,...)
* 功    能：格式化串口输出函数
* 入口参数：USARTx:  指定串口
			Data：   发送数组
			...:     不定参数
* 出口参数：无
* 说    明：格式化串口输出函数
        	"\r"	回车符	   USART_OUT(USART1, "abcdefg\r")   
			"\n"	换行符	   USART_OUT(USART1, "abcdefg\r\n")
			"%s"	字符串	   USART_OUT(USART1, "字符串是：%s","abcdefg")
			"%d"	十进制	   USART_OUT(USART1, "a=%d",10)
* 调用方法：无 
****************************************************************************/
void USART_OUT(USART_TypeDef* USARTx, uint8_t *Data,...){ 

	const char *s;
    int d;
   
    char buf[16];
    va_list ap;
    va_start(ap, Data);

	while(*Data!=0){				                          //判断是否到达字符串结束符
		if(*Data==0x5c){									  //'\'
			switch (*++Data){
				case 'r':							          //回车符
					USART_SendData(USARTx, 0x0d);	   

					Data++;
					break;
				case 'n':							          //换行符
					USART_SendData(USARTx, 0x0a);	
					Data++;
					break;
				
				default:
					Data++;
				    break;
			}
			
			 
		}
		else if(*Data=='%'){									  //
			switch (*++Data){				
				case 's':										  //字符串
                	s = va_arg(ap, const char *);
                	for ( ; *s; s++) {
                    	USART_SendData(USARTx,*s);
						while(USART_GetFlagStatus(USARTx, USART_FLAG_TC)==RESET);
                	}
					Data++;
                	break;
            	case 'd':										  //十进制
                	d = va_arg(ap, int);
                	itoa(d, buf, 10);
                	for (s = buf; *s; s++) {
                    	USART_SendData(USARTx,*s);
						while(USART_GetFlagStatus(USARTx, USART_FLAG_TC)==RESET);
                	}
					Data++;
                	break;
				default:
					Data++;
				    break;
			}		 
		}
		else USART_SendData(USARTx, *Data++);
		while(USART_GetFlagStatus(USARTx, USART_FLAG_TC)==RESET);
	}
}

/******************* (C) COPYRIGHT 2011 奋斗STM32 *****END OF FILE****/
