#include "stm32f1xx.h"
#include "stm32f103xe.h"
#include "common.h"

#define SDIO_CMDTIMEOUT                            (5000U) 
#define SDIO_RESP1                                 ((uint32_t)0x00000000)
#define SDIO_RESP2                                 ((uint32_t)0x00000004)
#define SDIO_RESP3                                 ((uint32_t)0x00000008)
#define SDIO_RESP4                                 ((uint32_t)0x0000000C)
#define SD_CMD_GO_IDLE_STATE                       ((uint8_t)0)
#define SD_CMD_ALL_SEND_CID                        ((uint8_t)2)
#define SD_CMD_SET_REL_ADDR                        ((uint8_t)3) /*!< SDIO_SEND_REL_ADDR for SD Card */
#define SD_CMD_SEL_DESEL_CARD                      ((uint8_t)7)
#define SD_CMD_SEND_CSD                            ((uint8_t)9)
#define SD_CMD_SET_BLOCKLEN                        ((uint8_t)16)
#define SD_CMD_SD_APP_OP_COND                      ((uint8_t)41) /*!< For SD Card only */
#define SD_CMD_SD_APP_SEND_SCR                     ((uint8_t)51) /*!< For SD Card only */
#define SD_CMD_APP_CMD                             ((uint8_t)55)
#define SD_CHECK_PATTERN                           ((uint32_t)0x000001AA)
#define SDIO_SEND_IF_COND                          ((uint32_t)0x00000008)
#define SD_OCR_ERRORBITS                           ((uint32_t)0xFDFFE008)
#define SD_VOLTAGE_WINDOW_SD                       ((uint32_t)0x80100000)
#define SD_HIGH_CAPACITY                           ((uint32_t)0x40000000)
#define SD_R6_GENERAL_UNKNOWN_ERROR                ((uint32_t)0x00002000)
#define SD_R6_ILLEGAL_CMD                          ((uint32_t)0x00004000)
#define SD_R6_COM_CRC_FAILED                       ((uint32_t)0x00008000)
#define SD_CARD_LOCKED                             ((uint32_t)0x02000000)
#define SD_DATATIMEOUT                             ((uint32_t)0x000FFFFF)

static uint32_t CSD_Tab[4], CID_Tab[4], RCA = 0;

static const GPIO_PINS_t GPIO_PINS_L[] = {
    // sdio
    {GPIOD, GPIO_BSRR_BS2, (GPIO_CRL_CNF2 | GPIO_CRL_MODE2), (GPIO_CRL_CNF2_1 | GPIO_CRL_MODE2)},
};
static const GPIO_PINS_t GPIO_PINS_H[] = {
    // sdio
    {GPIOC, GPIO_BSRR_BS8, (GPIO_CRH_CNF8 | GPIO_CRH_MODE8), (GPIO_CRH_CNF8_1 | GPIO_CRH_MODE8)},
    {GPIOC, GPIO_BSRR_BS9, (GPIO_CRH_CNF9 | GPIO_CRH_MODE9), (GPIO_CRH_CNF9_1 | GPIO_CRH_MODE9)},
    {GPIOC, GPIO_BSRR_BS10, (GPIO_CRH_CNF10 | GPIO_CRH_MODE10), (GPIO_CRH_CNF10_1 | GPIO_CRH_MODE10)},
    {GPIOC, GPIO_BSRR_BS11, (GPIO_CRH_CNF11 | GPIO_CRH_MODE11), (GPIO_CRH_CNF11_1 | GPIO_CRH_MODE11)},
    {GPIOC, GPIO_BSRR_BS12, (GPIO_CRH_CNF12 | GPIO_CRH_MODE12), (GPIO_CRH_CNF12_1 | GPIO_CRH_MODE12)},
};

static uint32_t SDIO_GetResponse(uint32_t Response)
{
    __IO uint32_t tmp = 0U;

    /* Get the response */
    tmp = (uint32_t)&(SDIO->RESP1) + Response;

    return (*(__IO uint32_t *) tmp);
}

