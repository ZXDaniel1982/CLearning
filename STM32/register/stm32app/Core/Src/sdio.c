#include "stm32f1xx.h"
#include "stm32f103xe.h"
#include "common.h"
#include "sdio.h"

static uint32_t CSD_Tab[4], CID_Tab[4], RCA = 0, Class = 0, CardType = 0;
static uint32_t LogBlockNbr = 0;

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

static void SDIO_DeInit(void)
{
    SDIO->POWER = 0x00000000;
    SDIO->CLKCR = 0x00000000;
    SDIO->ARG = 0x00000000;
    SDIO->CMD = 0x00000000;
    SDIO->DTIMER = 0x00000000;
    SDIO->DLEN = 0x00000000;
    SDIO->DCTRL = 0x00000000;
    SDIO->ICR = 0x00C007FF;
    SDIO->MASK = 0x00000000;
}

static void SDIO_Perip_Init(uint32_t ClockEdge, uint32_t ClockBypass, uint32_t ClockPowerSave,
                            uint32_t BusWide, uint32_t HardwareFlowControl, uint32_t ClockDiv)
{
    uint32_t tmpreg = 0U;

    /* Set SDMMC configuration parameters */
    tmpreg |= (ClockEdge | ClockBypass | ClockPowerSave | BusWide | HardwareFlowControl | ClockDiv); 
  
    /* Write to SDMMC CLKCR */
    MODIFY_REG(SDIO->CLKCR, CLKCR_CLEAR_MASK, tmpreg); 
}

static uint8_t SDIO_GetCommandResponse()
{
    return (uint8_t)(SDIO->RESPCMD);
}

uint32_t SDIO_GetPowerState()  
{
    return (SDIO->POWER & SDIO_POWER_PWRCTRL);
}

static uint32_t SDIO_GetResponse(uint32_t Response)
{
    __IO uint32_t tmp = 0U;

    /* Get the response */
    tmp = (uint32_t)&(SDIO->RESP1) + Response;
  
    return (*(__IO uint32_t *) tmp);
}  

static void SDIO_SendCommand(uint32_t Argument, uint32_t CmdIndex, uint32_t Response,
                                            uint32_t WaitForInterrupt, uint32_t CPSM)
{
    uint32_t tmpreg = 0U;

    /* Set the SDMMC Argument value */
    SDIO->ARG = Argument;

    /* Set SDMMC command parameters */
    tmpreg |= (uint32_t)(CmdIndex | Response | WaitForInterrupt | CPSM);
  
    /* Write to SDMMC CMD register */
    MODIFY_REG(SDIO->CMD, CMD_CLEAR_MASK, tmpreg); 
}

static uint32_t SDMMC_GetCmdError()
{
    /* 8 is the number of required instructions cycles for the below loop statement.
    The SDMMC_CMDTIMEOUT is expressed in ms */
    register uint32_t count = SDIO_CMDTIMEOUT * (SystemCoreClock / 8U /1000U);
  
    do {
        if (count-- == 0U) {
            return SDMMC_ERROR_TIMEOUT;
        }
    } while (!__SDIO_GET_FLAG(SDIO, SDIO_STA_CMDSENT));
  
    /* Clear all the static flags */
    __SDIO_CLEAR_FLAG(SDIO, SDIO_STATIC_FLAGS);
  
    return SDMMC_ERROR_NONE;
}

static uint32_t SDMMC_GetCmdResp1(uint8_t SD_CMD, uint32_t Timeout)
{
    uint32_t response_r1;
  
    /* 8 is the number of required instructions cycles for the below loop statement.
    The Timeout is expressed in ms */
    register uint32_t count = Timeout * (SystemCoreClock / 8U /1000U);
  
    do {
        if (count-- == 0U)
        {
            return SDMMC_ERROR_TIMEOUT;
        }
    } while (!__SDIO_GET_FLAG(SDIO, SDIO_STA_CCRCFAIL | SDIO_STA_CMDREND | SDIO_STA_CTIMEOUT));
  
    if(__SDIO_GET_FLAG(SDIO, SDIO_STA_CTIMEOUT)) {
        __SDIO_CLEAR_FLAG(SDIO, SDIO_STA_CTIMEOUT);
        return SDMMC_ERROR_CMD_RSP_TIMEOUT;
    } else if(__SDIO_GET_FLAG(SDIO, SDIO_STA_CCRCFAIL)) {
        __SDIO_CLEAR_FLAG(SDIO, SDIO_STA_CCRCFAIL);
        return SDMMC_ERROR_CMD_CRC_FAIL;
    }
  
    /* Check response received is of desired command */
    if(SDIO_GetCommandResponse() != SD_CMD) {
        return SDMMC_ERROR_CMD_CRC_FAIL;
    }
  
    /* Clear all the static flags */
    __SDIO_CLEAR_FLAG(SDIO, SDIO_STATIC_FLAGS);
  
    /* We have received response, retrieve it for analysis  */
    response_r1 = SDIO_GetResponse(SDIO_RESP1);
  
    if((response_r1 & SDMMC_OCR_ERRORBITS) == SDMMC_ALLZERO) {
        return SDMMC_ERROR_NONE;
    } else {
        return SDMMC_ERROR_GENERAL_UNKNOWN_ERR;
    }
}

