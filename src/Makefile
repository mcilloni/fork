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


SONAME = 'libfork.so'
ARNAME = 'libfork.a'

.PHONY: all clean

all:
	mkdir -p ../build/
	@printf "FORKC\t\t%s\n" rt.fork
	@ FORDPATHS="$(shell pwd)/ford/internal/:$(shell pwd)/ford/" $(FORKC_O) -o ../build/rt.o rt.fork

	$(MAKE) -C err
	$(MAKE) -C base
	$(MAKE) -C utils
	$(MAKE) -C lex
	$(MAKE) -C ast
	$(MAKE) -C synt
	$(MAKE) -C sema

	@printf "AR\t\t%s\n" $(ARNAME)
	@ $(AR) rc ../build/$(ARNAME) ../build/*/*.o
	@ $(RANLIB) ../build/$(ARNAME)

	@printf "CCLD\t\t%s\n" $(SONAME)
	@ $(CCLD) -shared -o ../build/$(SONAME) ../build/*/*.o

	cp -r ford/ ../build

clean:
	$(MAKE) -C err clean
	$(MAKE) -C base clean
	$(MAKE) -C utils clean
	$(MAKE) -C lex clean
	$(MAKE) -C ast clean
	$(MAKE) -C synt clean
	$(MAKE) -C sema clean
	rm -rf ../build/ford/
