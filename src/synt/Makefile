BUILDPATH = ../../build/synt/
LIBPATH = ../../build/libsynt.a

ifndef FORKC
	FORKC = forkc
endif

ifndef AR
	AR=ar
endif

ifndef RANLIB
	RANLIB=ranlib
endif

SRCS = $(wildcard *.fork)
OBJS = $(patsubst %.fork,%.o,$(SRCS))
OPATHS = $(foreach obj, $(OBJS), $(BUILDPATH)/$(obj))

.PHONY: all clean

all: $(OPATHS)
	$(AR) rc $(LIBPATH) $(OPATHS)
	$(RANLIB) $(LIBPATH)

dir:
	install -d $(BUILDPATH)	

$(BUILDPATH)/%.o: %.fork dir
	@echo [FORKC] $<
	@ FORDPATHS="$(shell pwd)/../ford/" $(FORKC) -o $@ $<

clean:
	rm -rf $(BUILDPATH)
	rm -f $(LIBPATH)

