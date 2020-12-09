/*
 *  stack.c: a file that implements the fundamental operations on the stack such as 
 *  adding and deleting elements
 *
 *  NOTE: mainly used the dynamic memory files as a guide :)
 *
 */

#include "stack.h"

#include <stdio.h>
#include <string.h>
#include <stdlib.h>

int size;

void init_stack(stack *s) {
	s -> top = NULL;
	size = 0;
}

void push(stack *s, frac x) {
	stack_elt *elt;

	// allocate new mem
	elt = malloc(sizeof(*elt));

	// if malloc fails fat L
	if (elt == NULL) {
		printf("Yikes boo boo ya ran outta memory :(\n");
		exit(1);
	}

	elt-> x = malloc(sizeof(frac));
	// if malloc fails fat L
	if (elt->x == NULL) {
		printf("Yikes boo boo ya ran outta memory :(\n");
		exit(1);
	}
	elt->x->numerator = x.numerator;
	elt->x->denominator = x.denominator;

	if (size == 0) { // if empty stack, next is null
		elt->next = NULL;
	} else { // next element is prev top of stack
		elt->next = s->top; 
	}
	s->top = elt;
	size++;
}

frac pop(stack *s) {
	stack_elt *elt;
	frac popped;

	if (size == 0) {
		printf("STACK ERROR\n");
		popped.numerator = 0;
		popped.denominator = 0;
	} else {
		elt = s->top;
		popped = *(elt->x);

		if (size == 1) {
			s->top = NULL;
		} else {
			s->top = elt->next;
		}

		size--;
		
		free(elt->x);
		free(elt);
	}
	return popped;
}

frac peek(stack *s) {
	stack_elt *elt;
	frac peek;

	if (size == 0) {
		printf("STACK ERROR\n");
		peek.numerator = 0;
		peek.denominator = 0;
	} else {
		elt = s->top;
		peek = *(elt->x);
	}
	return peek;
}

void clear(stack *s) {
	while (s->top) {
		pop(s);
	}
} 

int get_size(stack *s) {
	return size;
}

void print(stack *s) {
    stack_elt *elt = s->top;

    if (elt == NULL) {
    	printf("STACK IS EMPTY\n");
    	return;
    }

    printf("STACK CONTENTS: \n");
	while (elt) {
    	printf("%d/%d\n", elt->x->numerator, elt->x->denominator);
    	elt = elt->next; 
	}
}