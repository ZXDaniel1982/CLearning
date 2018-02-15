foo = $(bar)
bar = Huh?

CLOCAT := -L./stack/
CFLAGS := -lstack -o

STRING = "Output string"
STRING ?= "Alter output"
STRING += "book"

main: main.c
	$(CC) $< $(CLOCAT) $(CFLAGS) $@

all:
	@echo $(foo)
	@echo $(foo)

.PHONY: clean
clean:
	@echo "Cleaning project"
	@echo $(STRING)
	-rm main
	@echo "Clean completed"
