/* Includes ------------------------------------------------------------------*/
#include "cli.h"
#include "lcd.h"
#include "usart.h"
#include "FreeRTOS.h"

osThreadId CliTaskHandle;
osMessageQId CliQueueHandle;

const CliCommand_t cliCommandList[] = {
  {READ_EEPROM_INFO, cliShowEEPROMInfo},
	{READ_SD_INFO, cliShowSdInfo},
	{READ_SD_FILE_LIST, cliShowSdFileInfo}
};

const char *cliUsage[] = {
  "======Invalid command========\r\n",
	"Use bellow commands:         \r\n",
	"                             \r\n",
	"1 : Show EEPROM device info  \r\n",
	"2 : Show SD device info      \r\n",
	"3 : Show SD card files info  \r\n"
};

static void CliTask(void const *arg);
/*----------------------------------------------------------------------------*/
/* Public functions                                                           */
/*----------------------------------------------------------------------------*/
void Cli_Init(void)
{
  osThreadDef(CliTaskName, CliTask, osPriorityBelowNormal, 0, 128);
  CliTaskHandle = osThreadCreate(osThread(CliTaskName), NULL);
	
	osMessageQDef(CliQueueName, 4, uint16_t);
	CliQueueHandle = osMessageCreate(osMessageQ(CliQueueName), NULL);
}

static void cliShowUage(void)
{
	uint8_t i;
	
	for (i=0; i<ARRY_NUM(cliUsage); i++) {
		uartprintf(cliUsage[i]);
	}
	return;
}

static void cliSendBlank(void)
{
	uartprintf(BLANK_STR);
}

static void CliProcessCommand(uint16_t cliCommand)
{
	uint8_t i;
	
	osDelay(300);
	cliSendBlank();
	if (!ISVALID(cliCommand)) {
	  cliShowUage();
		cliSendBlank();
		return;
	}
	
	for (i=0; i<ARRY_NUM(cliCommandList); i++) {
	  if (cliCommandList[i].index == cliCommand) {
		  cliCommandList[i].func(&cliCommand);
			cliSendBlank();
			return;
		}
	}
	
	cliShowUage();
	cliSendBlank();
}

static void CliTask(void const *arg)
{
	osEvent event;
	uint16_t command = 0;
	
	while (1) {
	  event = osMessageGet (CliQueueHandle, osWaitForever );
		if (event.status == osEventMessage) {
      command = event.value.v;
      CliProcessCommand(command);
    }
	}
}
