#!/bin/sh

dfu-util -a 0 -S 00000000001A -s 0x08005000 -D build/STM32_Full_Parts.bin
