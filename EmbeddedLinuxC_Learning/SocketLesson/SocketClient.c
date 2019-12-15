#include<stdio.h>
#include<stdlib.h>
#include<string.h>
#include<stdint.h>
#include<stdbool.h>
#include<sys/stat.h>
#include<sys/socket.h>
#include<sys/types.h>
#include<sys/un.h>
#include<errno.h>
#include<stddef.h>
#include<unistd.h>

#define IMAGEARGS_HEADER         (0x2233)
#define IMAGEARGS_TAIL           (0x8899)

#define IAP_RETRY_MAX            ( 10 )

#define FLASH_PAGE_SIZE          ( 0x800U )   // 2048B
#define EEPROM_PAGE_SIZE         ( 0x1000U )  // 4096B
#define SDCARD_PAGE_SIZE         ( 0x200U )   // 512B
#define DATA_BUF_SIZE            ( SDCARD_PAGE_SIZE )

#define SDCARD_ARGS_ADDR         ( 0 )
#define SDCARD_IMAGE_ADDR        ( SDCARD_PAGE_SIZE )

#define BUFFER_SIZE              ( 20 )

typedef enum
{
    IAP_ERROR = 0,
    IAP_SUCCESS,

    IAP_ERROR_HEAD_INVALID,
    IAP_ERROR_FRAME_INVALID,
    IAP_ERROR_CHKSUM_INVALID,
    
    // common
    IAP_CMD_CONNECT,
    IAP_CONNECT_SUCCESS,
    IAP_CONNECT_FAIL,
    
    // SD card programming
    IAP_CMD_SETARGS,
    IAP_SETARGS_SUCCESS,
    IAP_SETARGS_FAIL,

    IAP_CMD_BUFFER,
    IAP_BUFFER_SUCCESS,
    IAP_BUFFER_FAIL,

    IAP_CMD_CLEAR,
    IAP_CLEAR_SUCCESS,
    IAP_CLEAR_FAIL,

    IAP_CMD_SAVE,
    IAP_SAVE_SUCCESS,
    IAP_SAVE_FAIL,

    IAP_CMD_REBOOT,
    IAP_REBOOT_SUCCESS,
    IAP_REBOOT_FAIL,
    
    IAP_MAX_COMMAND = 100,
} IAP_COMMANDS;

typedef struct
{
    uint16_t header;
    uint16_t version;
    uint32_t size;
    uint16_t tail; 
} Imageargs_t;

const char *argsname = "/tmp/ImageArgs";
const char *binname = "/tmp/stm32app.bin";

uint8_t txBuf[BUFFER_SIZE] = {0};
uint8_t rxBuf[BUFFER_SIZE] = {0};
uint8_t rdBuf[8] = {0};
uint16_t chksum = 0;

const char *SocketDomain="/tmp/uds-tmp";

static FILE *file = NULL;

static void GetHeader(uint8_t *buf, uint8_t cmd);
static void GetChecksum(uint8_t *buf);
static bool GetReply(uint8_t *buf);
static bool SingleComm(uint16_t cmd, int fd);
static void IAP_CONV_FROM_32(uint8_t *buf, uint32_t val);
static void Process(int fd);

//======================================================================//
// Import
//======================================================================//
static const char versionfn[] = "/tmp/version";

static uint32_t GetFileSize(char *filename)
{
    if (filename == NULL)
        return 0;

    struct stat st;
    stat(filename, &st);
    return (uint32_t)st.st_size;
}

static uint16_t GetVersion()
{
    char buf[10] = {0};
    uint16_t version = 0;
    if( access( versionfn, F_OK ) != -1 ) {
        FILE *file = fopen(versionfn, "r+");
        if (file == NULL) {
            printf("Fail to open file (%s)\n", versionfn);
            return 0;
        }
        fread(buf, 10, 1, file);
        version = atol(buf);
        version++;

        memset(buf, 0, 10);
        snprintf(buf, 10, "%d", version);
        fseek(file, 0, SEEK_SET);
        fwrite(buf, strlen(buf)+1, 1, file);
        fclose(file);
    } else {
        version = 1;
        FILE *file = fopen(versionfn, "w+");
        if (file == NULL) {
            printf("Fail to open file (%s)\n", versionfn);
            return 0;
        }
        memset(buf, 0, 10);
        snprintf(buf, 10, "%d", version);
        rewind(file);
        fwrite(buf, strlen(buf)+1, 1, file);
        fclose(file);
    }
    return version;
}