static uint32_t SDMMC_GetCmdResp2()
{
    /* 8 is the number of required instructions cycles for the below loop statement.
    The SDMMC_CMDTIMEOUT is expressed in ms */
    register uint32_t count = SDIO_CMDTIMEOUT * (SystemCoreClock / 8U /1000U);
  
    do {
        if (count-- == 0U) {
            return SDMMC_ERROR_TIMEOUT;
        }
    } while (!__SDIO_GET_FLAG(SDIO, SDIO_FLAG_CCRCFAIL | SDIO_FLAG_CMDREND | SDIO_FLAG_CTIMEOUT));
    
    if (__SDIO_GET_FLAG(SDIO, SDIO_FLAG_CTIMEOUT)) {
        __SDIO_CLEAR_FLAG(SDIO, SDIO_FLAG_CTIMEOUT);
        return SDMMC_ERROR_CMD_RSP_TIMEOUT;
    } else if (__SDIO_GET_FLAG(SDIO, SDIO_FLAG_CCRCFAIL)) {
        __SDIO_CLEAR_FLAG(SDIO, SDIO_FLAG_CCRCFAIL);
        return SDMMC_ERROR_CMD_CRC_FAIL;
    } else {
        /* No error flag set */
        /* Clear all the static flags */
        __SDIO_CLEAR_FLAG(SDIO, SDIO_STATIC_FLAGS);
    }

    return SDMMC_ERROR_NONE;
}

static uint32_t SDMMC_GetCmdResp3()
{
    /* 8 is the number of required instructions cycles for the below loop statement.
    The SDMMC_CMDTIMEOUT is expressed in ms */
    register uint32_t count = SDIO_CMDTIMEOUT * (SystemCoreClock / 8U /1000U);
  
    do {
        if (count-- == 0U) {
            return SDMMC_ERROR_TIMEOUT;
        }
    } while (!__SDIO_GET_FLAG(SDIO, SDIO_FLAG_CCRCFAIL | SDIO_FLAG_CMDREND | SDIO_FLAG_CTIMEOUT));
  
    if(__SDIO_GET_FLAG(SDIO, SDIO_FLAG_CTIMEOUT)) {
        __SDIO_CLEAR_FLAG(SDIO, SDIO_FLAG_CTIMEOUT);
        return SDMMC_ERROR_CMD_RSP_TIMEOUT;
    } else {  
        /* Clear all the static flags */
        __SDIO_CLEAR_FLAG(SDIO, SDIO_STATIC_FLAGS);
    }
  
    return SDMMC_ERROR_NONE;
}

static uint32_t SDMMC_GetCmdResp6(uint8_t SD_CMD, uint16_t *pRCA)
{
    uint32_t response_r1;

    /* 8 is the number of required instructions cycles for the below loop statement.
    The SDMMC_CMDTIMEOUT is expressed in ms */
    register uint32_t count = SDIO_CMDTIMEOUT * (SystemCoreClock / 8U /1000U);
  
    do {
        if (count-- == 0U) {
            return SDMMC_ERROR_TIMEOUT;
        }
    } while (!__SDIO_GET_FLAG(SDIO, SDIO_FLAG_CCRCFAIL | SDIO_FLAG_CMDREND | SDIO_FLAG_CTIMEOUT));
  
    if(__SDIO_GET_FLAG(SDIO, SDIO_FLAG_CTIMEOUT)) {
        __SDIO_CLEAR_FLAG(SDIO, SDIO_FLAG_CTIMEOUT);
        return SDMMC_ERROR_CMD_RSP_TIMEOUT;
    } else if(__SDIO_GET_FLAG(SDIO, SDIO_FLAG_CCRCFAIL)) {
        __SDIO_CLEAR_FLAG(SDIO, SDIO_FLAG_CCRCFAIL);
        return SDMMC_ERROR_CMD_CRC_FAIL;
    }
  
    /* Check response received is of desired command */
    if(SDIO_GetCommandResponse() != SD_CMD) {
        return SDMMC_ERROR_CMD_CRC_FAIL;
    }
  
    /* Clear all the static flags */
    __SDIO_CLEAR_FLAG(SDIO, SDIO_STATIC_FLAGS);
  
    /* We have received response, retrieve it.  */
    response_r1 = SDIO_GetResponse(SDIO_RESP1);
  
    if((response_r1 & (SDMMC_R6_GENERAL_UNKNOWN_ERROR | SDMMC_R6_ILLEGAL_CMD | SDMMC_R6_COM_CRC_FAILED)) == SDMMC_ALLZERO) {
        *pRCA = (uint16_t) (response_r1 >> 16);
        return SDMMC_ERROR_NONE;
    } else if((response_r1 & SDMMC_R6_ILLEGAL_CMD) == SDMMC_R6_ILLEGAL_CMD) {
        return SDMMC_ERROR_ILLEGAL_CMD;
    } else if((response_r1 & SDMMC_R6_COM_CRC_FAILED) == SDMMC_R6_COM_CRC_FAILED) {
        return SDMMC_ERROR_COM_CRC_FAILED;
    } else {
        return SDMMC_ERROR_GENERAL_UNKNOWN_ERR;
    }
}

