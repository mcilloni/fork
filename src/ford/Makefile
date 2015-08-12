BUILDPATH = $(shell pwd)/../../build/include/
LIBFORK = $(shell pwd)/../../libfork/
LFINCL = $(LIBFORK)/build/include/

ifndef FORDC
	FORDC = fordc
endif

FORDC += --no-libfork

.PHONY: all dir clean

all: dir
	@printf "FORDC:\t\tcompiling fords\n"
	@ FORDPATHS="$(LIBFORK)/build/ford:$(shell pwd)" $(FORDC) -H $(BUILDPATH) *.ford

dir:
	mkdir -p $(BUILDPATH)

clean:
	rm -rf $(BUILDPATH)
