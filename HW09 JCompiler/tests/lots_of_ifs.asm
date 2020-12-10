		.CODE
		.FALIGN
testIfs
		ADD R6, R6, #-3
		STR R7, R6, #1
		STR R5, R6, #0
		ADD R5, R6, #0

		LDR R0, R5, #3 			; ARG
		ADD R6, R6, #-1
		STR R0, R6, #0

		LDR R0, R6, #0 			; DUP
		ADD R6, R6, #-1
		STR R0, R6, #0

		CONST R0, #10 				; LITERAL
		HICONST R0, #0
		ADD R6, R6, #-1
		STR R0, R6, #0

		LDR R0, R6, #0 			; COMPARE
		LDR R1, R6, #1
		CMP R0 R1
		BRp CMP_TRUE_0 		; GT
		BRnz CMP_FALSE_0

CMP_TRUE_0
		CONST R2, #1
		BRnzp CMP_END_0

CMP_FALSE_0
		CONST R2, #0
		BRnzp CMP_END_0

CMP_END_0
		ADD R6, R6, #1
		STR R2, R6, #0

		ADD R6, R6, #1 			; IF
		LDR R0, R6, #-1
		BRnz ELSE_0

		LDR R0, R6, #0 			; DUP
		ADD R6, R6, #-1
		STR R0, R6, #0

		CONST R0, #5 				; LITERAL
		HICONST R0, #0
		ADD R6, R6, #-1
		STR R0, R6, #0

		LDR R0, R6, #0 			; COMPARE
		LDR R1, R6, #1
		CMP R0 R1
		BRp CMP_TRUE_1 		; GT
		BRnz CMP_FALSE_1

CMP_TRUE_1
		CONST R2, #1
		BRnzp CMP_END_1

CMP_FALSE_1
		CONST R2, #0
		BRnzp CMP_END_1

CMP_END_1
		ADD R6, R6, #1
		STR R2, R6, #0

		ADD R6, R6, #1 			; IF
		LDR R0, R6, #-1
		BRnz ELSE_1

		CONST R0, #11 				; LITERAL
		HICONST R0, #0
		ADD R6, R6, #-1
		STR R0, R6, #0

		JMP ENDIF_1

ELSE_1
		CONST R0, #12 				; LITERAL
		HICONST R0, #0
		ADD R6, R6, #-1
		STR R0, R6, #0

	ENDIF_1
		JMP ENDIF_0

ELSE_0
		LDR R0, R6, #0 			; DUP
		ADD R6, R6, #-1
		STR R0, R6, #0

		CONST R0, #20 				; LITERAL
		HICONST R0, #0
		ADD R6, R6, #-1
		STR R0, R6, #0

		LDR R0, R6, #0 			; COMPARE
		LDR R1, R6, #1
		CMP R0 R1
		BRp CMP_TRUE_2 		; GT
		BRnz CMP_FALSE_2

CMP_TRUE_2
		CONST R2, #1
		BRnzp CMP_END_2

CMP_FALSE_2
		CONST R2, #0
		BRnzp CMP_END_2

CMP_END_2
		ADD R6, R6, #1
		STR R2, R6, #0

		ADD R6, R6, #1 			; IF
		LDR R0, R6, #-1
		BRnz ELSE_2

		CONST R0, #13 				; LITERAL
		HICONST R0, #0
		ADD R6, R6, #-1
		STR R0, R6, #0

		JMP ENDIF_2

ELSE_2
		CONST R0, #14 				; LITERAL
		HICONST R0, #0
		ADD R6, R6, #-1
		STR R0, R6, #0

	ENDIF_2
	ENDIF_0
		LDR R7, R6, #0 			; RETURN
		STR R7, R5, #2
		ADD R6, R5, #0
		LDR R5, R6, #0
		LDR R7, R6, #1
		ADD R6, R6, #3
		RET

		.CODE
		.FALIGN
main
		ADD R6, R6, #-3
		STR R7, R6, #1
		STR R5, R6, #0
		ADD R5, R6, #0

		CONST R0, #8 				; LITERAL
		HICONST R0, #0
		ADD R6, R6, #-1
		STR R0, R6, #0

		JSR testIfs
		ADD R6, R6, #-1

		JSR printnum
		ADD R6, R6, #-1

		JSR endl
		ADD R6, R6, #-1

		CONST R0, #4 				; LITERAL
		HICONST R0, #0
		ADD R6, R6, #-1
		STR R0, R6, #0

		JSR testIfs
		ADD R6, R6, #-1

		JSR printnum
		ADD R6, R6, #-1

		JSR endl
		ADD R6, R6, #-1

		CONST R0, #45 				; LITERAL
		HICONST R0, #0
		ADD R6, R6, #-1
		STR R0, R6, #0

		JSR testIfs
		ADD R6, R6, #-1

		JSR printnum
		ADD R6, R6, #-1

		JSR endl
		ADD R6, R6, #-1

		LDR R7, R6, #0 			; RETURN
		STR R7, R5, #2
		ADD R6, R5, #0
		LDR R5, R6, #0
		LDR R7, R6, #1
		ADD R6, R6, #3
		RET

