//******************************************************************************
// File:     test4.c
// Purpose:  unit test for single linked list
// Author:   M. Thaler, 2012
// Revision: M. Thaler, 2/2015, mime mesurement of function mlSortIn()
// Version: v.fs16
//******************************************************************************

#include <stdio.h>
#include <stdlib.h>
#include <assert.h>
#include <stdlib.h>
#include <sys/time.h>

#include "commondefs.h"
#include "mlist.h"
#include "mthread.h"

//******************************************************************************
#define N (1024*1024)

//------------------------------------------------------------------------------
typedef struct gtimer_t { struct timeval sT; struct timeval eT; } gtimer_t;

#define startGTimer(X)  gettimeofday(&X.sT, NULL)  
#define stopGTimer(X)   gettimeofday(&X.eT, NULL)
#define getWallGTime(X) ((double)(X.eT.tv_sec) - (double)(X.sT.tv_sec)) +\
                            ((double)X.eT.tv_usec - (double)X.sT.tv_usec)/1e6  
#define printGTime(X)   printf("elapsed %3.4lfs\n", getWallGTime(X))

//******************************************************************************
// prototypes of local functions

void beginTest(const char *str);
void endTest(void);
void shuffleIntArray(int *ar, int size);

//******************************************************************************

int main(void) {

    int        tid;
    int*       array;
    mthread_t* th;
    mlist_t*   queue = mlNewList();
    double     time = 0.0;
    gtimer_t   gt;

    // -------------------------------------------------------------------------
    // enqueue N threads

    beginTest("large queue");

    tid = 0;
    for (int i = 0; i < N; i++) {
        th = mtNewThread(tid++, HIGH, 10);
        mlEnqueue(queue, th);
    }
    assert(mlGetNumNodes(queue) == N);

    // dequeue N threads
    for (int i = 0; i < N; i++) {
        th = mlDequeue(queue);
        mtDelThread(th);
    }   
    assert(mlGetNumNodes(queue) == 0);

    endTest();

    // -------------------------------------------------------------------------
    // enqueue N threads sorted i increasing

    beginTest("put sort in increasing order");
    startGTimer(gt);
    for (int i = 0; i < N; i++) {
        th = mtNewThread(tid++, HIGH, i);
        mlSortIn(queue, th);
    }
    stopGTimer(gt);
    time += getWallGTime(gt);
    assert(mlGetNumNodes(queue) == N);

    // dequeue N threads
    for (int i = 0; i < N; i++) {
        th = mlDequeue(queue);
        mtDelThread(th);
    }
    assert(mlGetNumNodes(queue) == 0);

    endTest();

    // -------------------------------------------------------------------------
    // enqueue N threads sorted i decreasing

    beginTest("put sort in decreasing order");
    startGTimer(gt);
    for (int i = 0; i < N; i++) {
        th = mtNewThread(tid++, HIGH, N-1-i);
        mlSortIn(queue, th);
    }
    stopGTimer(gt);
    time += getWallGTime(gt);
    assert(mlGetNumNodes(queue) == N);

    // dequeue N threads
    for (int i = 0; i < N; i++) {
        th = mlDequeue(queue);
        mtDelThread(th);
    }
    assert(mlGetNumNodes(queue) == 0);

    endTest();

    // -------------------------------------------------------------------------
    // enqueue N threads sorted all i shuffled

    beginTest("put sort all i shuffled");

    array = (int *)malloc(N * sizeof(int));
    assert(array != NULL);

    int nN = N / 128;
    for (int i = 0; i < nN; i++)
        array[i] = i;
    shuffleIntArray(array, nN);

    startGTimer(gt);
    for (int i = 0; i < nN; i++) {
        th = mtNewThread(tid++, HIGH, array[i]);
        mlSortIn(queue, th);
    }
    stopGTimer(gt);
    time += getWallGTime(gt);
    // we do not need ist anymore: before assert -> memory leak
    free(array);

    assert(mlGetNumNodes(queue) == nN);

    // dequeue N threads
    for (int i = 0; i < N; i++) {
        th = mlDequeue(queue);
        mtDelThread(th);
    }
    assert(mlGetNumNodes(queue) == 0);

    endTest();

    mlDelList(queue);

    printf("mlSortIn(): elapsed time %3.2lfs\n", time);
    exit(0);

}

//******************************************************************************

void beginTest(const char *str) {
    printf("\n*************************************************************\n");
    if (str != NULL)
        printf("check: %s\n", str);
}


void endTest(void){
    printf("-> passed\n");
}

//******************************************************************************

void shuffleIntArray(int *ar, int size) {
    int j, k, tmp;
    double dran;
    // shuffle according to Knuth to avoid sorted lists
    for (j = size-1; j >= 0; j--) {
        dran = (double)rand() / (double)(RAND_MAX);
        k = (int)(j*dran);
        tmp   = ar[j];
        ar[j] = ar[k];
        ar[k] = tmp;
    }
}

//******************************************************************************

