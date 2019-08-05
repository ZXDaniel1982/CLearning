#ifndef __statemachine_H
#define __statemachine_H
#ifdef __cplusplus
 extern "C" {
#endif

#include "main.h"
#include "cmsis_os.h"

#define GSM_MAX_EVENTS 30
#define GSM_STATE_ANY 0xffff

typedef enum
{
    GSM,                        /*!<state machine running.*/
    MAX_DEVICES,                        /*!<state machine stopped.*/
} gsm_gsm_devices;

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
} gsmStateEntry_t;

typedef struct
{
    uint16_t state;                    /*!<state in the state machine.*/
    uint16_t event;                    /*!<event in the state machine.*/
    pfnAction action;                  /*!<Pointer to the function that needs to be invoked upon an event.*/
} gsmEventAction_t;

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
    const gsmStateEntry_t *gsm_stateEntry;        /*!<Pointer to the table of entry function pointers for each state.*/
    const gsmEventAction_t *gsm_eventAction;      /*!<Pointer to the table of action function pointers for each event.*/
    TaskHandle_t taskHandle;
};

typedef struct GSM_StateMachine GSM_StateMachine;

typedef enum
{
    GSM_STATE_INIT = 1,
    GSM_STATE_EXT,
    GSM_STATE_NUM_STATES
} GSM_STATE_T;

typedef enum
{
    GSM_EVENT_STATECHANGE = 0,               /**< enum On changing to this state */
    GSM_EVENT_STAY_INIT,                 /**< enum On Firmware Load Timer expiring */
    GSM_EVENT_GOTO_EXE,
    GSM_EVENT_STAY_EXE,
    GSM_EVENT_GOTO_INIT,
    GSM_EVENT_NUM_EVENTS,
    GSM_EVENT_NOEVENT
} GSM_EVENT_T;

uint16_t gsm_InitStateEntry(GSM_StateMachine *gsm);
uint16_t gsm_ExeStateEntry(GSM_StateMachine *gsm);
uint16_t gsm_StayInitEventHandler(GSM_StateMachine *gsm, void *eventData);
uint16_t gsm_GotoExeEventHandler(GSM_StateMachine *gsm, void *eventData);
uint16_t gsm_StayExeEventHandler(GSM_StateMachine *gsm, void *eventData);
uint16_t gsm_GotoInitEventHandler(GSM_StateMachine *gsm, void *eventData);

static const gsmStateEntry_t gsmStateEntry[] = {
    { GSM_STATE_INIT,                     gsm_InitStateEntry },
    { GSM_STATE_EXT,                      gsm_ExeStateEntry },
};

static const gsmEventAction_t gsmEventAction[] = {

    { GSM_STATE_INIT,            GSM_EVENT_STAY_INIT,         gsm_StayInitEventHandler},
    { GSM_STATE_INIT,            GSM_EVENT_GOTO_EXE,          gsm_GotoExeEventHandler},
    { GSM_STATE_EXT,             GSM_EVENT_STAY_EXE,          gsm_StayExeEventHandler},
    { GSM_STATE_EXT,             GSM_EVENT_GOTO_INIT,         gsm_GotoInitEventHandler},
};

/**
 * Table containing the state enum-to-name mapping
 */
#define ENUM_STRING(x) {x, #x}
static const gsmEnumStringMap gsmStateNames[] = {
    ENUM_STRING(GSM_STATE_INIT),
    ENUM_STRING(GSM_STATE_EXT),
};

static const gsmEnumStringMap gsmEventNames[] = {
    ENUM_STRING(GSM_EVENT_STATECHANGE),
    ENUM_STRING(GSM_EVENT_STAY_INIT),
    ENUM_STRING(GSM_EVENT_GOTO_EXE),
    ENUM_STRING(GSM_EVENT_STAY_EXE),
    ENUM_STRING(GSM_EVENT_GOTO_INIT),
};

void statemachine_Init(void);
int gsm_SetNextEvent(GSM_StateMachine *machine, uint16_t nextEvent, void *eventData, uint16_t dataSize);

#ifdef __cplusplus
}
#endif
#endif /*__statemachine_H */
