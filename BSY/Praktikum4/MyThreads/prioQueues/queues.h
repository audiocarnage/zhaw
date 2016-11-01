#ifndef QUEUES_HEADER_FILE
#define QUEUES_HEADER_FILE

//******************************************************************************
// File:    queues.h
// Purpose: header file of queues for scheduler
// Author:  M. Thaler, 2012, (based on former work by J. Zeman and M. Thaler)
// Version:  v.fs16
//******************************************************************************

#include <sys/time.h>

#include "mthread.h"

//******************************************************************************


//******************************************************************************
void       mqInit(void);
void       mqDelete(void);

mthread_t* mqGetNextThread(void);
void       mqAddToQueue(mthread_t* tcb, int where);

//******************************************************************************

#endif // QUEUES_HEADER
