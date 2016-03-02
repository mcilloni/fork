BUILD = $(shell pwd)/../build/
CFILES = $(BUILD)/cfiles/
FORDS = $(BUILD)/ford/

ifndef TRNS
	TRNS = transmod
endif

TRNSCMD = env FORDPATHS=$(FORDS) transmod -fo $(FORDS) -co $(CFILES)

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
	cd $(CFILES) && $(CC) -w -c -g -std=c99 -D_POSIX_C_SOURCE=200112L $(CFILES)/*.c
	mv $(CFILES)/rt.o $(BUILD)
	@printf "AR\t\t%s\n" $(ARNAME)
	@ $(AR) rc $(BUILD)/$(ARNAME) $(CFILES)/*.o
	@ $(RANLIB) $(BUILD)/$(ARNAME)

clean:
	rm -rf $(BUILD)
