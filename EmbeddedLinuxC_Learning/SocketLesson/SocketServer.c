#include<stdio.h>
#include<stdlib.h>
#include<stdint.h>
#include<string.h>
#include<sys/stat.h>
#include<sys/socket.h>
#include<sys/types.h>
#include<sys/un.h>
#include<errno.h>
#include<stddef.h>
#include<unistd.h>

#define FLASH_PAGE_SIZE          ( 0x800U )   // 2048B
#define EEPROM_PAGE_SIZE         ( 0x1000U )  // 4096B
#define SDCARD_PAGE_SIZE         ( 0x200U )   // 512B
#define DATA_BUF_SIZE            ( SDCARD_PAGE_SIZE )

#define SDCARD_ARGS_ADDR         ( 0 )
#define SDCARD_IMAGE_ADDR        ( SDCARD_PAGE_SIZE )

#define USART_MAX_LEN            ( 255 )
#define USART_PROTOCOL_LEN       ( 20 )

#define NUM_ROWS(ARRAY) (sizeof(ARRAY) / sizeof(ARRAY[0]))

const char *filename="/tmp/uds-tmp";

typedef enum
{
    IAP_ERROR = 0,                 // 0
    IAP_SUCCESS,                   // 1

    IAP_ERROR_HEAD_INVALID,        // 2
    IAP_ERROR_FRAME_INVALID,       // 3
    IAP_ERROR_CHKSUM_INVALID,      // 4
    
    // common
    IAP_CMD_CONNECT,               // 5
    IAP_CONNECT_SUCCESS,           // 6
    IAP_CONNECT_FAIL,              // 7
    
    // SD card programming
    IAP_CMD_SETARGS,               // 8
    IAP_SETARGS_SUCCESS,           // 9
    IAP_SETARGS_FAIL,              // 10

    IAP_CMD_BUFFER,                // 11
    IAP_BUFFER_SUCCESS,            // 12
    IAP_BUFFER_FAIL,               // 13

    IAP_CMD_CLEAR,                 // 14
    IAP_CLEAR_SUCCESS,             // 15
    IAP_CLEAR_FAIL,                // 16

    IAP_CMD_SAVE,                  // 17
    IAP_SAVE_SUCCESS,              // 18
    IAP_SAVE_FAIL,                 // 19

    IAP_CMD_REBOOT,                // 20
    IAP_REBOOT_SUCCESS,            // 21
    IAP_REBOOT_FAIL,               // 22
    
    IAP_MAX_COMMAND = 100,
} IAP_COMMANDS;

typedef struct
{
    uint16_t header;
    uint16_t version;
    uint32_t size;
    uint16_t tail; 
} Imageargs_t;

static void IAP_SetArgs(uint8_t* Buf, int fd);
static void IAP_Buffer(uint8_t* Buf, int fd);
static void IAP_Clear(uint8_t* Buf, int fd);
static void IAP_Save(uint8_t* Buf, int fd);
static void IAP_Reboot(uint8_t* Buf, int fd);

typedef void (*IAP_Func)(uint8_t *Buf, int fd);
typedef struct
{
    uint16_t cmd;
    uint16_t suc;
    uint16_t err;
    IAP_Func func;
} IAP_Command_t;
static const IAP_Command_t IAP_Command[] = {
    {IAP_CMD_CONNECT, IAP_CONNECT_SUCCESS, IAP_CONNECT_FAIL, NULL},
    {IAP_CMD_SETARGS, IAP_SETARGS_SUCCESS, IAP_SETARGS_FAIL, IAP_SetArgs},
    {IAP_CMD_BUFFER,  IAP_BUFFER_SUCCESS,  IAP_BUFFER_FAIL,  IAP_Buffer},
    {IAP_CMD_CLEAR,   IAP_CLEAR_SUCCESS,   IAP_CLEAR_FAIL,   IAP_Clear},
    {IAP_CMD_SAVE,    IAP_SAVE_SUCCESS,    IAP_SAVE_FAIL,    IAP_Save},
    {IAP_CMD_REBOOT,  IAP_REBOOT_SUCCESS,  IAP_REBOOT_FAIL,  IAP_Reboot},
};

uint8_t data[DATA_BUF_SIZE] = {0};
uint8_t txBuf[USART_PROTOCOL_LEN] = {0};
uint8_t rxBuf[USART_MAX_LEN] = {0};
uint8_t rxCnt = 0;

#define MAX_CONNECT_NUM 2
const char *SocketDomain="/tmp/uds-tmp";

const char *SdFileName = "/tmp/SdImage";
FILE *file = NULL;

//======================================================================//
// Private functions
//======================================================================//
static uint32_t IAP_CONV_TO_32(uint8_t *buf)
{
    uint32_t ret = 0;
    ret = (*buf) << 24;
    ret += *(buf+1) << 16;
    ret += *(buf+2) << 8;
    ret += *(buf+3);
    return ret;
}

static void IAP_SendReply(uint8_t replyType, uint8_t replyDetail, int fd)
{
    txBuf[0] = 0x33;
    txBuf[1] = 0x44;
    txBuf[2] = replyType;
    txBuf[3] = replyDetail;

    //USART_SendData(txBuf,USART_PROTOCOL_LEN);
    send(fd,txBuf,USART_PROTOCOL_LEN,0);
}