static uint32_t SDMMC_GetCmdResp7()
{
    /* 8 is the number of required instructions cycles for the below loop statement.
    The SDIO_CMDTIMEOUT is expressed in ms */
    register uint32_t count = SDIO_CMDTIMEOUT * (SystemCoreClock / 8U /1000U);
  
    do {
        if (count-- == 0U) {
            return SDMMC_ERROR_TIMEOUT;
        }
    } while (!__SDIO_GET_FLAG(SDIO, SDIO_STA_CCRCFAIL | SDIO_STA_CMDREND | SDIO_STA_CTIMEOUT));

    if(__SDIO_GET_FLAG(SDIO, SDIO_STA_CTIMEOUT)) {
        /* Card is SD V2.0 compliant */
        __SDIO_CLEAR_FLAG(SDIO, SDIO_STA_CMDREND);
        
        return SDMMC_ERROR_CMD_RSP_TIMEOUT;
    }
  
    if(__SDIO_GET_FLAG(SDIO, SDIO_STA_CMDREND)) {
        /* Card is SD V2.0 compliant */
        __SDIO_CLEAR_FLAG(SDIO, SDIO_STA_CMDREND);
    }
  
    return SDMMC_ERROR_NONE;
  
}

static uint32_t SDMMC_CmdGoIdleState()
{
    uint32_t errorstate = SDMMC_ERROR_NONE;

    SDIO_SendCommand(0U, SDMMC_CMD_GO_IDLE_STATE, 0U, 0U, SDIO_CMD_CPSMEN);

    /* Check for error conditions */
    errorstate = SDMMC_GetCmdError();

    return errorstate;
}

static uint32_t SDMMC_CmdOperCond()
{
    uint32_t errorstate = SDMMC_ERROR_NONE;

    /* Send CMD8 to verify SD card interface operating condition */
    /* Argument: - [31:12]: Reserved (shall be set to '0')
    - [11:8]: Supply Voltage (VHS) 0x1 (Range: 2.7-3.6 V)
    - [7:0]: Check Pattern (recommended 0xAA) */
    /* CMD Response: R7 */
    SDIO_SendCommand(SDMMC_CHECK_PATTERN, SDMMC_CMD_HS_SEND_EXT_CSD, SDIO_CMD_WAITRESP_0, 0U, SDIO_CMD_CPSMEN);

    /* Check for error conditions */
    errorstate = SDMMC_GetCmdResp7();

    return errorstate;
}

static uint32_t SDMMC_CmdAppCommand(uint32_t Argument)
{
    uint32_t errorstate = SDMMC_ERROR_NONE;

    SDIO_SendCommand(Argument, SDMMC_CMD_APP_CMD, SDIO_CMD_WAITRESP_0, 0U, SDIO_CMD_CPSMEN);

    /* Check for error conditions */
    /* If there is a HAL_ERROR, it is a MMC card, else
    it is a SD card: SD card 2.0 (voltage range mismatch)
     or SD card 1.x */
    errorstate = SDMMC_GetCmdResp1(SDMMC_CMD_APP_CMD, SDIO_CMDTIMEOUT);

    return errorstate;
}

static uint32_t SDMMC_CmdAppOperCommand(uint32_t SdType)
{
    uint32_t errorstate = SDMMC_ERROR_NONE;

    SDIO_SendCommand(SDMMC_VOLTAGE_WINDOW_SD | SdType, SDMMC_CMD_SD_APP_OP_COND, SDIO_CMD_WAITRESP_0, 0U, SDIO_CMD_CPSMEN);

    /* Check for error conditions */
    errorstate = SDMMC_GetCmdResp3();

    return errorstate;
}

static uint32_t SDMMC_CmdSendCID()
{
    uint32_t errorstate = SDMMC_ERROR_NONE;

    /* Send CMD2 ALL_SEND_CID */
    SDIO_SendCommand(0U, SDMMC_CMD_ALL_SEND_CID, SDIO_RESPONSE_LONG, SDIO_WAIT_NO, SDIO_CPSM_ENABLE);

    /* Check for error conditions */
    errorstate = SDMMC_GetCmdResp2();

    return errorstate;
}

static uint32_t SDMMC_CmdSetRelAdd(uint16_t *pRCA)
{
    uint32_t errorstate = SDMMC_ERROR_NONE;

    /* Send CMD3 SD_CMD_SET_REL_ADDR */
    SDIO_SendCommand(0U, SDMMC_CMD_SET_REL_ADDR, SDIO_RESPONSE_SHORT, SDIO_WAIT_NO, SDIO_CPSM_ENABLE);

    /* Check for error conditions */
    errorstate = SDMMC_GetCmdResp6(SDMMC_CMD_SET_REL_ADDR, pRCA);

    return errorstate;
}

