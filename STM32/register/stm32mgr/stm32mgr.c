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
uint8_t rdBuf[2048] = {0};
uint16_t chksum = 0;

static void GetHeader(uint8_t *buf, uint8_t cmd);
static void GetChecksum(uint8_t *buf);
static bool GetReply(uint8_t *buf);
static bool SingleComm(uint16_t cmd, int fd);
static bool Comm128B(uint16_t cmd, uint8_t *buf, int fd);
static uint32_t IAP_CONV_TO_32(uint8_t *buf);
static void IAP_CONV_FROM_32(uint8_t *buf, uint32_t val);

int main(int argc, char **argv)
{
    if (argc < 3) {
        printf("Usage : stm32mgr install [iap | app] <file>\n");
        printf("      : stm32mgr connect\n");
        printf("      : stm32mgr reboot\n");
        printf("      : stm32mgr info\n");
        return -1;
    }

    int fd = open (portname, O_RDWR | O_NOCTTY);
    if (fd < 0) {
        printf("%s:%d error opening %s %d\n", __func__, __LINE__, portname, fd);
        return -1;
    }

    set_interface_attribs (fd, B115200, 0);  // set speed to 115,200 bps, 8n1 (no parity)
    set_blocking (fd, 1);                // set no blocking

    memset(rxBuf, 0xff, 20);
    memset(txBuf, 0xff, 20);
    memset(rdBuf, 0xff, 2048);


    // make connection
    printf("Connect to app\n");
    if (!SingleComm(IAP_CMD_CONNECT, fd)) {
        return -1;
    }
    printf("Connection to app success\n");

    if (strcmp(argv[1], "connect") == 0) {
        return 0;
    } else if (strcmp(argv[1], "reboot") == 0) {
        // reboot device
        printf("Reboot device\n");
        if (!SingleComm(IAP_CMD_REBOOT, fd)) {
            return -1;
        }
        printf("Reboot success\n");
    } else if (strcmp(argv[1], "info") == 0) {
        // get info
        printf("Get info\n");
        if (!SingleComm(IAP_CMD_GETINFO, fd)) {
            return -1;
        }
    } else if (strcmp(argv[1], "install") == 0) {
        if (argv[3] == NULL) {
            printf("Please input valid file name\n");
            return -1;
        }

        uint8_t filename[255];
        memset(filename, 0, 255);
        strcpy(filename, argv[3]);

        FILE *file = fopen(filename, "r");
        if (file == NULL) {
            printf("Fail to open file\n");
            return -1;
        }

        struct stat st;
        stat(filename, &st);
        uint32_t size = st.st_size;
        rewind(file);

        if (strcmp(argv[2], "iap") == 0) {
            // programm iap
            printf("Enable flash write\n");
            if (!SingleComm(IAP_CMD_INIT, fd)) {
                return -1;
            }

            // write data
            printf("Write flash\n");
            uint32_t flashAdd = 0;
            uint32_t num = 0;
            while (size > 0) {
                IAP_CONV_FROM_32(&txBuf[3], flashAdd);
                if (!SingleComm(IAP_CMD_ERASE, fd)) {
                    return -1;
                }
                memset(rdBuf, 0xff, 2048);
                num = fread(rdBuf, sizeof(uint8_t), 2048, file);
                if (num == 0) {
                    break;
                }
                for (int i=0;i<(2048/8);++i) {
                    IAP_CONV_FROM_32(&txBuf[3], flashAdd);
                    memcpy(&txBuf[7], &rdBuf[i*8], 8);
                    if (!SingleComm(IAP_CMD_STORE, fd)) {
                        return -1;
                    }
                    flashAdd += 8;
                }
                if (size > 2048) {
                    size -= 2048;
                } else {
                    size = 0;
                }
            }

            // programm iap
            printf("Disable flash write\n");
            if (!SingleComm(IAP_CMD_DEINIT, fd)) {
                return -1;
            }
            printf("Programm iap success\n"); 
        } else if (strcmp(argv[2], "app") == 0) {
            // programm app
            printf("Programm app\n");
            uint32_t eepAdd = 4096;
            uint32_t num = 0;
            while (size > 0) {
                IAP_CONV_FROM_32(&txBuf[3], eepAdd);
                if (!SingleComm(IAP_CMD_CLEAR, fd)) {
                    return -1;
                }

                for (int i=0;i<(4096/128);++i) {
                    memset(rdBuf, 0xff, 2048);
                    num = fread(rdBuf, sizeof(uint8_t), 128, file);
                    if (num == 0) {
                        break;
                    }
                    if (!Comm128B(IAP_CMD_BUFFER, rdBuf, fd)) {
                        return -1;
                    }

                    IAP_CONV_FROM_32(&txBuf[3], eepAdd);
                    if (!SingleComm(IAP_CMD_SAVE, fd)) {
                        return -1;
                    }
                    eepAdd += 128;
                }

                if (size > 4096) {
                    size -= 4096;
                } else {
                    size = 0;
                }
            }

            // set info
            printf("Set app info in EEP\n");
            IapInfo_t info;
            memset(&info, 0, sizeof(IapInfo_t));
            info.header = 0x2233;
            info.tail = 0x4455;
            info.update = 1;
            info.size = st.st_size;
            memcpy(&txBuf[3], &info, sizeof(IapInfo_t));
            if (!SingleComm(IAP_CMD_SETINFO, fd)) {
                return -1;
            }

            // reboot
            printf("Reboot the device\n");
            if (!SingleComm(IAP_CMD_REBOOT, fd)) {
                return -1;
            }
        }
    }

    uint8_t filename[255];
    memset(filename, 0, 255);
    strcpy(filename, argv[3]);

    if (strcmp(argv[2], "iap") == 0) {
        // programm iap
        printf("Enable flash write\n");
        if (!SingleComm(IAP_CMD_INIT, fd)) {
            return -1;
        }
    }
}