static void SDIO_SendCommand(uint32_t arg, uint32_t index, uint32_t resp, uint32_t wait, uint32_t cpsm)
{
  uint32_t tmpreg = 0;
  
/*---------------------------- SDIO ARG Configuration ------------------------*/
  /* Set the SDIO Argument value */
  SDIO->ARG = arg;
  
/*---------------------------- SDIO CMD Configuration ------------------------*/  
  /* Get the SDIO CMD value */
  tmpreg = SDIO->CMD;
  /* Clear CMDINDEX, WAITRESP, WAITINT, WAITPEND, CPSMEN bits */
  tmpreg &= (SDIO_CMD_CMDINDEX | SDIO_CMD_WAITRESP | SDIO_CMD_WAITINT |
            SDIO_CMD_WAITPEND | SDIO_CMD_CPSMEN| SDIO_CMD_SDIOSUSPEND);
  /* Set CMDINDEX bits according to SDIO_CmdIndex value */
  /* Set WAITRESP bits according to SDIO_Response value */
  /* Set WAITINT and WAITPEND bits according to SDIO_Wait value */
  /* Set CPSMEN bits according to SDIO_CPSM value */
  tmpreg |= (uint32_t)index | resp | wait | cpsm;
  
  /* Write to SDIO CMD */
  SDIO->CMD = tmpreg;
}

static uint32_t CmdError(void)
{
    register uint32_t count = SDIO_CMDTIMEOUT * (SystemCoreClock / 8U /1000U);

    do {
        if (count-- == 0U) {
            return 0x80000000U;
        }
    } while (!(SDIO->STA & SDIO_STA_CMDSENT));

    /* Clear all the static flags */
    SDIO->ICR = (SDIO_STA_CCRCFAIL | SDIO_STA_DCRCFAIL | SDIO_STA_CTIMEOUT | SDIO_STA_DTIMEOUT |
                SDIO_STA_TXUNDERR | SDIO_STA_RXOVERR | SDIO_STA_CMDREND | SDIO_STA_CMDSENT |
                SDIO_STA_DATAEND | SDIO_STA_DBCKEND);
  
    return 0x00000000U;
}

static uint32_t CmdResp7Error(void)
{
    register uint32_t count = SDIO_CMDTIMEOUT * (SystemCoreClock / 8U /1000U);

    do {
        if (count-- == 0U) {
          return 0x80000000U;
        }
    } while (!(SDIO->STA & (SDIO_STA_CCRCFAIL | SDIO_STA_CMDSENT | SDIO_STA_CTIMEOUT)));

    if(SDIO->STA & SDIO_STA_CTIMEOUT) {
        /* Card is SD V2.0 compliant */
        SDIO->ICR = SDIO_STA_CTIMEOUT;
        
        return 0x00000004U;
    }
  
    if(SDIO->STA & SDIO_STA_CMDSENT) {
        /* Card is SD V2.0 compliant */
        SDIO->ICR = SDIO_STA_CMDSENT;
    }
  
    return 0x00000000U;
}

static uint32_t CmdResp1Error(uint8_t cmd)
{
    uint32_t response_r1;
    register uint32_t count = SDIO_CMDTIMEOUT * (SystemCoreClock / 8U /1000U);

    do {
        if (count-- == 0U) {
          return 0x80000000U;
        }
    } while (!(SDIO->STA & (SDIO_STA_CCRCFAIL | SDIO_STA_CMDREND | SDIO_STA_CTIMEOUT)));

    if(SDIO->STA & SDIO_STA_CTIMEOUT) {
        SDIO->ICR = SDIO_STA_CTIMEOUT;
        return 0x00000004U;
    } else if(SDIO->STA, SDIO_STA_CCRCFAIL) {
        SDIO->ICR = SDIO_STA_CCRCFAIL;
        return 0x00000001U;
    }

    /* Check response received is of desired command */
    if((uint8_t)(SDIO->RESPCMD) != cmd) {
        return 0x00000001U;
    }

    /* Clear all the static flags */
    SDIO->ICR = (SDIO_STA_CCRCFAIL | SDIO_STA_DCRCFAIL | SDIO_STA_CTIMEOUT | SDIO_STA_DTIMEOUT |
                SDIO_STA_TXUNDERR | SDIO_STA_RXOVERR | SDIO_STA_CMDREND | SDIO_STA_CMDSENT |
                SDIO_STA_DATAEND | SDIO_STA_DBCKEND);

    /*!< We have received response, retrieve it for analysis  */
    response_r1 = SDIO_GetResponse(SDIO_RESP1);

    if ((response_r1 & SD_OCR_ERRORBITS) == 0U) {
        return(0x00000000U);
    } else {
        return(0x00000001U);
    }
}

