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
	@printf "FORKC\t\tforkc1.fork\n"
	@ FORDPATHS="$(LIBFORK)/build/ford/:$(shell pwd)/../../build/ford/" $(FORKC) -I $(INCLUDES) -I $(LFINCL) -o $(BUILDPATH)/forkc1.o forkc1.fork

	@printf "FORKL\t\tforkc1.o\n"

	@ $(CC) -o $(BUILDPATH)/forkc1 $(BUILDPATH)/*.o $(LIBFORK)/build/rt.o $(LIBFORK)/build/libfork.a

	cp -f header.txt "$(BUILDPATH)/forkc"
	cat forkc.py >> "$(BUILDPATH)/forkc"
	chmod +x "$(BUILDPATH)/forkc"
	cp -f header.txt "$(BUILDPATH)/forkl"
	cat forkl.py >> "$(BUILDPATH)/forkl"
	chmod +x "$(BUILDPATH)/forkl"


clean:
	rm -rf $(BUILDPATH)
