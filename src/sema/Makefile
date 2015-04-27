BUILDPATH = ../../build/sema/
LIBPATH = ../../build/libsema.a

ifndef FORKC
	FORKC = forkc
endif

FORKC_O = $(FORKC) --no-spring

ifndef AR
	AR=ar
endif

ifndef RANLIB
	RANLIB=ranlib
endif

SRCS = $(wildcard *.fork)
OBJS = $(patsubst %.fork,%.o,$(SRCS))
OPATHS = $(foreach obj, $(OBJS), $(BUILDPATH)/$(obj))

.PHONY: all clean dir

all: $(OPATHS)
	$(AR) rc $(LIBPATH) $(OPATHS)
	$(RANLIB) $(LIBPATH)

dir:
	install -d $(BUILDPATH)

$(BUILDPATH)/%.o: %.fork dir
	@printf "FORKC\t\t%s\n" $<
	@ FORDPATHS="$(shell pwd)/../ford-int/" $(FORKC_O) -o $@ $<

clean:
	rm -rf $(BUILDPATH)
	rm -f $(LIBPATH)
