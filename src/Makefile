ifndef FORKC
	FORKC = forkc
endif

.PHONY: all clean

all:
	$(MAKE) -C utils
	$(MAKE) -C lex
	$(MAKE) -C synt
	$(MAKE) -C sema


clean:
	$(MAKE) -C utils clean
	$(MAKE) -C lex clean
	$(MAKE) -C synt clean
	$(MAKE) -C sema clean
