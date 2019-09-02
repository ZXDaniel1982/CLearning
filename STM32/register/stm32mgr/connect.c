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

static void GetHeader(uint8_t *buf, uint8_t cmd);
static bool GetReply(uint8_t *buf);

const char *portname = "/dev/ttyUSB0";

uint8_t txBuf[20] = {0};
uint8_t rxBuf[20] = {0};

int main(int argc, char **argv)
{
	int fd = open (portname, O_RDWR | O_NOCTTY);
    if (fd < 0) {
        printf("%s:%d error opening %s %d\n", __func__, __LINE__, portname, fd);
        return -1;
    }

    set_interface_attribs (fd, B115200, 0);  // set speed to 115,200 bps, 8n1 (no parity)
    set_blocking (fd, 1);                // set no blocking

    // jump
    memset(txBuf, 0, 20);
    memset(rxBuf, 0, 20);
    GetHeader(txBuf, IAP_CMD_CONNECT);

    int i;
    uint16_t chksum = 0;

    for (i=0;i<16;i++) {
        chksum += txBuf[i];
    }
    txBuf[16] = (uint8_t)((chksum >> 8) & 0x00ff);
    txBuf[17] = (uint8_t)(chksum & 0x00ff);

    printf("Connect to app\n");
    for (int i = 0; i < 5; ++i) {
        write (fd, txBuf, 20);
        read (fd, rxBuf, 20);
        usleep(50000);
        if (GetReply(rxBuf)) {
            printf("Connect success\n");
            break;
        } else {
            printf("Send fail, try again (%d)\n", i);
        }
    }

    close(fd);
}

static void GetHeader(uint8_t *buf, uint8_t cmd)
{
    buf[0] = 0x22;
    buf[1] = 0x33;
    buf[2] = cmd;
    buf[18] = 0x44;
    buf[19] = 0x55;
}

static bool GetReply(uint8_t *buf)
{
    if ((buf[0] != 0x33) || (buf[1] != 0x44)) return false;

    if (buf[2] == IAP_ERROR) 
        return false;

    return true;
}