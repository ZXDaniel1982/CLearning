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

    int fd = open (portname, O_RDWR | O_NOCTTY);
    if (fd < 0) {
        printf("%s:%d error opening %s %d\n", __func__, __LINE__, portname, fd);
        return -1;
    }

    set_interface_attribs (fd, B115200, 0);  // set speed to 115,200 bps, 8n1 (no parity)
    set_blocking (fd, 1);                // set no blocking

    strncpy(txBuf, "abcdefghijklmnopqrstttt", 20);
    write (fd, txBuf, 20);

    uint16_t num = read (fd, rxBuf, sizeof rxBuf);
    printf("read num %d \n", num);
    for (uint8_t i=0;i<num;i++) {
        printf("%c ", rxBuf[i]);
    }
    printf("\n");
    close(fd);
}