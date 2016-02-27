PWD = $(shell pwd)
BUILD = $(PWD)/build
CURSTAGE = $(BUILD)/current
STAGE1 = $(BUILD)/stage1
STAGE2 = $(BUILD)/stage2
STAGE3 = $(BUILD)/stage3

TRANSMODDIR = $(PWD)/transmod

LIBFORK = $(PWD)/libfork/
LIBFORDS = $(LIBFORK)/build/ford

RELDIRNAME = ctrans-release
RELDIR = $(PWD)/$(RELDIRNAME)

ifndef TRNS
	TRNS = transmod
endif

ifndef TAR
	TAR=tar
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

ifndef PKGNAME
	PKGNAME=$(RELDIRNAME).txz
endif

SONAME = libctrans.so
ARNAME = libctrans.a

.PHONY: all clean package package-base package-cross bootstrap stage1 stage2 stage3 libfork stage stage-ctrans stage-libfork stage-transmod

all:
	$(MAKE) stage-ctrans

package:
	$(MAKE) bootstrap
	$(MAKE) STAGE=$(STAGE3) package-base

package-cross:
	$(MAKE) stage1
	$(MAKE) STAGE=$(STAGE1) package-base

package-base:
	mkdir -p $(RELDIR)
	cp -r $(STAGE)/ford $(RELDIR)
	cp $(STAGE)/rt.o $(RELDIR)
	cp $(STAGE)/libfork.a $(RELDIR)
	cp $(STAGE)/transmod $(RELDIR)
	cp $(PWD)/LICENSE $(RELDIR)
	cd $(PWD) && $(TAR) -cJf $(PKGNAME) $(RELDIRNAME)
	rm -r $(RELDIR)

bootstrap:
	$(MAKE) stage1
	$(MAKE) stage2
	$(MAKE) stage3

stage1:
	$(MAKE) BUILD=$(STAGE1) stage

stage2:
	$(MAKE) TRNS=$(STAGE1)/transmod BUILD=$(BUILD)/stage2 stage

stage3:
	$(MAKE) TRNS=$(STAGE2)/transmod BUILD=$(BUILD)/stage3 stage

stage:
	$(MAKE) stage-libfork
	$(MAKE) stage-ctrans
	$(MAKE) stage-transmod

stage-ctrans:
	FORDPATHS=$(BUILD)/ford $(TRNS) -n ctrans -fo $(BUILD) -co $(BUILD) lib
	$(CC) -c -w -g -std=c99 -o $(BUILD)/ctrans.o $(BUILD)/ctrans.c
	$(AR) rc $(BUILD)/$(ARNAME) $(BUILD)/ctrans.o
	$(RANLIB) $(BUILD)/$(ARNAME)

stage-libfork:
	$(MAKE) -C $(LIBFORK) clean
	$(MAKE) libfork

stage-transmod:
	FORDPATHS=$(BUILD):$(BUILD)/ford $(TRNS) -n transmod -co $(BUILD) $(TRANSMODDIR)
	$(CC) -w -g -std=c99 -o $(BUILD)/transmod $(BUILD)/transmod.c $(BUILD)/libctrans.a $(BUILD)/libfork.a $(BUILD)/rt.o

clean:
	$(MAKE) -C libfork clean
	rm -rf $(BUILD)
	rm -rf ctrans-release
	rm -rf ctrans-devrel
	rm -f ctrans-release.txz
	rm -f ctrans-devrel.txz

libfork:
	$(MAKE) -C $(LIBFORK)
