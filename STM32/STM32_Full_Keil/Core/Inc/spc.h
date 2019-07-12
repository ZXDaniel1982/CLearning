#ifndef __spc_H
#define __spc_H
#ifdef __cplusplus
 extern "C" {
#endif

#include "main.h"
#include "cmsis_os.h"

// SPC related definition
#define SPC_MAX_STR_LEN  ( 20 )

#define RTD_OPNE             ( 0x7ffd )
#define RTD_SHORT            ( 0x7fff )
#define OUTOFRANGE           ( 0x7ffe )
#define SPC_SIMULATE_TEMP_C  ( 20 )
#define SPC_SIMULATE_TEMP_F  ( 20 )

static const char *spcStartupLogOn[] = {
    "Turn on Heater Led",
    "Turn on System Fail Led",
    "Turn on Alarm Led",
    "Turn on Communication Led",
};
static const char *spcStartupLogOff[] = {
    "Turn off Heater Led",
    "Turn off System Fail Led",
    "Turn off Alarm Led",
    "Turn off Communication Led",
};

typedef enum
{
    SPC_SOFTWARE_VERSION = 0,
    SPC_SELFCHECK,

    SPC_MAX_INFO_TYPE
} SpcInfoType_t;

typedef enum
{
    SPC_RTD_CHANNEL1 = 0,
    SPC_RTD_CHANNEL2,

    SPC_MAX_RTD_CHANNEL
} SpcRtdChannel_t;

typedef struct
{
    SpcInfoType_t infoType;
    char stringLine1[SPC_MAX_STR_LEN];
    char stringLine2[SPC_MAX_STR_LEN];
} SpcScreenInfo_t;

typedef struct
{
    int8_t tempf;
    int8_t tempc;
}SpcTemperatureSingle_t;

typedef struct
{
    //SpcTempStatus tempStatus;
    SpcTemperatureSingle_t tempsingle[SPC_MAX_RTD_CHANNEL];
}SpcTemperature_t;

typedef struct
{
    SpcTemperature_t temp;
}SpcValue_t;

static const SpcScreenInfo_t SpcScreenInfo[SPC_MAX_INFO_TYPE] = {
    {SPC_SOFTWARE_VERSION, "DPC firmware", "Version 1.0"},
    {SPC_SELFCHECK, "System Check...", "    "}
};


void SPC_Init(void);

#ifdef __cplusplus
}
#endif
#endif /*__spc_H */
