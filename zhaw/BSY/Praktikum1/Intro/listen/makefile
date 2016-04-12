# ---------------------------------------------------------------------------
# Makefile fuer Programmbeispiel mit searaten Dateien
# Fach:     BS
# Changes:  J. Zeman, M. Thaler
# File:     makefile 
# Version:  v.fs16
# ---------------------------------------------------------------------------

# Macros

CC    = gcc -std=gnu99
CFLGS = -Wall
	
doit:
		@make --no-print-directory test1
		@make --no-print-directory test2

test1:		test1.o mlist.o mthread.o 
		$(CC) $(CFLGS) test1.o mlist.o mthread.o -o $@.e

test2:		test2.o mlist.o mthread.o 
		$(CC) $(CFLGS) test2.o mlist.o mthread.o -o $@.e

leakTest:		
		rm -f test3.e
		make --no-print-directory MtestM

MtestM:
		$(CC) test3.c mlist.c mthread.c -o test3.e

test4:		test4.o mlist.o mthread.o mthread.h
		$(CC) $(CFLGS) test4.o mlist.o mthread.o -o test4.e

profileTest:
		touch *.c
		@make --no-print-directory test4

.c.o:		$< mlist.h  mthread.h
		$(CC) $(CFLGS) -c $< -o $*.o

clean:		
		rm -f *.e *.o
		@echo "directory cleaned"

all:
		@rm -f *.o
		make --no-print-directory test1
		make --no-print-directory test2
#-----------------------------------------------------------------------------