static uint32_t SDMMC_CmdSendCSD(uint32_t Argument)
{
    uint32_t errorstate = SDMMC_ERROR_NONE;

    /* Send CMD9 SEND_CSD */
    SDIO_SendCommand(Argument, SDMMC_CMD_SEND_CSD, SDIO_RESPONSE_LONG, SDIO_WAIT_NO, SDIO_CPSM_ENABLE);

    /* Check for error conditions */
    errorstate = SDMMC_GetCmdResp2();

    return errorstate;
}

static uint32_t SDMMC_CmdSelDesel(uint32_t Addr)
{
    uint32_t errorstate = SDMMC_ERROR_NONE;

    /* Send CMD7 SDMMC_SEL_DESEL_CARD */
    SDIO_SendCommand(Addr, SDMMC_CMD_SEL_DESEL_CARD, SDIO_RESPONSE_SHORT, SDIO_WAIT_NO, SDIO_CPSM_ENABLE);

    /* Check for error conditions */
    errorstate = SDMMC_GetCmdResp1(SDMMC_CMD_SEL_DESEL_CARD, SDIO_CMDTIMEOUT);

    return errorstate;
}

static uint32_t SD_PowerON()
{
    __IO uint32_t count = 0U;
    uint32_t response = 0U, validvoltage = 0U;
    uint32_t errorstate = SDMMC_ERROR_NONE;
  
    /* CMD0: GO_IDLE_STATE */
    errorstate = SDMMC_CmdGoIdleState();
    if(errorstate != SDMMC_ERROR_NONE) {
        return errorstate;
    }
  
    /* CMD8: SEND_IF_COND: Command available only on V2.0 cards */
    errorstate = SDMMC_CmdOperCond();
    if(errorstate != SDMMC_ERROR_NONE) {
        tftprintf("I dont support SD V1.x");
    } else {
        //hsd->SdCard.CardVersion = CARD_V2_X;
            
        /* Send ACMD41 SD_APP_OP_COND with Argument 0x80100000 */
        while(validvoltage == 0U) {
            if(count++ == SDMMC_MAX_VOLT_TRIAL) {
                return SDMMC_ERROR_INVALID_VOLTRANGE;
            }
          
            /* SEND CMD55 APP_CMD with RCA as 0 */
            errorstate = SDMMC_CmdAppCommand(0U);
            if(errorstate != SDMMC_ERROR_NONE) {
                return errorstate;
            }
          
            /* Send CMD41 */
            errorstate = SDMMC_CmdAppOperCommand(SDMMC_HIGH_CAPACITY);
            if(errorstate != SDMMC_ERROR_NONE) {
                return errorstate;
            }
          
            /* Get command response */
            response = SDIO_GetResponse(SDIO_RESP1);
          
            /* Get operating voltage*/
            validvoltage = (((response >> 31U) == 1U) ? 1U : 0U);
        }
        
        if((response & SDMMC_HIGH_CAPACITY) == SDMMC_HIGH_CAPACITY) { /* (response &= SD_HIGH_CAPACITY) */
            CardType = CARD_SDHC_SDXC;
        } else {
            CardType = CARD_SDSC;
        }
    }
  
    return SDMMC_ERROR_NONE;
}

static void SD_GetCardCSD()
{
    uint32_t tmp = 0U, DeviceSize = 0;

    /* Byte 5 */
    tmp = (hsd->CSD[1U] & 0x00FF0000U) >> 16U;
    RdBlockLen = (uint8_t)(tmp & 0x0FU);

    /* Byte 6 */
    tmp = (CSD_Tab[1U] & 0x0000FF00U) >> 8U;
    if (CardType == CARD_SDSC) {
        DeviceSize = (tmp & 0x03U) << 10U;

        /* Byte 7 */
        tmp = (uint8_t)(CSD_Tab[1U] & 0x000000FFU);
        DeviceSize |= (tmp) << 2U;

        /* Byte 8 */
        tmp = (uint8_t)((CSD_Tab[2U] & 0xFF000000U) >> 24U);
        DeviceSize |= (tmp & 0xC0U) >> 6U;

        /* Byte 9 */
        tmp = (uint8_t)((CSD_Tab[2U] & 0x00FF0000U) >> 16U);
        DeviceSizeMul = (tmp & 0x03U) << 1U;

        /* Byte 10 */
        tmp = (uint8_t)((CSD_Tab[2U] & 0x0000FF00U) >> 8U);
        DeviceSizeMul |= (tmp & 0x80U) >> 7U;

        BlockNbr  = (DeviceSize + 1U) ;
        BlockNbr *= (1U << (DeviceSizeMul + 2U));
        BlockSize = 1U << (RdBlockLen);
        LogBlockNbr =  (BlockNbr) * (BlockSize / 512U); 
    } else if (CardType == CARD_SDHC_SDXC) {
        /* Byte 7 */
        tmp = (uint8_t)(CSD_Tab[1U] & 0x000000FFU);
        DeviceSize = (tmp & 0x3FU) << 16U;

        /* Byte 8 */
        tmp = (uint8_t)((CSD_Tab[2U] & 0xFF000000U) >> 24U);
        DeviceSize |= (tmp << 8U);
        
        /* Byte 9 */
        tmp = (uint8_t)((CSD_Tab[2U] & 0x00FF0000U) >> 16U);
        DeviceSize |= (tmp);

        LogBlockNbr = BlockNbr = (((uint64_t)DeviceSize + 1U) * 1024U);
    }
}

