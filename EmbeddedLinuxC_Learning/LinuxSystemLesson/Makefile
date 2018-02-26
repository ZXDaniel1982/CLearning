TARGET = main

.PHONY: all
all: $(TARGET)

$(TARGET): $(TARGET).o
	$(CC) $< -o $@
	-rm $<

$(TARGET).o: $(TARGET).c
	indent -kr -i4 -nut $<
	$(CC) -c $< -g

.PHONY: clean
clean:
	@echo "Cleaning project"
	-rm $(TARGET)
	-rm $(TARGET).o
	@echo "Clean completed"