BUILDPATH = ../../build/dyn/
INCLUDES = $(shell pwd)/../../build/include/

ifndef FORKC
	FORKC = forkc
endif

ifndef CC
	CC=clang
endif

ifndef AR
	AR=ar
endif

ifndef RANLIB
	RANLIB=ranlib
endif

MACHINE = $(shell uname -m)

ifeq ($(MACHINE), x86_64)
	AMD64 = yes
endif

ifeq ($(MACHINE), amd64)
	AMD64 = yes
endif

ifdef AMD64
ifeq (,$(findstring CYGWIN,$(UNAME)))
	FPIC = -fPIC
endif
endif

.PHONY: all clean dir

CSRCS = $(wildcard *.c)
COBJS = $(patsubst %.c,%.c.o,$(CSRCS))
OPATHS = $(foreach obj, $(COBJS), $(BUILDPATH)/$(obj))

FSRCS = $(wildcard *.fork)
FOBJS = $(patsubst %.fork,%.fork.o,$(FSRCS))
OPATHS += $(foreach obj, $(FOBJS), $(BUILDPATH)/$(obj))

all: $(OPATHS)

dir:
	install -d $(BUILDPATH)

$(BUILDPATH)/%.c.o: %.c dir
	@printf "CC\t\t%s\n" $<
	@$(CC) -c -g -o $@ $< $(FPIC) -std=c11 -D_POSIX_C_SOURCE=200112L

$(BUILDPATH)/%.fork.o: %.fork dir
	@printf "FORKC\t\t%s\n" $<
	@ FORDPATHS="$(shell pwd)/../ford/internal/:$(shell pwd)/../ford/" $(FORKC) -I $(INCLUDES) -o $@ $<

clean:
	rm -rf $(BUILDPATH)
