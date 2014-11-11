ifndef HELMC
	HELMC = helmc
endif

ifndef HELML
	HELML = helml
endif

SRCS = $(wildcard *.helm)
OBJS = $(patsubst %.helm,%.o,$(SRCS))
BINS = $(patsubst %.helm,%.elf,$(SRCS))

.PHONY: all clean

all: $(BINS)

%.elf: %.o
	@echo [HELML] $<
	@ $(HELML) -o $@ $< ../build/libsynt.a ../build/liblex.a ../build/libutils.a

%.o: %.helm 
	@echo [HELMC] $<
	@ HELM_MODULES="$(shell pwd)/../src/hemd/" $(HELMC) -o $@ $<

clean:
	rm $(BINS)

