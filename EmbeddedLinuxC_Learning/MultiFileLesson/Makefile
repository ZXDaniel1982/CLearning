CLOCAT := -L./stack
CFLAGS := -lstack -o

STRING = "Output string"
STRING ?= "Alter output"
STRING += "book"

NEXTDIR = stack

#source = main.c

#include $(source:.c=.d)

.PHONY: all
all: main

main: main.c
	@echo "Entering $(NEXTDIR)"
	make -C $(NEXTDIR) all
	@echo "Back from $(NEXTDIR)"
	$(CC) $< $(CLOCAT) $(CFLAGS) $@

#stack/libstack.a: stack/tmp

.PHONY: clean
clean:
	@echo "Cleaning project"
	@echo $(STRING)
	-rm main
	@echo "Clean completed"

#%.d: %.c
#	set -e; rm -f $@; \
#	$(CC) -MM $(CPPFLAGS) $< > $@.$$$$;  \
#	sed 's,\($*\)\.o[ :]*,\1.o $@ : ,g' < $@.$$$$ > $@; \
#	rm -f $@.$$$$