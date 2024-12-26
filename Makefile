PWD = $(shell pwd)
BUILD = $(PWD)/build
CURSTAGE = $(BUILD)/current
STAGE1 = $(BUILD)/stage1
STAGE2 = $(BUILD)/stage2
STAGE3 = $(BUILD)/stage3

TOOLSDIR = $(PWD)/tools/

LIBFORK = $(PWD)/libfork/
LIBFORKPARSE = $(PWD)/libforkparse/
LIBCTRANS = $(PWD)/libctrans/

RELDIRNAME = fork-release
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

CFLAGS = -Wno-incompatible-pointer-types -Wno-implicit-function-declaration -Wno-incompatible-function-pointer-types -w -g -std=c99 -D_POSIX_C_SOURCE=200112L 

.PHONY: all clean package package-base package-cross bootstrap stage1 stage2 \
	stage3 libfork libforkparse libctrans stage stage-libctrans stage-libfork \
	stage-libfork stage-tools

all: bootstrap

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
	cp $(STAGE)/libforkparse.a $(RELDIR)
	cp $(STAGE)/libctrans.a $(RELDIR)
	cp $(STAGE)/forktree $(RELDIR)
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
	$(MAKE) stage-libforkparse
	$(MAKE) stage-libctrans
	$(MAKE) stage-tools

stage-libctrans:
	$(MAKE) -C $(LIBCTRANS)
	$(MAKE) libctrans

stage-libfork:
	$(MAKE) -C $(LIBFORK) clean
	$(MAKE) libfork

stage-libforkparse:
	$(MAKE) -C $(LIBFORKPARSE) clean
	$(MAKE) libforkparse

stage-tools:
	FORDPATHS=$(BUILD)/ford $(TRNS) -n forktree -co $(BUILD)/cfiles $(TOOLSDIR)/forktree
	$(CC) $(CFLAGS) -o $(BUILD)/forktree $(BUILD)/cfiles/forktree.c $(BUILD)/libforkparse.a $(BUILD)/libfork.a $(BUILD)/rt.o
	FORDPATHS=$(BUILD)/ford $(TRNS) -n transmod -co $(BUILD)/cfiles $(TOOLSDIR)/transmod
	$(CC) $(CFLAGS) -o $(BUILD)/transmod $(BUILD)/cfiles/transmod.c $(BUILD)/libctrans.a $(BUILD)/libforkparse.a $(BUILD)/libfork.a $(BUILD)/rt.o

clean:
	$(MAKE) -C libfork clean
	rm -rf $(BUILD)
	rm -rf fork-release
	rm -f fork-release.txz
	rm -f fork-cfiles.txz

libfork:
	$(MAKE) -C $(LIBFORK)

libforkparse:
	$(MAKE) FORDPATHS=$(BUILD)/ford -C $(LIBFORKPARSE)

libctrans:
	$(MAKE) FORDPATHS=$(BUILD)/ford -C $(LIBCTRANS)

pack-cout:
	if test ! -d $(BUILD)/stage3; then $(MAKE); fi; \
	cp -r $(BUILD)/stage3/cfiles fork-cfiles && \
	cp Makefile-cfiles fork-cfiles/Makefile && \
	find fork-cfiles -name "*.o" -delete && \
	tar cvf - fork-cfiles | xz > fork-cfiles.txz && \
	rm -rf fork-cfiles
