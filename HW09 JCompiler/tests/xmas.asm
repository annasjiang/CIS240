		.CODE
		.FALIGN
main
		ADD R6, R6, #-3
		STR R7, R6, #1
		STR R5, R6, #0
		ADD R5, R6, #0

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

		CONST R0, #0 				; LITERAL
		HICONST R0, #51
		ADD R6, R6, #-1
		STR R0, R6, #0

		CONST R0, #20 				; LITERAL
		HICONST R0, #0
		ADD R6, R6, #-1
		STR R0, R6, #0

		CONST R0, #80 				; LITERAL
		HICONST R0, #0
		ADD R6, R6, #-1
		STR R0, R6, #0

		CONST R0, #80 				; LITERAL
		HICONST R0, #0
		ADD R6, R6, #-1
		STR R0, R6, #0

		CONST R0, #24 				; LITERAL
		HICONST R0, #0
		ADD R6, R6, #-1
		STR R0, R6, #0

		JSR lc4_draw_rect
		ADD R6, R6, #-1

		CONST R0, #0 				; LITERAL
		HICONST R0, #124
		ADD R6, R6, #-1
		STR R0, R6, #0

		CONST R0, #20 				; LITERAL
		HICONST R0, #0
		ADD R6, R6, #-1
		STR R0, R6, #0

		CONST R0, #60 				; LITERAL
		HICONST R0, #0
		ADD R6, R6, #-1
		STR R0, R6, #0

		CONST R0, #60 				; LITERAL
		HICONST R0, #0
		ADD R6, R6, #-1
		STR R0, R6, #0

		CONST R0, #34 				; LITERAL
		HICONST R0, #0
		ADD R6, R6, #-1
		STR R0, R6, #0

		JSR lc4_draw_rect
		ADD R6, R6, #-1

		CONST R0, #0 				; LITERAL
		HICONST R0, #51
		ADD R6, R6, #-1
		STR R0, R6, #0

		CONST R0, #20 				; LITERAL
		HICONST R0, #0
		ADD R6, R6, #-1
		STR R0, R6, #0

		CONST R0, #40 				; LITERAL
		HICONST R0, #0
		ADD R6, R6, #-1
		STR R0, R6, #0

		CONST R0, #40 				; LITERAL
		HICONST R0, #0
		ADD R6, R6, #-1
		STR R0, R6, #0

		CONST R0, #44 				; LITERAL
		HICONST R0, #0
		ADD R6, R6, #-1
		STR R0, R6, #0

		JSR lc4_draw_rect
		ADD R6, R6, #-1

		CONST R0, #240 				; LITERAL
		HICONST R0, #127
		ADD R6, R6, #-1
		STR R0, R6, #0

		CONST R0, #20 				; LITERAL
		HICONST R0, #0
		ADD R6, R6, #-1
		STR R0, R6, #0

		CONST R0, #20 				; LITERAL
		HICONST R0, #0
		ADD R6, R6, #-1
		STR R0, R6, #0

		CONST R0, #20 				; LITERAL
		HICONST R0, #0
		ADD R6, R6, #-1
		STR R0, R6, #0

		CONST R0, #54 				; LITERAL
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

