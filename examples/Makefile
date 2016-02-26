BUILD = $(shell pwd)/../build/
FORDS = $(BUILD)/ford/

ifndef TRNS
	TRNS = transmod
endif

TRNSCMD = env FORDPATHS=$(FORDS) $(TRNS)

ifndef NODL
ifeq ($(shell uname), Linux)
	LDFLAGS=-ldl
endif
endif

CCLD = $(CC)

MACHINE = $(shell uname -m)

ifeq ($(MACHINE), amd64)
	AMD64 = yes
endif

ifdef AMD64
ifeq (,$(findstring CYGWIN,$(UNAME)))
	FPIC = -fPIC
endif
endif

.PHONY: all clean

all:
	$(TRNSCMD) -n parsedir -co $(shell pwd) ex-parsedir
	$(CCLD) -w -g -std=c99 -D_POSIX_C_SOURCE=200112L -o parsedir $(shell pwd)/parsedir.c $(BUILD)/rt.o $(BUILD)/libfork.a
	rm -f $(shell pwd)/parsedir.c

clean:
	rm -f $(shell pwd)/parsedir
