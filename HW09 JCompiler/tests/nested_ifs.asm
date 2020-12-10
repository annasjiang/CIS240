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

		CONST R0, #16 				; LITERAL
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

		CONST R0, #8 				; LITERAL
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

		LDR R0, R6, #0 			; DUP
		ADD R6, R6, #-1
		STR R0, R6, #0

		CONST R0, #4 				; LITERAL
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

		CONST R0, #0 				; LITERAL
		HICONST R0, #0
		ADD R6, R6, #-1
		STR R0, R6, #0

		JMP ENDIF_2

ELSE_2
		CONST R0, #1 				; LITERAL
		HICONST R0, #0
		ADD R6, R6, #-1
		STR R0, R6, #0

	ENDIF_2
		JMP ENDIF_1

ELSE_1
		CONST R0, #2 				; LITERAL
		HICONST R0, #0
		ADD R6, R6, #-1
		STR R0, R6, #0

	ENDIF_1
		JMP ENDIF_0

ELSE_0
		LDR R0, R6, #0 			; DUP
		ADD R6, R6, #-1
		STR R0, R6, #0

		CONST R0, #24 				; LITERAL
		HICONST R0, #0
		ADD R6, R6, #-1
		STR R0, R6, #0

		LDR R0, R6, #0 			; COMPARE
		LDR R1, R6, #1
		CMP R0 R1
		BRp CMP_TRUE_3 		; GT
		BRnz CMP_FALSE_3

CMP_TRUE_3
		CONST R2, #1
		BRnzp CMP_END_3

CMP_FALSE_3
		CONST R2, #0
		BRnzp CMP_END_3

CMP_END_3
		ADD R6, R6, #1
		STR R2, R6, #0

		ADD R6, R6, #1 			; IF
		LDR R0, R6, #-1
		BRnz ELSE_3

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
		BRp CMP_TRUE_4 		; GT
		BRnz CMP_FALSE_4

CMP_TRUE_4
		CONST R2, #1
		BRnzp CMP_END_4

CMP_FALSE_4
		CONST R2, #0
		BRnzp CMP_END_4

CMP_END_4
		ADD R6, R6, #1
		STR R2, R6, #0

		ADD R6, R6, #1 			; IF
		LDR R0, R6, #-1
		BRnz ELSE_4

		CONST R0, #3 				; LITERAL
		HICONST R0, #0
		ADD R6, R6, #-1
		STR R0, R6, #0

		JMP ENDIF_4

ELSE_4
		CONST R0, #4 				; LITERAL
		HICONST R0, #0
		ADD R6, R6, #-1
		STR R0, R6, #0

	ENDIF_4
		JMP ENDIF_3

ELSE_3
		LDR R0, R6, #0 			; DUP
		ADD R6, R6, #-1
		STR R0, R6, #0

		CONST R0, #32 				; LITERAL
		HICONST R0, #0
		ADD R6, R6, #-1
		STR R0, R6, #0

		LDR R0, R6, #0 			; COMPARE
		LDR R1, R6, #1
		CMP R0 R1
		BRp CMP_TRUE_5 		; GT
		BRnz CMP_FALSE_5

CMP_TRUE_5
		CONST R2, #1
		BRnzp CMP_END_5

CMP_FALSE_5
		CONST R2, #0
		BRnzp CMP_END_5

CMP_END_5
		ADD R6, R6, #1
		STR R2, R6, #0

		ADD R6, R6, #1 			; IF
		LDR R0, R6, #-1
		BRnz ELSE_5

		CONST R0, #5 				; LITERAL
		HICONST R0, #0
		ADD R6, R6, #-1
		STR R0, R6, #0

		JMP ENDIF_5

ELSE_5
		CONST R0, #246 				; LITERAL
		HICONST R0, #255
		ADD R6, R6, #-1
		STR R0, R6, #0

	ENDIF_5
	ENDIF_3
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

		CONST R0, #5 				; LITERAL
		HICONST R0, #0
		ADD R6, R6, #-1
		STR R0, R6, #0

		JSR testIfs
		ADD R6, R6, #-1

		JSR printnum
		ADD R6, R6, #-1

		JSR endl
		ADD R6, R6, #-1

		CONST R0, #11 				; LITERAL
		HICONST R0, #0
		ADD R6, R6, #-1
		STR R0, R6, #0

		JSR testIfs
		ADD R6, R6, #-1

		JSR printnum
		ADD R6, R6, #-1

		JSR endl
		ADD R6, R6, #-1

		CONST R0, #28 				; LITERAL
		HICONST R0, #0
		ADD R6, R6, #-1
		STR R0, R6, #0

		JSR testIfs
		ADD R6, R6, #-1

		JSR printnum
		ADD R6, R6, #-1

		JSR endl
		ADD R6, R6, #-1

		CONST R0, #35 				; LITERAL
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

