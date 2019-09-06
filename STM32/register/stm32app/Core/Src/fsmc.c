#include "stm32f1xx.h"
#include "stm32f103xe.h"
#include "common.h"

typedef struct
{
    GPIO_TypeDef *port;
    uint32_t pin;
} GPIO_PINS_t;
static const GPIO_PINS_t GPIO_PINS[] = {
    {GPIOD, GPIO_BSRR_BS13},
    {GPIOE, GPIO_BSRR_BS1},
    {GPIOE, GPIO_BSRR_BS7},
    {GPIOE, GPIO_BSRR_BS8},
    {GPIOE, GPIO_BSRR_BS9},
    {GPIOE, GPIO_BSRR_BS10},
    {GPIOE, GPIO_BSRR_BS11},
    {GPIOE, GPIO_BSRR_BS12},
    {GPIOE, GPIO_BSRR_BS13},
    {GPIOE, GPIO_BSRR_BS14},
    {GPIOE, GPIO_BSRR_BS15},
    {GPIOD, GPIO_BSRR_BS0},
    {GPIOD, GPIO_BSRR_BS1},
    {GPIOD, GPIO_BSRR_BS4},
    {GPIOD, GPIO_BSRR_BS5},
    {GPIOD, GPIO_BSRR_BS7},
    {GPIOD, GPIO_BSRR_BS8},
    {GPIOD, GPIO_BSRR_BS9},
    {GPIOD, GPIO_BSRR_BS10},
    {GPIOD, GPIO_BSRR_BS11},
    {GPIOD, GPIO_BSRR_BS14},
    {GPIOD, GPIO_BSRR_BS15},
};

