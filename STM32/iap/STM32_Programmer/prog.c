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
static bool SendData(uint8_t *rbuf, uint8_t *tbuf, int fd);

const char *portname = "/dev/ttyUSB0";

uint32_t addr = 0x08005000;

uint8_t txBuf[20] = {0};
uint8_t rxBuf[20] = {0};
uint8_t rdBuf[20] = {0};

int main(int argc, char **argv)
{
    chmod(portname, 777);

    char filename[255] = "/home/dzhang/workspace/CLearning/STM32/STM32_FreeRTOS/build/STM32_FreeRTOS.bin";
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

    printf("file %s size is %d\n", filename, size);

    // init flash
    GetHeader(txBuf, IAP_CMD_INIT);
    if (!SendData(rxBuf, txBuf, fd)) {
        printf("Send data failed\n");
        close(fd);
        fclose(file);
        return -1;
    }

    // prog
    uint32_t page = size / 2048;
    uint32_t mod = size % 2048;

    for (int i = 0; i < page; ++i) {
        // erase
        printf("erase %x\n", addr);
        memset(txBuf, 0, 20);
        memset(rxBuf, 0, 20);
        GetHeader(txBuf, IAP_CMD_ERASE);
        txBuf[3] = (uint8_t)((addr >> 24) & 0x000000ff);
        txBuf[4] = (uint8_t)((addr >> 16) & 0x000000ff);
        txBuf[5] = (uint8_t)((addr >> 8) & 0x000000ff);
        txBuf[6] = (uint8_t)(addr & 0x000000ff);

        if (!SendData(rxBuf, txBuf, fd)) {
            printf("Send data failed\n");
            close(fd);
            fclose(file);
            return -1;
        }

        for (uint32_t j=0; j<512; j++) {
            // store
            memset(txBuf, 0, 20);
            memset(rxBuf, 0, 20);
            printf("Store addr %x\n", addr);
            GetHeader(txBuf, IAP_CMD_STORE);
            txBuf[3] = (uint8_t)((addr >> 24) & 0x000000ff);
            txBuf[4] = (uint8_t)((addr >> 16) & 0x000000ff);
            txBuf[5] = (uint8_t)((addr >> 8) & 0x000000ff);
            txBuf[6] = (uint8_t)(addr & 0x000000ff);

            memset(rdBuf, 0, 1000);
            fread(rdBuf,sizeof(uint8_t),4,file);
            memcpy(&txBuf[7], rdBuf, 4);

            if (!SendData(rxBuf, txBuf, fd)) {
                printf("Send data failed\n");
                close(fd);
                fclose(file);
                return -1;
            }

            addr += 4;
        }
    }


    // erase
    printf("erase %d\n", addr);
    memset(txBuf, 0, 20);
    memset(rxBuf, 0, 20);
    GetHeader(txBuf, IAP_CMD_ERASE);
    txBuf[3] = (uint8_t)((addr >> 24) & 0x000000ff);
    txBuf[4] = (uint8_t)((addr >> 16) & 0x000000ff);
    txBuf[5] = (uint8_t)((addr >> 8) & 0x000000ff);
    txBuf[6] = (uint8_t)(addr & 0x000000ff);

    if (!SendData(rxBuf, txBuf, fd)) {
        printf("Send data failed\n");
        close(fd);
        fclose(file);
        return -1;
    }

    for (uint32_t j=0; j<(mod/4); j++) {
        // store
        memset(txBuf, 0, 20);
        memset(rxBuf, 0, 20);
        printf("Store addr %x\n", addr);
        GetHeader(txBuf, IAP_CMD_STORE);
        txBuf[3] = (uint8_t)((addr >> 24) & 0x000000ff);
        txBuf[4] = (uint8_t)((addr >> 16) & 0x000000ff);
        txBuf[5] = (uint8_t)((addr >> 8) & 0x000000ff);
        txBuf[6] = (uint8_t)(addr & 0x000000ff);

        memset(rdBuf, 0, 1000);
        fread(rdBuf,sizeof(uint8_t),4,file);
        memcpy(&txBuf[7], rdBuf, 4);

        if (!SendData(rxBuf, txBuf, fd)) {
            printf("Send data failed\n");
            close(fd);
            fclose(file);
            return -1;
        }

        addr += 4;
    }


    printf("finish prog\n");

    // jump
    memset(txBuf, 0, 20);
    memset(rxBuf, 0, 20);
    GetHeader(txBuf, IAP_CMD_JUMP);

    printf("Jump to app\n");
    if (!SendData(rxBuf, txBuf, fd)) {
        printf("Send data failed\n");
        close(fd);
        fclose(file);
        return -1;
    }

    close(fd);
    fclose(file);
}

static void GetHeader(uint8_t *buf, uint8_t cmd)
{
    buf[0] = 0x22;
    buf[1] = 0x33;
    buf[2] = cmd;
}

static bool GetReply(uint8_t *buf)
{
    if ((buf[0] != 0x33) || (buf[1] != 0x44)) return false;

    if (buf[2] == IAP_ERROR) 
        return false;

    return true;
}

static bool SendData(uint8_t *rbuf, uint8_t *tbuf, int fd)
{
    for (int i = 0; i < IAP_RETRY_MAX; ++i) {
        write (fd, tbuf, 20);
        read (fd, rbuf, 20);
        if (GetReply(rbuf)) {
            return true;
        } else {
            printf("Send fail, try again (%d)\n", i);
        }
    }
    return false;
}