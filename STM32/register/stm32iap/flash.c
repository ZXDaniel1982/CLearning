#include "stm32f1xx.h"
#include "stm32f103xe.h"
#include "common.h"

void FLASH_Lock()
{
    SET_BIT(FLASH->CR, FLASH_CR_LOCK);
}

void FLASH_Unlock()
{
    if(READ_BIT(FLASH->CR, FLASH_CR_LOCK) != 0) {
		    WRITE_REG(FLASH->KEYR, FLASH_KEY1);
        WRITE_REG(FLASH->KEYR, FLASH_KEY2);
		}
}

bool FLASH_WaitForFinish()
{
    while (FLASH->SR & FLASH_SR_BSY) {}
			
		if (FLASH->SR & FLASH_SR_EOP) {
			  FLASH->SR = FLASH_SR_EOP;
    }
		
		if ((FLASH->SR & FLASH_SR_WRPRTERR) ||
        (FLASH->SR & FLASH_SR_PGERR) ||
        (FLASH->OBR & FLASH_OBR_OPTERR))		{
				return false;
    }
	  return true;
}
