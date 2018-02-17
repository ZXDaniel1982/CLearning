TARGET = Lesson

.PHONY: all
all: $(TARGET)

$(TARGET): $(TARGET).o
	$(CC) $< -o $@ -lm
	-rm $<

$(TARGET).o: $(TARGET).c
	$(CC) -c $<

.PHONY: clean
clean:
	@echo "Cleaning project"
	-rm $(TARGET)
	-rm $(TARGET).o
	@echo "Clean completed"