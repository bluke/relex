EXEC=relex
CC=gcc -Wall
LEX= flex
FAL= $(wildcard *.lex)
CSRC= $(FAL:.lex=.c)
SRC= $(wildcard *.c)
OBJ= $(SRC:.c=.o),$(CSRC:.c=.o)


all: OBJ
	$(CC) -o $(EXEC) $^

%.o: %.c
	$(CC) -o $@ -c $< $(CFLAGS)

%.c:%.lex
	$(LEX) -o $@ $<

clean:
	rm $(CSRC) $(OBJ) $(EXEC)
