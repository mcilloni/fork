INCLUDES = $(shell pwd)/../build/include/

ifndef FORKC
	FORKC = forkc
endif

FORKC += --no-libfork

ifndef FORKL
	FORKL = forkl
endif

ifndef NODL
ifeq ($(shell uname), Linux)
	LDFLAGS=-ldl
endif
endif

SRCS = $(wildcard *.fork)
OBJS = $(patsubst %.fork,%.o,$(SRCS))
BINS = $(patsubst %.fork,%.elf,$(SRCS))

.PHONY: all clean

all: $(BINS)

%.elf: %.o

	@printf "FORKL\t\t%s\n" $<

	@ $(CC) -o $@ $< $(shell pwd)/../build/rt.o $(shell pwd)/../build/libfork.a $(LDFLAGS)

%.o: %.fork
	@printf "FORKC\t\t%s\n" $<
	@ FORDPATHS="$(shell pwd)/../src/ford/internal/:$(shell pwd)/../src/ford/" $(FORKC) -I $(INCLUDES) -o $@ $<

clean:
	rm -f $(BINS)
