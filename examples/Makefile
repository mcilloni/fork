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
<<<<<<< HEAD
	@printf "FORKL\t\t%s\n" $<
=======
	@echo FORKL $<
>>>>>>> 6e9387e28c7ba2ddd343ef303d8076fa93a60bed
	@ $(FORKL) -o $@ $< ../build/libsema.a ../build/libsynt.a ../build/libast.a ../build/liblex.a ../build/libutils.a 

%.o: %.fork
	@printf "FORKC\t\t%s\n" $<
	@ FORDPATHS="$(shell pwd)/../src/ford/" $(FORKC) -o $@ $<

clean:
	rm -f $(BINS)
