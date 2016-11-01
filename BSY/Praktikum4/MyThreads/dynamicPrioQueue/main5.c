//******************************************************************************
// File:    main1.c
// Purpose: demo program for mythreads: Hello World (2 threads)
// Author:  M. Thaler, 2012
// Version: v.fs16
//******************************************************************************

#include <stdlib.h>
#include <stdio.h>
#include <unistd.h>

#include "mythreads.h"

#define ITERS 1000

//******************************************************************************

void* printMessage1(void* ptr);
void* printMessage2(void* ptr);

//******************************************************************************

int main (void)
{
    mthread_t   *thread1, *thread2;
    const char  *message1 = "Hello";
    const char  *message2 = "\tWorld";
    const char  *message3 = "\t\tGruezi";

    printf("program main5 starting\n");

    mthreadCreate(thread1, printMessage1, (void *)message1, HIGH,   STACK_SIZE);
    mthreadCreate(thread1, printMessage1, (void *)message2, MEDIUM, STACK_SIZE);
    mthreadCreate(thread2, printMessage1, (void *)message3, LOW,    STACK_SIZE);

    mthreadJoin();

    printf("\nscheduler terminated .... \n");
}

//******************************************************************************

void* printMessage1(void* ptr)                // user defined thread function
{
    char *message;
    unsigned int i, j;

    message = (char*) ptr;
    for (i = 0; i < ITERS; i++) {
        printf("%s  \n", message);
        for (j = 0; j < 500000; j++) {}    // do some work 
    }
    printf("Thread \"%s\" terminates\n", message);
    mthreadExit();
}

void* printMessage2(void* ptr)                // user defined thread function
{
    char *message;
    unsigned i, j;

    message = (char*) ptr;
    for (i = 0; i < ITERS; i++) {
        printf("%s  \n", message);
        for (j = 0; j < 500000; j++) {}    // do some work 
    }
    printf("Thread \"%s\" terminates\n", message);
    exit(0);
    //mthreadExit();
}

//******************************************************************************

