/****************************************************************************
* Copyright (C), 2011 �ܶ�Ƕ��ʽ������ www.ourstm.net
*
* �������� �ܶ���STM32������V2,V2.1��V3��MINI�ϵ���ͨ��           
* QQ: 9191274, ������sun68, Email: sun68@163.com 
* �Ա����̣�ourstm.taobao.com  
*
* �ļ���: main.c
* ���ݼ���:	
*       
*	TF���ϵĵ�Tini-FatFs0.08bʵ�֣������˽�TF����Ŀ¼�µ�txt�����ļ�����ͨ���������
	֧�ֳ��ļ����� ֧�������ļ���
*	���������PC������Ҫ���д��ڵ������������
    
	����MDK�汾��        3.8
	���ڹٷ������汾�� 3.5
	����Tiny-FatFs�汾�� 0.08B
*
* �ļ���ʷ:
* �汾��  ����       ����    ˵��
* v0.3    2011-8-17 sun68  �������ļ�
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

FATFS fs;                      // �߼��������ı�־
FIL fsrc, fdst;                // �ļ���־ 
unsigned char buffer[512];     // �ļ����ݻ�����
FRESULT res;                   // FatFs ���ܺ������ؽ������
unsigned int br, bw;           // �ļ���/д������
    


/****************************************************************************
* ��    �ƣ�void RCC_Configuration(void)
* ��    �ܣ�ϵͳʱ������Ϊ72MHZ�� ����ʱ������
* ��ڲ�������
* ���ڲ�������
* ˵    ����
* ���÷������� 
****************************************************************************/ 
void RCC_Configuration(void){

  SystemInit(); 
  RCC_APB2PeriphClockCmd(RCC_APB2Periph_AFIO, ENABLE);
  RCC_APB2PeriphClockCmd(RCC_APB2Periph_GPIOA | RCC_APB2Periph_GPIOB | RCC_APB2Periph_GPIOC 
  						| RCC_APB2Periph_GPIOD| RCC_APB2Periph_GPIOE , ENABLE);
}

/*-----------�������õ����ļ�ϵͳ����ԭ��------------------------

---------------���ļ�ϵͳ��ע��/ע�� ��������0-9)-----------------------------------------------------------------
FRESULT f_mount (
  BYTE  Drive,                 	//Logical drive number 
  FATFS*  FileSystemObject  	// Pointer to the work area 
);
������
Drive�����߼���������(0-9) ȥע��/ע�� ������ 
FileSystemObject���ļ�ϵͳ�������ı�ʶ�� 
--------------------------------------------------------------------------------

---------------��Ŀ¼------------------------------------------------------------------
FRESULT f_opendir (
  DIR* DirObject,       	//��Ŀ¼�ṹָ��
  const TCHAR* DirName  	//Ŀ¼��ָ��
)
����ֵ��
FR_OK (0)  ��Ŀ¼�ɹ�
--------------------------------------------------------------------------------
---------------��ȡĿ¼�µ��ļ��� --------------------------------------------------------
FRESULT f_readdir (
  DIR* DirObject,             // Ŀ¼�ṹָ��
  FILINFO* FileInfo           // �ļ���Ϣָ�� 
);
����ֵ��
FR_OK (0)  ��ȡ�ļ����ɹ�
-------------------------------------------------------------------------------------------
----------------Ϊ�˴�ȡ���ݣ����ļ�Ŀ��----------------------------------------------------------
FRESULT f_open (
  FIL* FileObject,       	 // �ļ��ṹ��ָ�� 
  const TCHAR* FileName, 	 // �ļ���ָ��
  BYTE ModeFlags             // ģʽ��־ 
);
ModeFlags��
FA_OPEN_EXISTING�� ָ��Ϊ�ļ������ڵĻ������ش���
FA_READ��          ָ��Ϊ�ļ���
FA_CREATE_ALWAYS�� �ļ������ڵĻ���ֱ�ӽ���
FA_WRITE: 		   ָ��Ϊ�ļ�д

--------------------------------------------------------------------------
-----------------���ļ�����--------------------------------------------------------------
FRESULT f_read (
  FIL* FileObject,    // �ļ��ṹ��ָ�� 
  void* Buffer,       // �����ݻ�����ָ��
  UINT ByteToRead,    // Ҫ��ȡ���ֽ��� 
  UINT* ByteRead      // ���ص�����ȡ�Ŀɱ��ֽ�����ָ�� 
);
----------------------------------------------------------------------------------

-----------------д�ļ�����-------------------------------------------------------
FRESULT f_write (
  FIL* FileObject,     // �ļ��ṹ��ָ�� 
  const void* Buffer,  // д���ݻ�����ָ��
  UINT ByteToWrite,    // Ҫд����ֽ��� 
  UINT* ByteWritten    // ���ص���д��Ŀɱ��ֽ�����ָ�� 
);
----------------------------------------------------------------------------------
-----------------�رմ򿪵��ļ�---------------------------------------------------
FRESULT f_close (
  FIL* FileObject     // �ļ��ṹ��ָ�� 
);

-------------------------------------------------------------------------------
*/ 

