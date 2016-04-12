# ---------------------------------------------------------------------------
# Makefile fuer MyThreads
# Kurs:	BSy, M. Thaler, 2012
# File:	makefile 
# ---------------------------------------------------------------------------

#macros

#CFL = -Wall -g -m32 -L/usr/lib32
CFL = -Wall -g 
CMP = gcc -std=gnu99 $(CFL)


main1:	main1.o  mthread.o dispatcher.o queues.o mlist.o
	$(CMP) main1.o mthread.o dispatcher.o queues.o mlist.o -o $@.e

.c.o:
	$(CMP) -c $<

.cc.o:
	$(CMP) -c $<

clean:		
	rm -f *.o main*.e
	echo "directory cleaned"

all:
	@make --no-print-directory clean
	@make --no-print-directory main1



#-----------------------------------------------------------------------------
