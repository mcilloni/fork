.PHONY: all clean

all:
	make -C src

clean:
	make -C src clean
	rm -rf build
