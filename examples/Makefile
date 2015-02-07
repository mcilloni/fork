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
	@echo FORKL $<
	@ $(FORKL) -o $@ $< ../build/libsema.a ../build/libsynt.a ../build/libast.a ../build/liblex.a ../build/libutils.a 

%.o: %.fork
	@printf "FORKC\t\t%s\n" $<
	@ FORDPATHS="$(shell pwd)/../src/ford/" $(FORKC) -o $@ $<

clean:
	rm -f $(BINS)
