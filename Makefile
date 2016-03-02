.PHONY: all clean 

all: clean
	$(MAKE) -C src

clean:
	rm -rf build
