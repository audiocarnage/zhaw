# ************************************************************
# Fach    BSy
# Autor   M. Thaler
# Version v.fs16
# ************************************************************

CC = gcc
CF = -Wall -g

build:	miShell.o readline.o
	$(CC) $(CF) miShell.o readline.o -o miShell.e

.c.o:
	$(CC) $(CF) -c $<

.cc.o:
	$(CC) $(CF) -c $<

clean:
	rm -f *.o *.e

all:
	@make -s clean
	make 
