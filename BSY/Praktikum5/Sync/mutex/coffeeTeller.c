/*******************************************************************************
* File:     coffeTeller.c
* Purpose:  coffe teller with pthreads
* Course:   bsy
* Author:   M. Thaler, 2011
* Revision: 5/2012
* Version:  v.fs16
*******************************************************************************/

#include <stdio.h>
#include <unistd.h>
#include <stdlib.h>
#include <sys/types.h>
#include <sys/wait.h>

#include <pthread.h>

#include "commonDefs.h"

//******************************************************************************

void *coffeeTeller(void* data) {

    int i;
    cData *cD = (cData *) data;

    /* Lösung ohne Mutexe:
       Die gemeinsamen Daten werden in lokale Variablen kopiert.

    int coinCount = ((cData *)data)->coinCount;              // number of paid coffees
    int selCount1 = ((cData *)data)->selCount1;              // number of chosen coffees of type 1
    int selCount2 = ((cData *)data)->selCount2;      	     // number of chosen coffees of type 2
    */

    // now start selling coffee
    printf("\nCoffee teller machine starting\n\n");
    
    i = 0;
    while (i < ITERATIONS) {
	pthread_mutex_lock(&(cD->lock));
        if (cD->coinCount != cD->selCount1 + cD->selCount2) {
            printf("error c = %5d  s1 =%6d   s2 =%6d   diff: %4d\ti = %d\n", 
                   cD->coinCount, cD->selCount1, cD->selCount2, 
                   cD->coinCount - cD->selCount1 - cD->selCount2, 
                   i);
            cD->coinCount = 0;
            cD->selCount1 = cD->selCount2 = 0;
        }
	pthread_mutex_unlock(&(cD->lock));
        if (i%1000000 == 0) printf("working\n");
        i++;
    }
    pthread_exit(0);
}

//******************************************************************************
