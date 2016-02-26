.PHONY: all clean tests st

all: clean
	$(MAKE) -C src
	$(MAKE) -C examples clean
	$(MAKE) -C examples
	
st:
	@ sh selftest.sh

clean:
	rm -rf build
	$(MAKE) -C examples clean
