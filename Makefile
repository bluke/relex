EXEC=relex
CC=gcc -g -Wall
LEX= flex
PAR=bison

FAL= $(wildcard *.lex)
LSRC= $(FAL:.lex=.c)

FGP= $(wildcard *.y)
PSRC= $(FGP:.y=.c)

SRC= $(wildcard *.c)
OBJ= $(SRC:.c=.o) $(LSRC:.c=.o) $(PSRC:.c=.o)


all: $(OBJ)
	$(CC) -o $(EXEC) $^

%.o: %.c
	$(CC) -o $@ -c $< $(CFLAGS)

%.c:%.lex
	$(LEX) -o $@ $<

%.c:%.y
	$(PAR) -o $@ $< 

clean:
	rm $(CSRC) $(OBJ) $(EXEC)
