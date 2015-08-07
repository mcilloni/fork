BUILDPATH = ../../../build/include/

ifndef FORDC
	FORDC = fordc
endif

.PHONY: all clean

all: dir
	@printf "FORDC:\t\tcompiling internal fords\n"
	@ FORDPATHS="$(shell pwd):$(shell pwd)/../ford/" $(FORDC) -H $(BUILDPATH) *.ford

dir:
	mkdir -p $(BUILDPATH)

clean:
	rm -rf $(BUILDPATH)
