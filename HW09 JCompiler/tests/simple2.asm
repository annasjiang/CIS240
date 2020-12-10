		.CODE
		.FALIGN
main
		ADD R6, R6, #-3
		STR R7, R6, #1
		STR R5, R6, #0
		ADD R5, R6, #0

		CONST R0, #5 				; LITERAL
		HICONST R0, #0
		ADD R6, R6, #-1
		STR R0, R6, #0

		CONST R0, #3 				; LITERAL
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

		JSR printnum
		ADD R6, R6, #-1

		JSR endl
		ADD R6, R6, #-1

		CONST R0, #88 				; LITERAL
		HICONST R0, #27
		ADD R6, R6, #-1
		STR R0, R6, #0

		CONST R0, #190 				; LITERAL
		HICONST R0, #252
		ADD R6, R6, #-1
		STR R0, R6, #0

		LDR R0, R6, #0 			; COMPARE
		LDR R1, R6, #1
		CMP R0 R1
		BRn CMP_TRUE_1 		; LT
		BRzp CMP_FALSE_1

CMP_TRUE_1
		CONST R2, #1
		BRnzp CMP_END_1

CMP_FALSE_1
		CONST R2, #0
		BRnzp CMP_END_1

CMP_END_1
		ADD R6, R6, #1
		STR R2, R6, #0

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

