		.CODE
		.FALIGN
fact
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

		CONST R0, #1 				; LITERAL
		HICONST R0, #0
		ADD R6, R6, #-1
		STR R0, R6, #0

		LDR R0, R6, #0 			; COMPARE
		LDR R1, R6, #1
		CMP R0 R1
		BRzp CMP_TRUE_0 		; GE
		BRn CMP_FALSE_0

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

		CONST R0, #1 				; LITERAL
		HICONST R0, #0
		ADD R6, R6, #-1
		STR R0, R6, #0

		JMP ENDIF_0

ELSE_0
		LDR R0, R6, #0 			; DUP
		ADD R6, R6, #-1
		STR R0, R6, #0

		CONST R0, #1 				; LITERAL
		HICONST R0, #0
		ADD R6, R6, #-1
		STR R0, R6, #0

		LDR R0, R6, #0 			; SWAP
		LDR R1, R6, #1
		STR R0, R6, #1
		STR R1, R6, #0

		LDR R0, R6, #0 			; MATH/LOGIC
		LDR R1, R6, #1
		SUB R0, R0, R1 			; MINUS
		ADD R6, R6, #1
		STR R0, R6, #0

		JSR fact
		ADD R6, R6, #-1

		LDR R0, R6, #0 			; SWAP
		LDR R1, R6, #1
		STR R0, R6, #1
		STR R1, R6, #0

		ADD R6, R6, #1 			; DROP
		LDR R0, R6, #0 			; MATH/LOGIC
		LDR R1, R6, #1
		MUL R0, R0, R1 			; MUL
		ADD R6, R6, #1
		STR R0, R6, #0

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

		CONST R0, #4 				; LITERAL
		HICONST R0, #0
		ADD R6, R6, #-1
		STR R0, R6, #0

		JSR fact
		ADD R6, R6, #-1

		JSR printnum
		ADD R6, R6, #-1

		JSR endl
		ADD R6, R6, #-1

		CONST R0, #5 				; LITERAL
		HICONST R0, #0
		ADD R6, R6, #-1
		STR R0, R6, #0

		JSR fact
		ADD R6, R6, #-1

		JSR printnum
		ADD R6, R6, #-1

		JSR endl
		ADD R6, R6, #-1

		CONST R0, #6 				; LITERAL
		HICONST R0, #0
		ADD R6, R6, #-1
		STR R0, R6, #0

		JSR fact
		ADD R6, R6, #-1

		JSR printnum
		ADD R6, R6, #-1

		JSR endl
		ADD R6, R6, #-1

		CONST R0, #7 				; LITERAL
		HICONST R0, #0
		ADD R6, R6, #-1
		STR R0, R6, #0

		JSR fact
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

