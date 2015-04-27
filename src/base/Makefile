BUILDPATH = ../../build/base/
LIBPATH = ../../build/libbase.a

ifndef FORKC
	FORKC = forkc
endif

FORKC_O = $(FORKC) --no-spring

ifndef CXX
	CXX=clang++
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

CSRCS = $(wildcard *.cc)
COBJS = $(patsubst %.cc,%.cc.o,$(CSRCS))
OPATHS = $(foreach obj, $(COBJS), $(BUILDPATH)/$(obj))

FSRCS = $(wildcard *.fork)
FOBJS = $(patsubst %.fork,%.fork.o,$(FSRCS))
OPATHS += $(foreach obj, $(FOBJS), $(BUILDPATH)/$(obj))

all: $(OPATHS)
	$(AR) rc $(LIBPATH) $(OPATHS)
	$(RANLIB) $(LIBPATH)

dir:
	install -d $(BUILDPATH)

$(BUILDPATH)/%.cc.o: %.cc dir
	@printf "CXX\t\t%s\n" $<
	@$(CXX) -c -g -o $@ $< $(FPIC) -std=c++14 -D_POSIX_C_SOURCE=200112L

$(BUILDPATH)/%.fork.o: %.fork dir
	@printf "FORKC\t\t%s\n" $<
	@ FORDPATHS="$(shell pwd)/../ford-int/" $(FORKC_O) -o $@ $<

clean:
	rm -rf $(BUILDPATH)
	rm -f $(LIBPATH)
