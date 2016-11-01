# ---------------------------------------------------------------------------
# Author:       M. Rennhard
# Date:         06.01.2011
# Description:  Makefile for Task 2 of Security Lab Buffer-Overflow Attacks
# ---------------------------------------------------------------------------

C       = gcc
CFLAGS  = -g -fno-stack-protector

all:
		make server
		make client
		cp *.txt /tmp

server:		server.o
		$(C) server.o -o $@

server.o:	server.c task2.h Makefile
		$(C) -c $(CFLAGS) server.c -o $@

client:		client.o
		$(C) client.o -o $@

client.o:	client.c task2.h Makefile
		$(C) -c $(CFLAGS) client.c -o $@  

clean:
		rm -f *.o
		rm -f server
		rm -f client
		rm -f /tmp/public.txt
		rm -f /tmp/secret.txt

build:
		touch *.c*
		make clean
		make all

#-----------------------------------------------------------------------------
