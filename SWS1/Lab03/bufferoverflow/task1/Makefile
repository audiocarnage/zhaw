# ---------------------------------------------------------------------------
# Author:       M. Rennhard
# Date:         06.01.2011
# Description:  Makefile for Task 1 of Security Lab Buffer-Overflow Attacks
# ---------------------------------------------------------------------------

C       = gcc
CFLAGS  = -g

all:
	make task1

task1:	task1.o
	$(C) task1.o -o $@

task1.o:	task1.c Makefile
	$(C) -c $(CFLAGS) task1.c -o $@

clean:
	rm -f *.o
	rm -f task1

build:
	touch *.c*
	make clean
	make all

#-----------------------------------------------------------------------------
