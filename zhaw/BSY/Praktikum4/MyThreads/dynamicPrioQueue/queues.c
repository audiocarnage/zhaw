//******************************************************************************
// File:    queues.c
// Purpose: implementation of queues for scheduler
// Author:  M. Thaler, 2012, (based on former work by J. Zeman and M. Thaler)
// Changes: tham, 2/2015
// Version: v.fs16
//******************************************************************************

#include <stdlib.h>
#include <sys/types.h>
#include <sys/times.h>
#include <unistd.h>
#include <stdio.h>

#include "mlist.h"
#include "mthread.h"
#include "queues.h"

//******************************************************************************
// local function prototypes

unsigned int mqGetTime(void);

//******************************************************************************
// Static data of queueing system

mlist_t *readyQueues[NUM_PRIO_QUEUES];                 // array of ready queues
mlist_t *waitQueue;

//******************************************************************************
//
// Queueing functions
//
//==============================================================================
// Function:    initQueues
// Purpose:     initialize queueing system
//              behaves like a singleton

void mqInit(void) {
    static int queueState = 0;
    if (queueState == 0) {
	readyQueues[HIGH] = mlNewList();
	readyQueues[MEDIUM] = mlNewList();
	readyQueues[LOW] = mlNewList();
  	waitQueue = mlNewList();
        mqGetTime();                                // register start time
        queueState = 1;                             // now we are initialized
    }
}

//==============================================================================
// Function:    delQueues
// Purpose:     clean up dynamically allocated data
// Hint:        will be called by scheduler before termination

void mqDelete(void) {
    int i;
    for (i = 0; i < NUM_PRIO_QUEUES; i++)
        mlDelList(readyQueues[i]);
    printf("\n*** cleaning queues ***\n");
}

//==============================================================================
// Function:    getNextThread
// Purpose:     returns thread (tcb) with highest priority in the ready queues
//              if there is no thread, return value is NULL

mthread_t* mqGetNextThread(void) {
    mthread_t* tcb = NULL;

    mthread_t *waitingTCB = NULL;
    while ((waitingTCB = mlDequeue(waitQueue)) != NULL)
    {
        if (mqGetTime() > waitingTCB->readyTime)
	    mqAddToQueue(waitingTCB, 0);
	else
	    mlEnqueue(waitQueue, waitingTCB);
    }

    if (mlGetNumNodes(readyQueues[HIGH]) > 0)
    	tcb = mlDequeue(readyQueues[HIGH]);
    else if (mlGetNumNodes(readyQueues[MEDIUM]) > 0)
    	tcb = mlDequeue(readyQueues[MEDIUM]);
    else if (mlGetNumNodes(readyQueues[LOW]) > 0)
    	tcb = mlDequeue(readyQueues[LOW]);

    return tcb;
}

//==============================================================================
// Function:    add to queue
// Purpose:     initialize queueing system

void mqAddToQueue(mthread_t *tcb, int where) {
    if (tcb->tPrio >= NUM_PRIO_QUEUES || tcb->tPrio < 0)
	(void)printf("unknown thread priority, cannot enqueue.");
    
    if (where > 0)
    {
	if (where < 10)
	    tcb->tPrio = HIGH;
	else if (where < 50 && where >= 10)
	    tcb->tPrio = MEDIUM;
	else
	    tcb->tPrio = LOW;

	tcb->readyTime = mqGetTime() + where;
	mlSortIn(waitQueue, tcb);
    }
    else
    {
        mlEnqueue(readyQueues[tcb->tPrio], tcb);
    }
}

//==============================================================================
// Function:    printReadyQueueStatus
// Purpose:     prints the number of threads in the ready queues at mqGetTime()

void lqPrintReadyQueueStatus(mlist_t *queue) {
    printf("\t\tqueue, %d entries at time %d\n", 
                                        mlGetNumNodes(queue), mqGetTime());
}

//******************************************************************************
// Function:    getTime, local function
// Purpose:     returns wall clock time in 1ms resolution since program start,
//              works like singleton to register start time of module

unsigned int mqGetTime(void) {
    static int    firstCall = 1;
    static struct timeval startTime;

    struct timeval currentTime;
    unsigned int time;

    if (firstCall) {
        gettimeofday(&startTime, NULL);
        firstCall = 0;
    }

    if (gettimeofday(&currentTime, NULL) < 0)
        perror("gettimeofday failed: ");
    time = (unsigned int)((currentTime.tv_sec  - startTime.tv_sec)*1000 + 
                         (currentTime.tv_usec - startTime.tv_usec)/1000);
    return time;
}

//******************************************************************************

