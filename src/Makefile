BUILD = $(shell pwd)/../build/
CFILES = $(BUILD)/cfiles/
FORDS = $(BUILD)/ford/

ifndef TRNS
	TRNS = env FORDPATHS=$(FORDS) transmod -fo $(FORDS) -co $(CFILES)
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

SONAME = 'libfork.so'
ARNAME = 'libfork.a'

.PHONY: all clean

all:
	mkdir -p $(BUILD)
	mkdir -p $(FORDS)
	mkdir -p $(CFILES)
	find $(shell pwd) -name '*.c' -exec cp {} $(CFILES) \;
	$(TRNS) about
	$(TRNS) c
	$(TRNS) math
	$(TRNS) proc
	$(TRNS) -n rt rt
	$(TRNS) mem
	$(TRNS) tty
	$(TRNS) txt
	$(TRNS) sort
	$(TRNS) err
	$(TRNS) io
	$(TRNS) pair
	$(TRNS) vect
	$(TRNS) list
	$(TRNS) map
	$(TRNS) hash
	$(TRNS) set
	$(TRNS) kv
	$(TRNS) fs
	$(TRNS) dyn
	$(TRNS) misc
	$(TRNS) memutils
	$(TRNS) args
	$(TRNS) ast
	$(TRNS) parser
	cd $(CFILES) && $(CC) -w -c -g -std=c99 -D_POSIX_C_SOURCE=200112L $(CFILES)/*.c
	mv $(CFILES)/rt.o $(BUILD)
	@printf "AR\t\t%s\n" $(ARNAME)
	@ $(AR) rc $(BUILD)/$(ARNAME) $(CFILES)/*.o
	@ $(RANLIB) $(BUILD)/$(ARNAME)

clean:
	rm -rf $(BUILD)
