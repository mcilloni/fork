BUILDPATH = ../../build/synt/
LIBPATH = ../../build/libsynt.a

ifndef HELMC
	HELMC = helmc
endif

ifndef AR
	AR=ar
endif

ifndef RANLIB
	RANLIB=ranlib
endif

SRCS = $(wildcard *.helm)
OBJS = $(patsubst %.helm,%.o,$(SRCS))
OPATHS = $(foreach obj, $(OBJS), $(BUILDPATH)/$(obj))

.PHONY: all clean

all: $(OPATHS)
	$(AR) rc $(LIBPATH) $(OPATHS)
	$(RANLIB) $(LIBPATH)

dir:
	install -d $(BUILDPATH)	

$(BUILDPATH)/%.o: %.helm dir
	@echo [HELMC] $<
	@ HELM_MODULES="$(shell pwd)/../hemd/" $(HELMC) -o $@ $<

clean:
	rm -rf $(BUILDPATH)
	rm -f $(LIBPATH)

