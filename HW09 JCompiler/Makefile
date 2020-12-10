stack.o: stack.c stack.h
	clang -Wall -c stack.c

token.o: token.c token.h
	clang -Wall -c token.c

jc.o: jc.c token.h stack.h
	clang -Wall -c jc.c

jc: clean jc.o token.o stack.o
	clang -Wall -o jc jc.o token.o stack.o

clean: 
	rm -f jc jc.o token.o stack.o