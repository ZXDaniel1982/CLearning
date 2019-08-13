#include <stdio.h>
#include <errno.h>
#include <fcntl.h> 
#include <string.h>
#include <termios.h>
#include <unistd.h>

char *portname = "/dev/ttyUSB0";

char txBuf[1000] = {0};
char rxBuf[1000] = {0};
uint16_t len = 0;

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

static void IAP_InitTxPackage(char *buf)
{
    buf[0] = 0x22;
    buf[1] = 0x33;
}

static void IAP_GenInfoGetPack(char *buf, uint16_t *len)
{
    buf[2] = 0x0;
    buf[3] = 0x5;
    buf[4] = CDC_CMD_GET_INFO;

    *len = 5;
}

int main(int argc, char **argv)
{
    int i;
    int cmd = 0;
    if (argc != 2) {
        return -1;
    }

    int fd = open (portname, O_RDWR | O_NOCTTY);
    if (fd < 0) {
        printf("%s:%d error opening %s %d\n", __func__, __LINE__, portname, fd);
        return -1;
    }

    set_interface_attribs (fd, B115200, 0);  // set speed to 115,200 bps, 8n1 (no parity)
    set_blocking (fd, 1);                // set no blocking

    printf("Start programming mini STM32\n");

    while (1) {
        IAP_InitTxPackage(txBuf);
        IAP_GenInfoGetPack(txBuf, &len);

        printf("Require eeprom infro\n");
        write (fd, txBuf, len);

        int num = read (fd, rxBuf, sizeof rxBuf);
        if (num <= 0) {
            printf("Invalid bytes when reading eeprom info %d\n", n);
            return -1;
        }

        if (IAP_InfoIsValid()) {

        } else {

        }
        printf("Received data 0x%02x 0x%02x\n", rxBuf[0], rxBuf[1]);

        if ((rxBuf[0] == 0x24) && (rxBuf[1] == 0x34)) {
            if (cmd == 1) {
                // run app
                txBuf[0] = 0x15;  txBuf[1] = 0x17;
            } else if (cmd == 2) {
                // update app
                txBuf[0] = 0x25;  txBuf[1] = 0x27;
            }
            write (fd, txBuf, 2);
        }
    }
}
