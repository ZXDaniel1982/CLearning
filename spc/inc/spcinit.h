#ifndef _SPC_INIT_H_
#define _SPC_INIT_H_

#include "spcconst.h"

// For SPC test 
#define SPC_TEST_TEMP_STATUS      ( SPC_TEMP_NORMAL )
#define SPC_SIMULATE_TEMP_C       ( 20 )
#define SPC_SIMULATE_TEMP_F       ( 20 )
#define SPC_SIMULATE_GFI          ( 10 )

void Spc_StartupLog(void);
void Spc_SystemInit(SpcValue_t *SpcValue);
void Spc_SelfCheck(SpcValue_t *SpcValue);
void SpcShowDefInfo(SpcValue_t *SpcValue);
void SpcSetTestData(SpcValue_t *SpcValue);

#endif // _SPC_INIT_H_