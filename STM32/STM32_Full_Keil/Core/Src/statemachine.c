/* Includes ------------------------------------------------------------------*/
#include "statemachine.h"
#include "FreeRTOS.h"
#include "lcd.h"
#include <string.h>
#include <stdlib.h>

#define GSM_NAME_MAX_LEN 20
#define sleepPeriod      0xffffffff

static GSM_StateMachine *gsm_machines[MAX_DEVICES];

osTimerId gsmTimer;

/*----------------------------------------------------------------------------*/
/* Private functions                                                           */
/*----------------------------------------------------------------------------*/
static t_gsm_queue *gsm_QueueInit(int size)
{
    t_gsm_queue *queue = malloc(sizeof(t_gsm_queue));

    if (queue == NULL) {
        return NULL;
    }

    queue->head = 0;
    queue->tail = 0;
    queue->count = 0;
    queue->size = size;

    queue->queue = malloc(sizeof(*queue->queue) * size);

    if (queue->queue == NULL) {
        /* Malloc failed */
        free(queue);
        return NULL;
    }

    return queue;
}

static GSM_StateMachine *gsm_CreateMachine(const char *name,
                       const gsmStateEntry * entry,
                       const gsmEventAction * action,
                       uint16_t numStates,
                       uint16_t numEvents,
                       uint16_t eventActionSize,
                       uint16_t eventQueueSize,
                       const gsmEnumStringMap *
                       pStateNames,
                       const gsmEnumStringMap *
                       pEventNames)
{
    if (entry == NULL) {
        tftprintf("Fail to get GSM entry");
    }

    if (action == NULL) {
        tftprintf("Fail to get GSM action");
    }

    GSM_StateMachine *machine = malloc(sizeof(GSM_StateMachine));
    if (machine == NULL) {
        tftprintf("%s alloc failed for GSM_StateMachine", name);
        return NULL;
    }

    machine->gsm_eventQueue = gsm_QueueInit(eventQueueSize);
    if (machine->gsm_eventQueue == NULL) {
        tftprintf("%s alloc failed for event queue", name);
        free(machine);
        return NULL;
    }

    machine->gsm_name = name;
    machine->gsm_stateMax = numStates;
    machine->gsm_eventMax = numEvents;
    machine->gsm_eventActionSize = eventActionSize;
    machine->gsm_stateNames = pStateNames;
    machine->gsm_eventNames = pEventNames;

    machine->gsm_status = GSM_NOT_STARTED;
    machine->gsm_currentState = 0;

    machine->gsm_stateEntry = entry;
    machine->gsm_eventAction = action;

    osMutexDef(SpcGSMMutex);
    machine->gsm_stateMutex = osMutexCreate(osMutex(SpcGSMMutex));

    osSemaphoreDef(SpcGSMCond);
    machine->gsm_stateCond = osSemaphoreCreate(osSemaphore(SpcGSMCond), 1);

    return machine;
}

static void GSM_Init()
{
    static char gsmName[GSM_NAME_MAX_LEN];

    snprintf(gsmName, GSM_NAME_MAX_LEN, "SPCStateMachine");

    gsm_machines[SPC] = gsm_CreateMachine(gsmName,  // char               *name
                      spcStateEntry,                // gsmStateEntry      *entry
                      spcEventAction,               // gsmEventAction     *action
                      SPC_STATE_NUM_STATES,         // uint16_t           numStates
                      SPC_EVENT_NUM_EVENTS,         // uint16_t           numEvents
                      NUM_ROWS(spcEventAction),     // uint16_t           eventActionSize
                      GSM_MAX_EVENTS,               // uint16_t           eventQueueSize
                      spcStateNames,                // gsmEnumStringMap   *pStateNames
                      spcEventNames                 // gsmEnumStringMap   *pEventNames
    );
}

static inline bool gsm_QueueIsEmpty(t_gsm_queue * queue)
{
    return queue->count == 0;
}

static inline bool gsm_QueueIsFull(t_gsm_queue * queue)
{
    return queue->size == queue->count;
}

static int gsm_EnqueueItem(t_gsm_queue * queue, uint16_t item, void *data)
{
    if (queue->count >= queue->size) {
        /* queue is full */
        return -1;
    }

    queue->queue[queue->tail].item = item;
    queue->queue[queue->tail++].itemData = data;
    queue->tail %= queue->size;
    queue->count++;

    return 0;
}

static int gsm_DequeueItem(t_gsm_queue * queue, uint16_t * item,
               void **datap)
{
    if (queue->count == 0) {
        /* queue is empty */
        return -1;
    }

    *item = queue->queue[queue->head].item;
    if (datap) {
        *datap = queue->queue[queue->head].itemData;
    }
    queue->head = (queue->head + 1) % queue->size;
    queue->count--;

    return 0;
}

