//************************************************************************
// Course:  BSy
// Author:  M. Thaler, ZHAW, 2016
// File:    threadpool.h
// Purpose: thread pool and task queue implementation with message queues
//************************************************************************

#ifndef MY_TASK_QUEUE_MQ
#define MY_TASK_QUEUE_MQ

//************************************************************************

typedef void (*taskfun_t)(void *);

//************************************************************************

// start task queue -> set up nThreads threads
void startThreadPool(int nThreads);

// stop task queue
void stopThreadPool(void);

// add task to queue with task function "func" and data "data"
void runTask(void *tObj);

//************************************************************************

#endif

