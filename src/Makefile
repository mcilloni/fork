BUILDPATH = $(shell pwd)/../build/
LIBFORK = $(shell pwd)/../libfork/
LFINCL = $(LIBFORK)/build/include/
INCLUDES = $(BUILDPATH)/include/

ifndef FORKC
	FORKC = forkc
endif

FORKC += --no-libfork

CCLD = $(CC)

SONAME = 'ctrans.so'

SRCS = $(wildcard *.fork)
OBJS = $(patsubst %.fork,%.o,$(SRCS))
OPATHS = $(foreach obj, $(OBJS), $(BUILDPATH)/$(obj))

.PHONY: all dir clean fords

all: dir fords $(OPATHS)
	$(MAKE) -C tools

dir:
	install -d $(BUILDPATH)

fords:
	$(MAKE) -C ford


$(BUILDPATH)/%.o: %.fork
	@printf "FORKC\t\t%s\n" $<
	@ FORDPATHS="$(LIBFORK)/build/ford/:$(BUILDPATH)/../src/ford/" $(FORKC) -I $(INCLUDES) -I $(LFINCL) -o $@ $<

clean:
	rm -rf $(BUILDPATH)
