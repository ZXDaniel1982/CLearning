#include <stdio.h>
#include <errno.h>
#include <fcntl.h> 
#include <string.h>
#include <termios.h>
#include <unistd.h>

char *portname = "/dev/ttyS0";

int set_interface_attribs (int fd, int speed, int parity)
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

void
set_blocking (int fd, int should_block)
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

int main(int argc, char **argv)
{
    int i;
    int fd = open (portname, O_RDWR | O_NOCTTY);
    if (fd < 0) {
        printf("%s:%d error opening %s %d\n", __func__, __LINE__, portname, fd);
        return -1;
    }

    set_interface_attribs (fd, B115200, 0);  // set speed to 115,200 bps, 8n1 (no parity)
    set_blocking (fd, 1);                // set no blocking

    printf("Start programming mini STM32\n");

//============================================================================================
//    receive 0x21 0x31    transmit  0x22  0x23
//============================================================================================
    char revBuf[2] = {0};
    int n = read (fd, revBuf, sizeof revBuf);
    if (n != 2) {
        printf("Invalid STM IAP start command %d\n", n);
        return -1;
    }
    printf("Received data %x %x  : ", revBuf[0], revBuf[1]);
    if ((revBuf[0] == 0x21) & (revBuf[1] == 0x31)) {
        printf("Start STM IAP processing\n");
    } else {
        printf("Invalid STM IAP processing command\n");
        return -1;
    }

    usleep(50000);

    char txBuf[2] = {0};
    txBuf[0] = 0x22;  txBuf[1] = 0x32;
    write (fd, txBuf, 2);

//============================================================================================
//    receive 0x22 0x32    transmit  0x23  0x33
//============================================================================================
    n = read (fd, revBuf, sizeof revBuf);
    if (n != 2) {
        printf("Invalid STM IAP init command\n");
        return -1;
    }
    printf("Received data %x %x  : ", revBuf[0], revBuf[1]);
    if ((revBuf[0] == 0x22) & (revBuf[1] == 0x32)) {
        printf("init STM IAP processing\n");
    } else {
        printf("Invalid STM IAP init processing command\n");
        return -1;
    }

    usleep(50000);
    txBuf[0] = 0x23;  txBuf[1] = 0x33;
    write (fd, txBuf, 2);

//============================================================================================
//    block 0x00 0x01    exceed  0x00  0x04
//============================================================================================
    usleep(50000);
    txBuf[0] = 0x00;  txBuf[1] = 0x01;
    write (fd, txBuf, 2);

    n = read (fd, revBuf, sizeof revBuf);
    if (n != 2) {
        printf("Invalid STM IAP block number\n");
        return -1;
    }
    printf("Received data %x %x  : ", revBuf[0], revBuf[1]);
    if ((revBuf[0] == 0x00) & (revBuf[1] == 0x01)) {
        printf("init STM IAP block number\n");
    } else {
        printf("Invalid STM IAP init block number\n");
        return -1;
    }

    usleep(50000);
    txBuf[0] = 0x00;  txBuf[1] = 0x04;
    write (fd, txBuf, 2);

    n = read (fd, revBuf, sizeof revBuf);
    if (n != 2) {
        printf("Invalid STM IAP exceed number\n");
        return -1;
    }
    printf("Received data %x %x  : ", revBuf[0], revBuf[1]);
    if ((revBuf[0] == 0x00) & (revBuf[1] == 0x04)) {
        printf("init STM IAP exceed number\n");
    } else {
        printf("Invalid STM IAP init exceed number\n");
        return -1;
    }

//============================================================================================
//    send 2048 data
//============================================================================================

    char dataTxBuf = 0;
    char dataRxBuf = 0;
    for (i=0; i<64; i++) {
        usleep(50000);
        write (fd, &dataTxBuf, 1);
        n = read (fd, &dataRxBuf, sizeof revBuf);
        if (n != 1) {
            printf("Invalid STM IAP respond data length\n");
            return -1;
        }
        if (dataTxBuf != dataRxBuf) {
            printf("Invalid STM IAP respond data number\n");
            return -1;
        }
        printf("dataTxBuf %x dataRxBuf %x\n", dataTxBuf, dataRxBuf);
        dataTxBuf++;
    }

//============================================================================================
//    send 4 data
//============================================================================================
    for (i=0; i<4; i++) {
        usleep(50000);
        write (fd, &dataTxBuf, 1);
        n = read (fd, &dataRxBuf, sizeof revBuf);
        if (n != 1) {
            printf("Invalid STM IAP respond  exceed length\n");
            return -1;
        }
        if (dataTxBuf != dataRxBuf) {
            printf("Invalid STM IAP respond exceed number\n");
            return -1;
        }
        printf("dataTxBuf %x dataRxBuf %x\n", dataTxBuf, dataRxBuf);
        dataTxBuf++;
    }

//============================================================================================
//    receive 0x23 0x33   to finish
//============================================================================================
    n = read (fd, revBuf, sizeof revBuf);
    if (n != 2) {
        printf("Invalid STM IAP finish number\n");
        return -1;
    }
    printf("Received data %x %x  : ", revBuf[0], revBuf[1]);
    if ((revBuf[0] == 0x23) & (revBuf[1] == 0x33)) {
        printf("init STM IAP finish number\n");
    } else {
        printf("Invalid STM IAP init finish number\n");
        return -1;
    }
}
