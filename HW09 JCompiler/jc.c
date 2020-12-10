/*
 * jc.c : main compiler function that reads in tokens and generates corresponding .asm file
 * 
 */

#include "token.h"
#include "stack.h"

#include <stdio.h>
#include <stdlib.h>
#include <string.h>

int main(int argc, char **argv) {
	// read file to be compiled
	FILE *in_file = fopen(argv[1], "r");
	if (in_file == NULL) {
		printf("couldn't open file to read\n");
		exit(1);
	}

	// create .asm file to write into
	char filename[strlen(argv[1]) + 1];
	sscanf(argv[1], "%[^.].j", filename);
	strcat(filename, ".asm");
	FILE *out_file = fopen(filename, "w");

	// init token and fat stackz
	token *theToken = malloc(sizeof(token));
	init_token(theToken);
	stack *ifStack = malloc(sizeof(stack));
	init_stack(ifStack);
	stack *elseStack = malloc(sizeof(stack));
	init_stack(elseStack);

	int isPartOfFunction = 0; // will be 1 within (defun, return]
	int cmpBranchNo = 0; // use to keep track of diff compare branches
	int ifElseNo = 0; // use to keep track of if else statements

	while (read_token(theToken, in_file) == 0) { // REG FUNCTIONS
		if (theToken->funcType == 0) {
			if (theToken->type == LITERAL) { // literal
				fprintf(out_file, "\t\tCONST R0, #%d \t\t\t\t; LITERAL\n", (short) (theToken->literal_value & 0x00FF));
	            fprintf(out_file, "\t\tHICONST R0, #%d\n", (short) ((theToken->literal_value >> 8) & 0xFF));
	            fprintf(out_file, "\t\tADD R6, R6, #-1\n");
	            fprintf(out_file, "\t\tSTR R0, R6, #0\n\n");
			} // stack
			else if (theToken->type == DROP) {
				fprintf(out_file, "\t\tADD R6, R6, #1 \t\t\t; DROP\n");
			} else if (theToken->type == DUP) {
				fprintf(out_file, "\t\tLDR R0, R6, #0 \t\t\t; DUP\n");
	            fprintf(out_file, "\t\tADD R6, R6, #-1\n");
	            fprintf(out_file, "\t\tSTR R0, R6, #0\n\n");
			} else if (theToken->type == SWAP) {
				fprintf(out_file, "\t\tLDR R0, R6, #0 \t\t\t; SWAP\n");
	            fprintf(out_file, "\t\tLDR R1, R6, #1\n");
	            fprintf(out_file, "\t\tSTR R0, R6, #1\n");
	            fprintf(out_file, "\t\tSTR R1, R6, #0\n\n");
			} else if (theToken->type == ROT) {
				fprintf(out_file, "\t\tLDR R0, R6, #0 \t\t\t; ROT\n");
	            fprintf(out_file, "\t\tLDR R1, R6, #1\n");
	            fprintf(out_file, "\t\tLDR R2, R6, #2\n");
	            fprintf(out_file, "\t\tSTR R0, R6, #1\n");
	            fprintf(out_file, "\t\tSTR R1, R6, #2\n");
	            fprintf(out_file, "\t\tSTR R2, R6, #0\n\n");
			} else if (theToken->type == ARG) {
				fprintf(out_file, "\t\tLDR R0, R5, #%d \t\t\t; ARG\n", theToken->arg_no + 2);
	            fprintf(out_file, "\t\tADD R6, R6, #-1\n");
	            fprintf(out_file, "\t\tSTR R0, R6, #0\n\n");
			} // if else
			else if (theToken->type == IF) {
				fprintf(out_file, "\t\tADD R6, R6, #1 \t\t\t; IF\n");
	            fprintf(out_file, "\t\tLDR R0, R6, #-1\n");
	            fprintf(out_file, "\t\tBRnz ELSE_%d\n\n", ifElseNo);
	            push(ifStack, ifElseNo);
	            push(elseStack, ifElseNo);
	            ifElseNo++;
			} else if (theToken->type == ELSE) {
				int peekElse = pop(elseStack);
				fprintf(out_file, "\t\tJMP ENDIF_%d\n\n", peekElse);
	            fprintf(out_file, "ELSE_%d\n", peekElse);   
			} else if (theToken->type == ENDIF) {
				int peekIf = pop(ifStack);
				int peekElse = peek(elseStack);
				if (peekElse) {
					if (peekIf == peekElse) {                   
                        fprintf(out_file, "\tELSE_%d\n", pop(elseStack));
                    } else {
                    	fprintf(out_file, "\tENDIF_%d\n", peekIf);    
                    } 
                } else {
                    fprintf(out_file, "\tENDIF_%d\n", peekIf);
                }
			} // functions
			else if (theToken->type == DEFUN) { // declaring functions
				read_token(theToken, in_file); // check next token for name
				if (isPartOfFunction == 0 && theToken->type == IDENT) {
					isPartOfFunction = 1;
					fprintf(out_file, "\t\t.CODE\n");
					fprintf(out_file, "\t\t.FALIGN\n");
					fprintf(out_file, "%s\n", theToken->str);
					fprintf(out_file, "\t\tADD R6, R6, #-3\n");
					fprintf(out_file, "\t\tSTR R7, R6, #1\n");
					fprintf(out_file, "\t\tSTR R5, R6, #0\n");			
					fprintf(out_file, "\t\tADD R5, R6, #0\n\n");
				} else {
					printf("ERROR: can't declare function inside a function/invalid function name\n");
				}
			} else if (theToken->type == IDENT) { // calling functions
				fprintf(out_file, "\t\tJSR %s\n", theToken->str);
				fprintf(out_file, "\t\tADD R6, R6, #-1\n\n");
			} else { // return
				if (isPartOfFunction == 1) {
					isPartOfFunction = 0;
					fprintf(out_file, "\t\tLDR R7, R6, #0 \t\t\t; RETURN\n");
					fprintf(out_file, "\t\tSTR R7, R5, #2\n");
					fprintf(out_file, "\t\tADD R6, R5, #0\n");
					fprintf(out_file, "\t\tLDR R5, R6, #0\n");
					fprintf(out_file, "\t\tLDR R7, R6, #1\n");
					fprintf(out_file, "\t\tADD R6, R6, #3\n");
					fprintf(out_file, "\t\tRET\n\n");
				} else {
					printf("ERROR: can't return outside of function\n");
				}
			}
		} else if (theToken->funcType == 1) { // MATH AND LOGIC
			fprintf(out_file, "\t\tLDR R0, R6, #0 \t\t\t; MATH/LOGIC\n");
		    fprintf(out_file, "\t\tLDR R1, R6, #1\n");
   
			if (theToken->type == PLUS) { // math			
			    fprintf(out_file, "\t\tADD R0, R0, R1 \t\t\t; PLUS\n"); 
			} else if (theToken->type == MINUS) {
	            fprintf(out_file, "\t\tSUB R0, R0, R1 \t\t\t; MINUS\n");
			} else if (theToken->type == MUL) { 
	            fprintf(out_file, "\t\tMUL R0, R0, R1 \t\t\t; MUL\n");
			} else if (theToken->type == DIV) {
	            fprintf(out_file, "\t\tDIV R0, R0, R1 \t\t\t; DIV\n");
			} else if (theToken->type == MOD) { 
	            fprintf(out_file, "\t\tMOD R0, R0, R1 \t\t\t; MOD\n");
			} // logic
			else if (theToken->type == AND) { 
		        fprintf(out_file, "\t\tAND R0, R0, R1 \t\t\t; AND\n");
			} else if (theToken->type == OR) { 
		        fprintf(out_file, "\t\tOR R0, R0, R1 \t\t\t; OR\n");
			}  else { // not
		        fprintf(out_file, "\t\tNOT R0, R0 \t\t\t\t; NOT\n");
			} 

		    fprintf(out_file, "\t\tADD R6, R6, #1\n");
		    fprintf(out_file, "\t\tSTR R0, R6, #0\n\n");
		} else if (theToken->funcType == 2) { // COMPARISIONS
			fprintf(out_file, "\t\tLDR R0, R6, #0 \t\t\t; COMPARE\n");
            fprintf(out_file, "\t\tLDR R1, R6, #1\n");
            fprintf(out_file, "\t\tCMP R0 R1\n");

            if (theToken->type == LT) {
            	fprintf(out_file, "\t\tBRn CMP_TRUE_%d \t\t; LT\n", cmpBranchNo);
            	fprintf(out_file, "\t\tBRzp CMP_FALSE_%d\n\n", cmpBranchNo);
            } else if (theToken->type == LE) {
            	fprintf(out_file, "\t\tBRnz CMP_TRUE_%d \t\t; LE\n ", cmpBranchNo);
            	fprintf(out_file, "\t\tBRp CMP_FALSE_%d\n\n", cmpBranchNo);
			} else if (theToken->type == EQ) {
				fprintf(out_file, "\t\tBRz CMP_TRUE_%d \t\t; EQ\n", cmpBranchNo);
            	fprintf(out_file, "\t\tBRnp CMP_FALSE_%d\n\n", cmpBranchNo);
			} else if (theToken->type == GE) {
				fprintf(out_file, "\t\tBRzp CMP_TRUE_%d \t\t; GE\n", cmpBranchNo);
            	fprintf(out_file, "\t\tBRn CMP_FALSE_%d\n\n", cmpBranchNo);
			} else { // gt
				fprintf(out_file, "\t\tBRp CMP_TRUE_%d \t\t; GT\n", cmpBranchNo);
            	fprintf(out_file, "\t\tBRnz CMP_FALSE_%d\n\n", cmpBranchNo);
			}

			// CMP_TRUE (jump to here if true)
			fprintf(out_file, "CMP_TRUE_%d\n", cmpBranchNo);
            fprintf(out_file, "\t\tCONST R2, #1\n");
            fprintf(out_file, "\t\tBRnzp CMP_END_%d\n\n", cmpBranchNo);

            // CMP_FALSE (jump to here if false)
            fprintf(out_file, "CMP_FALSE_%d\n", cmpBranchNo);
            fprintf(out_file, "\t\tCONST R2, #0\n");
            fprintf(out_file, "\t\tBRnzp CMP_END_%d\n\n", cmpBranchNo);

            // CMP_END
            fprintf(out_file, "CMP_END_%d\n", cmpBranchNo);
            fprintf(out_file, "\t\tADD R6, R6, #1\n");
            fprintf(out_file, "\t\tSTR R2, R6, #0\n\n");      
            cmpBranchNo++;
		} else { // BROKEN TOKEN
			printf("ERROR: broken token\n");

			fclose(in_file);
			fclose(out_file);

			free(theToken);
			clear(ifStack);
			free(ifStack);
			clear(elseStack);
			free(elseStack);

			exit(1);
		}
	}

	fclose(in_file);
	fclose(out_file);

	free(theToken);
	clear(ifStack);
	free(ifStack);
	clear(elseStack);
	free(elseStack);
}