# ************************************************************
# Fach    BSy
# Autor   M. Thaler
# Version v.fs16
# ************************************************************

CC = gcc
CF = -Wall -g

build:	simpleShell.o readline.o
	$(CC) $(CF) simpleShell.o readline.o -o simpleShell.e

.c.o:
	$(CC) $(CF) -c $<

.cc.o:
	$(CC) $(CF) -c $<

clean:
	rm -f *.o *.e

all:
	@make -s clean
	make 
