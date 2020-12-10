/*
 *  stack.h: a header file containing declarations of relevant data structures and 
 *  functions provided by stack.c
 *
 *  NOTE: mainly used the dynamic memory files as a guide :)
 *  ANOTHER NOTE: this is the same stack from rpn but adapted for this hw
 *
 */

// stack struct
typedef struct stack_elt_tag {
	int x;
	struct stack_elt_tag *next;
} stack_elt;

typedef struct {
	stack_elt *top;
} stack;

// initialize stack
void init_stack(stack *s);
// add number to top of stack
void push(stack *s, int x);
// remove number from top of stack
int pop(stack *s);
// peek top val of stack
int peek(stack *s);
// delete stack
void clear(stack *s);