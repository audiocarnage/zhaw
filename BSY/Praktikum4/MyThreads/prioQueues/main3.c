//******************************************************************************
// File:    main3.c
// Purpose: demo program for mythreads: Hello World (2 threads)
// Author:  M. Thaler, 2012
// Version: v.fs16
//******************************************************************************

#include <stdlib.h>
#include <stdio.h>
#include <unistd.h>

#include "mythreads.h"

#define ITERS 100

//******************************************************************************

void* printMessage1(void* ptr);
void* printMessage2(void* ptr);

//******************************************************************************

int main (void)
{
    mthread_t   *thread;
    const char  *message1 = "Hello";
    const char  *message2 = "\tWorld";


    printf("program main3 starting\n");

    mthreadCreate(thread, printMessage1, (void *)message1, MEDIUM, STACK_SIZE);
    mthreadCreate(thread, printMessage2, (void *)message2, MEDIUM, STACK_SIZE);

    mthreadJoin();

    printf("\nscheduler terminated .... \n");
}

//******************************************************************************

void* printMessage1(void* ptr)                // user defined thread function
{
    char *message;

    message = (char*) ptr;
    for (int i = 0; i < ITERS/2; i++) {
        printf("%s  \n", message);
        for (int j = 0; j < 500000; j++) {}    // do some work 
    }
    printf("Thread \"%s\" terminates\n", message);
    mthreadExit();
}

void* printMessage2(void* ptr)                // user defined thread function
{
    char *message;

    message = (char*) ptr;
    for (int i = 0; i < ITERS; i++) {
        printf("%s  \n", message);
        for (int j = 0; j < 500000; j++) {}    // do some work 
    }
    printf("Thread \"%s\" terminates\n", message);
    mthreadExit();
}
//******************************************************************************

