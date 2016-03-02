.PHONY: all clean tests st

all: clean
	$(MAKE) -C src

clean:
	rm -rf build