static uint32_t SDMMC_InitCard()
{
  uint32_t errorstate = SDMMC_ERROR_NONE;
  uint16_t sd_rca = 1U;
  
    /* Check the power State */
    if(SDIO_GetPowerState() == 0U) {
        /* Power off */
        return SDMMC_ERROR_REQUEST_NOT_APPLICABLE;
    }
  
    /* Send CMD2 ALL_SEND_CID */
    errorstate = SDMMC_CmdSendCID();
    if(errorstate != SDMMC_ERROR_NONE) {
        return errorstate;
    } else {
        /* Get Card identification number data */
        CID_Tab[0U] = SDIO_GetResponse(SDIO_RESP1);
        CID_Tab[1U] = SDIO_GetResponse(SDIO_RESP2);
        CID_Tab[2U] = SDIO_GetResponse(SDIO_RESP3);
        CID_Tab[3U] = SDIO_GetResponse(SDIO_RESP4);
    }
  
    /* Send CMD3 SET_REL_ADDR with argument 0 */
    /* SD Card publishes its RCA. */
    errorstate = SDMMC_CmdSetRelAdd(&sd_rca);
    if(errorstate != SDMMC_ERROR_NONE) {
        return errorstate;
    }

    /* Get the SD card RCA */
    RCA = sd_rca;
    
    /* Send CMD9 SEND_CSD with argument as card's RCA */
    errorstate = SDMMC_CmdSendCSD((uint32_t)(RCA << 16U));
    if(errorstate != SDMMC_ERROR_NONE) {
        return errorstate;
    } else {
        /* Get Card Specific Data */
        CSD_Tab[0U] = SDIO_GetResponse(SDIO_RESP1);
        CSD_Tab[1U] = SDIO_GetResponse(SDIO_RESP2);
        CSD_Tab[2U] = SDIO_GetResponse(SDIO_RESP3);
        CSD_Tab[3U] = SDIO_GetResponse(SDIO_RESP4);
    }
  
    /* Get the Card Class */
    Class = (SDIO_GetResponse(SDIO_RESP2) >> 20U);

    /* Get CSD parameters */
    SD_GetCardCSD(hsd, &CSD);
  
    /* Select the Card */
    errorstate = SDMMC_CmdSelDesel((uint32_t)(RCA << 16U));
    if(errorstate != SDMMC_ERROR_NONE) {
        return errorstate;
    }

    /* Configure SDIO peripheral interface */     
    SDIO_Perip_Init(SDIO_CLOCK_EDGE_RISING, SDIO_CLOCK_BYPASS_DISABLE, SDIO_CLOCK_POWER_SAVE_DISABLE,
                    SDIO_BUS_WIDE_1B, SDIO_HARDWARE_FLOW_CONTROL_DISABLE, 4U);

    /* All cards are initialized */
    return SDMMC_ERROR_NONE;
}

static uint32_t SDMMC_CmdBlockLength(uint32_t BlockSize)
{
    uint32_t errorstate = SDMMC_ERROR_NONE;

    /* Set Block Size for Card */ 
    SDIO_SendCommand(BlockSize, SDMMC_CMD_SET_BLOCKLEN, SDIO_RESPONSE_SHORT, SDIO_WAIT_NO, SDIO_CPSM_ENABLE);

    /* Check for error conditions */
    errorstate = SDMMC_GetCmdResp1(SDMMC_CMD_SET_BLOCKLEN, SDIO_CMDTIMEOUT);

    return errorstate;
}

static void SD_InitCard()
{
    uint32_t i;
    uint32_t errorstate;
    /* Initialize SDIO peripheral interface with default configuration */
    SDIO_Perip_Init(0U, 0U, 0U, 0U, 0U, 0xC3);

    /* Disable SDIO Clock */
    __SDIO_DISABLE(); 
  
    /* Set Power State to ON */
    SDIO->POWER = SDIO_POWER_PWRCTRL;
  
    /* Enable SDIO Clock */
    __SDIO_ENABLE();
  
    /* Required power up waiting time before starting the SD initialization 
    sequence */
    for (i=0;i<72000;++i) {}
  
    /* Identify card operating voltage */
    errorstate = SD_PowerON();
    if(errorstate != SDMMC_ERROR_NONE) {
        tftprintf("%s:%d", __func__, __LINE__);
        return;
    }

    /* Card initialization */
    errorstate = SDMMC_InitCard();
    if(errorstate != SDMMC_ERROR_NONE) {
        tftprintf("%s:%d", __func__, __LINE__);
        return;
    }
}

