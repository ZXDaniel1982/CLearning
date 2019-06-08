#include <stdio.h>
#include <errno.h>
#include <fcntl.h> 
#include <string.h>
#include <termios.h>
#include <unistd.h>

char *portname = "/dev/ttyUSB0";

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
    int cmd = 0;
    if (argc != 2) {
        printf("usage : ./server [run | upd]\n");
        return -1;
    }

    if (strcmp("run", argv[1]) == 0) {
        cmd = 1;
    } else if (strcmp("upd", argv[1]) == 0) {
        cmd = 2;
    } else {
        printf("error command\n");
        printf("usage : ./server [run | upd]\n");
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

    unsigned char rxBuf[2] = {0};
    unsigned char txBuf[2] = {0};
    while (1) {
        int n = read (fd, rxBuf, sizeof rxBuf);
        if (n != 2) {
            printf("Invalid bytes %d\n", n);
            return -1;
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
#if 0 
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

    usleep(500000);

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

    usleep(500000);
    txBuf[0] = 0x23;  txBuf[1] = 0x33;
    write (fd, txBuf, 2);

//============================================================================================
//    send total bytes number,   receive  it back
//============================================================================================
    FILE *file = fopen(filename, "rb");
    if (file == NULL) {
        printf("Unable to open file %s\n", filename);
        return -1;
    }

    fseek(file, 0L, SEEK_END);
    long sz = ftell(file) + 1;
    unsigned char totalBytesTxBuf[4] = { 0xff };
    unsigned char totalBytesRxBuf[4] = { 0xff };
    totalBytesTxBuf[0] = (unsigned char)(sz / 0x1000000);
    totalBytesTxBuf[1] = (unsigned char)((sz % 0x1000000) / 0x10000);
    totalBytesTxBuf[2] = (unsigned char)((sz % 0x10000) / 0x100);
    totalBytesTxBuf[3] = (unsigned char)(sz % 0x100);
    printf("Bin file size %ld\n", sz);
    rewind(file);
    
    usleep(500000);
    write (fd, totalBytesTxBuf, 4);

    n = read (fd, totalBytesRxBuf, sizeof totalBytesRxBuf);
    if (n != 4) {
        printf("Invalid STM IAP total bytes number\n");
        return -1;
    }
    printf("Received data %x %x %x %x  : ", totalBytesRxBuf[0], totalBytesRxBuf[1],
            totalBytesRxBuf[2], totalBytesRxBuf[3]);
    if ((totalBytesRxBuf[0] == totalBytesTxBuf[0]) &&
        (totalBytesRxBuf[1] == totalBytesTxBuf[1]) &&
        (totalBytesRxBuf[2] == totalBytesTxBuf[2]) &&
        (totalBytesRxBuf[3] == totalBytesTxBuf[3])) {
        printf("Stm32 get the correct total bytes number\n");
    } else {
        printf("Stm32 did not get the correct total bytes number\n");
        return -1;
    }

//============================================================================================
//    send all data
//============================================================================================

    char dataTxBuf[8] = { 0xff };
    char dataRxBuf[8] = { 0xff };
    int num = 0;
    long totalNum = 0;
    sleep(5);
    while (1) {
        num = fread(dataTxBuf, 1, 8, file);
        totalNum += num;
        if ((totalNum % 256) == 0) {
            printf("256 block number %ld send\n", (totalNum / 256));
        }
        if (num > 8) {
            printf("Error happened when reading file\n");
            return -1;
        } else if (num == 8) {
            sleep(1);
            write (fd, dataTxBuf, 8);
            n = read (fd, dataRxBuf, sizeof dataRxBuf);
            if (n != 8) {
                printf("Invalid STM IAP respond data length\n");
                return -1;
            }
            /*for (i=0; i<8; i++) {
                if (dataTxBuf[i] != dataRxBuf[i]) {
                    printf("i %d tx %d rx %d total %ld\n", i, dataTxBuf[i], dataRxBuf[i], totalNum);
                    printf("Invalid STM IAP respond data number\n");
                    return -1;
                }
            }*/
            memset(dataTxBuf, 0xff, sizeof dataTxBuf);
            memset(dataRxBuf, 0xff, sizeof dataRxBuf);
        } else if (num > 0) {
            sleep(1);
            write (fd, dataTxBuf, 8);
            n = read (fd, dataRxBuf, sizeof dataRxBuf);
            if (n != 8) {
                printf("Invalid STM IAP respond data length\n");
                return -1;
            }
            /*for (i=0; i<8; i++) {
                if (dataTxBuf[i] != dataRxBuf[i]) {
                    printf("Invalid STM IAP respond data number\n");
                    return -1;
                }
            }*/
            break;
        } else {
            break;
        }
    }
    fclose(file);

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
        printf("STM IAP finished\n");
    } else {
        printf("Invalid STM IAP finish number\n");
        return -1;
    }
#endif
}
