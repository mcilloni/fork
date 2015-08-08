BUILDPATH = ../../build/io/
INCLUDES = $(shell pwd)/../../build/include/

ifndef FORKC
	FORKC = forkc
endif

FORKC += --no-libfork


SRCS = $(wildcard *.fork)
OBJS = $(patsubst %.fork,%.o,$(SRCS))
OPATHS = $(foreach obj, $(OBJS), $(BUILDPATH)/$(obj))

.PHONY: all clean

all: $(OPATHS)

dir:
	install -d $(BUILDPATH)

$(BUILDPATH)/%.o: %.fork dir
	@printf "FORKC\t\t%s\n" $<
	@ FORDPATHS="$(shell pwd)/../ford/internal/:$(shell pwd)/../ford/" $(FORKC) -I $(INCLUDES) -o $@ $<

clean:
	rm -rf $(BUILDPATH)