static void SDIO_ConfigData(uint32_t DataTimeOut, uint32_t DataLength, uint32_t DataBlockSize,
                            uint32_t TransferDir, uint32_t TransferMode, uint32_t DPSM)
{
    uint32_t tmpreg = 0U;

    /* Set the SDMMC Data TimeOut value */
    SDIO->DTIMER = DataTimeOut;

    /* Set the SDMMC DataLength value */
    SDIO->DLEN = DataLength;

    /* Set the SDMMC data configuration parameters */
    tmpreg |= (uint32_t)(DataBlockSize | TransferDir | TransferMode | DPSM);

    /* Write to SDMMC DCTRL */
    MODIFY_REG(SDIO->DCTRL, DCTRL_CLEAR_MASK, tmpreg);
}

static uint32_t SDMMC_CmdSendSCR()
{
    uint32_t errorstate = SDMMC_ERROR_NONE;

    /* Send CMD51 SD_APP_SEND_SCR */
    SDIO_SendCommand(0U, SDMMC_CMD_SD_APP_SEND_SCR, SDIO_RESPONSE_SHORT, SDIO_WAIT_NO, SDIO_CPSM_ENABLE);

    /* Check for error conditions */
    errorstate = SDMMC_GetCmdResp1(SDMMC_CMD_SD_APP_SEND_SCR, SDIO_CMDTIMEOUT);

    return errorstate;
}

static uint32_t SD_FindSCR(uint32_t *pSCR)
{
    __IO uint32_t count = 0U;
    uint32_t errorstate = SDMMC_ERROR_NONE;
    uint32_t index = 0U;
    uint32_t tempscr[2U] = {0U, 0U};
  
    /* Set Block Size To 8 Bytes */
    errorstate = SDMMC_CmdBlockLength(8U);
    if(errorstate != SDMMC_ERROR_NONE) {
        return errorstate;
    }

    /* Send CMD55 APP_CMD with argument as card's RCA */
    errorstate = SDMMC_CmdAppCommand((uint32_t)(RCA << 16U));
    if(errorstate != SDMMC_ERROR_NONE) {
        return errorstate;
    }

    SDIO_ConfigData(SDMMC_DATATIMEOUT, 8U, SDIO_DATABLOCK_SIZE_8B, SDIO_TRANSFER_DIR_TO_SDIO,
                    SDIO_TRANSFER_MODE_BLOCK, SDIO_DPSM_ENABLE);
  
    /* Send ACMD51 SD_APP_SEND_SCR with argument as 0 */
    errorstate = SDMMC_CmdSendSCR();
    if(errorstate != SDMMC_ERROR_NONE) {
        return errorstate;
    }

    do {
        if (count-- == 0U) {
            return SDMMC_ERROR_TIMEOUT;
        }
        if(__SDIO_GET_FLAG(SDIO, SDIO_FLAG_RXDAVL)) {
            *(tempscr + index) = SDIO->FIFO;
            index++;
        }
    } while (!__SDIO_GET_FLAG(SDIO, SDIO_FLAG_RXOVERR | SDIO_FLAG_DCRCFAIL | SDIO_FLAG_DTIMEOUT | SDIO_FLAG_DBCKEND));
  
    if(__SDIO_GET_FLAG(SDIO, SDIO_FLAG_DTIMEOUT)) {
        __SDIO_CLEAR_FLAG(SDIO, SDIO_FLAG_DTIMEOUT);
        return SDMMC_ERROR_DATA_TIMEOUT;
    } else if(__SDIO_GET_FLAG(SDIO, SDIO_FLAG_DCRCFAIL)) {
        __SDIO_CLEAR_FLAG(SDIO, SDIO_FLAG_DCRCFAIL);
        return SDMMC_ERROR_DATA_CRC_FAIL;
    } else if(__SDIO_GET_FLAG(SDIO, SDIO_FLAG_RXOVERR)) {
        __SDIO_CLEAR_FLAG(SDIO, SDIO_FLAG_RXOVERR);
        return SDMMC_ERROR_RX_OVERRUN;
    } else {
        /* No error flag set */
        /* Clear all the static flags */
        __SDIO_CLEAR_FLAG(SDIO, SDIO_STATIC_FLAGS);
        
        *(pSCR + 1U) = ((tempscr[0U] & SDMMC_0TO7BITS) << 24U)  | ((tempscr[0U] & SDMMC_8TO15BITS) << 8U) |\
          ((tempscr[0U] & SDMMC_16TO23BITS) >> 8U) | ((tempscr[0U] & SDMMC_24TO31BITS) >> 24U);
        
        *(pSCR) = ((tempscr[1U] & SDMMC_0TO7BITS) << 24U)  | ((tempscr[1U] & SDMMC_8TO15BITS) << 8U) |\
          ((tempscr[1U] & SDMMC_16TO23BITS) >> 8U) | ((tempscr[1U] & SDMMC_24TO31BITS) >> 24U);
    }

    return SDMMC_ERROR_NONE;
}

static uint32_t SDMMC_CmdBusWidth(uint32_t BusWidth)
{
    uint32_t errorstate = SDMMC_ERROR_NONE;

    SDIO_SendCommand(BusWidth, SDMMC_CMD_APP_SD_SET_BUSWIDTH, SDIO_RESPONSE_SHORT, SDIO_WAIT_NO, SDIO_CPSM_ENABLE);

    /* Check for error conditions */
    errorstate = SDMMC_GetCmdResp1(SDMMC_CMD_APP_SD_SET_BUSWIDTH, SDIO_CMDTIMEOUT);

    return errorstate;
}

