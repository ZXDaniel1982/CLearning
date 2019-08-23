#include <stdio.h>
#include <errno.h>
#include <fcntl.h> 
#include <string.h>
#include <termios.h>
#include <unistd.h>
#include <stdint.h>
#include <stdbool.h>
#include <sys/stat.h>

#include "common.h"

const char *portname = "/dev/ttyUSB0";

uint8_t txBuf[20] = {0};
uint8_t rxBuf[20] = {0};

int main(int argc, char **argv)
{
    chmod(portname, 777);

    char filename[255] = "/home/dzhang/workspace/CLearning/STM32/STM32_CDC_Makefile/build/STM32_CDC_Makefile.bin";
    int fd = open (portname, O_RDWR | O_NOCTTY);
    if (fd < 0) {
        printf("%s:%d error opening %s %d\n", __func__, __LINE__, portname, fd);
        return -1;
    }

    set_interface_attribs (fd, B115200, 0);  // set speed to 115,200 bps, 8n1 (no parity)
    set_blocking (fd, 1);                // set no blocking

    for(uint8_t index=0;index<(256/20);index+=20) {
        memset(txBuf, 0, 20);
        for (int i = 0; i < 20; ++i) {
            txBuf[i] = index + i; 
        }
        write (fd, txBuf, 20);

        memset(rxBuf, 0, 20);
        read (fd, rxBuf, 20);

        if (memcmp(txBuf, rxBuf, 20) != 0) {
            printf("send ");
            for (int i = 0; i < 20; ++i) printf("%x ", txBuf[i]);
            printf("\nread ");
            for (int i = 0; i < 20; ++i) printf("%x ", rxBuf[i]);
            printf("\n");
        }
    }

    memset(txBuf, 0, 20);
    for (int i = 0; i < 16; ++i) {
        txBuf[i] = 240 + i; 
    }
    write (fd, txBuf, 20);

    memset(rxBuf, 0, 20);
    read (fd, rxBuf, 20);

    if (memcmp(txBuf, rxBuf, 20) != 0) {
        printf("send ");
        for (int i = 0; i < 20; ++i) printf("%x ", txBuf[i]);
        printf("\nread ");
        for (int i = 0; i < 20; ++i) printf("%x ", rxBuf[i]);
        printf("\n");
    }


    close(fd);
}