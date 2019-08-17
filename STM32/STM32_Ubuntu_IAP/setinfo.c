#include <stdio.h>
#include <errno.h>
#include <fcntl.h> 
#include <string.h>
#include <termios.h>
#include <unistd.h>
#include <stdint.h>
#include <stdbool.h>

#include "common.h"

char *portname = "/dev/ttyACM0";

uint8_t txBuf[1000] = {0};
uint8_t rxBuf[1000] = {0};
uint16_t len = 0;

eepInfo_t eepInfo;

static int set_interface_attribs (int fd, int speed, int parity)
{
    struct termios tty;
    memset (&tty, 0, sizeof tty);
    if (tcgetattr (fd, &tty) != 0)
    {
        printf("%s:%d error from tcgetattr\n", __func__, __LINE__);
        return -1;
    }

    cfsetospeed (&tty, speed);
    cfsetispeed (&tty, speed);

    tty.c_cflag = (tty.c_cflag & ~CSIZE) | CS8;     // 8-bit chars
    // disable IGNBRK for mismatched speed tests; otherwise receive break
    // as \000 chars
    tty.c_iflag &= ~IGNBRK;         // disable break processing
    tty.c_lflag = 0;                // no signaling chars, no echo,
                                    // no canonical processing
    tty.c_oflag = 0;                // no remapping, no delays
    tty.c_cc[VMIN]  = 0;            // read doesn't block
    tty.c_cc[VTIME] = 5;            // 0.5 seconds read timeout

    tty.c_iflag &= ~(IXON | IXOFF | IXANY); // shut off xon/xoff ctrl

    tty.c_cflag |= (CLOCAL | CREAD);// ignore modem controls,
                                    // enable reading
    tty.c_cflag &= ~(PARENB | PARODD);      // shut off parity
    tty.c_cflag |= parity;
    tty.c_cflag &= ~CSTOPB;
    tty.c_cflag &= ~CRTSCTS;

    if (tcsetattr (fd, TCSANOW, &tty) != 0)
    {
        printf("%s:%d error from tcsetattr\n",  __func__, __LINE__);
        return -1;
    }
    return 0;
}

static void set_blocking (int fd, int should_block)
{
    struct termios tty;
    memset (&tty, 0, sizeof tty);
    if (tcgetattr (fd, &tty) != 0)
    {
        printf("%s:%d error from tggetattr\n", __func__, __LINE__);
        return;
    }

    tty.c_cc[VMIN]  = should_block ? 1 : 0;
    tty.c_cc[VTIME] = 5;            // 0.5 seconds read timeout

    if (tcsetattr (fd, TCSANOW, &tty) != 0)
        printf("%s:%d error setting term attributes", __func__, __LINE__);
}

static void IAP_InitTxPackage(uint8_t *buf)
{
    buf[0] = 0x22;
    buf[1] = 0x33;
}

static void IAP_GeneratePack(uint8_t *buf, uint16_t *len)
{
    *len = 5 + sizeof(eepInfo_t);

    buf[2] = (uint8_t)((*len >> 8) & 0x00ff);
    buf[3] = (uint8_t)(*len & 0x00ff);
    buf[4] = CDC_CMD_SET_INFO;

    memcpy(&buf[5], &eepInfo, sizeof(eepInfo_t));
}

static bool IAP_InfoHeaderIsValid(uint8_t *buf)
{
    bool ret = false;

    if ((buf[0] == 0x33) && (buf[1] == 0x44))
        ret = true;
    else
        ret = false;

    if (buf[2] == CDC_SUCCESS) {
        ret = true;
    } else {
        printf("reply type %d, detail %d\n", buf[2], buf[3]);
        ret = false;
    }
}

static bool IAP_InfoLenIsValid(uint8_t *buf, uint16_t len)
{
    uint16_t rxLen = (uint16_t)(buf[4] * 256) + buf[5];

    printf("rxLen is %d, num is %d\n", rxLen, len);
    if (rxLen != len) {
        return false;
    } else {
        return true;
    }
}

int main(int argc, char **argv)
{
    eepInfo.id = 0xab;
    eepInfo.active = 0;

    int fd = open (portname, O_RDWR | O_NOCTTY);
    if (fd < 0) {
        printf("%s:%d error opening %s %d\n", __func__, __LINE__, portname, fd);
        return -1;
    }

    set_interface_attribs (fd, B115200, 0);  // set speed to 115,200 bps, 8n1 (no parity)
    set_blocking (fd, 1);                // set no blocking

    printf("Start programming mini STM32\n");

    IAP_InitTxPackage(txBuf);
    IAP_GeneratePack(txBuf, &len);

    printf("Config eeprom infro\n");
    write (fd, txBuf, len);

    uint16_t num = read (fd, rxBuf, sizeof rxBuf);
    if (num <= 0) {
        printf("Invalid bytes when reading eeprom info %d\n", num);
        close(fd);
        return -1;
    }

    if (!IAP_InfoHeaderIsValid(rxBuf)) {
        printf("Invalid header\n");
        close(fd);
        return -1;
    }

    if (!IAP_InfoLenIsValid(rxBuf, num)) {
        printf("Invalid length\n");
        close(fd);
        return -1;
    }

    printf("Config eeprom info success\n");
    close(fd);
}
