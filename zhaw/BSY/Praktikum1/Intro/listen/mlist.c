//******************************************************************************
// File:    mlist.c
// Purpose: implementation mlist (a single linked list with header dummy)
// Author:  R. Georgiou, 2016, (based on former work by J. Zeman and M. Thaler)
// Version: v.fs16
//******************************************************************************

#include <stdlib.h>
#include "commondefs.h"
#include "mthread.h"
#include "mlist.h"

//******************************************************************************
// macro to allocate new tnode_t

#define mlNewTNode() (tnode_t *)malloc(sizeof(tnode_t))

//******************************************************************************

mlist_t* mlNewList()
{
    mlist_t *list = (mlist_t *)malloc(sizeof(mlist_t));
    tnode_t *dummy = mlNewTNode();
    list->head = dummy;
    list->head->tcb = NULL;
    list->head->next = NULL;
    list->tail = dummy;
    list->iter = NULL;
    list->numNodes = 0;
    return list;
}

void mlDelList(mlist_t *list)
{
    while (list->head->next != NULL)
    {
    	tnode_t *currentNode = list->head->next;
    	list->head->next = currentNode->next;
        free(currentNode->tcb);
        free(currentNode);
    }
    free(list->head);
    free(list);
}

void mlEnqueue(mlist_t *list, mthread_t *tcb)
{
    tnode_t *tailNode = mlNewTNode();
    tailNode->tcb = tcb;
    tailNode->next = NULL;
    list->tail->next = tailNode;
    list->tail = tailNode;

    list->numNodes = list->numNodes + 1;
}

mthread_t* mlDequeue(mlist_t *list)
{
    if (mlGetNumNodes(list) == 0)
    {
	return NULL;
    }

    tnode_t *newDummy = list->head->next;
    mthread_t *thread = newDummy->tcb;
    free(list->head);
    list->head = newDummy;
    list->head->tcb = NULL;
    list->numNodes = list->numNodes - 1;

    if (mlGetNumNodes(list) == 0)
    {
        list->head->next = NULL;
        list->tail = list->head;
    }
    return thread;
}

void mlSortIn(mlist_t *list, mthread_t *tcb)
{
    tnode_t *previousNode = list->head;
    while (previousNode->next != NULL && tcb->readyTime > previousNode->next->tcb->readyTime)
    {
        previousNode = previousNode->next;
    }

    tnode_t *newNode = mlNewTNode();
    newNode->tcb = tcb;

    tnode_t *nextNode = previousNode->next;
    previousNode->next = newNode;
    newNode->next = nextNode;
    if (newNode->next == NULL)
    {
	list->tail = newNode;
    }

    list->numNodes = list->numNodes + 1;
}

mthread_t* mlReadFirst(mlist_t *list)
{
    if (mlGetNumNodes(list) == 0)
    {
	return NULL;
    }
    return list->head->next->tcb;
}

unsigned int mlGetNumNodes(mlist_t *list)
{
    return list->numNodes;
}

void mlSetPtrFirst(mlist_t *list)
{
    list->iter = list->head->next;
}

void mlSetPtrNext(mlist_t *list)
{
    if (list->iter != NULL)
    {
        list->iter = list->iter->next;
    }
}

mthread_t* mlReadCurrent(mlist_t *list)
{
    if (list->iter == NULL)
    {
	return NULL;
    }
    return list->iter->tcb;
}
