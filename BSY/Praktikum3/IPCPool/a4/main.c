//**************************************************************************
// Course:  BSy
// Author:  M. Thaler, ZHAW, 2016
// Purpose: main program for task queue with message queues
//**************************************************************************

#include <stdio.h>
#include <stdlib.h>
#include <unistd.h>

#include "threadpool.h"
#include "mtimer.h"

//**************************************************************************
// constant values

//**************************************************************************
// globals

int nThreads = 1;

//**************************************************************************

typedef struct fooDataStruct {
                                // mandatory entries
    void      *this;            // pointer to this structure
    taskfun_t func;             // function with signature: void foo(void *)
                                // type defined in threadpool.h

                                // data for individual task instances
    long   tid;                 // task id                 
    double retVal;              // return value

} fooTask_t;                    // type for this tasks

//---------------------------------------------------------------------------

void foo(void *arg) {
    fooTask_t *td = (fooTask_t *)arg;
    td->retVal = (double)td->tid;
}

void fooInit(fooTask_t *t) {
    t->this = t;
    t->func = foo; 
}

//**************************************************************************
// main program

int main(int argc, char *argv[]) {
    double sum1, sum2;
    ttimer_t tt;

    int nThreads = 1;
    if (argc > 1)
        nThreads = atoi(argv[1]);

    int nTasks = 2;
    if (argc > 2)
        nTasks = atoi(argv[2]);
    fooTask_t td[nTasks];

    //--------------------------------------------------------------

    startThreadPool(nThreads);

    // *** first run ***********************************************

    // initialize task object and start tasks
    for (int i = 0; i < nTasks; i++) {
        fooInit(&td[i]);
        td[i].tid = i;
        runTask(&td[i]); 
    } 
    waitTasks();

    //--------------------------------------------------------------

    // sum return values
    sum1 = 0;
    for (int i = 0; i < nTasks; i++)
        sum1 += td[i].retVal;

    // sum effective values
    sum2 = 0;
    for (int i = 0; i < nTasks; i++) 
        sum2 += i;
     
    if (sum1 == sum2)
        printf("test ok: %1.1lf = %1.1lf\n", sum1, sum2);
    else
        printf("test failed: sum is %1.1lf instead %1.1lf\n", sum1, sum2);


    // *** second run **********************************************

    // initialize task object and start tasks
    for (int i = 0; i < nTasks; i++) {
        fooInit(&td[i]);
        td[i].tid = i;
        runTask(&td[i]); 
    } 
    waitTasks();

    //--------------------------------------------------------------

    // sum return values
    sum1 = 0;
    for (int i = 0; i < nTasks; i++)
        sum1 += td[i].retVal;

    // sum effective values
    sum2 = 0;
    for (int i = 0; i < nTasks; i++) 
        sum2 += i;
     
    if (sum1 == sum2)
        printf("test ok: %1.1lf = %1.1lf\n", sum1, sum2);
    else
        printf("test failed: sum is %1.1lf instead %1.1lf\n", sum1, sum2);

    stopThreadPool();
}

//**************************************************************************
