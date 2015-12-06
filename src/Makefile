INCLUDES = $(shell pwd)/../build/include/

ifndef FORKC
	FORKC = forkc
endif

FORKC += --no-libfork

CCLD = $(CC)

ifndef AR
	AR=ar
endif

ifndef RANLIB
	RANLIB=ranlib
endif

ifeq ($(shell uname), Linux)
	LDFLAGS=-ldl
endif

SONAME = 'libfork.so'
ARNAME = 'libfork.a'

.PHONY: all clean

all:
	mkdir -p ../build/

	$(MAKE) -C ford

	@printf "FORKC\t\t%s\n" rt.fork
	@ FORDPATHS="$(shell pwd)/ford/internal/:$(shell pwd)/ford/" $(FORKC) -I $(INCLUDES) -o ../build/rt.o rt.fork

	$(MAKE) -C c
	$(MAKE) -C math
	$(MAKE) -C err
	$(MAKE) -C mem
	$(MAKE) -C io
	$(MAKE) -C fs
	$(MAKE) -C txt
	$(MAKE) -C tty
	$(MAKE) -C cs
	$(MAKE) -C pair
	$(MAKE) -C vect
	$(MAKE) -C list
	$(MAKE) -C kv
	$(MAKE) -C map
	$(MAKE) -C hash
	$(MAKE) -C proc
	$(MAKE) -C dyn
	$(MAKE) -C utils
	$(MAKE) -C ast
	$(MAKE) -C synt
	$(MAKE) -C sema
	$(MAKE) -C fords
	$(MAKE) -C parser
	$(MAKE) -C libfork

	@printf "AR\t\t%s\n" $(ARNAME)
	@ $(AR) rc ../build/$(ARNAME) ../build/*/*.o
	@ $(RANLIB) ../build/$(ARNAME)

	mkdir -p ../build/ford/internal
	cp -r ford/*.ford ../build/ford/
	cp -r ford/internal/*.ford ../build/ford/internal/

clean:
	$(MAKE) -C c clean
	$(MAKE) -C math clean
	$(MAKE) -C err clean
	$(MAKE) -C mem clean
	$(MAKE) -C io clean
	$(MAKE) -C file clean
	$(MAKE) -C txt clean
	$(MAKE) -C tty clean
	$(MAKE) -C pair clean
	$(MAKE) -C vect clean
	$(MAKE) -C list clean
	$(MAKE) -C kv clean
	$(MAKE) -C map clean
	$(MAKE) -C proc clean
	$(MAKE) -C dyn clean
	$(MAKE) -C utils clean
	$(MAKE) -C lex clean
	$(MAKE) -C ast clean
	$(MAKE) -C synt clean
	$(MAKE) -C sema clean
	$(MAKE) -C parser clean
	$(MAKE) -C libfork clean
	rm -rf ../build/ford/
