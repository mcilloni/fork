ifndef HELMC
	HELMC = helmc
endif

.PHONY: all clean

all:
	$(MAKE) -C utils
	$(MAKE) -C lex
	$(MAKE) -C synt

clean:
	$(MAKE) -C utils clean
	$(MAKE) -C lex clean
