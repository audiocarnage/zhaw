/******************************************************************************
// Aufgabe:    Simple Shell   
// File:       sishell.c
// Fach:       Betriebssysteme
// Autor:      M. Thaler, Rémi Georgiou
// Version:    v.fs16
******************************************************************************/

#include <stdio.h>
#include <string.h>
#include <unistd.h>
#include <stdlib.h>
#include <sys/types.h>
#include <fcntl.h> 
#include <sys/wait.h>
#include <assert.h>

#include "readline.h"

//*****************************************************************************

#define MAX_ARGV 16                     // max number of command line arguments
#define STR_LEN  32                     // max length of command line arguments
#define INPUT_REDIRECTION   '<'
#define OUTPUT_REDIRECTION  '>'

//*****************************************************************************

int main(void) {
    char  *argv[MAX_ARGV];              // pointer to command line arguments
    char  *word;                        // pointer to command line word
    char  *delims = " \t\n";		// delimiting characters for tokeniser function
    char  buf[STR_LEN], cmd[STR_LEN];   // buffer for command line and command
    int   idx, rv; 	 		// index variable
    char  *infile, *outfile;		// files for input and output redirection
    pid_t PID;                          // process identifier

    while (1)
    {    
        (void)printf("oui, Maître? $ ");  // print prompt
        (void)readline(buf, STR_LEN);   // read one line from stdin

	infile = NULL;
	outfile = NULL;
        idx = 0;

        // ***** PARSE BUFFER *****
	word = strtok(buf, delims);	// get first word
	while (word != NULL && idx < MAX_ARGV)
	{
	    if (*word == INPUT_REDIRECTION)
	        infile = strtok(NULL, delims);
	    else if (*word == OUTPUT_REDIRECTION)
		outfile = strtok(NULL, delims);
	    else
            {
 	        argv[idx] = word;	// set pointer to argument string (word), word points to "word" in buf
	        idx++;			// next index
	    }
	    word = strtok(NULL, delims);// get next word
	}

        argv[idx] = NULL;               // terminate arguments with NULL pointer

	if (argv[0] != NULL)
	{
	    strcpy(cmd, argv[0]);       // add command to cmd

	    if (strncmp(cmd, "exit", 4) == 0 || strncmp(cmd, "logout", 6) == 0)
	        exit(EXIT_SUCCESS);	// terminate shell

	    if (strncmp(cmd, "cd", 2) == 0)	// change dir system function
	    {
	        if (argv[1] != NULL)
		{
		    assert(strlen(argv[1]) < STR_LEN);
		    strcpy(cmd, argv[1]);
   	            rv = chdir(cmd);	        // change dir
	            if (rv < 0)
		        perror("chdir failed: ");
		}
	    }
	    else			        // other case: execute program
	    {	
                if ((PID = fork()) == 0)	// fork child process
	        {
		    if (infile != NULL)		// input redirection
		    {
		        fclose(stdin);
		    	if (open(infile, O_RDONLY) < 0)
			    perror("open failed: ");
		    }

		    if (outfile != NULL)	// output redirection
		    {
		    	fclose(stdout);
	 	        if (open(outfile, O_CREAT | O_TRUNC | O_WRONLY, 0644) < 0)
			    perror("open failed: ");
		    }

                    execvp(cmd, &argv[0]);      // execute command
            	    perror("!!! panic !!!\n");  // should not come here
            	    exit(EXIT_FAILURE);         // if we came here ... we have to exit
                }
                else if (PID < 0)
   	        {
            	    (void)printf("fork failed\n");    // fork didn't succeed
            	    exit(EXIT_FAILURE);         // terminate sishell
                }
                else
	        {              	                // here we are parents           
            	    rv = wait(0);               // wait for child process to terminate
                    if (rv < 0)
                        perror("wait failed: ");
                }
    	    }
	}
    }
    exit(EXIT_SUCCESS);
}
