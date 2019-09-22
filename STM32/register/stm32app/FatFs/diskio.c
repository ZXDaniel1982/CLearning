/*-----------------------------------------------------------------------*/
/* Low level disk I/O module skeleton for FatFs     (C)ChaN, 2016        */
/*-----------------------------------------------------------------------*/
/* If a working storage control module is available, it should be        */
/* attached to the FatFs via a glue function rather than modifying it.   */
/* This is an example of glue functions to attach various exsisting      */
/* storage control modules to the FatFs module with a defined API.       */
/*-----------------------------------------------------------------------*/

#include "ff.h"         /* Obtains integer types */
#include "diskio.h"     /* Declarations of disk functions */

#include "common.h"         /* Obtains integer types */
#include "sdio.h"         /* Obtains integer types */

#define SECTOR_SIZE 512U

/* Definitions of physical drive number for each drive */
#define DEV_MMC     0   /* Example: Map MMC/SD card to physical drive 1 */

/*-----------------------------------------------------------------------*/
/* Get Drive Status                                                      */
/*-----------------------------------------------------------------------*/

DSTATUS disk_status (
    BYTE pdrv       /* Physical drive nmuber to identify the drive */
)
{
    DSTATUS stat;
    int result;

    switch (pdrv) {
    case DEV_MMC :
        UNUSED(result);
        // result = MMC_disk_status();

        // translate the reslut code here

        return stat;
    }
    return STA_NOINIT;
}



/*-----------------------------------------------------------------------*/
/* Inidialize a Drive                                                    */
/*-----------------------------------------------------------------------*/

DSTATUS disk_initialize (
    BYTE pdrv               /* Physical drive nmuber to identify the drive */
)
{
    DSTATUS stat;
    int result;

    switch (pdrv) {
    case DEV_MMC :
        UNUSED(result);
        // result = MMC_disk_initialize();

        // translate the reslut code here

        return stat;
    }
    return STA_NOINIT;
}



/*-----------------------------------------------------------------------*/
/* Read Sector(s)                                                        */
/*-----------------------------------------------------------------------*/

DRESULT disk_read (
    BYTE pdrv,      /* Physical drive nmuber to identify the drive */
    BYTE *buff,     /* Data buffer to store read data */
    DWORD sector,   /* Start sector in LBA */
    UINT count      /* Number of sectors to read */
)
{
    DRESULT res;

    switch (pdrv) {
    case DEV_MMC :
        // translate the arguments here
        if (count == 1) {
            if (SD_ReadBlock((uint32_t *)(&buff[0]), sector << 9, SECTOR_SIZE) == SD_OK) {
                res = RES_OK;
            } else {
                res = RES_ERROR;
            }
        } else {
            if (SD_ReadMultiBlocks((uint8_t *)(&buff[0]), sector << 9, SECTOR_SIZE, count) == SD_OK) {
                res = RES_OK;
            } else {
                res = RES_ERROR;
            }
        }

        // result = MMC_disk_read(buff, sector, count);

        // translate the reslut code here

        return res;
    }

    return RES_PARERR;
}



/*-----------------------------------------------------------------------*/
/* Write Sector(s)                                                       */
/*-----------------------------------------------------------------------*/

#if FF_FS_READONLY == 0

DRESULT disk_write (
    BYTE pdrv,          /* Physical drive nmuber to identify the drive */
    const BYTE *buff,   /* Data to be written */
    DWORD sector,       /* Start sector in LBA */
    UINT count          /* Number of sectors to write */
)
{
    DRESULT res;

    switch (pdrv) {
    case DEV_MMC :
        // translate the arguments here
        if (count == 1) {
            if (SD_WriteBlock((uint32_t *)(&buff[0]), sector << 9, SECTOR_SIZE) == SD_OK) {
                res = RES_OK;
            } else {
                res = RES_ERROR;
            }
        } else {
            if (SD_WriteMultiBlocks((uint8_t *)(&buff[0]), sector << 9, SECTOR_SIZE, count)) {
                res = RES_OK;
            } else {
                res = RES_ERROR;
            }
        }

        // result = MMC_disk_write(buff, sector, count);

        // translate the reslut code here

        return res;
    }

    return RES_PARERR;
}

#endif


/*-----------------------------------------------------------------------*/
/* Miscellaneous Functions                                               */
/*-----------------------------------------------------------------------*/

DRESULT disk_ioctl (
    BYTE pdrv,      /* Physical drive nmuber (0..) */
    BYTE cmd,       /* Control code */
    void *buff      /* Buffer to send/receive control data */
)
{
    DRESULT res;
    int result;
    UNUSED(result);

    switch (pdrv) {
    case DEV_MMC :

        // Process of the command for the MMC/SD card
        switch (cmd) {
        /* Make sure that no pending write process */
        case CTRL_SYNC :
            res = RES_OK;
            break;

        /* Get number of sectors on the disk (DWORD) */
        case GET_SECTOR_COUNT :
            //BSP_SD_GetCardInfo(&CardInfo);
            //*(DWORD*)buff = CardInfo.LogBlockNbr;
            res = RES_OK;
            break;

        /* Get R/W sector size (WORD) */
        case GET_SECTOR_SIZE :
            //BSP_SD_GetCardInfo(&CardInfo);
            //*(WORD*)buff = CardInfo.LogBlockSize;
            res = RES_OK;
            break;

        /* Get erase block size in unit of sector (DWORD) */
        case GET_BLOCK_SIZE :
            //BSP_SD_GetCardInfo(&CardInfo);
            //*(DWORD*)buff = CardInfo.LogBlockSize;
            res = RES_OK;
            break;

        default:
            res = RES_PARERR;
        }

        return res;
    }

    return RES_PARERR;
}

DWORD get_fattime (void)
{
  return 0;
}
