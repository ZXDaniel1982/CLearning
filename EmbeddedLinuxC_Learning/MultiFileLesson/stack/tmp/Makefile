.PHONY: all
all: libstack.a

libstack.a: stack.o
	@echo "Generating $@"
	ar rs $@ $<

stack.o: stack.c
	@echo "Generating $@"
	$(CC) -c $<