static uint32_t SD_WideBus_Enable()
{
    uint32_t scr[2U] = {0U, 0U};
    uint32_t errorstate = SDMMC_ERROR_NONE;
  
    if((SDIO_GetResponse(SDIO_RESP1) & SDMMC_CARD_LOCKED) == SDMMC_CARD_LOCKED) {
        return SDMMC_ERROR_LOCK_UNLOCK_FAILED;
    }
  
    /* Get SCR Register */
    errorstate = SD_FindSCR(scr);
    if(errorstate != SDMMC_ERROR_NONE) {
        return errorstate;
    }
  
    /* If requested card supports wide bus operation */
    if((scr[1U] & SDMMC_WIDE_BUS_SUPPORT) != SDMMC_ALLZERO) {
        /* Send CMD55 APP_CMD with argument as card's RCA.*/
        errorstate = SDMMC_CmdAppCommand((uint32_t)(RCA << 16U));
        if(errorstate != SDMMC_ERROR_NONE) {
            return errorstate;
        }
        
        /* Send ACMD6 APP_CMD with argument as 2 for wide bus mode */
        errorstate = SDMMC_CmdBusWidth(2U);
        if(errorstate != SDMMC_ERROR_NONE) {
            return errorstate;
        }

        return SDMMC_ERROR_NONE;
    } else {
        return SDMMC_ERROR_REQUEST_NOT_APPLICABLE;
    }
}

static void SD_ConfigWideBusOperation()
{
    uint32_t errorstate = SDMMC_ERROR_NONE;
    errorstate = SD_WideBus_Enable();
    if(errorstate != SDMMC_ERROR_NONE) {
        /* Clear all the static flags */
        __SDIO_CLEAR_FLAG(SDIO, SDIO_STATIC_FLAGS);
        tftprintf("%s:%d", __func__, __LINE__);
        return;
    } else {
        SDIO_Perip_Init(SDIO_CLOCK_EDGE_RISING, SDIO_CLOCK_BYPASS_DISABLE, SDIO_CLOCK_POWER_SAVE_DISABLE,
                    SDIO_BUS_WIDE_4B, SDIO_HARDWARE_FLOW_CONTROL_DISABLE, 4U);
    }
}

void SDIO_Init()
{
    uint16_t i;
    SET_BIT(RCC->APB2ENR, RCC_APB2ENR_IOPCEN);
    SET_BIT(RCC->APB2ENR, RCC_APB2ENR_IOPDEN);
    SET_BIT(RCC->AHBENR, RCC_AHBENR_SDIOEN);

    for (i=0;i<NUM_ROWS(GPIO_PINS_L);++i) {
        GPIOxL_Init(GPIO_PINS_L[i].port, GPIO_PINS_L[i].pin, GPIO_PINS_L[i].clear, GPIO_PINS_L[i].set);
    }
    for (i=0;i<NUM_ROWS(GPIO_PINS_H);++i) {
        GPIOxH_Init(GPIO_PINS_H[i].port, GPIO_PINS_H[i].pin, GPIO_PINS_H[i].clear, GPIO_PINS_H[i].set);
    }

    SDIO_DeInit();
    SD_InitCard();
    SD_ConfigWideBusOperation();
}

