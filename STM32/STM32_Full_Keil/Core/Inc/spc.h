#ifndef __spc_H
#define __spc_H
#ifdef __cplusplus
 extern "C" {
#endif

#include "main.h"
#include "cmsis_os.h"
#include "spccommon.h"
#include "spcconst.h"

extern static SpcValue_t SpcValue;

// SPC related definition
#define SpcManuOptEn              ( SPC_NORMAL )
#define SpcManuOptDis             ( SPC_ERROR )
#define SpcTempInCelsius          ( SPC_NORMAL )
#define SpcTempInFahren           ( SPC_ERROR )

#define SpcTemp(x,y)              ( (x)->measure.temp[y] )
#define SpcGfi(x)                 ( (x)->measure.gfi )
#define SpcPercent(x)             ( (x)->measure.PowerPercent )
#define SpcCurrent(x)             ( (x)->measure.Current )
#define SpcVoltage(x)             ( (x)->measure.Voltage )

#define SpcConf(x)                ( (x)->config.system )
#define SpcConfMainTemp(x)        ( (x)->config.MaintainTemp )
#define SpcConfTimeout(x)         ( (x)->config.DisplayTime )

#define SpcAlarmList(x)           ( (x)->alarm.alarmList )
#define SpcAlarmMask(x)           ( (x)->alarm.alarmMask )

#define SpcPosition(x)            ( (x)->runStatus.position )

#define SpcInitEntry(x)           ( SpcStateAction[(x)].initEntry )
#define SpcRight(x)               ( SpcStateAction[(x)].rightEntry )
#define SpcLeft(x)                ( SpcStateAction[(x)].leftEntry )
#define SpcUp(x)                  ( SpcStateAction[(x)].upEntry )
#define SpcDown(x)                ( SpcStateAction[(x)].downEntry )
#define SpcAct(x)                 ( SpcStateAction[(x)].actEntry )
#define SpcProg(x)                ( SpcStateAction[(x)].progEntry )
#define SpcAlarm(x)               ( SpcStateAction[(x)].alarmEntry )
#define SpcReset(x)               ( SpcStateAction[(x)].resetEntry )
#define SpcEnter(x)               ( SpcStateAction[(x)].enterEntry )

// For SPC test 
#define SPC_TEST_TEMP_STATUS      ( SPC_TEMP_NORMAL )
#define SPC_SIMULATE_TEMP_C       ( 20 )
#define SPC_SIMULATE_TEMP_F       ( 20 )
#define SPC_SIMULATE_GFI          ( 10 )

void SPC_Init(void);
void cliSpcKeyOpt(void *arg);

#ifdef __cplusplus
}
#endif
#endif /*__spc_H */
