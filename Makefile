.PHONY: all clean tests

all:
	$(MAKE) -C src
	$(MAKE) -C examples clean
	$(MAKE) -C examples

tests:
	cram tests/*.t

clean:
	$(MAKE) -C src clean
	rm -rf build
