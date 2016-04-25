//***************************************************************************
// File:        child.c
// Author:      M. Thaler
// Revision:    3/2016
// Version:     v.fs16
//***************************************************************************

//***************************************************************************
// system includes
//***************************************************************************

#include <unistd.h>
#include <stdlib.h>
#include <mqueue.h>
#include <stdio.h>
#include <string.h>

#include "msgDefs.h"

//***************************************************************************

#define checkSucc(X,Y) {if (X < 0) {perror(Y); exit(0);}}

//***************************************************************************
// Function: main() for child
//***************************************************************************

int main(int argc, char *argv[]) {
    mqd_t q1, q2;
    char  *str = "\t Gruezi";
    struct mq_attr attr;

    // open queues and initialize receive buffer

    ...

    while (1) {
        // recieve message from main and check for 1 char string '\0'

        ...
               
        // send message to main

        ...            
    }
    exit(0);
}

//***************************************************************************