uint32_t SD_ReadBlock(uint8_t *pData, uint32_t BlockAdd, uint32_t NumberOfBlocks, uint32_t Timeout)
{
    SDIO_DataInitTypeDef config;
    uint32_t errorstate = SDMMC_ERROR_NONE;
    uint32_t tickstart = HAL_GetTick();
    uint32_t count = 0U, *tempbuff = (uint32_t *)pData;
  
    if(NULL == pData) {
        return;
    }
 
    if(hsd->State == HAL_SD_STATE_READY) {
        if((BlockAdd + NumberOfBlocks) > LogBlockNbr) {
            return SDMMC_ERROR_ADDR_OUT_OF_RANGE;
        }
    
        /* Initialize data control register */
        SDIO->DCTRL = 0U;
        
        if(CardType != CARD_SDHC_SDXC) {
            BlockAdd *= 512U;
        }
          
        /* Set Block Size for Card */
        errorstate = SDMMC_CmdBlockLength(512U);
        if(errorstate != SDMMC_ERROR_NONE) {
            /* Clear all the static flags */
            __SDIO_CLEAR_FLAG(SDIO, SDIO_STATIC_FLAGS);      
            return errorstate;
        }
    
        /* Configure the SD DPSM (Data Path State Machine) */
        SDIO_ConfigData(SDMMC_DATATIMEOUT, NumberOfBlocks * 512U, SDIO_DATABLOCK_SIZE_512B,
                        SDIO_TRANSFER_DIR_TO_SDIO, SDIO_TRANSFER_MODE_BLOCK, SDIO_DPSM_ENABLE);
        
        /* Read block(s) in polling mode */
        if(NumberOfBlocks > 1U) {
            hsd->Context = SD_CONTEXT_READ_MULTIPLE_BLOCK;
            /* Read Multi Block command */ 
            errorstate = SDMMC_CmdReadMultiBlock(hsd->Instance, BlockAdd);
        } else {
            hsd->Context = SD_CONTEXT_READ_SINGLE_BLOCK;
            /* Read Single Block command */
            errorstate = SDMMC_CmdReadSingleBlock(hsd->Instance, BlockAdd);
        }

        if(errorstate != SDMMC_ERROR_NONE) {
            /* Clear all the static flags */
            __HAL_SD_CLEAR_FLAG(hsd, SDIO_STATIC_FLAGS);
            return errorstate;
        }
          
        /* Poll on SDIO flags */
        while(!__HAL_SD_GET_FLAG(hsd, SDIO_FLAG_RXOVERR | SDIO_FLAG_DCRCFAIL | SDIO_FLAG_DTIMEOUT | SDIO_FLAG_DATAEND | SDIO_STA_STBITERR))
        {
          if(__HAL_SD_GET_FLAG(hsd, SDIO_FLAG_RXFIFOHF))
          {
            /* Read data from SDIO Rx FIFO */
            for(count = 0U; count < 8U; count++)
            {
              *(tempbuff + count) = SDIO_ReadFIFO(hsd->Instance);
            }
            tempbuff += 8U;
          }
          
          if((Timeout == 0U)||((HAL_GetTick()-tickstart) >=  Timeout))
          {
            /* Clear all the static flags */
            __HAL_SD_CLEAR_FLAG(hsd, SDIO_STATIC_FLAGS);
            hsd->ErrorCode |= HAL_SD_ERROR_TIMEOUT;
            hsd->State= HAL_SD_STATE_READY;
            return HAL_TIMEOUT;
          }
        }
    
        /* Send stop transmission command in case of multiblock read */
        if(__HAL_SD_GET_FLAG(hsd, SDIO_FLAG_DATAEND) && (NumberOfBlocks > 1U))
        {    
          if(hsd->SdCard.CardType != CARD_SECURED)
          {
            /* Send stop transmission command */
            errorstate = SDMMC_CmdStopTransfer(hsd->Instance);
            if(errorstate != HAL_SD_ERROR_NONE)
            {
              /* Clear all the static flags */
              __HAL_SD_CLEAR_FLAG(hsd, SDIO_STATIC_FLAGS);
              hsd->ErrorCode |= errorstate;
              hsd->State = HAL_SD_STATE_READY;
              return HAL_ERROR;
            }
          }
        }
    
        /* Get error state */
        if(__HAL_SD_GET_FLAG(hsd, SDIO_FLAG_DTIMEOUT))
        {
          /* Clear all the static flags */
          __HAL_SD_CLEAR_FLAG(hsd, SDIO_STATIC_FLAGS);
          hsd->ErrorCode |= HAL_SD_ERROR_DATA_TIMEOUT;
          hsd->State = HAL_SD_STATE_READY;
          return HAL_ERROR;
        }
        else if(__HAL_SD_GET_FLAG(hsd, SDIO_FLAG_DCRCFAIL))
        {
          /* Clear all the static flags */
          __HAL_SD_CLEAR_FLAG(hsd, SDIO_STATIC_FLAGS);
          hsd->ErrorCode |= HAL_SD_ERROR_DATA_CRC_FAIL;
          hsd->State = HAL_SD_STATE_READY;
          return HAL_ERROR;
        }
        else if(__HAL_SD_GET_FLAG(hsd, SDIO_FLAG_RXOVERR))
        {
          /* Clear all the static flags */
          __HAL_SD_CLEAR_FLAG(hsd, SDIO_STATIC_FLAGS);
          hsd->ErrorCode |= HAL_SD_ERROR_RX_OVERRUN;
          hsd->State = HAL_SD_STATE_READY;
          return HAL_ERROR;
        }
        
        /* Empty FIFO if there is still any data */
        while ((__HAL_SD_GET_FLAG(hsd, SDIO_FLAG_RXDAVL)))
        {
          *tempbuff = SDIO_ReadFIFO(hsd->Instance);
          tempbuff++;
          
          if((Timeout == 0U)||((HAL_GetTick()-tickstart) >=  Timeout))
          {
            /* Clear all the static flags */
            __HAL_SD_CLEAR_FLAG(hsd, SDIO_STATIC_FLAGS);        
            hsd->ErrorCode |= HAL_SD_ERROR_TIMEOUT;
            hsd->State= HAL_SD_STATE_READY;
            return HAL_ERROR;
          }
        }
        
        /* Clear all the static flags */
        __HAL_SD_CLEAR_FLAG(hsd, SDIO_STATIC_FLAGS);
        
        hsd->State = HAL_SD_STATE_READY;
        
        return HAL_OK;
  }
  else
  {
    hsd->ErrorCode |= HAL_SD_ERROR_BUSY;
    return HAL_ERROR;
  }
}

void SD_WriteBlock(uint32_t *writebuff, uint32_t WriteAddr, uint16_t BlockSize)
{

}
