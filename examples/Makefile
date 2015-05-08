ifndef FORKC
	FORKC = forkc
endif

ifndef FORKL
	FORKL = forkl
endif

SRCS = $(wildcard *.fork)
OBJS = $(patsubst %.fork,%.o,$(SRCS))
BINS = $(patsubst %.fork,%.elf,$(SRCS))

.PHONY: all clean

all: $(BINS)

%.elf: %.o

	@printf "FORKL\t\t%s\n" $<

	@ $(CC) -o $@ $< $(shell pwd)/../build/rt.o -L$(shell pwd)/../build/ -lfork -static

%.o: %.fork
	@printf "FORKC\t\t%s\n" $<
	@ FORDPATHS="$(shell pwd)/../src/ford/internal/:$(shell pwd)/../src/ford/" $(FORKC) -o $@ $<

clean:
	rm -f $(BINS)
