BUILD = $(shell pwd)/../build/
CFILES = $(BUILD)/cfiles/libfork/
FORDS = $(BUILD)/ford/

CFLAGS = -Wno-incompatible-pointer-types -Wno-implicit-function-declaration -Wno-incompatible-function-pointer-types -w -g -std=c99 -D_POSIX_C_SOURCE=200112L 

ifndef TRNS
	TRNS = transmod
endif

TRNSCMD = env FORDPATHS=$(FORDS) $(TRNS) -fo $(FORDS) -co $(CFILES)

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

SONAME = 'libfork.so'
ARNAME = 'libfork.a'

.PHONY: all clean

all:
	$(MAKE) transl
	$(MAKE) cc-ar

transl:
	mkdir -p $(BUILD)
	mkdir -p $(FORDS)
	mkdir -p $(CFILES)
	find $(shell pwd) -name '*.c' -exec cp {} $(CFILES) \;
	$(TRNSCMD) about
	$(TRNSCMD) c
	$(TRNSCMD) math
	$(TRNSCMD) proc
	$(TRNSCMD) -n rt rt
	$(TRNSCMD) mem
	$(TRNSCMD) tty
	$(TRNSCMD) txt
	$(TRNSCMD) sort
	$(TRNSCMD) err
	$(TRNSCMD) io
	$(TRNSCMD) pair
	$(TRNSCMD) vect
	$(TRNSCMD) list
	$(TRNSCMD) map
	$(TRNSCMD) hash
	$(TRNSCMD) set
	$(TRNSCMD) kv
	$(TRNSCMD) fs
	$(TRNSCMD) dyn
	$(TRNSCMD) misc
	$(TRNSCMD) memutils
	$(TRNSCMD) args
	mv $(CFILES)/rt.c $(CFILES)/..

cc-ar:
	cd $(CFILES) && $(CC) -c $(CFLAGS) $(CFILES)/*.c
	$(CC) $(CFLAGS) -c -o $(BUILD)/rt.o $(CFILES)/../rt.c
	@printf "AR\t\t%s\n" $(ARNAME)
	@ $(AR) rc $(BUILD)/$(ARNAME) $(CFILES)/*.o
	@ $(RANLIB) $(BUILD)/$(ARNAME)

clean:
	rm -rf $(BUILD)
