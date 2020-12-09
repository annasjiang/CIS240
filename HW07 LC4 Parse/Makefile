loader.o: loader.c loader.h
	clang -Wall -c loader.c

LC4.o: LC4.c LC4.h
	clang -Wall -c LC4.c

parser.o: parser.c loader.h LC4.h
	clang -Wall -c parser.c

parser: clean parser.o loader.o LC4.o
	clang -Wall -o parser parser.o loader.o LC4.o

clean:
	rm -f parser parser.o loader.o LC4.o
