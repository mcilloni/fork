ifndef FORKC
	FORKC = forkc
endif

FORKC_O = $(FORKC) --no-spring

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
	@printf "FORKC\t\t%s\n" rt.fork
	@ FORDPATHS="$(shell pwd)/ford/internal/:$(shell pwd)/ford/" $(FORKC_O) -o ../build/rt.o rt.fork

	$(MAKE) -C c
	$(MAKE) -C err
	$(MAKE) -C mem
	$(MAKE) -C io
	$(MAKE) -C file
	$(MAKE) -C base
	$(MAKE) -C text
	$(MAKE) -C tty
	$(MAKE) -C vect
	$(MAKE) -C map
	$(MAKE) -C dyn
	$(MAKE) -C utils
	$(MAKE) -C lex
	$(MAKE) -C ast
	$(MAKE) -C synt
	$(MAKE) -C sema

	@printf "AR\t\t%s\n" $(ARNAME)
	@ $(AR) rc ../build/$(ARNAME) ../build/*/*.o
	@ $(RANLIB) ../build/$(ARNAME)

	@printf "CCLD\t\t%s\n" $(SONAME)
	@ $(CCLD) -shared -o ../build/$(SONAME) ../build/*/*.o $(LDFLAGS)

	cp -r ford/ ../build

clean:
	$(MAKE) -C c clean
	$(MAKE) -C err clean
	$(MAKE) -C mem clean
	$(MAKE) -C io clean
	$(MAKE) -C file clean
	$(MAKE) -C base clean
	$(MAKE) -C text clean
	$(MAKE) -C tty clean
	$(MAKE) -C vect clean
	$(MAKE) -C map clean
	$(MAKE) -C dyn clean
	$(MAKE) -C utils clean
	$(MAKE) -C lex clean
	$(MAKE) -C ast clean
	$(MAKE) -C synt clean
	$(MAKE) -C sema clean
	rm -rf ../build/ford/
