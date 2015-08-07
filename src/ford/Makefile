BUILDPATH = ../../build/include/

ifndef FORDC
	FORDC = fordc
endif

.PHONY: all dir clean

all: dir
	$(MAKE) -C internal
	@printf "FORDC:\t\tcompiling fords\n"
	@ FORDPATHS="$(shell pwd)/internal/:$(shell pwd)" $(FORDC) -H $(BUILDPATH) *.ford

dir:
	mkdir -p $(BUILDPATH)

clean:
	rm -rf $(BUILDPATH)
