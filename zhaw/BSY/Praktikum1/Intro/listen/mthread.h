#ifndef MTHREAD_HEADER_FILE
#define MTHREAD_HEADER_FILE

//******************************************************************************
// File:    mthread.h
// Purpose: header file for thread handling thread control blocks (tcb)
// Author:  M. Thaler, 2012, (based on former work by J. Zeman and M. Thaler)
// Version: v.fs16
//******************************************************************************

#include "commondefs.h"
//#define MACRO

//******************************************************************************
// Thread control block

typedef struct mthread {
    unsigned int tID;              // thread-ID
    unsigned int readyTime;        // time, when thread is ready to run
} mthread_t;

//******************************************************************************
// function prototypes 

    mthread_t*    mtNewThread(unsigned int id, tprio_t prio, unsigned int readyTime);
    void          mtDelThread(mthread_t *tcb);

//******************************************************************************
// single variable access functions

    unsigned int  mtGetID(mthread_t* tcb);
    void          mtSetReadyTime(mthread_t* tcb, unsigned int rtime);

#ifndef MACRO
    unsigned int  mtGetReadyTime(mthread_t* tcb);
#else
    #define     mtGetReadyTime(X) X->readyTime
#endif
    
//******************************************************************************

#endif // MTHREAD_HEADER_FILE
