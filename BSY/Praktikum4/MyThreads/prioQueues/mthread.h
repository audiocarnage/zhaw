#ifndef MYTHREAD_HEADER
#define MYTHREAD_HEADER

//******************************************************************************
// File:     mthread.h
// Purpose:  header file for thread handling functions and data
// Author:   M. Thaler, 2012, (based on former work by J. Zeman and M. Thaler)
// Revision: 1/2014, 2/2015
// Veriosn:  v.fs16
//******************************************************************************

//#define FX_SIZE 512

#include "commondefs.h"

//------------------------------------------------------------------------------
// Thread control block

typedef struct mthread_struct {
    unsigned int  tID;              // thread-ID
    tprio_t       tPrio;            // thread priority
    unsigned int  readyTime;        // time, when a a waiting tcbread
                                    // can be activated, in clock ticks    

    tfunc_t       startFunction;    // thread function (pointer)
    void          *arg;             // argument of thread function (pointer)

    unsigned long stackpointer;     // current stackpointer of the thread
    unsigned long stack;            // bottom of stack
    //char 	  fx;		    // address of 512 Byte memory region

    int           firstCall;        // thread runs for the first time
} mthread_t;

//******************************************************************************
// function prototypes 

    mthread_t* mtNewThread(tfunc_t function, void* arg, tprio_t prio, 
                                             unsigned int stacksize);
    void      mtDelThread(mthread_t* tcb);
    long      mtGetFreeStackSize(mthread_t* tcb);


    unsigned  int mtGetID(mthread_t* tcb);

    tprio_t   mtGetPrio(mthread_t* tcb);

    void      mtSetReadyTime(mthread_t* tcb, unsigned int rtime);    
    unsigned  int mtGetReadyTime(mthread_t* tcb);

    tfunc_t   mtGetStartFunction(mthread_t* tcb);
    void*     mtGetArgPointer(mthread_t* tcb);

    void      mtSaveSP(mthread_t* tcb, unsigned long sp);
    unsigned  long mtGetSP(mthread_t* tcb);

    int       mtIsFirstCall(mthread_t* tcb);
    void      mtClearFirstCall(mthread_t* tcb);

    void      mtPrintTCB(mthread_t* tcb);
    
//******************************************************************************

#endif // MYTHREAD_HEADER
