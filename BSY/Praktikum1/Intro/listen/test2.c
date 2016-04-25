//******************************************************************************
// File:    test2.c
// Purpose: test for single linked list
// Author:  M. Thaler, 2012, (based on former work by J. Zeman and M. Thaler)
// Version: v.fs16
//******************************************************************************

#include <stdio.h>
#include <stdlib.h>
#include <assert.h>

#include "commondefs.h"
#include "mlist.h"
#include "mthread.h"

//******************************************************************************
// prototypes of local functions

void beginTest(void);
void endTest(void);
void printList(mlist_t* list, const char *str);
void printFirst(mlist_t* list, const char *str);

//******************************************************************************

int main(void){

    unsigned int tid = 0, i;
    mthread_t* th;
    mlist_t* queue1 = mlNewList();
    mlist_t* queue2 = mlNewList();
    mlist_t* queue3 = mlNewList();
    mlist_t* queue4 = mlNewList();
 
    // show empty queues -------------------------------------------------------
    beginTest(); 
    printList(queue1, "queue1 -> empty");
    printList(queue2, "queue2 -> empty");
    printList(queue3, "queue3 -> empty");
    printList(queue4, "queue4 -> empty");
    endTest();

    // add one thread to queue 2 -----------------------------------------------
    beginTest();
    th = mtNewThread(tid++, 1, 40);
    mlEnqueue(queue2, th);
    printList(queue2, "queue2, after one put");


    // put last 5 threads ------------------------------------------------------
    mlEnqueue(queue2, mtNewThread(tid++,1, 20));
    mlEnqueue(queue2, mtNewThread(tid++,1, 30));
    mlEnqueue(queue2, mtNewThread(tid++,2, 35));
    mlEnqueue(queue2, mtNewThread(tid++,3, 50));
    mlEnqueue(queue2, mtNewThread(tid++,3, 10));

    printFirst(queue2, "queue2 after 6 puts");
    printList(queue2,  "queue2 after 6 puts");
    endTest();

    // move threads between queues ---------------------------------------------
    beginTest();
    printList(queue3, "queue3 -> empty");
    mlSortIn(queue3, mtNewThread(tid++, 4,1000));
    mlSortIn(queue3, mtNewThread(tid++, 4, 999));

    for (i = 1; i <= 6; i++) {
        printFirst(queue2, "--->> queue2, for-loop before pop");
        th = mlDequeue(queue2);
        if (th == NULL)
            printf("\t th == NULL at iteration i = %d", i);
        else {
            printList(queue2, "queue2, for-loop after pop");
            mlEnqueue(queue1, th);        // in andere Queue einreihen
            mlSortIn(queue3, th);     // in die sort.Liste einreihen
            printList(queue3, "queue3, for-loop");
        }
    }
    
    printList(queue2, "queue2, after 1. for loop");
    printList(queue3, "queue3, after 1. for loop");
    printList(queue1, "queue1, after 1. for loop");
 
    endTest();   

    //  add a lot of threds to queue 1 then pop 590 threads
    beginTest();
    for (i = 1; i < 200; i++) {
        mlSortIn(queue3, mtNewThread(tid++, 5, 500+2*i));
    }
    for (i = 1; i < 200; i++) {
        mlSortIn(queue3, mtNewThread(tid++, 6, 401+2*i));
    }
    for (i = 1; i < 200; i++) {
        mlSortIn(queue3, mtNewThread(tid++, 7, 600+2*i));
    }
    for (i = 1; i < 590; i++) {
        th = mlDequeue(queue3);
        mtDelThread(th);
    }

    printList(queue3, "queue3 after 600 SortIns and 590 pops");
    printList(queue1, "queue1 before end");
    printList(queue2, "queue2 before end");
    printList(queue4, "queue4 before end");

    mlDelList(queue1);  
    mlDelList(queue2);
    mlDelList(queue3);
    mlDelList(queue4);

    exit(0);
}

//******************************************************************************

void beginTest(void) {
    printf("---------------------------------------------------------------\n");
}
void endTest(void){
    printf("---------------------------------------------------------------\n"); 
}

void printList(mlist_t* list, const char *str) {
    mthread_t* p;
    printf("-> printing %s, total %d elements\n", str, mlGetNumNodes(list));
    mlSetPtrFirst(list);
    while((p = mlReadCurrent(list)) != NULL) {
        printf(" > node tid = %3d, ready time = %3d\n", p->tID, p->readyTime);
        mlSetPtrNext(list);
    }
}


void printFirst(mlist_t* list, const char *string) {
  mthread_t* th;
  th = mlReadFirst(list);

  printf("-> printing first element of list %s\n", string);
  if (th != NULL)
    printf(" > node tid = %3d, ready time=%3d\n", mtGetID(th), mtGetReadyTime(th));
  else
    printf("   list is empty  !!!!");
  printf("\n");
}

//******************************************************************************

