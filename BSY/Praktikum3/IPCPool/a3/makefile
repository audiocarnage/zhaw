# ---------------------------------------------------------------------------
# Makefile 
# Fach:	   
# Autoren: 
# File:    makefile 
# ---------------------------------------------------------------------------

# Macros

CC     = gcc
CFLAGS = -std=gnu11 -pthread -g
LIBS   = -lrt
OBJS   = main.o threadpool.o

main:		$(OBJS)
		$(CC) $(CFLAGS) $(OBJS) $(LIBS) -o $@.e

.c.o:
		$(CC) $(CFLAGS) -c $< -o $*.o

clean:		
		rm -f *.e *.o
		@echo "directory cleaned"

all:
		@rm -f  *.o *.e
		@make main

#-----------------------------------------------------------------------------
