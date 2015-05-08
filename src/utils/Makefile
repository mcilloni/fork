BUILDPATH = ../../build/utils/
LIBPATH = ../../build/libutils.a

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

dir:
	install -d $(BUILDPATH)

$(BUILDPATH)/%.o: %.fork dir
	@printf "FORKC\t\t%s\n" $<
	@ FORDPATHS="$(shell pwd)/../ford/internal/:$(shell pwd)/../ford/" $(FORKC) -o $@ $<

clean:
	rm -rf $(BUILDPATH)
	rm -f $(LIBPATH)
