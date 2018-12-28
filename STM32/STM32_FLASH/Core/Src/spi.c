/**
  ******************************************************************************
  * File Name          : SPI.c
  * Description        : This file provides code for the configuration
  *                      of the SPI instances.
  ******************************************************************************
  * This notice applies to any and all portions of this file
  * that are not between comment pairs USER CODE BEGIN and
  * USER CODE END. Other portions of this file, whether 
  * inserted by the user or by software development tools
  * are owned by their respective copyright owners.
  *
  * Copyright (c) 2018 STMicroelectronics International N.V. 
  * All rights reserved.
  *
  * Redistribution and use in source and binary forms, with or without 
  * modification, are permitted, provided that the following conditions are met:
  *
  * 1. Redistribution of source code must retain the above copyright notice, 
  *    this list of conditions and the following disclaimer.
  * 2. Redistributions in binary form must reproduce the above copyright notice,
  *    this list of conditions and the following disclaimer in the documentation
  *    and/or other materials provided with the distribution.
  * 3. Neither the name of STMicroelectronics nor the names of other 
  *    contributors to this software may be used to endorse or promote products 
  *    derived from this software without specific written permission.
  * 4. This software, including modifications and/or derivative works of this 
  *    software, must execute solely and exclusively on microcontroller or
  *    microprocessor devices manufactured by or for STMicroelectronics.
  * 5. Redistribution and use of this software other than as permitted under 
  *    this license is void and will automatically terminate your rights under 
  *    this license. 
  *
  * THIS SOFTWARE IS PROVIDED BY STMICROELECTRONICS AND CONTRIBUTORS "AS IS" 
  * AND ANY EXPRESS, IMPLIED OR STATUTORY WARRANTIES, INCLUDING, BUT NOT 
  * LIMITED TO, THE IMPLIED WARRANTIES OF MERCHANTABILITY, FITNESS FOR A 
  * PARTICULAR PURPOSE AND NON-INFRINGEMENT OF THIRD PARTY INTELLECTUAL PROPERTY
  * RIGHTS ARE DISCLAIMED TO THE FULLEST EXTENT PERMITTED BY LAW. IN NO EVENT 
  * SHALL STMICROELECTRONICS OR CONTRIBUTORS BE LIABLE FOR ANY DIRECT, INDIRECT,
  * INCIDENTAL, SPECIAL, EXEMPLARY, OR CONSEQUENTIAL DAMAGES (INCLUDING, BUT NOT
  * LIMITED TO, PROCUREMENT OF SUBSTITUTE GOODS OR SERVICES; LOSS OF USE, DATA, 
  * OR PROFITS; OR BUSINESS INTERRUPTION) HOWEVER CAUSED AND ON ANY THEORY OF 
  * LIABILITY, WHETHER IN CONTRACT, STRICT LIABILITY, OR TORT (INCLUDING 
  * NEGLIGENCE OR OTHERWISE) ARISING IN ANY WAY OUT OF THE USE OF THIS SOFTWARE,
  * EVEN IF ADVISED OF THE POSSIBILITY OF SUCH DAMAGE.
  *
  ******************************************************************************
  */

/* Includes ------------------------------------------------------------------*/
#include "spi.h"

/* USER CODE BEGIN 0 */
#include <string.h>
#include "usart.h"

static void wen(void);
static void wdis(void);
static void wsr(void);
static void wip(void);
static unsigned char rdsr(void);
static void sect_clr(unsigned long a1);
static uint8_t SPI_Flash_ReadByte(void);
static uint8_t SPI_Flash_SendByte(uint8_t byte);
static void sst_wr_block(uint32_t addr, uint8_t *readbuff, uint16_t BlockSize);
static void sst_rd_block(unsigned long addr, unsigned char *readbuff, unsigned int BlockSize);

static uint8_t txBuf[20] = "SPI SST25 Demo";
static uint8_t sstBuf[20] = {0};
static uint8_t debugStr[40] = {0};
/* USER CODE END 0 */

SPI_HandleTypeDef hspi1;

/* SPI1 init function */
void MX_SPI1_Init(void)
{

  hspi1.Instance = SPI1;
  hspi1.Init.Mode = SPI_MODE_MASTER;
  hspi1.Init.Direction = SPI_DIRECTION_2LINES;
  hspi1.Init.DataSize = SPI_DATASIZE_8BIT;
  hspi1.Init.CLKPolarity = SPI_POLARITY_HIGH;
  hspi1.Init.CLKPhase = SPI_PHASE_2EDGE;
  hspi1.Init.NSS = SPI_NSS_SOFT;
  hspi1.Init.BaudRatePrescaler = SPI_BAUDRATEPRESCALER_8;
  hspi1.Init.FirstBit = SPI_FIRSTBIT_MSB;
  hspi1.Init.TIMode = SPI_TIMODE_DISABLE;
  hspi1.Init.CRCCalculation = SPI_CRCCALCULATION_DISABLE;
  hspi1.Init.CRCPolynomial = 7;
  if (HAL_SPI_Init(&hspi1) != HAL_OK)
  {
    Error_Handler();
  }

}