static void gsm_AddEvent(GSM_StateMachine * machine, uint16_t Event,
             void *eventData, uint16_t dataSize)
{
    int res = -1;
    void *pEnqData = NULL;

    if (!gsm_QueueIsFull(machine->gsm_eventQueue)) {
    //allocate and copy eventData
    if (dataSize && eventData) {
        pEnqData = malloc(dataSize);
        if (!pEnqData) {
            tftprintf("failed to allocate memory for event data");
            return;
        }
        memcpy(pEnqData, eventData, dataSize);
    }
    res = gsm_EnqueueItem(machine->gsm_eventQueue, Event, pEnqData);
    }

    if (res < 0) {
        tftprintf("%s ERROR Too many events in queue (%d)",
              machine->gsm_name, machine->gsm_eventQueue->count);
    }
}

static int gsm_Wait(GSM_StateMachine * machine)
{
    osMutexWait(machine->gsm_stateMutex, sleepPeriod);

    if (gsm_QueueIsEmpty(machine->gsm_eventQueue)) {
        osMutexRelease(machine->gsm_stateMutex);
        osSemaphoreWait(machine->gsm_stateCond, sleepPeriod);
    } else {
        osMutexRelease(machine->gsm_stateMutex);
    }
    return 0;
}

static void gsm_ProcessStateChange(GSM_StateMachine * pStateMachine,
                   uint16_t newState)
{
    gsmStateEntry entryElement = { 0 };
    uint16_t nextState = newState;
    int i;

    /*Find if entry function exists */
    for (i = 0; i < pStateMachine->gsm_stateMax; i++) {
        entryElement = pStateMachine->gsm_stateEntry[i];
        if (entryElement.state == newState) {
            if (entryElement.entry) {
                /*Invoke entry function */
                nextState = entryElement.entry(pStateMachine);
                break;
            }
        }
    }

    if (pStateMachine->gsm_currentState != nextState) {
        /* Queue a state change event */
        gsm_SetNextEvent(pStateMachine,
                 pStateMachine->gsm_stateChangeEvent, &nextState,
                 sizeof(nextState));
    }
}

static void gsm_Start(GSM_StateMachine * pStateMachine,
              uint16_t startState, uint16_t stateChangeEvent)
{
    if (pStateMachine == NULL) {
        tftprintf("Could not find any machine");
    }

    pStateMachine->gsm_currentState = startState;
    pStateMachine->gsm_stateChangeEvent = stateChangeEvent;
    pStateMachine->gsm_status = GSM_RUNNING;
    gsm_ProcessStateChange(pStateMachine, startState);
}

int gsm_NextEvent(GSM_StateMachine * machine, void **eventData)
{
    uint16_t event = 0;
    int res = -1;

    osMutexWait(machine->gsm_stateMutex, sleepPeriod);  // TODO This is inconsistent with add

    /* No saved events, check main queue */
    res = gsm_DequeueItem(machine->gsm_eventQueue, &event, eventData);
    osMutexRelease(machine->gsm_stateMutex);

    if (res == 0) {
        return event;
    } else {
        /* no item available */
        return -1;
    }
}

static int32_t gsm_SendEvent(GSM_StateMachine * pStateMachine,
                 uint16_t event, void *eventData)
{
    const gsmEventAction *actionElement = NULL;
    int i;

    if (pStateMachine == NULL) {
        tftprintf("Could not find any machine");
    }

    if (pStateMachine->gsm_status != GSM_RUNNING) {
        return -1;
    }
    uint16_t nextState = pStateMachine->gsm_currentState;
    /* Check for state change event, do the state change first before checking for state change handler */
    if (event == pStateMachine->gsm_stateChangeEvent) {
        if (eventData == NULL) {
            tftprintf("ERROR %s sent stateChangeEvent %d",
                  pStateMachine->gsm_name,
                  pStateMachine->gsm_stateChangeEvent);
        } else {
            nextState = *(uint16_t *) eventData;
            pStateMachine->gsm_currentState = nextState;
            gsm_ProcessStateChange(pStateMachine, nextState);
        }
        return -1;
    }

    /*Find action function */
    for (i = 0; i < pStateMachine->gsm_eventActionSize; i++) {
        if (pStateMachine->gsm_eventAction[i].event == event
            && ((pStateMachine->gsm_eventAction[i].state ==
              pStateMachine->gsm_currentState)
             || (pStateMachine->gsm_eventAction[i].state ==
             GSM_STATE_ANY))) {
            actionElement = &pStateMachine->gsm_eventAction[i];
            break;
        }
    }
    // Can't handle the event, so save it until we can
    if (actionElement == NULL) {
        tftprintf("Could not find any action");
        return -1;
    }
    // Handle the event, then free the data
    if (actionElement->action != NULL) {
        nextState = actionElement->action(pStateMachine, eventData);
    }
    if (eventData) {
        free(eventData);
        eventData = NULL;
    }

    /* If next state is different from the current state then queue a state change event for the state machine */
    if (pStateMachine->gsm_currentState != nextState) {
        /* Got a new state */
        gsm_SetNextEvent(pStateMachine,
                 pStateMachine->gsm_stateChangeEvent, &nextState,
                 sizeof(nextState));
    }
    return 0;
}