static uint32_t CmdResp3Error(void)
{
    register uint32_t count = SDIO_CMDTIMEOUT * (SystemCoreClock / 8U /1000U);

    do {
        if (count-- == 0U) {
            return 0x80000000U;
        }
    } while (!(SDIO->STA & (SDIO_STA_CCRCFAIL | SDIO_STA_CMDREND | SDIO_STA_CTIMEOUT)));

    if(SDIO->STA & SDIO_STA_CTIMEOUT) {
        SDIO->ICR = SDIO_STA_CTIMEOUT;
        return 0x00000004U;
    } else {  
        /* Clear all the static flags */
        SDIO->ICR = (SDIO_STA_CCRCFAIL | SDIO_STA_DCRCFAIL | SDIO_STA_CTIMEOUT | SDIO_STA_DTIMEOUT |
                SDIO_STA_TXUNDERR | SDIO_STA_RXOVERR | SDIO_STA_CMDREND | SDIO_STA_CMDSENT |
                SDIO_STA_DATAEND | SDIO_STA_DBCKEND);
    }
  
    return 0x00000000U;
}

static uint32_t CmdResp2Error(void)
{
    register uint32_t count = SDIO_CMDTIMEOUT * (SystemCoreClock / 8U /1000U);

    do {
        if (count-- == 0U) {
            return 0x80000000U;
        }
    } while (!(SDIO->STA & (SDIO_STA_CCRCFAIL | SDIO_STA_CMDREND | SDIO_STA_CTIMEOUT)));

    if (SDIO->STA & SDIO_STA_CTIMEOUT) {
        SDIO->ICR = SDIO_STA_CTIMEOUT;
        return 0x00000004U;
    } else if (SDIO->STA & SDIO_STA_CCRCFAIL) {
        SDIO->ICR = SDIO_STA_CCRCFAIL;
        return 0x00000001U;
    } else {
        /* No error flag set */
        /* Clear all the static flags */
        SDIO->ICR = (SDIO_STA_CCRCFAIL | SDIO_STA_DCRCFAIL | SDIO_STA_CTIMEOUT | SDIO_STA_DTIMEOUT |
                SDIO_STA_TXUNDERR | SDIO_STA_RXOVERR | SDIO_STA_CMDREND | SDIO_STA_CMDSENT |
                SDIO_STA_DATAEND | SDIO_STA_DBCKEND);
    }

    return 0x00000000U;
}

static uint32_t CmdResp6Error(uint8_t cmd, uint16_t *prca)
{
    uint32_t response_r1;
    register uint32_t count = SDIO_CMDTIMEOUT * (SystemCoreClock / 8U /1000U);

    do {
        if (count-- == 0U) {
            return 0x80000000U;
        }
    } while (!(SDIO->STA & (SDIO_STA_CCRCFAIL | SDIO_STA_CMDREND | SDIO_STA_CTIMEOUT)));

    if (SDIO->STA & SDIO_STA_CTIMEOUT) {
        SDIO->ICR = SDIO_STA_CTIMEOUT;
        return 0x00000004U;
    } else if (SDIO->STA & SDIO_STA_CCRCFAIL) {
        SDIO->ICR = SDIO_STA_CCRCFAIL;
        return 0x00000001U;
    }

    /* Check response received is of desired command */
    if((uint8_t)(SDIO->RESPCMD) != cmd) {
        return 0x00000001U;
    }

    /* Clear all the static flags */
    SDIO->ICR = (SDIO_STA_CCRCFAIL | SDIO_STA_DCRCFAIL | SDIO_STA_CTIMEOUT | SDIO_STA_DTIMEOUT |
            SDIO_STA_TXUNDERR | SDIO_STA_RXOVERR | SDIO_STA_CMDREND | SDIO_STA_CMDSENT |
            SDIO_STA_DATAEND | SDIO_STA_DBCKEND);

    /*!< We have received response, retrieve it.  */
    response_r1 = SDIO_GetResponse(SDIO_RESP1);

    if((response_r1 & (SD_R6_GENERAL_UNKNOWN_ERROR | SD_R6_ILLEGAL_CMD | SD_R6_COM_CRC_FAILED)) == 0U) {
        *prca = (uint16_t) (response_r1 >> 16);
        return 0x00000000U;
    } else if((response_r1 & SD_R6_ILLEGAL_CMD) == SD_R6_ILLEGAL_CMD) {
        return 0x00002000U;
    } else if((response_r1 & SD_R6_COM_CRC_FAILED) == SD_R6_COM_CRC_FAILED) {
        return 0x00001000U;
    } else {
        return 0x00010000U;
    }
}

