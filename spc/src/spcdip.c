#include <stdio.h>
#include <stdlib.h>
#include <string.h>
#include <unistd.h>

#include "spcconst.h"

void Spc_ScreenUpdateStatic(int16_t line1, int16_t line2)
{
	clear();
    printf("%s\n", SpcStrPool[line1].str);
    printf("%s\n", SpcStrPool[line2].str);
}

void Spc_ScreenUpdateDynamic(int16_t line1, char *buf)
{
	clear();
    printf("%s\n", SpcStrPool[line1].str);
    printf("%s\n", buf);
}