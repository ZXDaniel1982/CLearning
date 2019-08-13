CC=gcc
CFLAGS=
DEPS = STM32_Ubuntu_IAP.h
OBJ = STM32_Ubuntu_IAP.o

%.o: %.c $(DEPS)
	$(CC) -c -o $@ $< $(CFLAGS)

iap: $(OBJ)
	$(CC) -o $@ $^ $(CFLAGS)