/****************************************************************************
* ��    �ƣ�void OutPutFile(void)
* ��    �ܣ�TXT�ļ��������
* ��ڲ�������
* ���ڲ�������
* ˵    ����
* ���÷������� 
****************************************************************************/ 
void OutPutFile(void)
{ unsigned int a;
  FILINFO finfo;
  DIR dirs;

  char path[50]={""}; 	  						 //Ŀ¼��Ϊ�գ���ʾ�Ǹ�Ŀ¼
  char *result1, *result2; 
  char EXT1[4]=".txt"; 	 
  char EXT2[4]=".TXT"; 	
  /*�������ļ�������ʱ�� ҪԤ�ȳ�ʼ���ļ����������ĳ��� */
  #if _USE_LFN
    static char lfn[_MAX_LFN * (_DF1S ? 2 : 1) + 1];
    finfo.lfname = lfn;
    finfo.lfsize = sizeof(lfn);
  #endif
  USART_OUT(USART1,"\n�ܶ�STM32�������ļ�ϵͳ(Tini-FatFS0.08b)�����ɹ�! \n");
  
  disk_initialize(0);						     //fatfs���Թ��������ʵķ����� ���԰�����洢����SST25VF016B��ʾΪ0�����൱�ڴ��̱��
    
  f_mount(0, &fs);							     //���ļ�ϵͳ���õ�0�� 

 if (f_opendir(&dirs, path) == FR_OK)            //��ȡ�ô��̵ĸ�Ŀ¼        
  {
    while (f_readdir(&dirs, &finfo) == FR_OK)  	 //ѭ�����ζ�ȡ�ļ���
    {	 
      if (finfo.fattrib & AM_ARC) 			     //�ж��ļ������Ƿ�Ϊ�浵��	 TXT�ļ�һ�㶼Ϊ�浵��
      {
        if(!finfo.fname[0])	 break;    		     //������ļ���Ϊ�ձ�ʾ��Ŀ¼��ĩβ���˳�	 
		if(finfo.lfname[0]){	 											 //���ļ���	
			USART_OUT(USART1,"\r\n�ļ�����:\n   %s\n",finfo.lfname);	     //������ļ���
			result1=strstr(finfo.lfname,EXT1);								 //�ж��Ƿ���txt��Сд����׺���ļ���
			result2=strstr(finfo.lfname,EXT2);	     						 //�ȽϺ�׺�Ƿ�TXT����д����׺���ļ���
			
		}
		else{						  			    	                     //8.3��ʽ�ļ���
			USART_OUT(USART1,"\r\n�ļ�����:\n   %s\n",finfo.fname);	         //���8.3��ʽ�ļ���
			result1=strstr(finfo.fname,EXT1);								 //�ж��Ƿ���txt��Сд����׺���ļ���
			result2=strstr(finfo.fname,EXT2);	     						 //�ȽϺ�׺�Ƿ�TXT����д����׺���ļ���		
		}			
		if(result1!=NULL||result2!=NULL){	 								  //�ǵĻ�������ļ������� 
        	if(finfo.lfname[0]){	 										  //���ļ���		
				res = f_open(&fsrc, finfo.lfname, FA_OPEN_EXISTING | FA_READ);//�Զ��ķ�ʽ���ļ�
			}
			else{										  		 			  //8.3��ʽ�ļ���
				res = f_open(&fsrc, finfo.fname, FA_OPEN_EXISTING | FA_READ); //�Զ��ķ�ʽ���ļ�
			}
			//res1 = f_open(&fdst, "a2.txt", FA_CREATE_ALWAYS | FA_WRITE);	  //��д�ķ�ʽ���ļ�����������ڣ���ֱ�ӽ�����������ھ͸��ǵ�
																			  //ע�͵���Ϊ�������ѧϰ�ļ��������ܣ�Ҳͬ��������
																			  //�ļ��������������ݡ�
       	 	br=1;
			a=0;
			for (;;) {														  //ѭ�����������ļ�������
				for(a=0; a<512; a++) buffer[a]=0; 							  //��Ϊ����һ�ζ���512�ֽڣ���������ݻ����� 
    	    	res = f_read(&fsrc, buffer, sizeof(buffer), &br);			  //���ļ����ݶ��������ݻ�����
				USART_OUT(USART1,"%s\n",buffer);							  //�����������������������1
				//printf("\r\n@@@@@res=%2d  br=%6d  bw=%6d",res1,br,bw);
    	    	if (res || br == 0) break;   // error or eof				  //�ж��Ƿ��ļ�����
       	    	//res1 = f_write(&fdst, buffer, br, &bw);					  //��������������д�뵽Ŀ���ļ� Ҳ����a2.txt
		    	//USART_OUT(USART1,"\r\n$$$$$res=%2d  br=%6d  bw=%6d",res1,br,bw);
            	//if (res1 || bw < br) break;   // error or disk full		  //���д��ʱ�쳣�����ߴ��������˳�
        	}
			f_close(&fsrc);													   //�ر�Դ�ļ�
		  }												   
    	  //f_close(&fdst);	    											   //�ر�Ŀ���ļ�
      	}
    } 
    
  } 
}
/****************************************************************************
* ��    �ƣ�void SD_TEST(void)
* ��    �ܣ�SD�����Ժ���
* ��ڲ�������
* ���ڲ�������
* ˵    ����
* ���÷������� 
****************************************************************************/ 
void SD_TEST(void){
	Status = SD_Init();
    Status = SD_GetCardInfo(&SDCardInfo);
    Status = SD_SelectDeselect((uint32_t) (SDCardInfo.RCA << 16));
    Status = SD_EnableWideBusOperation(SDIO_BusWide_4b);
    Status = SD_SetDeviceMode(SD_DMA_MODE);  
 	if (Status == SD_OK)
  	{
        // �ӵ�ַ0��ʼ��ȡ512�ֽ�  
    	Status = SD_ReadBlock(Buffer_Block_Rx, 0x00,  512); 
  	}
  	if (Status == SD_OK)
    {	 
       // ���سɹ��Ļ����������SD�����Գɹ���Ϣ 
	    USART_OUT(USART1,"\r\nSD �ܶ�STM32������ SDIO-4bitģʽ ����TF���ɹ��� \n ");
    } 
}
/****************************************************************************
* ��    �ƣ�int main(void)
* ��    �ܣ�������
* ��ڲ�������
* ���ڲ�������
* ˵    ����
* ���÷������� 
****************************************************************************/ 
int main(void)
{
  RCC_Configuration();	   //�����ڲ�ʱ�Ӽ�����ʱ��ʹ��
  NVIC_Configuration();	   //�ж�Դ����
  Usart1_Init();		   //����1��ʼ��
  SD_TEST();               //SD�����Ժ���
  OutPutFile();			   //TXT�ļ�ͨ�������������        
  USART_OUT(USART1,"\r\n ����TXT�����ļ�������!\n");
  while (1);
}


