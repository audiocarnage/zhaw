//***************************************************************************
// File:        main.c
// Author:      M. Thaler
// Revision:    3/2016
// Version:     v.fs16
//***************************************************************************

//***************************************************************************
// system includes
//***************************************************************************

#include <stdio.h>
#include <stdlib.h>
#include <unistd.h>
#include <string.h>
#include <mqueue.h>
#include <errno.h>
#include <sys/types.h>
#include <sys/wait.h>

#include "msgDefs.h"

//***************************************************************************

#define NUM_MSGS 10

#define checkSucc(X,Y) {if (X < 0) {perror(Y); exit(0);}}


//***************************************************************************
// Function: main(), parameter: none
//***************************************************************************

int main(void) {

    pid_t  pid;
    int    rv = 0;
    mqd_t  q1, q2;
    char   *str = "Hello";
    struct mq_attr attr;

    pid = fork();
    switch (pid) {
      case -1:
        perror("Could not fork");
        rv = -1;
        break;
      case 0:
        rv = execl("./child.e", "child.e", NULL, NULL);
        if (rv < 0) perror("\nexecl not successful");
        rv = -1;
        break;

      default:

        // set up queue 1
        
        ...

        // set up queue 2 including receive buffer

        ...

        // send NUM_MSGS messages to child
        for (int i = 0; i < NUM_MSGS; i++) {
            // send message to child

            ...

            // recieve message from child

            ...
        
        }

        // send '\0'-string (1 char) to child

        ...

        // wait for child to terminate
        
        wait(NULL);

        // close and unlink queues

        ...

        rv = 0;
        break;
    }
    exit(rv);
}

//***************************************************************************
