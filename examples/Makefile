ifndef FORKC
	FORKC = forkc
endif

ifndef FORKL
	FORKL = forkl
endif

ifeq ($(shell uname), Linux)
	LDFLAGS+=-ldl
endif

SRCS = $(wildcard *.fork)
OBJS = $(patsubst %.fork,%.o,$(SRCS))
BINS = $(patsubst %.fork,%.elf,$(SRCS))

.PHONY: all clean

all: $(BINS)
	cp -fv test.elf "$(shell pwd)/../build/forkc1"
	cp -f header.txt "$(shell pwd)/../build/forkc"
	cat forkc.py >> "$(shell pwd)/../build/forkc"
	chmod +x "$(shell pwd)/../build/forkc"
	cp -f header.txt "$(shell pwd)/../build/forkl"
	cat forkl.py >> "$(shell pwd)/../build/forkl"
	chmod +x "$(shell pwd)/../build/forkl"
	cp -f header.txt "$(shell pwd)/../build/fordc"
	cat fordc.py >> "$(shell pwd)/../build/fordc"
	chmod +x "$(shell pwd)/../build/fordc"



%.elf: %.o

	@printf "FORKL\t\t%s\n" $<

	@ $(CC) -o $@ $< $(FORKROOT)/libfork/build/rt.o  $(FORKROOT)/libfork/build/libfork.a $(shell pwd)/../build/*.o

%.o: %.fork
	@printf "FORKC\t\t%s\n" $<
	@ FORDPATHS="$(FORKROOT)/libfork/build/ford/:$(shell pwd)/../build/ford/" $(FORKC) -o $@ $<

clean:
	rm -f $(BINS)
