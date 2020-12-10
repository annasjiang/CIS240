/*
 * token.c : reads a string and determines token type
 */

#include "token.h"

#include <stdio.h>
#include <stdlib.h>
#include <string.h>
#include <ctype.h>

void init_token (token *theToken) {
	theToken->type = BROKEN_TOKEN; // default token
    theToken->funcType = -1; // -1 = broken, 0 = reg, 1 = math/logic, 2 = comp
	theToken->literal_value = 0;
	theToken->arg_no = 0;
}

int isValidDefun (char *str) {
	int i;
	// can only start with letters
	// cant contain things besides alpha numeric and underscore
	if (isalpha(str[0]) != 0) {
		for (i = 0; i < strlen(str); i++) {
			if (isalnum(str[i]) == 0 && str[i] != '_') {
				return 1; // false
			}
		}
        return 0; // true
	}
	return 1; // false
}

int read_token (token *theToken, FILE *theFile) {
    char tokenName[MAX_TOKEN_LENGTH];
    int litVal = 0;
    int argNo = 0;

    // check if EOF + get string
    if (fscanf(theFile, "%s", tokenName) == EOF) {
        return 1;
    } // skip over comments 
    else if (tokenName[0] == ';') {
        char c = getc(theFile);
        while (c != '\n') {
            c = getc(theFile);
        }
        return read_token(theToken, theFile);
    } // math
    else if (strcmp(tokenName, "+") == 0) {
        theToken->type = PLUS;
        theToken->funcType = 1;
        return 0;
    } else if (strcmp(tokenName, "-") == 0) {
        theToken->type = MINUS;
        theToken->funcType = 1;
        return 0;
    } else if (strcmp(tokenName, "*") == 0) {
        theToken->type = MUL;
        theToken->funcType = 1;
        return 0;
    } else if (strcmp(tokenName, "/") == 0) {
        theToken->type = DIV;
        theToken->funcType = 1;
        return 0;
    } else if (strcmp(tokenName, "%") == 0) {
        theToken->type = MOD;
        theToken->funcType = 1;
        return 0;
    } // logic
    else if (strcmp(tokenName, "and") == 0) {
        theToken->type = AND;
        theToken->funcType = 1;
        return 0;
    } else if (strcmp(tokenName, "or") == 0) {
        theToken->type = OR;
        theToken->funcType = 1;
        return 0;
    } else if (strcmp(tokenName, "not") == 0) {
        theToken->type = NOT;
        theToken->funcType = 1;
        return 0;
    } // comparisons
    else if (strcmp(tokenName, "lt") == 0) {
        theToken->type = LT;
        theToken->funcType = 2;
        return 0;
    } else if (strcmp(tokenName, "le") == 0) {
        theToken->type = LE;
        theToken->funcType = 2;
        return 0;
    } else if (strcmp(tokenName, "eq") == 0) {
        theToken->type = EQ;
        theToken->funcType = 2;
        return 0;
    } else if (strcmp(tokenName, "ge") == 0) {
        theToken->type = GE;
        theToken->funcType = 2;
        return 0;
    } else if (strcmp(tokenName, "gt") == 0) {
        theToken->type = GT;
        theToken->funcType = 2;
        return 0;
    } // if else
    else if (strcmp(tokenName, "if") == 0) {
        theToken->type = IF;
        theToken->funcType = 0;
        return 0;
    } else if (strcmp(tokenName, "else") == 0) {
        theToken->type = ELSE;
        theToken->funcType = 0;
        return 0;
    } else if (strcmp(tokenName, "endif") == 0) {
        theToken->type = ENDIF;
        theToken->funcType = 0;
        return 0;
    } // stack
    else if (strcmp(tokenName, "drop") == 0) {
        theToken->type = DROP;
        theToken->funcType = 0;
        return 0;
    } else if (strcmp(tokenName, "dup") == 0) {
        theToken->type = DUP;
        theToken->funcType = 0;
        return 0;
    } else if (strcmp(tokenName, "swap") == 0) {
        theToken->type = SWAP;
        theToken->funcType = 0;
        return 0;
    } else if (strcmp(tokenName, "rot") == 0) {
        theToken->type = ROT;
        theToken->funcType = 0;
        return 0;
    } else if (sscanf(tokenName,"arg%d", &argNo) == 1) {
        if (argNo > 0 && argNo < 21) { // range 1-20
	        theToken->type = ARG;
	        theToken->funcType = 0;
            theToken->arg_no = argNo;
            return 0;
	    } else {
	    	theToken->type = BROKEN_TOKEN;
            theToken->funcType = -1;
        	return 1;
	    }
    } // functions
    else if (strcmp(tokenName, "defun") == 0) {
        theToken->type = DEFUN;
        theToken->funcType = 0;
        return 0;
    } else if (strcmp(tokenName, "return") == 0) {
        theToken->type = RETURN;
        theToken->funcType = 0;
        return 0;
    } else if (isValidDefun(tokenName) == 0) { 
        theToken->type = IDENT;
        theToken->funcType = 0;
        strcpy(theToken->str, tokenName);
        return 0;
    } // numbers
    else if (sscanf(tokenName,"0x%X", &litVal) == 1) {
        theToken->type = LITERAL;
        theToken->funcType = 0;
        theToken->literal_value = litVal;
        return 0;
    } else if (sscanf(tokenName,"%d", &litVal) == 1) {
        theToken->type = LITERAL;
        theToken->funcType = 0;
        theToken->literal_value = litVal;
        return 0;
    }// broken token
    else {
        theToken->type = BROKEN_TOKEN;
        theToken->funcType = -1;
        return 1;
    } 
    return 1; 
}