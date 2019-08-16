/* 
 * File : rbl_jump_stm32f2_f4.c.c 
 * This file is part of RT-Thread RTOS 
 * COPYRIGHT (C) 2006 - 2015, RT-Thread Development Team 
 * 
 * This program is free software; you can redistribute it and/or modify 
 * it under the terms of the GNU General Public License as published by 
 * the Free Software Foundation; either version 2 of the License, or 
 * (at your option) any later version. 
 * * This program is distributed in the hope that it will be useful, 
 * but WITHOUT ANY WARRANTY; without even the implied warranty of 
 * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE. See the 
 * GNU General Public License for more details. 
 * 
 * You should have received a copy of the GNU General Public License along 
 * with this program; if not, write to the Free Software Foundation, Inc., 
 * 51 Franklin Street, Fifth Floor, Boston, MA 02110-1301 USA. 
 * 
 * Change Logs: 
 * Date Author Notes 
 * 2014-03-12 aozima first version. 
 * 2015-09-22 aozima disable and clean up all interrupts. 
 */ 
#include <stdint.h>
#include <board.h> 

void jump_to_app(uint32_t app_address) 
{ 
    typedef void (*_func)(void); 
    __disable_irq(); 

    /* MCU peripherals re-initial. */ 
    { 
        GPIO_InitTypeDef GPIO_InitStruct; 
        GPIO_InitStruct.GPIO_Mode = GPIO_Mode_IN; 
        GPIO_InitStruct.GPIO_Speed = GPIO_Speed_2MHz; 
        GPIO_InitStruct.GPIO_OType = GPIO_OType_OD; 
        GPIO_InitStruct.GPIO_PuPd = GPIO_PuPd_NOPULL; 
        GPIO_InitStruct.GPIO_Pin = GPIO_Pin_All; 
        GPIO_InitStruct.GPIO_Pin &= ~(GPIO_Pin_13 | GPIO_Pin_14); 

        /* SWDIO/SWCLK */ 
        GPIO_Init(GPIOA, &GPIO_InitStruct); 
        GPIO_InitStruct.GPIO_Pin = GPIO_Pin_All; 
        GPIO_Init(GPIOB, &GPIO_InitStruct); 
        GPIO_Init(GPIOC, &GPIO_InitStruct); 
        GPIO_Init(GPIOD, &GPIO_InitStruct); 
        GPIO_Init(GPIOE, &GPIO_InitStruct); 
        GPIO_Init(GPIOF, &GPIO_InitStruct); 
        GPIO_Init(GPIOG, &GPIO_InitStruct); 
        GPIO_Init(GPIOH, &GPIO_InitStruct); 
        GPIO_Init(GPIOI, &GPIO_InitStruct); 

        /* reset systick */ 
        SysTick->CTRL &= ~SysTick_CTRL_ENABLE_Msk; 

        /* disable all peripherals clock. */ 
        RCC->AHB1ENR = (1<<20); 

        /* 20: F4 CCMDAT ARAMEN. */ 
        RCC->AHB2ENR = 0; RCC->AHB3ENR = 0; 
        RCC->APB1ENR = 0; RCC->APB2ENR = 0; 

        /* Switch to default cpu clock. */ 
        RCC->CFGR = 0; 
    } 

    /* MCU peripherals re-initial. */ 
    /* Disable MPU */ 
    MPU->CTRL &= ~MPU_CTRL_ENABLE_Msk; 

    /* disable and clean up all interrupts. */ 
    { 
        int i; 
        for(i = 0; i < 8; i++) 
        { 
            /* disable interrupts. */ 
            NVIC->ICER = 0xFFFFFFFF; 

            /* clean up interrupts flags. */ 
            NVIC->ICPR = 0xFFFFFFFF; 
        } 
    } 

    /* Set new vector table pointer */ 
    SCB->VTOR = app_address; 

    /* reset register values */ 
    __set_BASEPRI(0); 
    __set_FAULTMASK(0); 

    /* set up MSP and switch to it */ 
    __set_MSP(*(uint32_t*)app_address); 
    __set_PSP(*(uint32_t*)app_address); 
    __set_CONTROL(0); 

    /* ensure what we have done could take effect */ 
    __ISB(); 
    __disable_irq(); 

    /* never return */ 

    ((_func)(*(uint32_t*)(app_address + 4)))(); }