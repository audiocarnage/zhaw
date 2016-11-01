//******************************************************************************
// File:    main4.c
// Purpose: demo program for mythreads: sleeping threads
// Author:  M. Thaler, 2012
// Version: v.fs16
//******************************************************************************

#include <stdlib.h>
#include <stdio.h>
#include <unistd.h>
#include <assert.h>

#include "mythreads.h"

#define ITERS   100
#define TICTACS  10

//******************************************************************************
int tictacCount = 0;
//******************************************************************************

void* printMessage(void* ptr);
void* printMessageSleep(void* ptr);

//******************************************************************************

int main (void)
{
    mthread_t   *thread1, *thread2;
    const char  *msg1 = "Hello";
    const char  *msg2 = "\tWorld";


    printf("program main4 starting\n");

    mthreadCreate(thread1, printMessage, (void *)msg1,      HIGH, STACK_SIZE);
    mthreadCreate(thread2, printMessageSleep, (void *)msg2, HIGH, STACK_SIZE);

    mthreadJoin();

    assert(tictacCount == TICTACS);

    printf("\nscheduler terminated .... \n");
}

//******************************************************************************

void* printMessage(void* ptr)                // user defined thread function
{
    char *message;
    unsigned i, j;

    message = (char*) ptr;
    for (i = 0; i < ITERS; i++) {
        printf("%s  \n", message);
        for (j = 0; j < 500000; j++) {}    // do some work 
    }
    mthreadSleep(4000);
    printf("Thread \"%s\" terminates\n", message);
    mthreadExit();
}

//******************************************************************************

void* printMessageSleep(void* ptr)           // user defined thread function
{
    char *message;
    unsigned int i, j;

    message = (char*) ptr;
    for (i = 0; i < ITERS; i++) {
        printf("%s  \n", message);
        for (j = 0; j < 500000; j++) {}    // do some work 
    }
    mthreadSleep(2000);
    printf("-> thread %s sleeping for 2s\n", message);
    mthreadSleep(1000);

    for (i = 0; i < TICTACS; i++) {
        if (!(i%2))
            printf(" -> tic\n");
        else
            printf(" -> tac\n");
        tictacCount++;
        mthreadSleep(1000);
    }
    printf("Thread \"%s\" terminates\n", message);
    mthreadExit();
}

//******************************************************************************