void HAL_SPI_MspInit(SPI_HandleTypeDef* spiHandle)
{

  GPIO_InitTypeDef GPIO_InitStruct = {0};
  if(spiHandle->Instance==SPI1)
  {
  /* USER CODE BEGIN SPI1_MspInit 0 */

  /* USER CODE END SPI1_MspInit 0 */
    /* SPI1 clock enable */
    __HAL_RCC_SPI1_CLK_ENABLE();
  
    __HAL_RCC_GPIOA_CLK_ENABLE();
    /**SPI1 GPIO Configuration    
    PA4     ------> SPI1_NSS
    PA5     ------> SPI1_SCK
    PA6     ------> SPI1_MISO
    PA7     ------> SPI1_MOSI 
    */
    GPIO_InitStruct.Pin = GPIO_PIN_5|GPIO_PIN_7;
    GPIO_InitStruct.Mode = GPIO_MODE_AF_PP;
    GPIO_InitStruct.Speed = GPIO_SPEED_FREQ_HIGH;
    HAL_GPIO_Init(GPIOA, &GPIO_InitStruct);

    GPIO_InitStruct.Pin = GPIO_PIN_6;
    GPIO_InitStruct.Mode = GPIO_MODE_INPUT;
    GPIO_InitStruct.Pull = GPIO_NOPULL;
    HAL_GPIO_Init(GPIOA, &GPIO_InitStruct);

  /* USER CODE BEGIN SPI1_MspInit 1 */

  /* USER CODE END SPI1_MspInit 1 */
  }
}

void HAL_SPI_MspDeInit(SPI_HandleTypeDef* spiHandle)
{

  if(spiHandle->Instance==SPI1)
  {
  /* USER CODE BEGIN SPI1_MspDeInit 0 */

  /* USER CODE END SPI1_MspDeInit 0 */
    /* Peripheral clock disable */
    __HAL_RCC_SPI1_CLK_DISABLE();
  
    /**SPI1 GPIO Configuration    
    PA4     ------> SPI1_NSS
    PA5     ------> SPI1_SCK
    PA6     ------> SPI1_MISO
    PA7     ------> SPI1_MOSI 
    */
    HAL_GPIO_DeInit(GPIOA, GPIO_PIN_5|GPIO_PIN_6|GPIO_PIN_7);

  /* USER CODE BEGIN SPI1_MspDeInit 1 */

  /* USER CODE END SPI1_MspDeInit 1 */
  }
} 

/* USER CODE BEGIN 1 */
void EEPROM_Test(void)
{
  uint16_t i, len;
  len = strlen((char *)txBuf);
  for (i=0;i<len;i++)
    sstBuf[i] = txBuf[i];
  sstBuf[i] = '\0';
  snprintf((char *)debugStr, 40, "txBuf is %s", txBuf);
  tftprintf(debugStr);
  memset((char *)debugStr, 0, 40);

  snprintf((char *)debugStr, 40, "sstBuf p is %s", sstBuf);
  tftprintf(debugStr);
  memset((char *)debugStr, 0, 40);
  sst_wr_block(0, sstBuf, 20);
  HAL_Delay(1000);
  sst_rd_block(0, sstBuf, 20);

  snprintf((char *)debugStr, 40, "sstBuf a is %s", sstBuf);
  tftprintf(debugStr);
}

/****************************************************************************
* 名    称：void wen(void)
* 功    能：写使能
* 入口参数：无
* 出口参数：无
* 说    明：
* 调用方法：无 
****************************************************************************/ 
static void wen(void){
  Select_Flash();
  SPI_Flash_SendByte(0x06);
  NotSelect_Flash();
}

/****************************************************************************
* 名    称：void wdis(void)
* 功    能：写禁止
* 入口参数：无
* 出口参数：无
* 说    明：
* 调用方法：无 
****************************************************************************/ 
static void wdis(void){

  Select_Flash();
  SPI_Flash_SendByte(0x04); 
  NotSelect_Flash();
  wip();
  
} 
/****************************************************************************
* 名    称：void wsr(void)
* 功    能：写状态
* 入口参数：无
* 出口参数：无
* 说    明：
* 调用方法：无 
****************************************************************************/ 
static void wsr(void){ 
  Select_Flash();
  SPI_Flash_SendByte(0x50);
  NotSelect_Flash(); 
  Select_Flash();
  SPI_Flash_SendByte(0x01);
  SPI_Flash_SendByte(0x00); 
  NotSelect_Flash();
    wip();
}

