VALGRIND_FLAGS=--leak-check=full --track-origins=yes --show-reachable=yes --error-exitcode=2
CFLAGS =-g -std=c99 -Wall -Wconversion -Wtype-limits -pedantic -Werror -O0 -fPIC
CC = gcc

all: clean valgrind

ejemplo: ejemplo.c src/*
	$(CC) $(CFLAGS) src/*.c ejemplo.c -o ejemplo 2>&1

valgrind: ejemplo
	valgrind $(VALGRIND_FLAGS) ./ejemplo 2>&1

valgrind-pruebas: pruebas
	valgrind $(VALGRIND_FLAGS) ./pruebas 2>&1

pruebas: src/*.c pruebas.c
	$(CC) $(CFLAGS) src/*.c pruebas.c -o pruebas 2>&1

clean:
	rm -f ejemplo *.o pruebas 2>&1

64:
	$(CC) $(CFLAGS) src/*.c pruebas_chanutron-x86_64.o -o pruebas_chanutron
	valgrind $(VALGRIND_FLAGS) ./pruebas_chanutron 2>&1

32:
	$(CC) $(CFLAGS) src/*.c pruebas_chanutron-x86.o -o pruebas_chanutron
	valgrind $(VALGRIND_FLAGS) ./pruebas_chanutron 2>&1
