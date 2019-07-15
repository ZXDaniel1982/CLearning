/* Includes ------------------------------------------------------------------*/
#include "spclist.h"

static inline bool SpcListIsFull(SpcList_t * list);
static inline bool SpcListIsEmpty(SpcList_t * list);
static SpcItem_t *SpcFreeList(SpcList_t * list);

/* List functions */
static inline bool SpcListIsFull(SpcList_t * list)
{
    return list->totalNum >= list->maxSize;
}

static inline bool SpcListIsEmpty(SpcList_t * list)
{
    return list->totalNum == 0;
}

static SpcItem_t *SpcFreeList(SpcList_t * list)
{
    SpcItem_t *itemToDel = NULL;
    SpcItem_t *itemIndex = &(list->item);
    while ((itemIndex->next) != NULL) {
        if (itemIndex->next->alarmPrio == SpcAlarmNormal) {
            itemToDel = itemIndex->next;
            itemIndex->next = itemIndex->next->next;
            return itemToDel;
        }
    }

    return NULL;
}

void SpcListInit(SpcList_t * list, uint8_t size)
{
    list->totalNum = 0;
    list->maxSize = size;

    SpcItem_t *item = &(list->item);
    item->alarmType = SPC_MAX_ALARM_TYPE;
    item->alarmPrio = SpcAlarmCritical;
    item->delfunc = NULL;
    item->addfunc = NULL;
    item->next = NULL;
}

SpcStatus_t SpcListInsert(SpcList_t * list, SpcItem_t *itemToAdd)
{
    if (SpcListIsFull(list)) {
        SpcItem_t *itemToDel = NULL;
        itemToDel = SpcFreeList(list);
        if (itemToDel == NULL) return SPC_ERROR;
        if (itemToDel->delfunc != NULL) itemToDel->delfunc(itemToDel->alarmType);
        vPortFree(itemToDel);
        itemToDel = NULL;
        list->totalNum--;
    }

    SpcItem_t *itemIndex = &(list->item);
    while ((itemIndex->next) != NULL) itemIndex = itemIndex->next;

    itemIndex->next = itemToAdd;
    list->totalNum++;
    if (itemToAdd->addfunc != NULL) itemToAdd->addfunc(itemToAdd->alarmType);
    return SPC_NORMAL;
}

SpcStatus_t SpcListRemove(SpcList_t * list, SpcAlarmType_t alarmType)
{
    if (SpcListIsEmpty(list)) return SPC_ERROR;

    SpcItem_t *itemToDel = NULL;
    SpcItem_t *itemIndex = &(list->item);
    while ((itemIndex->next) != NULL) {
        if (itemIndex->next->alarmType == alarmType) {
            itemToDel = itemIndex->next;
            itemIndex->next = itemIndex->next->next;
            if (itemToDel->delfunc != NULL) itemToDel->delfunc(itemToDel->alarmType);
            vPortFree(itemToDel);
            itemToDel = NULL;
            return SPC_NORMAL;
        }
    }
    return SPC_ERROR;
}
