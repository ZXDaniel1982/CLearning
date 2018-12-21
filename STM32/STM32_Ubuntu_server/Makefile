CC=gcc
CFLAGS=
DEPS = stm32_ubuntu_server.h
OBJ = stm32_ubuntu_server.o stm32_ubuntu_server.o 

%.o: %.c $(DEPS)
	$(CC) -c -o $@ $< $(CFLAGS)

server: $(OBJ)
	$(CC) -o $@ $^ $(CFLAGS)