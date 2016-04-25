# ************************************************************
# Fach    BSy
# Autor   M. Thaler
# Version v.fs16
# ************************************************************

CC = gcc -std=gnu99
CF = -Wall -g

build:	siShell.o readline.o
	$(CC) $(CF) siShell.o readline.o -o siShell.e

.c.o:
	$(CC) $(CF) -c $<

.cc.o:
	$(CC) $(CF) -c $<

clean:
	rm -f *.o *.e

all:
	@make -s clean
	make 
