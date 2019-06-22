/**
  ******************************************************************************
  * @file   fatfs.c
  * @brief  Code for fatfs applications
  ******************************************************************************
  * @attention
  *
  * <h2><center>&copy; Copyright (c) 2019 STMicroelectronics.
  * All rights reserved.</center></h2>
  *
  * This software component is licensed by ST under Ultimate Liberty license
  * SLA0044, the "License"; You may not use this file except in compliance with
  * the License. You may obtain a copy of the License at:
  *                             www.st.com/SLA0044
  *
  ******************************************************************************
  */
#include <string.h>

#include "fatfs.h"
#include "lcd.h"

uint8_t retSD;    /* Return value for SD */
char SDPath[4];   /* SD logical drive path */
FATFS SDFatFS;    /* File system object for SD logical drive */
FIL SDFile;       /* File object for SD */

/* USER CODE BEGIN Variables */

/* USER CODE END Variables */    

void MX_FATFS_Init(void) 
{
  /*## FatFS: Link the SD driver ###########################*/
  retSD = FATFS_LinkDriver(&SD_Driver, SDPath);

  /* USER CODE BEGIN Init */
  /* additional user code for init */ 
	if(f_mount(&SDFatFS, (TCHAR const*)SDPath, 0) != FR_OK) {
	  tftprintf("SD card mount success");
		Error_Handler();
	} else {
	  tftprintf("SD card mount fail");
	}
  /* USER CODE END Init */
}

/**
  * @brief  Gets Time from RTC 
  * @param  None
  * @retval Time in DWORD
  */
DWORD get_fattime(void)
{
  /* USER CODE BEGIN get_fattime */
  return 0;
  /* USER CODE END get_fattime */  
}

/* USER CODE BEGIN Application */
void SD_ShowCardFiles(void)
{
	DIR dirs;
	FILINFO finfo;
	char path[50]={""};
	char rtext[512] = {0};
	UINT bytesread = 0;
	UINT res = 0;	
	
  if (f_opendir(&dirs, path) == FR_OK) {
	  while (f_readdir(&dirs, &finfo) == FR_OK) {
		  if (finfo.fattrib & AM_ARC) {
			  if(!finfo.fname[0])	 break;
				
				tftprintf("File name is:     %s", finfo.fname);	         //输出8.3格式文件名
				res = f_open(&SDFile, finfo.fname, FA_OPEN_EXISTING | FA_READ);
				
				for (;;) {														  //循环读出被打开文件的扇区
					memset(rtext, 0, sizeof(rtext));
					res = f_read(&SDFile, rtext, sizeof(rtext), &bytesread);			  //将文件内容读出到数据缓冲区
					tftprintf("      %s",rtext, bytesread, res);							  //将缓冲区的内容输出到串口1
					if (res || bytesread == 0) break;   // error or eof				  //判断是否到文件结束
				}
				f_close(&SDFile);
			}
		}
	}
}
/* USER CODE END Application */

/************************ (C) COPYRIGHT STMicroelectronics *****END OF FILE****/
