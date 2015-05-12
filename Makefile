.PHONY: all clean tests

all: clean
	$(MAKE) -C src
	$(MAKE) -C examples clean
	$(MAKE) -C examples

tests:
	cram tests/*.t

clean:
	rm -rf build
