//************************************************************************
// Course:  BSy
// Author:  M. Thaler, ZHAW, 2016
// File:    threadpool.c
// Purpose: thread pool and task queue implementation with message queues
//************************************************************************

#include <mqueue.h>
#include <pthread.h>
#include <stdio.h>

#include "threadpool.h"

//************************************************************************

#define TASK_QUEUE_MQ "/my_task_queue_mq"
#define WAIT_QUEUE_MQ "/my_wait_queue_mq"
#define MAX_THREADS    32

#define MYQ_FLAGS    0
#define MYQ_MESGS   10
#define MYQ_MSGSZ   16

//************************************************************************

typedef struct minTaskDataStruct {
    void   *this;
    taskfun_t func;
} task_t;

//************************************************************************


static pthread_t th[MAX_THREADS];
static int       nTh;

//************************************************************************

void *threadPoolFun(void *arg) {
    // ...
}

//------------------------------------------------------------------------
void runTask(void *taskObject) {
  
}

void startThreadPool(int nThreads) {
    
    nTh = (nThreads <= MAX_THREADS) ? nThreads : MAX_THREADS;

    // ...

    for (long i = 0; i < nTh; i++)
        pthread_create(&th[i], NULL, threadPoolFun, (void *)i);
}

void stopThreadPool(void) {

    // ...

}

//************************************************************************
