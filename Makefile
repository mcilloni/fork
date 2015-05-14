.PHONY: all clean

all:
	@ mkdir -p build/
	$(MAKE) -C src

clean:
	$(MAKE) -C src clean
	rm -rf build
