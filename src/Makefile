ifndef FORKC
	FORKC = forkc
endif

FORKC_O = $(FORKC) --no-spring

CCLD = $(CC)
SONAME = 'libfork.so'

.PHONY: all clean

all:
	mkdir -p ../build/
	@printf "FORKC\t\t%s\n" rt.fork
	@ FORDPATHS="$(shell pwd)/ford/" $(FORKC_O) -o ../build/rt.o rt.fork

	$(MAKE) -C base
	$(MAKE) -C utils
	$(MAKE) -C lex
	$(MAKE) -C ast
	$(MAKE) -C synt
	$(MAKE) -C sema

	@printf "CCLD\t\t%s\n" $<
	$(CCLD) -shared -o ../build/$(SONAME) ../build/*/*.o

clean:
	$(MAKE) -C base clean
	$(MAKE) -C utils clean
	$(MAKE) -C lex clean
	$(MAKE) -C ast clean
	$(MAKE) -C synt clean
	$(MAKE) -C sema clean
