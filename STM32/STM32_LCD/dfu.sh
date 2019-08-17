#!/bin/sh

dfu-util -a 0 -S 48D8844E3036 -s 0x08005000 -D build/STM32_LCD.bin
