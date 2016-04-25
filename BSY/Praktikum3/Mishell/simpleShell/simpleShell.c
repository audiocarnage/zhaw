/******************************************************************************
// Aufgabe:    Simple Shell   
// File:       sishell.c
// Fach:       Betriebssysteme
// Autor:      M. Thaler
// Version:    v.fs16
******************************************************************************/

#include <stdio.h>
#include <string.h>
#include <unistd.h>
#include <stdlib.h>
#include <sys/types.h>
#include <fcntl.h> 
#include <sys/wait.h>

#include "readline.h"

//*****************************************************************************

#define MAX_ARGV 16                     // max number of command line arguments
#define STR_LEN  32                     // max length of command line arguments

//*****************************************************************************

int main(void)
{
    char  *argv[MAX_ARGV];              // pointer to command line arguments
    char  *word;                        // pointer to command line word
    char  buf[STR_LEN], cmd[STR_LEN];   // buffer for command line and command
    int   idx, rv;	                // index variable
    pid_t PID;                          // process identifier

    while (1) {    
        printf("si ? ");                // print prompt
        readline(buf, STR_LEN);         // read one line from stdin
           
        idx = 0;        
        word = strtok(buf," \t\n");     // get first word
        argv[idx] = word;               // set pointer to argument string (word)
                                        // word points to "word" in buf
        idx++;                          // next index 
             
        argv[idx] = NULL;               // terminate arguments with NULL pointer
        strcpy(cmd, "/bin/");           // copy path to cmd
        strcat(cmd, argv[0]);           // add command to cmd
        if ((PID = fork()) == 0)	// fork child process
        {
            execv(cmd,  &argv[0]);      // execute command
            perror("!!! panic !!!\n");  // should not come here
            exit(-1);                   // if we came here ... we have to exit
        }
        else if (PID < 0)
	{
            printf("fork failed\n");    // fork didn't succeed
            exit(-1);                   // terminate sishell
        }
        else
	{                          	// here we are parents
            rv = wait(0);               // wait for child process to terminate
            if (rv < 0)
                perror("wait failed: ");        
        }
    }
    exit(0);
}

//*****************************************************************************
