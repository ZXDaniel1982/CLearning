#include <stdio.h>
#include <errno.h>
#include <fcntl.h> 
#include <string.h>
#include <termios.h>
#include <unistd.h>
#include <stdint.h>
#include <stdbool.h>
#include <sys/types.h>
#include <sys/stat.h>

#include "common.h"

char *portname = "/dev/ttyACM0";

uint8_t txBuf[1000] = {0};
uint8_t rxBuf[1000] = {0};
uint8_t rdBuf[1000] = {0};
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

static void IAP_InitTxPackage(uint8_t *buf)
{
    buf[0] = 0x22;
    buf[1] = 0x33;
}

static void IAP_GenErasePack(uint8_t *buf, uint16_t *len, uint32_t addr)
{
    *len = 5 + sizeof(eepInfo_t);

    buf[2] = 0;
    buf[3] = 9;
    buf[4] = CDC_CMD_ERASE;

    buf[5] = (uint8_t)((addr >> 24) & 0x000000ff);
    buf[6] = (uint8_t)((addr >> 16) & 0x000000ff);
    buf[7] = (uint8_t)((addr >> 8) & 0x000000ff);
    buf[8] = (uint8_t)(addr & 0x000000ff);
}

static void IAP_GenStorePack(uint8_t *buf, uint16_t *len, uint32_t addr, uint16_t offset)
{
    *len = 5 + sizeof(eepInfo_t);

    uint16_t length = 9 + offset;

    buf[2] = (uint8_t)((length >> 8) & 0x00ff);
    buf[3] = (uint8_t)(length & 0x00ff);
    buf[4] = CDC_CMD_STORE;

    buf[5] = (uint8_t)((addr >> 24) & 0x000000ff);
    buf[6] = (uint8_t)((addr >> 16) & 0x000000ff);
    buf[7] = (uint8_t)((addr >> 8) & 0x000000ff);
    buf[8] = (uint8_t)(addr & 0x000000ff);
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

static bool IAP_RevPack(int fd)
{
    uint16_t num = read (fd, rxBuf, sizeof rxBuf);
    if (num <= 0) {
        printf("Invalid bytes%d\n", num);
        return -1;
    }

    if (!IAP_InfoHeaderIsValid(rxBuf)) {
        printf("Invalid header\n");
        return -1;
    }

    if (!IAP_InfoLenIsValid(rxBuf, num)) {
        printf("Invalid length\n");
        return -1;
    }
}

int main(int argc, char **argv)
{
    char filename[255] = "/home/dzhang/workspace/CLearning/STM32/STM32_CDC_Makefile/build/STM32_CDC_Makefile.bin";
    uint32_t baseAddr = 0x804B000;
    if (strcmp("main", argv[1]) == 0) {
        //strncpy(filename, "main.bin", 255);
    } else if (strcmp("backup", argv[1]) == 0) {
        //strncpy(filename, "backup.bin", 255);
    } else {
        printf("error command\n");
        return -1;
    }

    uint32_t addr = baseAddr;

    int fd = open (portname, O_RDWR | O_NOCTTY);
    if (fd < 0) {
        printf("%s:%d error opening %s %d\n", __func__, __LINE__, portname, fd);
        return -1;
    }

    set_interface_attribs (fd, B115200, 0);  // set speed to 115,200 bps, 8n1 (no parity)
    set_blocking (fd, 1);                // set no blocking

    printf("Start programming mini STM32\n");

    FILE *file = fopen(filename, "r");
    if (file == NULL) {
        printf("Fail to open file\n");
        return -1;
    }

    rewind(file);

    struct stat st;
    stat(filename, &st);
    uint32_t size = st.st_size;
    uint32_t cnt = 0;

    printf("file %s size is %d\n", filename, size);

    uint32_t pageTotal = size / 2048;

    for (uint32_t i=0; i<pageTotal; i++) {
        // erase
        printf("Erase addr %x\n", addr);
        memset(txBuf, 0, 1000);
        IAP_InitTxPackage(txBuf);
        IAP_GenErasePack(txBuf, &len, addr);
        write (fd, txBuf, len);

        if (!IAP_RevPack(fd)) {
            close(fd);
            fclose(file);
            return -1;
        }

        for (uint32_t j=0; j<4; j++) {
            // store
            printf("Store addr %x\n", addr);
            memset(txBuf, 0, 1000);
            IAP_InitTxPackage(txBuf);
            IAP_GenStorePack(txBuf, &len, addr, 512);

            memset(rdBuf, 0, 1000);
            fread(rdBuf,sizeof(uint8_t),512,file);
            memcpy(&txBuf[9], rxBuf, 512);
            write (fd, txBuf, len);

            if (!IAP_RevPack(fd)) {
                close(fd);
                fclose(file);
                return -1;
            }

            addr += 512;
        }
    }

    uint32_t mod = (size % 2048) / 512;

    if (mod > 0) {
        // erase
        printf("Erase addr %x\n", addr);
        memset(txBuf, 0, 1000);
        IAP_InitTxPackage(txBuf);
        IAP_GenErasePack(txBuf, &len, addr);
        write (fd, txBuf, len);

        if (!IAP_RevPack(fd)) {
            close(fd);
            fclose(file);
            return -1;
        }

        for (uint32_t j=0; j<mod; j++) {
            // store
            printf("Store addr %x\n", addr);
            memset(txBuf, 0, 1000);
            IAP_InitTxPackage(txBuf);
            IAP_GenStorePack(txBuf, &len, addr, 512);

            memset(rdBuf, 0, 1000);
            fread(rdBuf,sizeof(uint8_t),512,file);
            memcpy(&txBuf[9], rxBuf, 512);
            write (fd, txBuf, len);

            if (!IAP_RevPack(fd)) {
                close(fd);
                fclose(file);
                return -1;
            }

            addr += 512;
        }
    }

    mod = (size % 2048) % 512;

    if (mod > 0) {
        // erase
        printf("Erase addr %x\n", addr);
        memset(txBuf, 0, 1000);
        IAP_InitTxPackage(txBuf);
        IAP_GenErasePack(txBuf, &len, addr);
        write (fd, txBuf, len);

        if (!IAP_RevPack(fd)) {
            close(fd);
            fclose(file);
            return -1;
        }

        // store
        printf("Store addr %x\n", addr);
        memset(txBuf, 0, 1000);
        IAP_InitTxPackage(txBuf);
        IAP_GenStorePack(txBuf, &len, addr, mod);

        memset(rdBuf, 0, 1000);
        fread(rdBuf,sizeof(uint8_t),512,file);
        memcpy(&txBuf[9], rxBuf, 512);
        write (fd, txBuf, len);

        if (!IAP_RevPack(fd)) {
            close(fd);
            fclose(file);
            return -1;
        }
    }

    printf("Programming success\n");
    close(fd);
    fclose(file);
}
