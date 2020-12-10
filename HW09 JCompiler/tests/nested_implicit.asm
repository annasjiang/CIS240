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

		CONST R0, #6 				; LITERAL
		HICONST R0, #0
		ADD R6, R6, #-1
		STR R0, R6, #0

		CONST R0, #10 				; LITERAL
		HICONST R0, #0
		ADD R6, R6, #-1
		STR R0, R6, #0

		CONST R0, #244 				; LITERAL
		HICONST R0, #1
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

		LDR R0, R6, #0 			; COMPARE
		LDR R1, R6, #1
		CMP R0 R1
		BRzp CMP_TRUE_1 		; GE
		BRn CMP_FALSE_1

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

		CONST R0, #0 				; LITERAL
		HICONST R0, #124
		ADD R6, R6, #-1
		STR R0, R6, #0

		CONST R0, #20 				; LITERAL
		HICONST R0, #0
		ADD R6, R6, #-1
		STR R0, R6, #0

		CONST R0, #100 				; LITERAL
		HICONST R0, #0
		ADD R6, R6, #-1
		STR R0, R6, #0

		CONST R0, #100 				; LITERAL
		HICONST R0, #0
		ADD R6, R6, #-1
		STR R0, R6, #0

		CONST R0, #14 				; LITERAL
		HICONST R0, #0
		ADD R6, R6, #-1
		STR R0, R6, #0

		JSR lc4_draw_rect
		ADD R6, R6, #-1

	ELSE_1
		JMP ENDIF_0

ELSE_0
		CONST R0, #0 				; LITERAL
		HICONST R0, #51
		ADD R6, R6, #-1
		STR R0, R6, #0

		CONST R0, #20 				; LITERAL
		HICONST R0, #0
		ADD R6, R6, #-1
		STR R0, R6, #0

		CONST R0, #100 				; LITERAL
		HICONST R0, #0
		ADD R6, R6, #-1
		STR R0, R6, #0

		LDR R0, R6, #0 			; SWAP
		LDR R1, R6, #1
		STR R0, R6, #1
		STR R1, R6, #0

		CONST R0, #100 				; LITERAL
		HICONST R0, #0
		ADD R6, R6, #-1
		STR R0, R6, #0

		CONST R0, #14 				; LITERAL
		HICONST R0, #0
		ADD R6, R6, #-1
		STR R0, R6, #0

		JSR lc4_draw_rect
		ADD R6, R6, #-1

	ENDIF_0
		LDR R7, R6, #0 			; RETURN
		STR R7, R5, #2
		ADD R6, R5, #0
		LDR R5, R6, #0
		LDR R7, R6, #1
		ADD R6, R6, #3
		RET

