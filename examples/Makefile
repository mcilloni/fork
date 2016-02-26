BUILD = $(shell pwd)/../build/
FORDS = $(BUILD)/ford/

ifndef TRNS
	TRNS = env FORDPATHS=$(FORDS) transmod
endif


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
	$(TRNS) -n parsedir ex-parsedir
	$(CCLD) -w -g -std=c99 -D_POSIX_C_SOURCE=200112L -o parsedir parsedir.c $(BUILD)/rt.o $(BUILD)/libfork.a
	rm -f parsedir.c