static uint8_t IAP_HeaderIsValid(uint8_t* Buf)
{
    if (Buf == NULL) return 0;

    if ((Buf[0] != 0x22) || (Buf[1] != 0x33)) {
        return 0;
    }

    return 1;
}

static uint8_t IAP_ChecksumIsValid(uint8_t* Buf)
{
    uint8_t i;
    uint16_t RxChksum = 0;
    uint16_t Checksum = 0;
    
    if (Buf == NULL) return 0;
    
    Checksum = Buf[16] * 256 + Buf[17];
    for (i=0;i<(USART_PROTOCOL_LEN-4);i++) {
        RxChksum += Buf[i];
    }
        
    if (Checksum == RxChksum) return 1;
    else return 0;
}

static void IAP_NorCommand(uint8_t *Buf, const IAP_Command_t *IapCmd, int fd)
{
    if (Buf == NULL) {
        IAP_SendReply(IAP_ERROR, IapCmd->err, fd);
        return;
    }
    
    if (Buf[0] != IapCmd->cmd) {
        return;
    }

    if (IapCmd->func != NULL) {
        IapCmd->func(&Buf[1], fd);
    } else {
        IAP_SendReply(IAP_SUCCESS, IapCmd->suc, fd);
    }
}

static void IAP_SetArgs(uint8_t* Buf, int fd)
{
    memset(data, 0xff, DATA_BUF_SIZE);
    memcpy(data, Buf, sizeof(Imageargs_t));

    fseek(file, SDCARD_ARGS_ADDR, SEEK_SET);
    fwrite(data, SDCARD_PAGE_SIZE, 1, file);
    //SD_WriteBlock((uint32_t *)data, SDCARD_ARGS_ADDR, SDCARD_PAGE_SIZE);
    IAP_SendReply(IAP_SUCCESS, IAP_SETARGS_SUCCESS, fd);
}

static void IAP_Buffer(uint8_t* Buf, int fd)
{
    uint16_t index = Buf[0];

    if (index == 0) {
        memset(data, 0xff, DATA_BUF_SIZE);
    }

    memcpy(&data[index*8], &Buf[1], 8);
    IAP_SendReply(IAP_SUCCESS, IAP_BUFFER_SUCCESS, fd);
}

static void IAP_Clear(uint8_t* Buf, int fd)
{
    IAP_SendReply(IAP_SUCCESS, IAP_CLEAR_SUCCESS, fd);
}

static void IAP_Save(uint8_t* Buf, int fd)
{
    uint32_t addr = IAP_CONV_TO_32(Buf);

    fseek(file, addr, SEEK_SET);
    fwrite(data, SDCARD_PAGE_SIZE, 1, file);
    //SD_WriteBlock((uint32_t *)data, addr, SDCARD_PAGE_SIZE);
    IAP_SendReply(IAP_SUCCESS, IAP_SAVE_SUCCESS, fd);
}

static void IAP_Reboot(uint8_t* Buf, int fd)
{
    IAP_SendReply(IAP_SUCCESS, IAP_REBOOT_SUCCESS, fd);
}

static void USART_DataProcess(uint8_t *Buf, int fd)
{
    uint16_t i;

    memset(txBuf, 0, USART_PROTOCOL_LEN);

    if (IAP_HeaderIsValid(Buf) == 0) {
        IAP_SendReply(IAP_ERROR, IAP_ERROR_HEAD_INVALID, fd);
        return;
    }
        
    if (IAP_ChecksumIsValid(Buf) == 0) {
        IAP_SendReply(IAP_ERROR, IAP_ERROR_CHKSUM_INVALID, fd);
        return;
    }

    for (i=0;i<NUM_ROWS(IAP_Command);++i) {
        IAP_NorCommand(&Buf[2], &IAP_Command[i], fd);
    }
}

//======================================================================//
// Public functions
//======================================================================//
int main()
{
    int fd,new_fd,i;
    struct sockaddr_un un;
    
    fd = socket(AF_UNIX,SOCK_STREAM,0);
    if(fd < 0){
        printf("Request socket failed!\n");
        return -1;
    }
    
    un.sun_family = AF_UNIX;
    unlink(SocketDomain);
    strcpy(un.sun_path,SocketDomain);
    if(bind(fd,(struct sockaddr *)&un,sizeof(un)) <0 ){
        printf("bind failed!\n");
        return -1;
    }
    if(listen(fd,MAX_CONNECT_NUM) < 0){
        printf("listen failed!\n");
        return -1;
    }
    
    new_fd = accept(fd,NULL,NULL);
    if(new_fd < 0){
        printf("accept failed\n");
        return -1;
    }
    
    file = fopen(SdFileName, "r+");
    if (file == NULL) {
        printf("Fail to open file (%s)\n", SdFileName);
        return -1;
    }
    
    while(1){
        char buffer[USART_PROTOCOL_LEN];
        memset(buffer, 0xff, USART_PROTOCOL_LEN);
        printf("Waiting for data\n");
        int ret = recv(new_fd,buffer,USART_PROTOCOL_LEN,0);
        if(ret < 0){
            printf("recv failed\n");
            continue;
        }
        printf("Got data\n");
        for (int i=0;i<USART_PROTOCOL_LEN;i++) {
            printf("%02x ", buffer[i]);
        }
        printf("\n");
        USART_DataProcess(buffer, new_fd);
    }
    fclose(file);
    close(new_fd);
    close(fd);
}