void SDIO_Init()
{
    uint32_t i;
    uint16_t rca = 0x01;
    //uint32_t scr[2] = {0, 0};

    SET_BIT(RCC->APB2ENR, RCC_APB2ENR_IOPCEN);
    SET_BIT(RCC->APB2ENR, RCC_APB2ENR_IOPDEN);
    SET_BIT(RCC->AHBENR, RCC_AHBENR_SDIOEN);

    for (i=0;i<NUM_ROWS(GPIO_PINS_L);++i) {
        GPIOxL_Init(GPIO_PINS_L[i].port, GPIO_PINS_L[i].pin, GPIO_PINS_L[i].clear, GPIO_PINS_L[i].set);
    }
    for (i=0;i<NUM_ROWS(GPIO_PINS_H);++i) {
        GPIOxH_Init(GPIO_PINS_H[i].port, GPIO_PINS_H[i].pin, GPIO_PINS_H[i].clear, GPIO_PINS_H[i].set);
    }

    SET_BIT(RCC->AHBENR, RCC_AHBENR_DMA2EN);

    SDIO->POWER = 0x00000000;
    SDIO->CLKCR = 0x00000000;
    SDIO->ARG = 0x00000000;
    SDIO->CMD = 0x00000000;
    SDIO->DTIMER = 0x00000000;
    SDIO->DLEN = 0x00000000;
    SDIO->DCTRL = 0x00000000;
    SDIO->ICR = 0x00C007FF;
    SDIO->MASK = 0x00000000;

    MODIFY_REG(SDIO->CLKCR, (SDIO_CLKCR_CLKDIV | SDIO_CLKCR_PWRSAV | SDIO_CLKCR_BYPASS |
                SDIO_CLKCR_WIDBUS | SDIO_CLKCR_NEGEDGE | SDIO_CLKCR_HWFC_EN), (uint32_t)0xC3);

    CLEAR_BIT(SDIO->CLKCR, SDIO_CLKCR_CLKEN);

    MODIFY_REG(SDIO->POWER, SDIO_POWER_PWRCTRL, SDIO_POWER_PWRCTRL);

    SET_BIT(SDIO->CLKCR, SDIO_CLKCR_CLKEN);
    for (i=0;i<72000;++i) {}

    /*!< CMD0: GO_IDLE_STATE ---------------------------------------------------*/
    SDIO_SendCommand(0U, SD_CMD_GO_IDLE_STATE, 0, 0, SDIO_CMD_CPSMEN);
    if (CmdError() != 0x00000000U) {
        tftprintf("SD fail goto idle");
    }

    /*!< CMD8: SEND_IF_COND ----------------------------------------------------*/
    SDIO_SendCommand(SD_CHECK_PATTERN, SDIO_SEND_IF_COND, SDIO_CMD_WAITRESP_0, 0, SDIO_CMD_CPSMEN);
    if (CmdResp7Error() != 0x00000000U) {
        tftprintf("SD CMD8 fail, V1.x not support");
    } else {
        //CardType = SDIO_STD_CAPACITY_SD_CARD_V2_0;
        //SDType = SD_HIGH_CAPACITY;
    }

    uint32_t validvoltage = 0U, response = 0;
    while(validvoltage == 0U) {
        /* SEND CMD55 APP_CMD with RCA as 0 */
        SDIO_SendCommand(0U, SD_CMD_APP_CMD, SDIO_CMD_WAITRESP_0, 0, SDIO_CMD_CPSMEN);
        if (CmdResp1Error(SD_CMD_APP_CMD) != 0x00000000U) {
            tftprintf("Send CMD55 fail");
            return;
        }

        /*!< Send ACMD41 SD_APP_OP_COND with Argument 0x80100000 */
        SDIO_SendCommand(SD_VOLTAGE_WINDOW_SD | SD_HIGH_CAPACITY, SD_CMD_SD_APP_OP_COND, SDIO_CMD_WAITRESP_0, 0, SDIO_CMD_CPSMEN);
        if (CmdResp3Error() != 0x00000000U) {
            tftprintf("Send ACMD41 fail");
            return;
        }

        response = SDIO_GetResponse(SDIO_RESP1);
        validvoltage = (((response >> 31) == 1) ? 1 : 0);
    }

    if((response & SD_HIGH_CAPACITY) == SD_HIGH_CAPACITY) {
        //hsd->SdCard.CardType = CARD_SDHC_SDXC;
    } else {
        //hsd->SdCard.CardType = CARD_SDSC;
    }

    if ((SDIO->POWER & SDIO_POWER_PWRCTRL) == 0U) {
        tftprintf("SD card powered off");
        return;
    }

    /*!< Send CMD2 ALL_SEND_CID */
    SDIO_SendCommand(0U, SD_CMD_ALL_SEND_CID, SDIO_CMD_WAITRESP, 0, SDIO_CMD_CPSMEN);
    if (CmdResp2Error() != 0x00000000U) {
        tftprintf("Send CMD2 fail");
        return;
    }
    CID_Tab[0] = SDIO_GetResponse(SDIO_RESP1);
    CID_Tab[1] = SDIO_GetResponse(SDIO_RESP2);
    CID_Tab[2] = SDIO_GetResponse(SDIO_RESP3);
    CID_Tab[3] = SDIO_GetResponse(SDIO_RESP4);

    /*!< Send CMD3 SET_REL_ADDR with argument 0 */
    SDIO_SendCommand(0U, SD_CMD_SET_REL_ADDR, SDIO_CMD_WAITRESP_0, 0, SDIO_CMD_CPSMEN);
    if (CmdResp6Error(SD_CMD_SET_REL_ADDR, &rca) != 0x00000000U) {
        tftprintf("Send CMD3 fail");
        return;
    }

    RCA = rca;

    /*!< Send CMD9 SEND_CSD with argument as card's RCA */
    SDIO_SendCommand((uint32_t)(RCA << 16), SD_CMD_SEND_CSD, SDIO_CMD_WAITRESP, 0, SDIO_CMD_CPSMEN);
    if (CmdResp2Error() != 0x00000000U) {
        tftprintf("Send CMD9 fail");
        return;
    }

    CSD_Tab[0] = SDIO_GetResponse(SDIO_RESP1);
    CSD_Tab[1] = SDIO_GetResponse(SDIO_RESP2);
    CSD_Tab[2] = SDIO_GetResponse(SDIO_RESP3);
    CSD_Tab[3] = SDIO_GetResponse(SDIO_RESP4);

    MODIFY_REG(SDIO->CLKCR, (SDIO_CLKCR_CLKDIV | SDIO_CLKCR_PWRSAV | SDIO_CLKCR_BYPASS |
                SDIO_CLKCR_WIDBUS | SDIO_CLKCR_NEGEDGE | SDIO_CLKCR_HWFC_EN), (uint32_t)0x1);

    /*!< Send CMD7 SDIO_SEL_DESEL_CARD */
    SDIO_SendCommand((uint32_t)(RCA << 16), SD_CMD_SEL_DESEL_CARD, SDIO_CMD_WAITRESP_0, 0, SDIO_CMD_CPSMEN);
    if (CmdResp1Error(SD_CMD_SEL_DESEL_CARD) != 0x00000000U) {
        tftprintf("Send CMD7 fail");
    }

    if((SDIO_GetResponse(SDIO_RESP1) & SD_CARD_LOCKED) == SD_CARD_LOCKED) {
        tftprintf("SD card is locked");
        return;
    }

    /*!< Set Block Size To 8 Bytes */
    /*!< Send CMD55 APP_CMD with argument as card's RCA */
    SDIO_SendCommand((uint32_t)8, SD_CMD_SET_BLOCKLEN, SDIO_CMD_WAITRESP_0, 0, SDIO_CMD_CPSMEN);
    if (CmdResp1Error(SD_CMD_SET_BLOCKLEN) != 0x00000000U) {
        tftprintf("Send CMD55 fail : SD_CMD_SET_BLOCKLEN");
        return;
    }

    SDIO_SendCommand((uint32_t) (RCA << 16), SD_CMD_APP_CMD, SDIO_CMD_WAITRESP_0, 0, SDIO_CMD_CPSMEN);
    if (CmdResp1Error(SD_CMD_APP_CMD) != 0x00000000U) {
        tftprintf("Send CMD55 fail : SD_CMD_APP_CMD");
        return;
    }

    SDIO->DTIMER = SD_DATATIMEOUT;
    SDIO->DLEN = 8;
    MODIFY_REG(SDIO->DCTRL, (SDIO_DCTRL_DTEN | SDIO_DCTRL_DTDIR | SDIO_DCTRL_DTMODE | SDIO_DCTRL_DBLOCKSIZE),
                (SDIO_DCTRL_DBLOCKSIZE_0 | SDIO_DCTRL_DBLOCKSIZE_1 | SDIO_DCTRL_DTDIR | SDIO_DCTRL_DTEN));

    /*!< Send ACMD51 SD_APP_SEND_SCR with argument as 0 */
    SDIO_SendCommand(0U, SD_CMD_SD_APP_SEND_SCR, SDIO_CMD_WAITRESP_0, 0, SDIO_CMD_CPSMEN);
    if (CmdResp1Error(SD_CMD_SD_APP_SEND_SCR) != 0x00000000U) {
        tftprintf("Send CMD55 fail : SD_CMD_SD_APP_SEND_SCR");
        return;
    }
}
