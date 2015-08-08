BUILDPATH = ../../../build/include/

ifndef FORDC
	FORDC = fordc
endif

FORDC += --no-libfork

.PHONY: all clean

all: dir
	@printf "FORDC:\t\tcompiling internal fords\n"
	@ FORDPATHS="$(shell pwd):$(shell pwd)/../" $(FORDC) -H $(BUILDPATH) *.ford

dir:
	mkdir -p $(BUILDPATH)

clean:
	rm -rf $(BUILDPATH)
