/*
 *  stack.c: a file that implements the fundamental operations on the stack such as 
 *  adding and deleting elements
 *
 *  NOTE: mainly used the dynamic memory files as a guide :)
 *  ANOTHER NOTE: this is the same stack from rpn but adapted for this hw
 *
 */

#include "stack.h"

#include <stdio.h>
#include <string.h>
#include <stdlib.h>

int size;

void init_stack(stack *s) {
	s->top = NULL;
	size = 0;
}

void push(stack *s, int x) {
	stack_elt *elt;

	// allocate new mem
	elt = malloc(sizeof(*elt));

	// if malloc fails fat L
	if (elt == NULL) {
		printf("Yikes boo boo ya ran outta memory :(\n");
		exit(1);
	}

	elt->x = x;
	elt->next = s->top; 
	s->top = elt;
	size++;
}

int pop(stack *s) {
	stack_elt *elt;
	int popped = 0;

	if (s->top != NULL) {
		elt = s->top;
		popped = elt->x;

		if (size == 1) {
			s->top = NULL;
		} else {
			s->top = elt->next;
		}

		size--;

		free(elt);
	}

	return popped;
}

int peek(stack *s) {
	stack_elt *elt;
	int peek = 0;
	if (s->top != NULL) {
		elt = s->top;
		peek = elt->x;
	}
	return peek;
}

void clear(stack *s) {
	while (s->top) {
		pop(s);
	}
} 