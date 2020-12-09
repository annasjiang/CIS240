/*
 *  rpn.c: contains the main routine of your solution –may contain
 *  additional functions
 *
 *  NOTE: mainly used the dynamic memory files as a guide :)
 *
 */

#include "stack.h"

#include <stdio.h>
#include <ctype.h>
#include <string.h>
#include <stdlib.h>

#define MAX_LINE_LENGTH 100

// helpers for simplication
int gcd(frac x) { // standard gcd function #thxCIS121
	int a, b, c;
	a = x.numerator;
	b = x.denominator;
	while (b != 0) {
		c = a % b;
		a = b;
		b = c;
	}
	return a;
}

frac simp(frac x) { // simplify fraction + get rid of neg denom
	int factor;
	frac new;
	factor = gcd(x);
	new.numerator = x.numerator/factor;
	new.denominator = x.denominator/factor;

	if (new.denominator < 0) { // get rid of neg in denom
		new.numerator = -new.numerator;
		new.denominator = -new.denominator;
	}

	return new;
} 

int main () {  
	char input[MAX_LINE_LENGTH];
	char string1[MAX_LINE_LENGTH];
	char string2[MAX_LINE_LENGTH];  
	int num, denom;
	frac x, y, temp, result, top;
	stack theStacc;  

	init_stack(&theStacc);  

	while (1) {      
		fgets (input, MAX_LINE_LENGTH, stdin); 

		// convert to lowercase for uniformity
		int i;
		for (i = 0; i < strlen(input); i++) {
			input[i] = tolower(input[i]);
		}  
		
		// the real shiz
		if (sscanf(input, "%s%s", string1, string2) == 2) { // can't have mult string commands
			printf("INVALID COMMAND\n");
		}
		else if (sscanf(input, "%d%s", &num, string1) == 2) { // can't have anything after a number
			printf("INVALID COMMAND\n");
		}
		else if (sscanf(input, "%d", &num) == 1) { // entered a number -> push to stack
			x.numerator = num;
			x.denominator = 1;
			push(&theStacc, x);	

			top = peek(&theStacc);
			printf("%d/%d\n", top.numerator, top.denominator);
		}
		else if (sscanf(input, "%s", string1) == 1) { // entered a command
			if (strcmp(string1, "+") == 0) { // add (+)
				if (get_size(&theStacc) >= 2) {
					x = pop(&theStacc);
					y = pop(&theStacc);
					temp.numerator = (x.numerator * y.denominator) + (y.numerator * x.denominator);
					temp.denominator = (x.denominator * y.denominator);
					result = simp(temp);
					push(&theStacc, result);

					top = peek(&theStacc);
					printf("%d/%d\n", top.numerator, top.denominator);
				} else {
					printf("STACK ERROR\n");
				}
			} 
			else if (strcmp(string1, "-") == 0) { // sub (-)
				if (get_size(&theStacc) >= 2) {
					y = pop(&theStacc);
					x = pop(&theStacc);
					temp.numerator = (x.numerator * y.denominator) - (y.numerator * x.denominator);
					temp.denominator = (x.denominator * y.denominator);
					result = simp(temp);
					push(&theStacc, result);

					top = peek(&theStacc);
					printf("%d/%d\n", top.numerator, top.denominator);
				} else {
					printf("STACK ERROR\n");
				}
			} 
			else if (strcmp(string1, "*") == 0) { // mult (*)
				if (get_size(&theStacc) >= 2) {
					x = pop(&theStacc);
					y = pop(&theStacc);
					temp.numerator = (x.numerator * y.numerator);
					temp.denominator = (x.denominator * y.denominator);
					result = simp(temp);
					push(&theStacc, result);

					top = peek(&theStacc);
					printf("%d/%d\n", top.numerator, top.denominator);
				} else {
					printf("STACK ERROR\n");
				}
			} 
			else if (strcmp(string1, "/") == 0) { // div (/)
				if (get_size(&theStacc) >= 2) {
					y = pop(&theStacc);
					x = pop(&theStacc);

					if (y.numerator == 0) { // div 0 error
						printf("ERROR: DIVIDE BY ZERO\n");
						clear(&theStacc);
						exit(1);
					}

					temp.numerator = (x.numerator * y.denominator);
					temp.denominator = (x.denominator * y.numerator);
					result = simp(temp);
					push(&theStacc, result);

					top = peek(&theStacc);
					printf("%d/%d\n", top.numerator, top.denominator);
				} else {
					printf("STACK ERROR\n");
				}
			}
			else if (strcmp(string1, "dup") == 0) { // dup
				if (get_size(&theStacc) >= 1) {
					x = peek(&theStacc);
					push(&theStacc, x);

					top = peek(&theStacc);
					printf("%d/%d\n", top.numerator, top.denominator);
				} else {
					printf("STACK ERROR\n");
				}
			}
			else if (strcmp(string1, "swap") == 0) { // swap
				if (get_size(&theStacc) >= 2) {
					x = pop(&theStacc);
					y = pop(&theStacc);
					push(&theStacc, x);
					push(&theStacc, y);

					top = peek(&theStacc);
					printf("%d/%d\n", top.numerator, top.denominator);
				} else {
					printf("STACK ERROR\n");
				}
			}
			else if (strcmp(string1, "drop") == 0) { // drop
				if (get_size(&theStacc) >= 1) {
					pop(&theStacc);

					if (get_size(&theStacc) > 0) { // only return top if stack isnt empty now
						top = peek(&theStacc);
						printf("%d/%d\n", top.numerator, top.denominator);
					}
				} else {
					printf("STACK ERROR\n");
				}
			}
			else if (strcmp(string1, "clear") == 0) { // clear
				if (get_size(&theStacc) > 0) {
					clear(&theStacc);
				}	
			}
			else if (strcmp(string1, "quit") == 0) { // quit
				clear(&theStacc);
				exit(0);
			}
			else { // one string read but no valid commands
				printf("INVALID COMMAND\n");
			}
		}
		else { // no strings read
			printf("INVALID COMMAND\n");
		}
	}  
	return 0;
}

