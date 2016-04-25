# *************************************************************
# Fach    BSy
# Autor   M. Thaler
# Stand   11/2014
# Version v.fs16
# *************************************************************

CMP=		gcc
CMPFLAGS=       -Wall -g
LDFLAGS=
EXENAME=	ProcA8.e
FNAME=		ProcA8
EXENAMC=	ChildProgA8.e
FNAMC=		ChildProgA8
LIBNAME=
LIBNAME=

compile:	$(EXENAME) $(EXENAMC)

$(EXENAME):	$(FNAME).o
		$(CMP)  $(FNAME).o $(LIBNAME) $(LDFLAGS) -o $@

$(EXENAMC):	$(FNAMC).o
		$(CMP)  $(FNAMC).o $(LIBNAME) $(LDFLAGS) -o $@
	
.c.o:
		$(CMP) -c $(CMPFLAGS) $<
	
.cc.o:
		$(CMP) -c $(CMPFLAGS) $<
	
clean:
		rm -f core *.o $(EXENAME) $(EXENAMC)

all:
		@make clean
		@make