/****************************************************************************
* ��    �ƣ�void Usart1_Init(void)
* ��    �ܣ�����1��ʼ������
* ��ڲ�������
* ���ڲ�������
* ˵    ����
* ���÷������� 
****************************************************************************/
void Usart1_Init(void)
{
  GPIO_InitTypeDef GPIO_InitStructure;
  USART_InitTypeDef USART_InitStructure;
 
  RCC_APB2PeriphClockCmd( RCC_APB2Periph_USART1 , ENABLE);	 //ʹ�ܴ���1ʱ��

  GPIO_InitStructure.GPIO_Pin = GPIO_Pin_9;	         		 //USART1 TX
  GPIO_InitStructure.GPIO_Speed = GPIO_Speed_50MHz;
  GPIO_InitStructure.GPIO_Mode = GPIO_Mode_AF_PP;    		 //�����������
  GPIO_Init(GPIOA, &GPIO_InitStructure);		    		 //A�˿� 

  GPIO_InitStructure.GPIO_Pin = GPIO_Pin_10;	         	 //USART1 RX
  GPIO_InitStructure.GPIO_Mode = GPIO_Mode_IN_FLOATING;   	 //���ÿ�©����
  GPIO_Init(GPIOA, &GPIO_InitStructure);		         	 //A�˿� 

  USART_InitStructure.USART_BaudRate = 115200;						//����115200bps
  USART_InitStructure.USART_WordLength = USART_WordLength_8b;		//����λ8λ
  USART_InitStructure.USART_StopBits = USART_StopBits_1;			//ֹͣλ1λ
  USART_InitStructure.USART_Parity = USART_Parity_No;				//��У��λ
  USART_InitStructure.USART_HardwareFlowControl = USART_HardwareFlowControl_None;   //��Ӳ������
  USART_InitStructure.USART_Mode = USART_Mode_Rx | USART_Mode_Tx;					//�շ�ģʽ

  /* Configure USART1 */
  USART_Init(USART1, &USART_InitStructure);							//���ô��ڲ�������   
   /* Enable the USART1 */
  USART_Cmd(USART1, ENABLE);	
  
}