static void GetHeader(uint8_t *buf, uint8_t cmd)
{
    buf[0] = 0x22;
    buf[1] = 0x33;
    buf[2] = cmd;
    buf[18] = 0x44;
    buf[19] = 0x55;
}

static void GetChecksum(uint8_t *buf)
{
    for (int i=0;i<16;i++) {
        chksum += buf[i];
    }

    buf[16] = (uint8_t)((chksum >> 8) & 0x00ff);
    buf[17] = (uint8_t)(chksum & 0x00ff);
    chksum = 0;
}

static bool GetReply(uint8_t *buf)
{
    if ((buf[0] != 0x33) || (buf[1] != 0x44)) return false;

    if (buf[2] == IAP_ERROR) 
        return false;

    return true;
}

static bool Comm128B(uint16_t cmd, uint8_t *buf, int fd)
{
    uint16_t size = 128;
    uint8_t index = 0;
    while (size > 0) {
        txBuf[3] = index;
        memcpy(&txBuf[4], &buf[index], 8);
        if (!SingleComm(cmd, fd)) {
            return false;
        }
        index += 8;
        size -= 8;
    }
    return true;
}

static bool SingleComm(uint16_t cmd, int fd)
{
    GetHeader(txBuf, cmd);
    GetChecksum(txBuf);

    for (int i = 0; i < 5; ++i) {
        for (int j = 0; j < 20; ++j) {
            printf("%d ", txBuf[j]);
        }
        printf("\n");
        write (fd, txBuf, 20);
        read (fd, rxBuf, 20);
        for (int j = 0; j < 20; ++j) {
            printf("%d ", rxBuf[j]);
        }
        printf("\n");
        if (GetReply(rxBuf)) {
            printf("Send success\n");
            memset(txBuf, 0xff, 20);
            memset(rxBuf, 0xff, 20);
            return true;
        } else {
            printf("Send fail, try again (%d)\n", i);
        }
    }
    return false;
}

static uint32_t IAP_CONV_TO_32(uint8_t *buf)
{
    uint32_t ret = 0;
    ret = (*buf) << 24;
    ret += *(buf+1) << 16;
    ret += *(buf+2) << 8;
    ret += *(buf+3);
    return ret;
}

static void IAP_CONV_FROM_32(uint8_t *buf, uint32_t val)
{
    buf[0] = (uint8_t)((val >> 24) & 0x000000ff);
    buf[1] = (uint8_t)((val >> 16) & 0x000000ff);
    buf[2] = (uint8_t)((val >> 8) & 0x000000ff);
    buf[3] = (uint8_t)(val & 0x000000ff);
}
