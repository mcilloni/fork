ifndef HELMC
	HELMC = helmc
endif

ifndef HELML
	HELML = helml
endif

SRCS = $(wildcard *.helm)
LIBS = $(wildcard $(shell pwd)/../build/*.a)
OBJS = $(patsubst %.helm,%.o,$(SRCS))
BINS = $(patsubst %.helm,%,$(SRCS))

.PHONY: all clean

all: $(BINS)

%: %.o
	@echo [HELML] $<
	@ $(HELML) -o $@ $< $(LIBS)

%.o: %.helm 
	@echo [HELMC] $<
	@ HELM_MODULES="$(shell pwd)/../src/hemd/" $(HELMC) -o $@ $<

clean:
	rm $(BINS)

