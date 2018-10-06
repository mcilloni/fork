BUILD = $(shell pwd)/../build/
CFILES = $(BUILD)/cfiles/libforkparse/
FORDS = $(BUILD)/ford/

ifndef TRNS
	TRNS = transmod
endif

ifdef FORDPATHS
	TRNSCMD = env FORDPATHS=$(FORDPATHS):$(FORDS) $(TRNS) -fo $(FORDS) -co $(CFILES)
else
	TRNSCMD = env FORDPATHS=$(FORDS) $(TRNS) -fo $(FORDS) -co $(CFILES)
endif

ifndef AR
	AR=ar
endif

ifndef RANLIB
	RANLIB=ranlib
endif

MACHINE = $(shell uname -m)

ifeq ($(MACHINE), amd64)
	AMD64 = yes
endif

ifdef AMD64
ifeq (,$(findstring CYGWIN,$(UNAME)))
	FPIC = -fPIC
endif
endif

SONAME = 'libforkparse.so'
ARNAME = 'libforkparse.a'

.PHONY: all clean

all:
	$(MAKE) transl
	$(MAKE) cc-ar

transl:
	mkdir -p $(BUILD)
	mkdir -p $(FORDS)
	mkdir -p $(CFILES)
	$(TRNSCMD) ast
	$(TRNSCMD) parser

cc-ar:
	cd $(CFILES) && $(CC) -w -c -g -std=c99 -D_POSIX_C_SOURCE=200112L $(CFILES)/*.c
	@printf "AR\t\t%s\n" $(ARNAME)
	@ $(AR) rc $(BUILD)/$(ARNAME) $(CFILES)/*.o
	@ $(RANLIB) $(BUILD)/$(ARNAME)

clean:
	rm -rf $(BUILD)
