.PHONY: all clean stage1 bootstrap copy-libs build

all:
	@ mkdir -p build/
	cp -rf src/ford/ build/
	$(MAKE) -C src

clean:
	$(MAKE) -C libfork clean
	rm -rf build
	rm -rf build.1
	rm -rf ctrans-release
	rm -f ctrans-release.txz


build:
	$(MAKE) -C libfork
	$(MAKE) all

	$(MAKE) copy-libs

stage1:
	$(MAKE) build
	mv build build.1

bootstrap:
	$(MAKE) stage1

	$(MAKE) -C libfork clean
	rm -rf build

	FORDC="$(shell pwd)/build.1/fordc" FORKC="$(shell pwd)/build.1/forkc" FORKL="$(shell pwd)/build.1/forkl" $(MAKE) build


copy-libs:
	mkdir -p build/libfork/ford
	cp -f libfork/build/ford/*.ford build/libfork/ford

	mkdir -p build/libfork/include
	cp -f libfork/build/include/*.h build/libfork/include

	cp -f libfork/build/libfork.a build/libfork/
	cp -f libfork/build/rt.o build/libfork/

tarball: bootstrap
	rm -f build/*.o
	rm -rf build/ford
	rm -rf build/include

	mv build ctrans-release

	tar -cf - ctrans-release | xz -9e -c - > ctrans-release.txz
