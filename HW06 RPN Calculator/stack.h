/*
 *  stack.h: a header file containing declarations of relevant data structures and 
 *  functions provided by stack.c
 *
 *  NOTE: mainly used the dynamic memory files as a guide :)
 *
 */

// fractions
typedef struct frac_struct {
	int numerator;
	int denominator;
} frac;

// stack struct
typedef struct stack_elt_tag {
	frac *x;
	struct stack_elt_tag *next;
} stack_elt;

typedef struct {
	stack_elt *top;
} stack;

// initialize stack
void init_stack(stack *s);
// add number to top of stack
void push(stack *s, frac x);
// remove number from top of stack
frac pop(stack *s);
// peek top val of stack
frac peek(stack *s);
// delete stack
void clear(stack *s);
// size
int get_size(stack *s);
// print stack
void print(stack *s);

