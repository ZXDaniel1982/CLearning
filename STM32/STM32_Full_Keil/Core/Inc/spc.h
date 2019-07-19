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
#define SpcManuOptEn            ( SPC_NORMAL )
#define SpcManuOptDis           ( SPC_ERROR )
#define SpcTempInCelsius        ( SPC_NORMAL )
#define SpcTempInFahren         ( SPC_ERROR )

#define SpcTemp(x,y)              ( (x)->measure.temp[y] )
#define SpcGfi(x)                 ( (x)->measure.gfi )
#define SpcPercent(x)             ( (x)->measure.PowerPercent )
#define SpcCurrent(x)             ( (x)->measure.Current )
#define SpcVoltage(x)             ( (x)->measure.Voltage )

#define SpcSysConf(x)             ( (x)->config.system )
#define SpcSysConfMainTemp(x)     ( (x)->config.MaintainTemp )
#define SpcConfTimeout(x)         ( (x)->config.DisplayTime )

#define SpcAlarmList(x)           ( (x)->alarm.alarmList )
#define SpcAlarmMask(x)           ( (x)->alarm.alarmMask )

#define SpcPosition(x)            ( (x)->runStatus.position )

#define SpcStrLine1(x)            ( SpcScreenInfo[(x)].strTypeLine1 )
#define SpcStrLine2(x)            ( SpcScreenInfo[(x)].strTypeLine2 )
#define SpcStrDetail(x)           ( SpcScreenInfo[(x)].infoDetail )
#define SpcRightType(x)           ( SpcScreenInfo[(x)].rightType )
#define SpcLeftType(x)            ( SpcScreenInfo[(x)].leftType )
#define SpcActType(x)             ( SpcScreenInfo[(x)].actType )
#define SpcProgType(x)            ( SpcScreenInfo[(x)].progType )
#define SpcAlarmType(x)           ( SpcScreenInfo[(x)].alarmType )
#define SpcResetType(x)           ( SpcScreenInfo[(x)].resetType )
#define SpcEnterType(x)           ( SpcScreenInfo[(x)].enterType )

// For SPC test 
#define SPC_TEST_TEMP_STATUS    ( SPC_TEMP_NORMAL )
#define SPC_SIMULATE_TEMP_C     ( 20 )
#define SPC_SIMULATE_TEMP_F     ( 20 )
#define SPC_SIMULATE_GFI        ( 10 )

void SPC_Init(void);
void cliSpcKeyOpt(void *arg);

#ifdef __cplusplus
}
#endif
#endif /*__spc_H */
