BUILDPATH = $(shell pwd)/../build/

ifndef FORKC
	FORKC = forkc
endif

FORKC_O = $(FORKC) --no-spring

CCLD = $(CC)

SONAME = 'ctrans.so'

SRCS = $(wildcard *.fork)
OBJS = $(patsubst %.fork,%.o,$(SRCS))
OPATHS = $(foreach obj, $(OBJS), $(BUILDPATH)/$(obj))

.PHONY: all clean fords

all: dir $(OPATHS)

	@printf "CCLD\t\t%s\n" $(SONAME)
	@ $(CCLD) -shared -o ../build/$(SONAME) ../build/*.o -L$(FORKROOT)/libfork/build/ -lfork

dir:
	install -d $(BUILDPATH)


$(BUILDPATH)/%.o: %.fork
	@printf "FORKC\t\t%s\n" $<
	@ FORDPATHS="$(FORKROOT)/libfork/build/ford/:$(FORKROOT)/forkc/build/ford/:$(BUILDPATH)/../src/ford/" $(FORKC_O) -o $@ $<

clean:
	rm -rf $(BUILDPATH)