/****************************************************************************
* 名    称：void wip(void)
* 功    能：忙检测
* 入口参数：无
* 出口参数：无
* 说    明：
* 调用方法：无 
****************************************************************************/ 
static void wip(void){
  unsigned char a=1;
  while((a&0x01)==1) a=rdsr();  

}
/****************************************************************************
* 名    称：unsigned char rdsr(void)
* 功    能：读状态寄存器
* 入口参数：无
* 出口参数：无
* 说    明：
* 调用方法：无 
****************************************************************************/ 
static unsigned char rdsr(void){
  unsigned char busy;
  Select_Flash();
  SPI_Flash_SendByte(0x05);
  busy = SPI_Flash_ReadByte();
  NotSelect_Flash();
  return(busy);
  
}

/****************************************************************************
* 名    称：void SST25_W_BLOCK(uint32_t addr, uint8_t *readbuff, uint16_t BlockSize)
* 功    能：页写
* 入口参数：uint32_t addr--页   uint8_t *readbuff--数组   uint16_t BlockSize--长度    
* 出口参数：无
* 说    明：
* 调用方法：无 
****************************************************************************/  
static void sst_wr_block(uint32_t addr, uint8_t *readbuff, uint16_t BlockSize){
  unsigned int i=0,a2;
  sect_clr(addr);                     //删除页     
  wsr();
    wen();  
  Select_Flash();    
  SPI_Flash_SendByte(0xad);
  SPI_Flash_SendByte((addr&0xffffff)>>16);
  SPI_Flash_SendByte((addr&0xffff)>>8);
  SPI_Flash_SendByte(addr&0xff);
  SPI_Flash_SendByte(readbuff[0]);
  SPI_Flash_SendByte(readbuff[1]);
  NotSelect_Flash();
  i=2;
  while(i<BlockSize){
    a2=120;
    while(a2>0) a2--;
    Select_Flash();
    SPI_Flash_SendByte(0xad);
    SPI_Flash_SendByte(readbuff[i++]);
    SPI_Flash_SendByte(readbuff[i++]);
    NotSelect_Flash();
  }
  
  a2=100;
  while(a2>0) a2--;
  wdis(); 
  Select_Flash(); 
  wip();
}

/****************************************************************************
* 名    称：void SST25_R_BLOCK(unsigned long addr, unsigned char *readbuff, unsigned int BlockSize)
* 功    能：页读
* 入口参数：unsigned long addr--页   unsigned char *readbuff--数组   unsigned int BlockSize--长度
* 出口参数：无
* 说    明：
* 调用方法：无 
****************************************************************************/  
static void sst_rd_block(unsigned long addr, unsigned char *readbuff, unsigned int BlockSize){
  unsigned int i=0;   
  Select_Flash();
  SPI_Flash_SendByte(0x0b);
  SPI_Flash_SendByte((addr&0xffffff)>>16);
  SPI_Flash_SendByte((addr&0xffff)>>8);
  SPI_Flash_SendByte(addr&0xff);
  SPI_Flash_SendByte(0);
  while(i<BlockSize){ 
    readbuff[i]=SPI_Flash_ReadByte();
    
    i++;
  }
  NotSelect_Flash();    
}

/****************************************************************************
* 名    称：void sect_clr(unsigned long a1)
* 功    能：页擦除
* 入口参数：unsigned long a1--页   
* 出口参数：无
* 说    明：
* 调用方法：无 
****************************************************************************/ 
static void sect_clr(unsigned long a1){
  wsr();
  wen();     
  Select_Flash();   
  SPI_Flash_SendByte(0x20);
  SPI_Flash_SendByte((a1&0xffffff)>>16);          //addh
  SPI_Flash_SendByte((a1&0xffff)>>8);          //addl 
  SPI_Flash_SendByte(a1&0xff);                 //wtt
  NotSelect_Flash();
  wip();
  
}

/*******************************************************************************
* Function Name  : SPI_FLASH_ReadByte
* Description    : Reads a byte from the SPI Flash.
*                  This function must be used only if the Start_Read_Sequence
*                  function has been previously called.
* Input          : None
* Output         : None
* Return         : Byte Read from the SPI Flash.
*******************************************************************************/
static uint8_t SPI_Flash_ReadByte(void)
{
  uint8_t ret;
  while (HAL_SPI_GetState(&hspi1) != HAL_SPI_STATE_READY) {}
  HAL_SPI_Receive(&hspi1, &ret, 1, 0xffff);

  return ret;
}

/*******************************************************************************
* Function Name  : SPI_FLASH_SendByte
* Description    : Sends a byte through the SPI interface and return the byte 
*                  received from the SPI bus.
* Input          : byte : byte to send.
* Output         : None
* Return         : The value of the received byte.
*******************************************************************************/
static uint8_t SPI_Flash_SendByte(uint8_t byte)
{
  while (HAL_SPI_GetState(&hspi1) != HAL_SPI_STATE_READY) {}
  HAL_SPI_Transmit(&hspi1, &byte, 1, 0xffff);

  return 0;
}/******************* (C) COPYRIGHT 2011 奋斗STM32 *****END OF FILE****/

/* USER CODE END 1 */

/************************ (C) COPYRIGHT STMicroelectronics *****END OF FILE****/