void FSMC_Init()
{
    MODIFY_REG(GPIOD->CRH, (GPIO_CRH_CNF13 | GPIO_CRH_MODE13), GPIO_CRH_MODE13);
    MODIFY_REG(GPIOE->CRL, (GPIO_CRL_CNF1 | GPIO_CRL_MODE1), GPIO_CRL_MODE1_1);
    MODIFY_REG(GPIOE->CRL, (GPIO_CRL_CNF7 | GPIO_CRL_MODE7), (GPIO_CRL_CNF7_1 | GPIO_CRL_MODE7));
    MODIFY_REG(GPIOE->CRH, (GPIO_CRH_CNF8 | GPIO_CRH_MODE8), (GPIO_CRH_CNF8_1 | GPIO_CRH_MODE8));
    MODIFY_REG(GPIOE->CRH, (GPIO_CRH_CNF9 | GPIO_CRH_MODE9), (GPIO_CRH_CNF9_1 | GPIO_CRH_MODE9));
    MODIFY_REG(GPIOE->CRH, (GPIO_CRH_CNF10 | GPIO_CRH_MODE10), (GPIO_CRH_CNF10_1 | GPIO_CRH_MODE10));
    MODIFY_REG(GPIOE->CRH, (GPIO_CRH_CNF11 | GPIO_CRH_MODE11), (GPIO_CRH_CNF11_1 | GPIO_CRH_MODE11));
    MODIFY_REG(GPIOE->CRH, (GPIO_CRH_CNF12 | GPIO_CRH_MODE12), (GPIO_CRH_CNF12_1 | GPIO_CRH_MODE12));
    MODIFY_REG(GPIOE->CRH, (GPIO_CRH_CNF13 | GPIO_CRH_MODE13), (GPIO_CRH_CNF13_1 | GPIO_CRH_MODE13));
    MODIFY_REG(GPIOE->CRH, (GPIO_CRH_CNF14 | GPIO_CRH_MODE14), (GPIO_CRH_CNF14_1 | GPIO_CRH_MODE14));
    MODIFY_REG(GPIOE->CRH, (GPIO_CRH_CNF15 | GPIO_CRH_MODE15), (GPIO_CRH_CNF15_1 | GPIO_CRH_MODE15));
    MODIFY_REG(GPIOD->CRL, (GPIO_CRL_CNF0 | GPIO_CRL_MODE0), (GPIO_CRL_CNF0_1 | GPIO_CRL_MODE0));
    MODIFY_REG(GPIOD->CRL, (GPIO_CRL_CNF1 | GPIO_CRL_MODE1), (GPIO_CRL_CNF1_1 | GPIO_CRL_MODE1));
    MODIFY_REG(GPIOD->CRL, (GPIO_CRL_CNF4 | GPIO_CRL_MODE4), (GPIO_CRL_CNF4_1 | GPIO_CRL_MODE4));
    MODIFY_REG(GPIOD->CRL, (GPIO_CRL_CNF5 | GPIO_CRL_MODE5), (GPIO_CRL_CNF5_1 | GPIO_CRL_MODE5));
    MODIFY_REG(GPIOD->CRL, (GPIO_CRL_CNF7 | GPIO_CRL_MODE7), (GPIO_CRL_CNF7_1 | GPIO_CRL_MODE7));
    MODIFY_REG(GPIOD->CRH, (GPIO_CRH_CNF8 | GPIO_CRH_MODE8), (GPIO_CRH_CNF8_1 | GPIO_CRH_MODE8));
    MODIFY_REG(GPIOD->CRH, (GPIO_CRH_CNF9 | GPIO_CRH_MODE9), (GPIO_CRH_CNF9_1 | GPIO_CRH_MODE9));
    MODIFY_REG(GPIOD->CRH, (GPIO_CRH_CNF10 | GPIO_CRH_MODE10), (GPIO_CRH_CNF10_1 | GPIO_CRH_MODE10));
    MODIFY_REG(GPIOD->CRH, (GPIO_CRH_CNF11 | GPIO_CRH_MODE11), (GPIO_CRH_CNF11_1 | GPIO_CRH_MODE11));
    MODIFY_REG(GPIOD->CRH, (GPIO_CRH_CNF14 | GPIO_CRH_MODE14), (GPIO_CRH_CNF14_1 | GPIO_CRH_MODE14));
    MODIFY_REG(GPIOD->CRH, (GPIO_CRH_CNF15 | GPIO_CRH_MODE15), (GPIO_CRH_CNF15_1 | GPIO_CRH_MODE15));

    uint8_t i;
    for (i = 0; i < NUM_ROWS(GPIO_PINS); ++i) {
        MODIFY_REG(GPIO_PINS[i].port->ODR, GPIO_PINS[i].pin, 0);
    }

    /* Initialize SRAM control Interface */
    CLEAR_BIT(FSMC_Bank1->BTCR[0], FSMC_BCRx_MBKEN);

    MODIFY_REG(FSMC_Bank1->BTCR[0], (uint32_t)(FSMC_BCRx_FACCEN | FSMC_BCRx_MUXEN | FSMC_BCRx_MTYP |
                FSMC_BCRx_MWID | FSMC_BCRx_BURSTEN | FSMC_BCRx_WAITPOL | FSMC_BCRx_WRAPMOD |
                FSMC_BCRx_WAITCFG | FSMC_BCRx_WREN | FSMC_BCRx_WAITEN | FSMC_BCRx_EXTMOD |
                FSMC_BCRx_ASYNCWAIT | FSMC_BCRx_CBURSTRW), (uint32_t)(FSMC_BCRx_MWID_0 | FSMC_BCRx_WREN));

    /* Initialize SRAM timing Interface */
    MODIFY_REG(FSMC_Bank1->BTCR[1U], (uint32_t)(FSMC_BTRx_ADDSET | FSMC_BTRx_ADDHLD | FSMC_BTRx_DATAST |
                FSMC_BTRx_BUSTURN | FSMC_BTRx_CLKDIV | FSMC_BTRx_DATLAT | FSMC_BTRx_ACCMOD),                                                                \
                (uint32_t)(0x2 | (15 << FSMC_BTRx_ADDHLD_Pos) | (0x5 << FSMC_BTRx_DATAST_Pos) |
                        ((16 - 1U) << FSMC_BTRx_CLKDIV_Pos) | ((17 - 2U) << FSMC_BTRx_DATLAT_Pos)));

    /* Initialize SRAM extended mode timing Interface */
    FSMC_Bank1E->BWTR[0] = 0x0FFFFFFFU;

    /* Enable the NORSRAM device */
    SET_BIT(FSMC_Bank1->BTCR[0], FSMC_BCRx_MBKEN);

    SET_BIT(AFIO->MAPR2, AFIO_MAPR2_FSMC_NADV_REMAP);
}
