BUILDPATH = $(shell pwd)/../../build/
LIBFORK = $(shell pwd)/../../libfork/
LFINCL = $(LIBFORK)/build/include/
INCLUDES = $(BUILDPATH)/include/


ifndef FORKC
	FORKC = forkc
endif

FORKC += --no-libfork

ifndef FORKL
	FORKL = forkl
endif

ifeq ($(shell uname), Linux)
	LDFLAGS+=-ldl
endif

.PHONY: all clean

all:
	mkdir -p $(BUILDPATH)/tools/

	@printf "FORKC\t\ttransmod.fork\n"
	@ FORDPATHS="$(LIBFORK)/build/ford/:$(shell pwd)/../../build/ford/" $(FORKC) -I $(INCLUDES) -I $(LFINCL) -o $(BUILDPATH)/tools/transmod.o transmod.fork
	@printf "FORKL\t\ttransmod.o\n"
	@ $(CC) -o $(BUILDPATH)/transmod $(BUILDPATH)/tools/transmod.o $(BUILDPATH)/*.o $(LIBFORK)/build/rt.o $(LIBFORK)/build/libfork.a

clean:
	rm -rf $(BUILDPATH)
