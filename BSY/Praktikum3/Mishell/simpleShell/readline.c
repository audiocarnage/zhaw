/******************************************************************************
// File:    readline.c
// Fach:    BSy
// Autor:   Rémi Georgiou
// Version: v.fs16
******************************************************************************/

#include <stdio.h>
#include <assert.h>
#include "readline.h"

/*****************************************************************************/
/* readline reads at most count-1 characters from stdin into the buffer buf  */
/* returns the number of characters (! must be less/equal : count-1          */

int readline(char *buf, int count) {

    // checks
    assert(buf != NULL);
    assert(count >= 0);
    assert(count <= INPUT_BUFFER_SIZE);

    int c;
    int charCount = 0;

    while ((c = getchar()) != EOF && c != '\n' && charCount < count)
    {
	*(buf + (charCount * sizeof(char))) = c;
	charCount++;
    }

    *(buf + (charCount * sizeof(char))) = '\0';
    return charCount;
}

/*****************************************************************************/
