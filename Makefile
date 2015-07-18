.PHONY: all clean

all:
	@ mkdir -p build/
	cp -rf src/ford/ build/
	$(MAKE) -C src
	$(MAKE) -C examples clean
	$(MAKE) -C examples

clean:
	rm -rf build