/****************************************************************************
* ��    �ƣ�void NVIC_Configuration(void)
* ��    �ܣ��ж�Դ���ú���
* ��ڲ�������
* ���ڲ�������
* ˵    ����
* ���÷������� 
****************************************************************************/
void NVIC_Configuration(void)
{
  NVIC_InitTypeDef NVIC_InitStructure;

  /* ���ȼ���1 */
  NVIC_PriorityGroupConfig(NVIC_PriorityGroup_1);	  

  NVIC_InitStructure.NVIC_IRQChannel = SDIO_IRQn;			     //SDIO�ж�
  NVIC_InitStructure.NVIC_IRQChannelPreemptionPriority = 0;		 //�������ȼ�0  ��Χ��0��1
  NVIC_InitStructure.NVIC_IRQChannelSubPriority = 0;			 //�����ȼ�0	��Χ��0-7
  NVIC_InitStructure.NVIC_IRQChannelCmd = ENABLE;
  NVIC_Init(&NVIC_InitStructure);
}

/******************************************************
		��������ת�ַ�������
        char *itoa(int value, char *string, int radix)
		radix=10 ��ʾ��10����	��ʮ���ƣ�ת�����Ϊ0;  

	    ����d=-379;
		ִ��	itoa(d, buf, 10); ��
		
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
* ��    �ƣ�void USART_OUT(USART_TypeDef* USARTx, uint8_t *Data,...)
* ��    �ܣ���ʽ�������������
* ��ڲ�����USARTx:  ָ������
			Data��   ��������
			...:     ��������
* ���ڲ�������
* ˵    ������ʽ�������������
        	"\r"	�س���	   USART_OUT(USART1, "abcdefg\r")   
			"\n"	���з�	   USART_OUT(USART1, "abcdefg\r\n")
			"%s"	�ַ���	   USART_OUT(USART1, "�ַ����ǣ�%s","abcdefg")
			"%d"	ʮ����	   USART_OUT(USART1, "a=%d",10)
* ���÷������� 
****************************************************************************/
void USART_OUT(USART_TypeDef* USARTx, uint8_t *Data,...){ 

	const char *s;
    int d;
   
    char buf[16];
    va_list ap;
    va_start(ap, Data);

	while(*Data!=0){				                          //�ж��Ƿ񵽴��ַ���������
		if(*Data==0x5c){									  //'\'
			switch (*++Data){
				case 'r':							          //�س���
					USART_SendData(USARTx, 0x0d);	   

					Data++;
					break;
				case 'n':							          //���з�
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
				case 's':										  //�ַ���
                	s = va_arg(ap, const char *);
                	for ( ; *s; s++) {
                    	USART_SendData(USARTx,*s);
						while(USART_GetFlagStatus(USARTx, USART_FLAG_TC)==RESET);
                	}
					Data++;
                	break;
            	case 'd':										  //ʮ����
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

/******************* (C) COPYRIGHT 2011 �ܶ�STM32 *****END OF FILE****/
