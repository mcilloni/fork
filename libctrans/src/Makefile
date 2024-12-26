BUILD = $(shell pwd)/../build/
CFILES = $(BUILD)/cfiles/libctrans
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

CFLAGS = -Wno-incompatible-pointer-types -Wno-implicit-function-declaration -Wno-incompatible-function-pointer-types -w -g -std=c99 -D_POSIX_C_SOURCE=200112L 

SONAME = 'libctrans.so'
ARNAME = 'libctrans.a'

.PHONY: all clean

all:
	$(MAKE) transl
	$(MAKE) cc-ar

clean:
	rm -rf $(BUILD)

transl:
	mkdir -p $(BUILD)
	mkdir -p $(FORDS)
	mkdir -p $(CFILES)
	$(TRNSCMD) ctrans

cc-ar:
	cd $(CFILES) && $(CC) -c $(CFLAGS) $(CFILES)/*.c
	@printf "AR\t\t%s\n" $(ARNAME)
	@ $(AR) rc $(BUILD)/$(ARNAME) $(CFILES)/*.o
	@ $(RANLIB) $(BUILD)/$(ARNAME)
