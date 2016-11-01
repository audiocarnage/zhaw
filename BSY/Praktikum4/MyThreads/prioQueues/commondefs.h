#ifndef COMMONDEFS_HEADER_FILE
#define COMMONDEFS_HEADER_FILE

//******************************************************************************
// File:     commondefs.h
// Purpose:  header file for thread handling functions and data
// Author:   M. Thaler, 2012, (based on former work by J. Zeman and M. Thaler)
// Revision: 
// Version:  v.fs16
//******************************************************************************

//******************************************************************************
// constant values

#ifdef __linux
    #define MIN_STACK_SIZE   (8*1024)
#endif

#ifdef __APPLE__
    #define MIN_STACK_SIZE  (16*1024)
#endif

#define STACK_SIZE  MIN_STACK_SIZE
#define LOW_STACK   (2*1024)

//******************************************************************************
// types

// priorities

#define NUM_PRIO_QUEUES 3
typedef enum tprio { HIGH = 0, MEDIUM = 1, LOW = 2} tprio_t;


// thread function signature: void* function(void *)
typedef void* (*tfunc_t)(void *);

//******************************************************************************
#endif

