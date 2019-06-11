#ifndef __spc_H
#define __spc_H
#ifdef __cplusplus
 extern "C" {
#endif

#include "main.h"
#include "cmsis_os.h"

#define SPC_MAX_EVENTS 30
#define NUM_ROWS(ARRAY) (sizeof(ARRAY) / sizeof(ARRAY[0]))

#define GSM_STATE_ANY 0xffff

typedef enum
{
    SPC,                        /*!<state machine running.*/
    MAX_DEVICES,                        /*!<state machine stopped.*/
} spc_gsm_devices;

typedef struct
{
    uint16_t enumValue;                     /*!<enum value.*/
    const char *stringValue;                /*!<string equivalent for the enum value.*/
}gsmEnumStringMap;

typedef struct {
    uint16_t item;
    void *itemData; /* data associated with the item (e.g. event data) */
} t_gsm_queueEntry;

typedef struct {
    t_gsm_queueEntry *queue;
    int count;
    int head;
    int tail;
    int size;
} t_gsm_queue;

typedef enum
{
    GSM_RUNNING,                        /*!<state machine running.*/
    GSM_STOPPED,                        /*!<state machine stopped.*/
    GSM_NOT_STARTED                     /*!<state machine not started.*/
} gsmStatus;

struct GSM_StateMachine;

typedef uint16_t (*pfnEntry)(struct GSM_StateMachine *machine);
typedef uint16_t (*pfnAction)(struct GSM_StateMachine *machine, void *eventData);

typedef struct
{
    uint16_t state;                     /*!<state in the state machine.*/
    pfnEntry entry;                     /*!<Pointer to the function that needs to be invoked upon a state entry.*/
} gsmStateEntry;

typedef struct
{
    uint16_t state;                    /*!<state in the state machine.*/
    uint16_t event;                    /*!<event in the state machine.*/
    pfnAction action;                  /*!<Pointer to the function that needs to be invoked upon an event.*/
} gsmEventAction;

struct GSM_StateMachine
{
    const char *gsm_name;
    t_gsm_queue *gsm_eventQueue;
    int gsm_eventMax;                         /*!<Maximum number of events in the state machine.*/
    int gsm_stateMax;                         /*!<Maximum number of states in the state machine.*/
    int gsm_eventActionSize;                  /*!<Size of the event action table.*/
    uint16_t gsm_startState;
    uint16_t gsm_stateChangeEvent; /* State change event */
    osMutexId gsm_stateMutex;
    osMutexId gsm_stateCond;
    const gsmEnumStringMap *gsm_stateNames;     /*!<Pointer to the table containing state enums and their string description.*/
    const gsmEnumStringMap *gsm_eventNames;     /*!<Pointer to the table containing event enums and their string description.*/
    uint16_t gsm_currentState;                  /*!<current active state.*/ 
    gsmStatus gsm_status;                       /*!<whether running or not.1- currently running and 0 else.*/
    const gsmStateEntry *gsm_stateEntry;        /*!<Pointer to the table of entry function pointers for each state.*/
    const gsmEventAction *gsm_eventAction;      /*!<Pointer to the table of action function pointers for each event.*/
    TaskHandle_t taskHandle;
};

typedef struct GSM_StateMachine GSM_StateMachine;

typedef enum
{
    SPC_STATE_INIT = 1,
    SPC_STATE_EXT,
    SPC_STATE_NUM_STATES
} SPC_STATE_T;

typedef enum
{
    SPC_EVENT_STATECHANGE = 0,               /**< enum On changing to this state */
    SPC_EVENT_STAY_INIT,                 /**< enum On Firmware Load Timer expiring */
    SPC_EVENT_GOTO_EXE,
    SPC_EVENT_STAY_EXE,
    SPC_EVENT_GOTO_INIT,
    SPC_EVENT_NUM_EVENTS,
    SPC_EVENT_NOEVENT
} SPC_EVENT_T;

uint16_t spc_InitStateEntry(GSM_StateMachine *gsm);
uint16_t spc_ExeStateEntry(GSM_StateMachine *gsm);
uint16_t spc_StayInitEventHandler(GSM_StateMachine *gsm, void *eventData);
uint16_t spc_GotoExeEventHandler(GSM_StateMachine *gsm, void *eventData);
uint16_t spc_StayExeEventHandler(GSM_StateMachine *gsm, void *eventData);
uint16_t spc_GotoInitEventHandler(GSM_StateMachine *gsm, void *eventData);

static const gsmStateEntry spcStateEntry[] = {
    { SPC_STATE_INIT,                     spc_InitStateEntry },
    { SPC_STATE_EXT,                      spc_ExeStateEntry },
};

static const gsmEventAction spcEventAction[] = {

    { SPC_STATE_INIT,            SPC_EVENT_STAY_INIT,         spc_StayInitEventHandler},
    { SPC_STATE_INIT,            SPC_EVENT_GOTO_EXE,          spc_GotoExeEventHandler},
    { SPC_STATE_EXT,             SPC_EVENT_STAY_EXE,          spc_StayExeEventHandler},
    { SPC_STATE_EXT,             SPC_EVENT_GOTO_INIT,         spc_GotoInitEventHandler},
};

/**
 * Table containing the state enum-to-name mapping
 */
#define ENUM_STRING(x) {x, #x}
static const gsmEnumStringMap spcStateNames[] = {
    ENUM_STRING(SPC_STATE_INIT),
    ENUM_STRING(SPC_STATE_EXT),
};

static const gsmEnumStringMap spcEventNames[] = {
    ENUM_STRING(SPC_EVENT_STATECHANGE),
    ENUM_STRING(SPC_EVENT_STAY_INIT),
    ENUM_STRING(SPC_EVENT_GOTO_EXE),
    ENUM_STRING(SPC_EVENT_STAY_EXE),
    ENUM_STRING(SPC_EVENT_GOTO_INIT),
};

void SPC_Init(void);
int gsm_SetNextEvent(GSM_StateMachine *machine, uint16_t nextEvent, void *eventData, uint16_t dataSize);

#ifdef __cplusplus
}
#endif
#endif /*__spc_H */