void GetImageArgs(Imageargs_t *iargs, char *filename)
{
    memset(iargs, 0, sizeof(Imageargs_t));
    iargs->header = IMAGEARGS_HEADER;
    iargs->tail = IMAGEARGS_TAIL;
    iargs->version = GetVersion();
    iargs->size = GetFileSize(filename);
}

static void Process(int fd)
{
    memset(rxBuf, 0xff, 20);
    memset(txBuf, 0xff, 20);
    memset(rdBuf, 0xff, 8);


    // make connection
    printf("Connect to app\n");
    if (!SingleComm(IAP_CMD_CONNECT, fd)) {
        return;
    }
    printf("Connection to app success\n");

    uint8_t filename[255];
    memset(filename, 0, 255);
    strcpy(filename, "/tmp/stm32app.bin");

    Imageargs_t iargs;
    GetImageArgs(&iargs, filename);

    uint32_t size = iargs.size;
    file = fopen(argsname, "r");
    if (file == NULL) {
        printf("Fail to open file (%s)\n", argsname);
        return;
    }

    // write data
    printf("Write Args to SD card\n");
    memcpy(&txBuf[3], &iargs, sizeof(Imageargs_t));
    if (!SingleComm(IAP_CMD_SETARGS, fd)) {
        fclose(file);
        return;
    }
    fclose(file);
    
    file = fopen(binname, "r");
    if (file == NULL) {
        printf("Fail to open file (%s)\n", binname);
        return;
    }

    uint32_t sdAddr = SDCARD_IMAGE_ADDR;
    while (size > 0) {
        for (int i=0;i<(SDCARD_PAGE_SIZE/8);++i) {
            memset(rdBuf, 0xff, 8);
            memset(txBuf, 0xff, 20);
                
            txBuf[3] = i;
            fread(rdBuf, sizeof(uint8_t), 8, file);
                
            memcpy(&txBuf[4], rdBuf, 8);
            if (!SingleComm(IAP_CMD_BUFFER, fd)) {
                fclose(file);
                return;
            }
        }

        memset(rdBuf, 0xff, 8);
        memset(txBuf, 0xff, 20);
        IAP_CONV_FROM_32(&txBuf[3], sdAddr);
        
        if (!SingleComm(IAP_CMD_SAVE, fd)) {
            fclose(file);
            return;
        }

        sdAddr += SDCARD_PAGE_SIZE;
        if (size < SDCARD_PAGE_SIZE) {
            size = 0;
        } else {
            size -= SDCARD_PAGE_SIZE;
        }
    }
    printf("Programm iap success\n"); 
    // reboot
    printf("Reboot the device\n");
    if (!SingleComm(IAP_CMD_REBOOT, fd)) {
        fclose(file);
        return;
    }
    fclose(file);
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

static bool SingleComm(uint16_t cmd, int fd)
{
    GetHeader(txBuf, cmd);
    GetChecksum(txBuf);

    for (int i = 0; i < 5; ++i) {
        //write (fd, txBuf, 20);
        send(fd,txBuf,BUFFER_SIZE,0);
        //read (fd, rxBuf, 20);
        int ret = recv(fd,rxBuf,BUFFER_SIZE,0);
        if(ret < 0){
            printf("recv failed\n");
            while(1);
        }
        if (GetReply(rxBuf)) {
            memset(txBuf, 0xff, 20);
            memset(rxBuf, 0xff, 20);
            return true;
        } else {
            printf("Send fail, try again (%d)\n", i);
        }
    }
    printf("Send fail for command (%d) detail (%d)\n", cmd, rxBuf[3]);
    return false;
}

static void IAP_CONV_FROM_32(uint8_t *buf, uint32_t val)
{
    buf[0] = (uint8_t)((val >> 24) & 0x000000ff);
    buf[1] = (uint8_t)((val >> 16) & 0x000000ff);
    buf[2] = (uint8_t)((val >> 8) & 0x000000ff);
    buf[3] = (uint8_t)(val & 0x000000ff);
}
//======================================================================//
// ~Import
//======================================================================//

int main()
{
    struct sockaddr_un un;
    int sock_fd;

    un.sun_family = AF_UNIX;
    strcpy(un.sun_path,SocketDomain);
    sock_fd = socket(AF_UNIX,SOCK_STREAM,0);
    if(sock_fd < 0){
        printf("Request socket failed\n");
        return -1;
    }
    if(connect(sock_fd,(struct sockaddr *)&un,sizeof(un)) < 0){
        printf("connect socket failed\n");
        return -1;
    }
    
    
    Process(sock_fd);

    close(sock_fd);
    return 0;
}
