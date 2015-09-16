.PHONY: all clean tests st

all: clean
	$(MAKE) -C src
	$(MAKE) -C examples clean
	$(MAKE) -C examples

tests:
	cram tests/*.t

st:
	@ sh selftest.sh

clean:
	rm -rf build
