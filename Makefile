.PHONY: all clean stage1 bootstrap copy-libs build

all:
	@ mkdir -p build/
	cp -rf src/ford build/ford
	$(MAKE) -C src

clean:
	$(MAKE) -C libfork clean
	rm -rf build
	rm -rf build.1
	rm -rf build.2
	rm -rf ctrans-release
	rm -rf ctrans-devrel
	rm -f ctrans-release.txz
	rm -f ctrans-devrel.txz


build:
	$(MAKE) -C libfork
	$(MAKE) all

	$(MAKE) copy-libs

stage1:
	$(MAKE) build

stage2:
	$(MAKE) stage1
	rm -rf build.1
	mv build build.1

	$(MAKE) -C libfork clean

	FORDC="$(shell pwd)/build.1/fordc" FORKC="$(shell pwd)/build.1/forkc" FORKL="$(shell pwd)/build.1/forkl" $(MAKE) build

stage3:
	$(MAKE) stage2
	rm -rf build.2
	mv build build.2

	$(MAKE) -C libfork clean

	FORDC="$(shell pwd)/build.2/fordc" FORKC="$(shell pwd)/build.2/forkc" FORKL="$(shell pwd)/build.2/forkl" $(MAKE) build

bootstrap:
	$(MAKE) clean
	$(MAKE) stage3

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


tarball-cross: stage1
	rm -f build/*.o
	rm -rf build/ford
	rm -rf build/include

	mv build ctrans-release

	tar -cf - ctrans-release | xz -9e -c - > ctrans-release.txz


tarball-devrel: stage1
	rm -f build/*.o
	rm -rf build/ford
	rm -rf build/include

	mv build ctrans-devrel

	tar -cf - ctrans-devrel | xz -9e -c - > ctrans-devrel.txz