static void gsm_StateMachine(void *arg)
{
    GSM_StateMachine *machine = (GSM_StateMachine *) arg;
    int nextEvent;
    void *eventData = NULL;
    int32_t res;

    //tftprintf("TASK %lu %s", (unsigned long int) xTaskGetCurrentTaskHandle(), machine->gsm_name);

    // start the state machine
    gsm_Start(machine, machine->gsm_startState,
          machine->gsm_stateChangeEvent);

    while (1) {
        if ((nextEvent = gsm_NextEvent(machine, &eventData)) >= 0) {
            res = gsm_SendEvent(machine, nextEvent, eventData);
            if (res < 0) {  //event not handled so free the data
                free(eventData);
                eventData = NULL;
            }
        } else {
            gsm_Wait(machine);
        }
    }

    vTaskDelete(machine->taskHandle);
}

static int gsm_StartMachine(GSM_StateMachine * machine,
                uint16_t startState, uint16_t stateChangeEvent)
{
    machine->gsm_startState = startState;
    machine->gsm_stateChangeEvent = stateChangeEvent;

    // start our thread
    //tftprintf("%s Creating GSM task", machine->gsm_name);

    xTaskCreate(gsm_StateMachine, (const char *) machine->gsm_name,
        (uint16_t) 128, machine, osPriorityIdle,
        &machine->taskHandle);

    return 0;
}

static void spcTimerCallback(void const *argument)
{
    static int i = 0;
    static const int count = NUM_ROWS(spcEventAction);

    HAL_GPIO_TogglePin(Led_GPIO_Port, Led_Pin);

    gsm_SetNextEvent(gsm_machines[SPC], spcEventAction[i].event, NULL, 0);

    i = (i + 1) % count;
}

static void GSM_Start()
{
    if (gsm_StartMachine
    (gsm_machines[SPC], SPC_STATE_INIT, SPC_EVENT_STATECHANGE) != 0) {
        /* Failed to start */
        return;
    }

    osTimerStart(gsmTimer, 1000);
}

/*----------------------------------------------------------------------------*/
/* Public functions                                                           */
/*----------------------------------------------------------------------------*/
void statemachine_Init(void)
{
    osTimerDef(gsmTimer, spcTimerCallback);
    gsmTimer = osTimerCreate(osTimer(gsmTimer), osTimerPeriodic, NULL);

    GSM_Init();
    GSM_Start();
}

int gsm_SetNextEvent(GSM_StateMachine * machine, uint16_t nextEvent,
             void *eventData, uint16_t dataSize)
{
    if (machine == NULL) {
        tftprintf("Fail to get GSM machine");
    }

    osMutexWait(machine->gsm_stateMutex, sleepPeriod);

    gsm_AddEvent(machine, nextEvent, eventData, dataSize);

    osSemaphoreRelease(machine->gsm_stateCond); // will wake up thread if sleeping
    osMutexRelease(machine->gsm_stateMutex);

    return 0;
}

uint16_t spc_InitStateEntry(GSM_StateMachine * gsm)
{
    return gsm->gsm_currentState;
}

uint16_t spc_ExeStateEntry(GSM_StateMachine * gsm)
{
    return gsm->gsm_currentState;
}

uint16_t spc_StayInitEventHandler(GSM_StateMachine * gsm, void *eventData)
{
    return gsm->gsm_currentState;
}

uint16_t spc_GotoExeEventHandler(GSM_StateMachine * gsm, void *eventData)
{
    return SPC_STATE_EXT;
}

uint16_t spc_StayExeEventHandler(GSM_StateMachine * gsm, void *eventData)
{
    return gsm->gsm_currentState;
}

uint16_t spc_GotoInitEventHandler(GSM_StateMachine * gsm, void *eventData)
{
    return SPC_STATE_INIT;
}
