		.CODE
		.FALIGN
main
		ADD R6, R6, #-3
		STR R7, R6, #1
		STR R5, R6, #0
		ADD R5, R6, #0

		CONST R0, #0 				; LITERAL
		HICONST R0, #3
		ADD R6, R6, #-1
		STR R0, R6, #0

		CONST R0, #0 				; LITERAL
		HICONST R0, #127
		ADD R6, R6, #-1
		STR R0, R6, #0

		LDR R0, R6, #0 			; MATH/LOGIC
		LDR R1, R6, #1
		SUB R0, R0, R1 			; MINUS
		ADD R6, R6, #1
		STR R0, R6, #0

		CONST R0, #252 				; LITERAL
		HICONST R0, #255
		ADD R6, R6, #-1
		STR R0, R6, #0

		CONST R0, #251 				; LITERAL
		HICONST R0, #255
		ADD R6, R6, #-1
		STR R0, R6, #0

		LDR R0, R6, #0 			; MATH/LOGIC
		LDR R1, R6, #1
		MUL R0, R0, R1 			; MUL
		ADD R6, R6, #1
		STR R0, R6, #0

		CONST R0, #99 				; LITERAL
		HICONST R0, #0
		ADD R6, R6, #-1
		STR R0, R6, #0

		CONST R0, #1 				; LITERAL
		HICONST R0, #0
		ADD R6, R6, #-1
		STR R0, R6, #0

		LDR R0, R6, #0 			; MATH/LOGIC
		LDR R1, R6, #1
		ADD R0, R0, R1 			; PLUS
		ADD R6, R6, #1
		STR R0, R6, #0

		CONST R0, #10 				; LITERAL
		HICONST R0, #0
		ADD R6, R6, #-1
		STR R0, R6, #0

		CONST R0, #232 				; LITERAL
		HICONST R0, #3
		ADD R6, R6, #-1
		STR R0, R6, #0

		LDR R0, R6, #0 			; MATH/LOGIC
		LDR R1, R6, #1
		DIV R0, R0, R1 			; DIV
		ADD R6, R6, #1
		STR R0, R6, #0

		CONST R0, #14 				; LITERAL
		HICONST R0, #0
		ADD R6, R6, #-1
		STR R0, R6, #0

		JSR lc4_draw_rect
		ADD R6, R6, #-1

		LDR R7, R6, #0 			; RETURN
		STR R7, R5, #2
		ADD R6, R5, #0
		LDR R5, R6, #0
		LDR R7, R6, #1
		ADD R6, R6, #3
		RET

