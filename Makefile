.PHONY: all clean stage1 bootstrap

all:
	@ mkdir -p build/
	cp -rf src/ford/ build/
	$(MAKE) -C src

clean:
	$(MAKE) -C libfork clean
	rm -rf build
	rm -rf build.1


stage1:
	$(MAKE) -C libfork
	$(MAKE) all
	mv build build.1

bootstrap:
	$(MAKE) stage1

	$(MAKE) -C libfork clean
	rm -rf build

	FORDC="$(shell pwd)/build.1/fordc" FORKC="$(shell pwd)/build.1/forkc" FORKL="$(shell pwd)/build.1/forkl" make -C libfork
	FORDC="$(shell pwd)/build.1/fordc" FORKC="$(shell pwd)/build.1/forkc" FORKL="$(shell pwd)/build.1/forkl" make all
