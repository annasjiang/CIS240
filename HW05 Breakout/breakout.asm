;;;;;;;;;;;;;;;;;;;;;;;;;;;;clear_screen;;;;;;;;;;;;;;;;;;;;;;;;;;;;
		.CODE
		.FALIGN
clear_screen
	;; prologue
	STR R7, R6, #-2	;; save return address
	STR R5, R6, #-3	;; save base pointer
	ADD R6, R6, #-3
	ADD R5, R6, #0
	;; function body
	CONST R7, #0
	ADD R6, R6, #-1
	STR R7, R6, #0
	CONST R7, #124
	ADD R6, R6, #-1
	STR R7, R6, #0
	CONST R7, #128
	ADD R6, R6, #-1
	STR R7, R6, #0
	CONST R7, #0
	ADD R6, R6, #-1
	STR R7, R6, #0
	ADD R6, R6, #-1
	STR R7, R6, #0
	JSR lc4_draw_rect
	ADD R6, R6, #5	;; free space for arguments
L1_breakout
	;; epilogue
	ADD R6, R5, #0	;; pop locals off stack
	ADD R6, R6, #3	;; free space for return address, base pointer, and return value
	STR R7, R6, #-1	;; store return value
	LDR R5, R6, #-3	;; restore base pointer
	LDR R7, R6, #-2	;; restore return address
	RET

;;;;;;;;;;;;;;;;;;;;;;;;;;;;draw_all_blocks;;;;;;;;;;;;;;;;;;;;;;;;;;;;
		.CODE
		.FALIGN
draw_all_blocks
	;; prologue
	STR R7, R6, #-2	;; save return address
	STR R5, R6, #-3	;; save base pointer
	ADD R6, R6, #-3
	ADD R5, R6, #0
	ADD R6, R6, #-3	;; allocate stack space for local variables
	;; function body
	CONST R7, #0
	STR R7, R5, #-2
L3_breakout
	CONST R7, #0
	STR R7, R5, #-1
L7_breakout
	LDR R7, R5, #-2
	CONST R3, #0
	CMP R7, R3
	BRnp L11_breakout
	CONST R7, #112
	HICONST R7, #7
	STR R7, R5, #-3
	JMP L12_breakout
L11_breakout
	LDR R7, R5, #-2
	CONST R3, #1
	CMP R7, R3
	BRnp L13_breakout
	CONST R7, #0
	HICONST R7, #124
	STR R7, R5, #-3
	JMP L14_breakout
L13_breakout
	LDR R7, R5, #-2
	CONST R3, #2
	CMP R7, R3
	BRnp L15_breakout
	CONST R7, #0
	HICONST R7, #51
	STR R7, R5, #-3
	JMP L16_breakout
L15_breakout
	LDR R7, R5, #-2
	CONST R3, #3
	CMP R7, R3
	BRnp L17_breakout
	CONST R7, #51
	STR R7, R5, #-3
	JMP L18_breakout
L17_breakout
	CONST R7, #0
	HICONST R7, #246
	STR R7, R5, #-3
L18_breakout
L16_breakout
L14_breakout
L12_breakout
	LDR R7, R5, #-3
	ADD R6, R6, #-1
	STR R7, R6, #0
	CONST R7, #8
	ADD R6, R6, #-1
	STR R7, R6, #0
	CONST R7, #14
	ADD R6, R6, #-1
	STR R7, R6, #0
	CONST R7, #10
	LDR R3, R5, #-2
	MUL R7, R7, R3
	ADD R7, R7, #1
	ADD R6, R6, #-1
	STR R7, R6, #0
	LDR R7, R5, #-1
	SLL R7, R7, #4
	ADD R7, R7, #1
	ADD R6, R6, #-1
	STR R7, R6, #0
	JSR lc4_draw_rect
	ADD R6, R6, #5	;; free space for arguments
L8_breakout
	LDR R7, R5, #-1
	ADD R7, R7, #1
	STR R7, R5, #-1
	LDR R7, R5, #-1
	CONST R3, #8
	CMP R7, R3
	BRn L7_breakout
L4_breakout
	LDR R7, R5, #-2
	ADD R7, R7, #1
	STR R7, R5, #-2
	LDR R7, R5, #-2
	CONST R3, #5
	CMP R7, R3
	BRn L3_breakout
L2_breakout
	;; epilogue
	ADD R6, R5, #0	;; pop locals off stack
	ADD R6, R6, #3	;; free space for return address, base pointer, and return value
	STR R7, R6, #-1	;; store return value
	LDR R5, R6, #-3	;; restore base pointer
	LDR R7, R6, #-2	;; restore return address
	RET

;;;;;;;;;;;;;;;;;;;;;;;;;;;;clear_block;;;;;;;;;;;;;;;;;;;;;;;;;;;;
		.CODE
		.FALIGN
clear_block
	;; prologue
	STR R7, R6, #-2	;; save return address
	STR R5, R6, #-3	;; save base pointer
	ADD R6, R6, #-3
	ADD R5, R6, #0
	;; function body
	CONST R7, #0
	ADD R6, R6, #-1
	STR R7, R6, #0
	CONST R7, #8
	ADD R6, R6, #-1
	STR R7, R6, #0
	CONST R7, #14
	ADD R6, R6, #-1
	STR R7, R6, #0
	CONST R7, #10
	LDR R3, R5, #3
	MUL R7, R7, R3
	ADD R7, R7, #1
	ADD R6, R6, #-1
	STR R7, R6, #0
	LDR R7, R5, #4
	SLL R7, R7, #4
	ADD R7, R7, #1
	ADD R6, R6, #-1
	STR R7, R6, #0
	JSR lc4_draw_rect
	ADD R6, R6, #5	;; free space for arguments
	LDR R7, R5, #4
	LDR R3, R5, #3
	SLL R3, R3, #3
	LEA R2, block_colors
	ADD R3, R3, R2
	ADD R7, R7, R3
	CONST R3, #0
	STR R3, R7, #0
	LEA R7, blocks_smashed
	LDR R3, R7, #0
	ADD R3, R3, #1
	STR R3, R7, #0
L19_breakout
	;; epilogue
	ADD R6, R5, #0	;; pop locals off stack
	ADD R6, R6, #3	;; free space for return address, base pointer, and return value
	STR R7, R6, #-1	;; store return value
	LDR R5, R6, #-3	;; restore base pointer
	LDR R7, R6, #-2	;; restore return address
	RET

;;;;;;;;;;;;;;;;;;;;;;;;;;;;redraw_ball;;;;;;;;;;;;;;;;;;;;;;;;;;;;
		.CODE
		.FALIGN
redraw_ball
	;; prologue
	STR R7, R6, #-2	;; save return address
	STR R5, R6, #-3	;; save base pointer
	ADD R6, R6, #-3
	ADD R5, R6, #0
	;; function body
	CONST R7, #0
	ADD R6, R6, #-1
	STR R7, R6, #0
	CONST R7, #3
	ADD R6, R6, #-1
	STR R7, R6, #0
	ADD R6, R6, #-1
	STR R7, R6, #0
	LDR R7, R5, #4
	ADD R7, R7, #-1
	ADD R6, R6, #-1
	STR R7, R6, #0
	LDR R7, R5, #3
	ADD R7, R7, #-1
	ADD R6, R6, #-1
	STR R7, R6, #0
	JSR lc4_draw_rect
	ADD R6, R6, #5	;; free space for arguments
	CONST R7, #255
	HICONST R7, #255
	ADD R6, R6, #-1
	STR R7, R6, #0
	CONST R7, #3
	ADD R6, R6, #-1
	STR R7, R6, #0
	ADD R6, R6, #-1
	STR R7, R6, #0
	LDR R7, R5, #6
	ADD R7, R7, #-1
	ADD R6, R6, #-1
	STR R7, R6, #0
	LDR R7, R5, #5
	ADD R7, R7, #-1
	ADD R6, R6, #-1
	STR R7, R6, #0
	JSR lc4_draw_rect
	ADD R6, R6, #5	;; free space for arguments
L20_breakout
	;; epilogue
	ADD R6, R5, #0	;; pop locals off stack
	ADD R6, R6, #3	;; free space for return address, base pointer, and return value
	STR R7, R6, #-1	;; store return value
	LDR R5, R6, #-3	;; restore base pointer
	LDR R7, R6, #-2	;; restore return address
	RET

;;;;;;;;;;;;;;;;;;;;;;;;;;;;redraw_paddle;;;;;;;;;;;;;;;;;;;;;;;;;;;;
		.CODE
		.FALIGN
redraw_paddle
	;; prologue
	STR R7, R6, #-2	;; save return address
	STR R5, R6, #-3	;; save base pointer
	ADD R6, R6, #-3
	ADD R5, R6, #0
	;; function body
	CONST R7, #0
	ADD R6, R6, #-1
	STR R7, R6, #0
	CONST R7, #3
	ADD R6, R6, #-1
	STR R7, R6, #0
	CONST R7, #11
	ADD R6, R6, #-1
	STR R7, R6, #0
	CONST R7, #119
	ADD R6, R6, #-1
	STR R7, R6, #0
	LDR R7, R5, #3
	ADD R7, R7, #-5
	ADD R6, R6, #-1
	STR R7, R6, #0
	JSR lc4_draw_rect
	ADD R6, R6, #5	;; free space for arguments
	CONST R7, #255
	HICONST R7, #255
	ADD R6, R6, #-1
	STR R7, R6, #0
	CONST R7, #3
	ADD R6, R6, #-1
	STR R7, R6, #0
	CONST R7, #11
	ADD R6, R6, #-1
	STR R7, R6, #0
	CONST R7, #119
	ADD R6, R6, #-1
	STR R7, R6, #0
	LDR R7, R5, #4
	ADD R7, R7, #-5
	ADD R6, R6, #-1
	STR R7, R6, #0
	JSR lc4_draw_rect
	ADD R6, R6, #5	;; free space for arguments
L21_breakout
	;; epilogue
	ADD R6, R5, #0	;; pop locals off stack
	ADD R6, R6, #3	;; free space for return address, base pointer, and return value
	STR R7, R6, #-1	;; store return value
	LDR R5, R6, #-3	;; restore base pointer
	LDR R7, R6, #-2	;; restore return address
	RET

;;;;;;;;;;;;;;;;;;;;;;;;;;;;reset_ball;;;;;;;;;;;;;;;;;;;;;;;;;;;;
		.CODE
		.FALIGN
reset_ball
	;; prologue
	STR R7, R6, #-2	;; save return address
	STR R5, R6, #-3	;; save base pointer
	ADD R6, R6, #-3
	ADD R5, R6, #0
	;; function body
	LEA R7, ball_x
	CONST R3, #64
	STR R3, R7, #0
	LEA R3, ball_y
	CONST R2, #60
	STR R2, R3, #0
	CONST R3, #0
	LEA R2, ball_vel_x
	STR R3, R2, #0
	LEA R2, ball_vel_y
	STR R3, R2, #0
	LEA R3, ball_x_scaled
	LDR R7, R7, #0
	SLL R7, R7, #3
	STR R7, R3, #0
L22_breakout
	;; epilogue
	ADD R6, R5, #0	;; pop locals off stack
	ADD R6, R6, #3	;; free space for return address, base pointer, and return value
	STR R7, R6, #-1	;; store return value
	LDR R5, R6, #-3	;; restore base pointer
	LDR R7, R6, #-2	;; restore return address
	RET

;;;;;;;;;;;;;;;;;;;;;;;;;;;;reset_game;;;;;;;;;;;;;;;;;;;;;;;;;;;;
		.CODE
		.FALIGN
reset_game
	;; prologue
	STR R7, R6, #-2	;; save return address
	STR R5, R6, #-3	;; save base pointer
	ADD R6, R6, #-3
	ADD R5, R6, #0
	ADD R6, R6, #-1	;; allocate stack space for local variables
	;; function body
	LEA R7, lives_left
	CONST R3, #3
	STR R3, R7, #0
	CONST R7, #0
	LEA R3, blocks_smashed
	STR R7, R3, #0
	LEA R3, paddle_x
	CONST R2, #64
	STR R2, R3, #0
	LEA R3, paddle_vel_x
	STR R7, R3, #0
	JSR reset_ball
	ADD R6, R6, #0	;; free space for arguments
	CONST R7, #0
	STR R7, R5, #-1
L24_breakout
	LDR R7, R5, #-1
	LEA R3, block_colors
	ADD R7, R7, R3
	CONST R3, #112
	HICONST R3, #7
	STR R3, R7, #0
L25_breakout
	LDR R7, R5, #-1
	ADD R7, R7, #1
	STR R7, R5, #-1
	LDR R7, R5, #-1
	CONST R3, #8
	CMP R7, R3
	BRn L24_breakout
	CONST R7, #0
	STR R7, R5, #-1
L28_breakout
	LDR R7, R5, #-1
	LEA R3, block_colors
	ADD R3, R3, #8
	ADD R7, R7, R3
	CONST R3, #0
	HICONST R3, #124
	STR R3, R7, #0
L29_breakout
	LDR R7, R5, #-1
	ADD R7, R7, #1
	STR R7, R5, #-1
	LDR R7, R5, #-1
	CONST R3, #8
	CMP R7, R3
	BRn L28_breakout
	CONST R7, #0
	STR R7, R5, #-1
L32_breakout
	LDR R7, R5, #-1
	LEA R3, block_colors
	CONST R2, #16
	ADD R3, R3, R2
	ADD R7, R7, R3
	CONST R3, #0
	HICONST R3, #51
	STR R3, R7, #0
L33_breakout
	LDR R7, R5, #-1
	ADD R7, R7, #1
	STR R7, R5, #-1
	LDR R7, R5, #-1
	CONST R3, #8
	CMP R7, R3
	BRn L32_breakout
	CONST R7, #0
	STR R7, R5, #-1
L36_breakout
	LDR R7, R5, #-1
	LEA R3, block_colors
	CONST R2, #24
	ADD R3, R3, R2
	ADD R7, R7, R3
	CONST R3, #51
	STR R3, R7, #0
L37_breakout
	LDR R7, R5, #-1
	ADD R7, R7, #1
	STR R7, R5, #-1
	LDR R7, R5, #-1
	CONST R3, #8
	CMP R7, R3
	BRn L36_breakout
	CONST R7, #0
	STR R7, R5, #-1
L40_breakout
	LDR R7, R5, #-1
	LEA R3, block_colors
	CONST R2, #32
	ADD R3, R3, R2
	ADD R7, R7, R3
	CONST R3, #0
	HICONST R3, #246
	STR R3, R7, #0
L41_breakout
	LDR R7, R5, #-1
	ADD R7, R7, #1
	STR R7, R5, #-1
	LDR R7, R5, #-1
	CONST R3, #8
	CMP R7, R3
	BRn L40_breakout
	JSR clear_screen
	ADD R6, R6, #0	;; free space for arguments
	JSR draw_all_blocks
	ADD R6, R6, #0	;; free space for arguments
	LEA R7, ball_y
	LDR R7, R7, #0
	ADD R6, R6, #-1
	STR R7, R6, #0
	LEA R3, ball_x
	LDR R3, R3, #0
	ADD R6, R6, #-1
	STR R3, R6, #0
	ADD R6, R6, #-1
	STR R7, R6, #0
	ADD R6, R6, #-1
	STR R3, R6, #0
	JSR redraw_ball
	ADD R6, R6, #4	;; free space for arguments
	LEA R7, paddle_x
	LDR R7, R7, #0
	ADD R6, R6, #-1
	STR R7, R6, #0
	ADD R6, R6, #-1
	STR R7, R6, #0
	JSR redraw_paddle
	ADD R6, R6, #2	;; free space for arguments
L23_breakout
	;; epilogue
	ADD R6, R5, #0	;; pop locals off stack
	ADD R6, R6, #3	;; free space for return address, base pointer, and return value
	STR R7, R6, #-1	;; store return value
	LDR R5, R6, #-3	;; restore base pointer
	LDR R7, R6, #-2	;; restore return address
	RET

;;;;;;;;;;;;;;;;;;;;;;;;;;;;serve_ball;;;;;;;;;;;;;;;;;;;;;;;;;;;;
		.CODE
		.FALIGN
serve_ball
	;; prologue
	STR R7, R6, #-2	;; save return address
	STR R5, R6, #-3	;; save base pointer
	ADD R6, R6, #-3
	ADD R5, R6, #0
	;; function body
	LEA R7, ball_vel_y
	LDR R7, R7, #0
	CONST R3, #0
	CMP R7, R3
	BRnp L45_breakout
	LEA R7, ball_x
	CONST R3, #64
	STR R3, R7, #0
	LEA R3, ball_y
	CONST R2, #60
	STR R2, R3, #0
	LEA R3, ball_vel_y
	CONST R2, #1
	STR R2, R3, #0
	LEA R3, ball_vel_x
	CONST R2, #8
	STR R2, R3, #0
	LEA R3, ball_x_scaled
	LDR R7, R7, #0
	SLL R7, R7, #3
	STR R7, R3, #0
L45_breakout
L44_breakout
	;; epilogue
	ADD R6, R5, #0	;; pop locals off stack
	ADD R6, R6, #3	;; free space for return address, base pointer, and return value
	STR R7, R6, #-1	;; store return value
	LDR R5, R6, #-3	;; restore base pointer
	LDR R7, R6, #-2	;; restore return address
	RET

;;;;;;;;;;;;;;;;;;;;;;;;;;;;update_paddle_state;;;;;;;;;;;;;;;;;;;;;;;;;;;;
		.CODE
		.FALIGN
update_paddle_state
	;; prologue
	STR R7, R6, #-2	;; save return address
	STR R5, R6, #-3	;; save base pointer
	ADD R6, R6, #-3
	ADD R5, R6, #0
	ADD R6, R6, #-1	;; allocate stack space for local variables
	;; function body
	LEA R7, paddle_x
	LDR R7, R7, #0
	STR R7, R5, #-1
	LDR R7, R5, #3
	CONST R3, #106
	CMP R7, R3
	BRnp L48_breakout
	LEA R7, paddle_vel_x
	LDR R3, R7, #0
	ADD R3, R3, #-1
	STR R3, R7, #0
	LDR R7, R7, #0
	CONST R3, #0
	CMP R7, R3
	BRn L50_breakout
	LEA R7, paddle_vel_x
	CONST R3, #-1
	STR R3, R7, #0
L50_breakout
	LEA R7, paddle_vel_x
	LDR R7, R7, #0
	CONST R3, #-4
	CMP R7, R3
	BRzp L52_breakout
	LEA R7, paddle_vel_x
	CONST R3, #-4
	STR R3, R7, #0
L52_breakout
L48_breakout
	LDR R7, R5, #3
	CONST R3, #107
	CMP R7, R3
	BRnp L54_breakout
	LEA R7, paddle_vel_x
	CONST R3, #0
	STR R3, R7, #0
L54_breakout
	LDR R7, R5, #3
	CONST R3, #108
	CMP R7, R3
	BRnp L56_breakout
	LEA R7, paddle_vel_x
	LDR R3, R7, #0
	ADD R3, R3, #1
	STR R3, R7, #0
	LDR R7, R7, #0
	CONST R3, #0
	CMP R7, R3
	BRp L58_breakout
	LEA R7, paddle_vel_x
	CONST R3, #1
	STR R3, R7, #0
L58_breakout
	LEA R7, paddle_vel_x
	LDR R7, R7, #0
	CONST R3, #4
	CMP R7, R3
	BRnz L60_breakout
	LEA R7, paddle_vel_x
	CONST R3, #4
	STR R3, R7, #0
L60_breakout
L56_breakout
	LEA R7, paddle_x
	LDR R3, R7, #0
	LEA R2, paddle_vel_x
	LDR R2, R2, #0
	ADD R3, R3, R2
	STR R3, R7, #0
	LDR R7, R7, #0
	CONST R3, #0
	CMP R7, R3
	BRzp L62_breakout
	LEA R7, paddle_x
	CONST R3, #0
	STR R3, R7, #0
L62_breakout
	LEA R7, paddle_x
	LDR R7, R7, #0
	CONST R3, #127
	CMP R7, R3
	BRnz L64_breakout
	LEA R7, paddle_x
	CONST R3, #127
	STR R3, R7, #0
L64_breakout
	LDR R7, R5, #-1
	LEA R3, paddle_x
	LDR R3, R3, #0
	CMP R7, R3
	BRnp L68_breakout
	LEA R7, ball_y
	LDR R7, R7, #0
	CONST R3, #119
	CMP R7, R3
	BRn L66_breakout
L68_breakout
	LEA R7, paddle_x
	LDR R7, R7, #0
	ADD R6, R6, #-1
	STR R7, R6, #0
	LDR R7, R5, #-1
	ADD R6, R6, #-1
	STR R7, R6, #0
	JSR redraw_paddle
	ADD R6, R6, #2	;; free space for arguments
L66_breakout
L47_breakout
	;; epilogue
	ADD R6, R5, #0	;; pop locals off stack
	ADD R6, R6, #3	;; free space for return address, base pointer, and return value
	STR R7, R6, #-1	;; store return value
	LDR R5, R6, #-3	;; restore base pointer
	LDR R7, R6, #-2	;; restore return address
	RET

;;;;;;;;;;;;;;;;;;;;;;;;;;;;update_ball_position;;;;;;;;;;;;;;;;;;;;;;;;;;;;
		.CODE
		.FALIGN
update_ball_position
	;; prologue
	STR R7, R6, #-2	;; save return address
	STR R5, R6, #-3	;; save base pointer
	ADD R6, R6, #-3
	ADD R5, R6, #0
	ADD R6, R6, #-2	;; allocate stack space for local variables
	;; function body
	LEA R7, ball_x
	LDR R7, R7, #0
	STR R7, R5, #-1
	LEA R7, ball_y
	LDR R7, R7, #0
	STR R7, R5, #-2
	LEA R7, ball_y
	LDR R3, R7, #0
	LEA R2, ball_vel_y
	LDR R2, R2, #0
	ADD R3, R3, R2
	STR R3, R7, #0
	LEA R3, ball_x_scaled
	LDR R2, R3, #0
	LEA R1, ball_vel_x
	LDR R1, R1, #0
	ADD R2, R2, R1
	STR R2, R3, #0
	LEA R2, ball_x
	LDR R3, R3, #0
	CONST R1, #8
	DIV R3, R3, R1
	STR R3, R2, #0
	LDR R7, R7, #0
	ADD R6, R6, #-1
	STR R7, R6, #0
	LDR R7, R2, #0
	ADD R6, R6, #-1
	STR R7, R6, #0
	LDR R7, R5, #-2
	ADD R6, R6, #-1
	STR R7, R6, #0
	LDR R7, R5, #-1
	ADD R6, R6, #-1
	STR R7, R6, #0
	JSR redraw_ball
	ADD R6, R6, #4	;; free space for arguments
L69_breakout
	;; epilogue
	ADD R6, R5, #0	;; pop locals off stack
	ADD R6, R6, #3	;; free space for return address, base pointer, and return value
	STR R7, R6, #-1	;; store return value
	LDR R5, R6, #-3	;; restore base pointer
	LDR R7, R6, #-2	;; restore return address
	RET

;;;;;;;;;;;;;;;;;;;;;;;;;;;;print_score;;;;;;;;;;;;;;;;;;;;;;;;;;;;
		.CODE
		.FALIGN
print_score
	;; prologue
	STR R7, R6, #-2	;; save return address
	STR R5, R6, #-3	;; save base pointer
	ADD R6, R6, #-3
	ADD R5, R6, #0
	ADD R6, R6, #-6	;; allocate stack space for local variables
	;; function body
	LDR R7, R5, #3
	CONST R3, #0
	CMP R7, R3
	BRnp L71_breakout
	LEA R7, L73_breakout
	ADD R6, R6, #-1
	STR R7, R6, #0
	JSR lc4_puts
	ADD R6, R6, #1	;; free space for arguments
	JMP L72_breakout
L71_breakout
	ADD R7, R5, #-6
	ADD R7, R7, #4
	STR R7, R5, #-1
	LDR R7, R5, #-1
	CONST R3, #0
	STR R3, R7, #0
	JMP L75_breakout
L74_breakout
	LDR R7, R5, #-1
	ADD R7, R7, #-1
	STR R7, R5, #-1
	LDR R7, R5, #-1
	LDR R3, R5, #3
	CONST R2, #10
	MOD R3, R3, R2
	CONST R2, #48
	ADD R3, R3, R2
	STR R3, R7, #0
	LDR R7, R5, #3
	CONST R3, #10
	DIV R7, R7, R3
	STR R7, R5, #3
L75_breakout
	LDR R7, R5, #3
	CONST R3, #0
	CMP R7, R3
	BRp L74_breakout
	LDR R7, R5, #-1
	ADD R6, R6, #-1
	STR R7, R6, #0
	JSR lc4_puts
	ADD R6, R6, #1	;; free space for arguments
L72_breakout
L70_breakout
	;; epilogue
	ADD R6, R5, #0	;; pop locals off stack
	ADD R6, R6, #3	;; free space for return address, base pointer, and return value
	STR R7, R6, #-1	;; store return value
	LDR R5, R6, #-3	;; restore base pointer
	LDR R7, R6, #-2	;; restore return address
	RET

;;;;;;;;;;;;;;;;;;;;;;;;;;;;handle_collision_with_walls;;;;;;;;;;;;;;;;;;;;;;;;;;;;
		.CODE
		.FALIGN
handle_collision_with_walls
	;; prologue
	STR R7, R6, #-2	;; save return address
	STR R5, R6, #-3	;; save base pointer
	ADD R6, R6, #-3
	ADD R5, R6, #0
	ADD R6, R6, #-1	;; allocate stack space for local variables
	;; function body
	LEA R7, ball_x
	LDR R7, R7, #0
	STR R7, R5, #-1
	CONST R3, #0
	CMP R7, R3
	BRnz L80_breakout
	CONST R7, #127
	LDR R3, R5, #-1
	CMP R3, R7
	BRn L78_breakout
L80_breakout
	LEA R7, ball_vel_x
	LDR R3, R7, #0
	NOT R3,R3
	ADD R3,R3,#1
	STR R3, R7, #0
L78_breakout
	LEA R7, ball_y
	LDR R7, R7, #0
	CONST R3, #0
	CMP R7, R3
	BRp L81_breakout
	LEA R7, ball_vel_y
	LDR R3, R7, #0
	NOT R3,R3
	ADD R3,R3,#1
	STR R3, R7, #0
L81_breakout
	LEA R7, ball_y
	LDR R7, R7, #0
	CONST R3, #123
	CMP R7, R3
	BRn L83_breakout
	LEA R7, lives_left
	LDR R3, R7, #0
	ADD R3, R3, #-1
	STR R3, R7, #0
	LDR R7, R7, #0
	CONST R3, #0
	CMP R7, R3
	BRnp L85_breakout
	LEA R7, L87_breakout
	ADD R6, R6, #-1
	STR R7, R6, #0
	JSR lc4_puts
	ADD R6, R6, #1	;; free space for arguments
	LEA R7, L88_breakout
	ADD R6, R6, #-1
	STR R7, R6, #0
	JSR lc4_puts
	ADD R6, R6, #1	;; free space for arguments
	LEA R7, blocks_smashed
	LDR R7, R7, #0
	ADD R6, R6, #-1
	STR R7, R6, #0
	JSR print_score
	ADD R6, R6, #1	;; free space for arguments
	LEA R7, L89_breakout
	ADD R6, R6, #-1
	STR R7, R6, #0
	JSR lc4_puts
	ADD R6, R6, #1	;; free space for arguments
	JMP L86_breakout
L85_breakout
	LEA R7, lives_left
	LDR R7, R7, #0
	CONST R3, #0
	CMP R7, R3
	BRn L90_breakout
	LEA R7, L92_breakout
	ADD R6, R6, #-1
	STR R7, R6, #0
	JSR lc4_puts
	ADD R6, R6, #1	;; free space for arguments
	LEA R7, blocks_smashed
	LDR R7, R7, #0
	ADD R6, R6, #-1
	STR R7, R6, #0
	JSR print_score
	ADD R6, R6, #1	;; free space for arguments
	LEA R7, L93_breakout
	ADD R6, R6, #-1
	STR R7, R6, #0
	JSR lc4_puts
	ADD R6, R6, #1	;; free space for arguments
	CONST R7, #0
	ADD R6, R6, #-1
	STR R7, R6, #0
	CONST R7, #3
	ADD R6, R6, #-1
	STR R7, R6, #0
	ADD R6, R6, #-1
	STR R7, R6, #0
	LEA R7, ball_y
	LDR R7, R7, #0
	ADD R7, R7, #-1
	ADD R6, R6, #-1
	STR R7, R6, #0
	LEA R7, ball_x
	LDR R7, R7, #0
	ADD R7, R7, #-1
	ADD R6, R6, #-1
	STR R7, R6, #0
	JSR lc4_draw_rect
	ADD R6, R6, #5	;; free space for arguments
	JSR reset_ball
	ADD R6, R6, #0	;; free space for arguments
L90_breakout
L86_breakout
L83_breakout
L77_breakout
	;; epilogue
	ADD R6, R5, #0	;; pop locals off stack
	ADD R6, R6, #3	;; free space for return address, base pointer, and return value
	STR R7, R6, #-1	;; store return value
	LDR R5, R6, #-3	;; restore base pointer
	LDR R7, R6, #-2	;; restore return address
	RET

;;;;;;;;;;;;;;;;;;;;;;;;;;;;handle_collision_with_paddle;;;;;;;;;;;;;;;;;;;;;;;;;;;;
		.CODE
		.FALIGN
handle_collision_with_paddle
	;; prologue
	STR R7, R6, #-2	;; save return address
	STR R5, R6, #-3	;; save base pointer
	ADD R6, R6, #-3
	ADD R5, R6, #0
	ADD R6, R6, #-1	;; allocate stack space for local variables
	;; function body
	LEA R7, ball_y
	LDR R7, R7, #0
	CONST R3, #120
	CMP R7, R3
	BRnp L95_breakout
	LEA R7, ball_x
	LDR R7, R7, #0
	LEA R3, paddle_x
	LDR R3, R3, #0
	SUB R7, R7, R3
	STR R7, R5, #-1
	LDR R7, R5, #-1
	CONST R3, #0
	CMP R7, R3
	BRzp L97_breakout
	LDR R7, R5, #-1
	NOT R7,R7
	ADD R7,R7,#1
	STR R7, R5, #-1
L97_breakout
	LDR R7, R5, #-1
	SLL R7, R7, #1
	CONST R3, #11
	CMP R7, R3
	BRzp L99_breakout
	LEA R7, ball_vel_y
	CONST R3, #-1
	STR R3, R7, #0
	LEA R7, ball_vel_x
	LDR R3, R7, #0
	LEA R2, paddle_vel_x
	LDR R2, R2, #0
	ADD R3, R3, R2
	STR R3, R7, #0
	LDR R7, R7, #0
	CONST R3, #8
	CMP R7, R3
	BRnz L101_breakout
	LEA R7, ball_vel_x
	CONST R3, #8
	STR R3, R7, #0
L101_breakout
	LEA R7, ball_vel_x
	LDR R7, R7, #0
	CONST R3, #-8
	CMP R7, R3
	BRzp L103_breakout
	LEA R7, ball_vel_x
	CONST R3, #-8
	STR R3, R7, #0
L103_breakout
L99_breakout
L95_breakout
L94_breakout
	;; epilogue
	ADD R6, R5, #0	;; pop locals off stack
	ADD R6, R6, #3	;; free space for return address, base pointer, and return value
	STR R7, R6, #-1	;; store return value
	LDR R5, R6, #-3	;; restore base pointer
	LDR R7, R6, #-2	;; restore return address
	RET

;;;;;;;;;;;;;;;;;;;;;;;;;;;;handle_collision_with_blocks;;;;;;;;;;;;;;;;;;;;;;;;;;;;
		.CODE
		.FALIGN
handle_collision_with_blocks
	;; prologue
	STR R7, R6, #-2	;; save return address
	STR R5, R6, #-3	;; save base pointer
	ADD R6, R6, #-3
	ADD R5, R6, #0
	ADD R6, R6, #-10	;; allocate stack space for local variables
	;; function body
	CONST R7, #0
	STR R7, R5, #-2
L106_breakout
	CONST R7, #0
	STR R7, R5, #-1
L110_breakout
	LDR R7, R5, #-1
	LDR R3, R5, #-2
	SLL R3, R3, #3
	LEA R2, block_colors
	ADD R3, R3, R2
	ADD R7, R7, R3
	LDR R7, R7, #0
	CONST R3, #0
	CMP R7, R3
	BRz L114_breakout
	LDR R7, R5, #-1
	SLL R7, R7, #4
	ADD R7, R7, #1
	STR R7, R5, #-3
	LDR R7, R5, #-1
	SLL R7, R7, #4
	CONST R3, #16
	ADD R7, R7, R3
	ADD R7, R7, #-1
	STR R7, R5, #-4
	CONST R7, #10
	LDR R3, R5, #-2
	MUL R7, R7, R3
	ADD R7, R7, #1
	STR R7, R5, #-5
	CONST R7, #10
	LDR R3, R5, #-2
	MUL R7, R7, R3
	ADD R7, R7, #10
	ADD R7, R7, #-1
	STR R7, R5, #-6
	LEA R7, ball_x
	LDR R7, R7, #0
	STR R7, R5, #-7
	LDR R3, R5, #-3
	CMP R7, R3
	BRz L118_breakout
	LDR R7, R5, #-4
	LDR R3, R5, #-7
	CMP R3, R7
	BRnp L116_breakout
L118_breakout
	LEA R7, ball_y
	LDR R7, R7, #0
	STR R7, R5, #-8
	LDR R3, R5, #-5
	CMP R7, R3
	BRnz L116_breakout
	LDR R7, R5, #-6
	LDR R3, R5, #-8
	CMP R3, R7
	BRzp L116_breakout
	LDR R7, R5, #-1
	ADD R6, R6, #-1
	STR R7, R6, #0
	LDR R7, R5, #-2
	ADD R6, R6, #-1
	STR R7, R6, #0
	JSR clear_block
	ADD R6, R6, #2	;; free space for arguments
	LEA R7, ball_vel_x
	LDR R3, R7, #0
	NOT R3,R3
	ADD R3,R3,#1
	STR R3, R7, #0
	JMP L117_breakout
L116_breakout
	LEA R7, ball_x
	LDR R7, R7, #0
	STR R7, R5, #-9
	LDR R3, R5, #-3
	CMP R7, R3
	BRnz L119_breakout
	LDR R7, R5, #-4
	LDR R3, R5, #-9
	CMP R3, R7
	BRzp L119_breakout
	LEA R7, ball_y
	LDR R7, R7, #0
	STR R7, R5, #-10
	LDR R3, R5, #-5
	CMP R7, R3
	BRz L121_breakout
	LDR R7, R5, #-6
	LDR R3, R5, #-10
	CMP R3, R7
	BRnp L119_breakout
L121_breakout
	LDR R7, R5, #-1
	ADD R6, R6, #-1
	STR R7, R6, #0
	LDR R7, R5, #-2
	ADD R6, R6, #-1
	STR R7, R6, #0
	JSR clear_block
	ADD R6, R6, #2	;; free space for arguments
	LEA R7, ball_vel_y
	LDR R3, R7, #0
	NOT R3,R3
	ADD R3,R3,#1
	STR R3, R7, #0
	JMP L120_breakout
L119_breakout
	LEA R7, ball_x
	LDR R7, R7, #0
	LDR R3, R5, #-3
	CMP R7, R3
	BRnp L125_breakout
	LEA R7, ball_y
	LDR R7, R7, #0
	LDR R3, R5, #-5
	CMP R7, R3
	BRz L128_breakout
L125_breakout
	LEA R7, ball_x
	LDR R7, R7, #0
	LDR R3, R5, #-3
	CMP R7, R3
	BRnp L127_breakout
	LEA R7, ball_y
	LDR R7, R7, #0
	LDR R3, R5, #-6
	CMP R7, R3
	BRz L128_breakout
L127_breakout
	LEA R7, ball_x
	LDR R7, R7, #0
	LDR R3, R5, #-4
	CMP R7, R3
	BRnp L129_breakout
	LEA R7, ball_y
	LDR R7, R7, #0
	LDR R3, R5, #-5
	CMP R7, R3
	BRz L128_breakout
L129_breakout
	LEA R7, ball_x
	LDR R7, R7, #0
	LDR R3, R5, #-4
	CMP R7, R3
	BRnp L122_breakout
	LEA R7, ball_y
	LDR R7, R7, #0
	LDR R3, R5, #-6
	CMP R7, R3
	BRnp L122_breakout
L128_breakout
	LDR R7, R5, #-1
	ADD R6, R6, #-1
	STR R7, R6, #0
	LDR R7, R5, #-2
	ADD R6, R6, #-1
	STR R7, R6, #0
	JSR clear_block
	ADD R6, R6, #2	;; free space for arguments
	LEA R7, ball_vel_x
	LDR R3, R7, #0
	NOT R3,R3
	ADD R3,R3,#1
	STR R3, R7, #0
	LEA R7, ball_vel_y
	LDR R3, R7, #0
	NOT R3,R3
	ADD R3,R3,#1
	STR R3, R7, #0
L122_breakout
L120_breakout
L117_breakout
L114_breakout
L111_breakout
	LDR R7, R5, #-1
	ADD R7, R7, #1
	STR R7, R5, #-1
	LDR R7, R5, #-1
	CONST R3, #8
	CMP R7, R3
	BRn L110_breakout
L107_breakout
	LDR R7, R5, #-2
	ADD R7, R7, #1
	STR R7, R5, #-2
	LDR R7, R5, #-2
	CONST R3, #5
	CMP R7, R3
	BRn L106_breakout
L105_breakout
	;; epilogue
	ADD R6, R5, #0	;; pop locals off stack
	ADD R6, R6, #3	;; free space for return address, base pointer, and return value
	STR R7, R6, #-1	;; store return value
	LDR R5, R6, #-3	;; restore base pointer
	LDR R7, R6, #-2	;; restore return address
	RET

;;;;;;;;;;;;;;;;;;;;;;;;;;;;main;;;;;;;;;;;;;;;;;;;;;;;;;;;;
		.CODE
		.FALIGN
main
	;; prologue
	STR R7, R6, #-2	;; save return address
	STR R5, R6, #-3	;; save base pointer
	ADD R6, R6, #-3
	ADD R5, R6, #0
	ADD R6, R6, #-1	;; allocate stack space for local variables
	;; function body
	LEA R7, L131_breakout
	ADD R6, R6, #-1
	STR R7, R6, #0
	JSR lc4_puts
	ADD R6, R6, #1	;; free space for arguments
	LEA R7, L132_breakout
	ADD R6, R6, #-1
	STR R7, R6, #0
	JSR lc4_puts
	ADD R6, R6, #1	;; free space for arguments
	LEA R7, L133_breakout
	ADD R6, R6, #-1
	STR R7, R6, #0
	JSR lc4_puts
	ADD R6, R6, #1	;; free space for arguments
	LEA R7, L134_breakout
	ADD R6, R6, #-1
	STR R7, R6, #0
	JSR lc4_puts
	ADD R6, R6, #1	;; free space for arguments
	LEA R7, L135_breakout
	ADD R6, R6, #-1
	STR R7, R6, #0
	JSR lc4_puts
	ADD R6, R6, #1	;; free space for arguments
	LEA R7, L136_breakout
	ADD R6, R6, #-1
	STR R7, R6, #0
	JSR lc4_puts
	ADD R6, R6, #1	;; free space for arguments
	CONST R7, #50
	ADD R6, R6, #-1
	STR R7, R6, #0
	JSR lc4_set_timer
	ADD R6, R6, #1	;; free space for arguments
	JSR reset_game
	ADD R6, R6, #0	;; free space for arguments
	JMP L138_breakout
L137_breakout
	JSR lc4_check_timer
	LDR R7, R6, #-1	;; grab return value
	ADD R6, R6, #0	;; free space for arguments
	CONST R3, #0
	CMP R7, R3
	BRzp L140_breakout
	JSR lc4_getc
	LDR R7, R6, #-1	;; grab return value
	ADD R6, R6, #0	;; free space for arguments
	STR R7, R5, #-1
	LDR R7, R5, #-1
	CONST R3, #122
	CMP R7, R3
	BRnp L142_breakout
	JSR reset_game
	ADD R6, R6, #0	;; free space for arguments
L142_breakout
	LDR R7, R5, #-1
	CONST R3, #113
	CMP R7, R3
	BRnp L144_breakout
	LEA R7, lives_left
	LDR R7, R7, #0
	CONST R3, #0
	CMP R7, R3
	BRnz L144_breakout
	JSR serve_ball
	ADD R6, R6, #0	;; free space for arguments
L144_breakout
	JSR update_ball_position
	ADD R6, R6, #0	;; free space for arguments
	JSR handle_collision_with_walls
	ADD R6, R6, #0	;; free space for arguments
	JSR handle_collision_with_paddle
	ADD R6, R6, #0	;; free space for arguments
	JSR handle_collision_with_blocks
	ADD R6, R6, #0	;; free space for arguments
	LDR R7, R5, #-1
	ADD R6, R6, #-1
	STR R7, R6, #0
	JSR update_paddle_state
	ADD R6, R6, #1	;; free space for arguments
L140_breakout
L138_breakout
	JMP L137_breakout
	CONST R7, #0
L130_breakout
	;; epilogue
	ADD R6, R5, #0	;; pop locals off stack
	ADD R6, R6, #3	;; free space for return address, base pointer, and return value
	STR R7, R6, #-1	;; store return value
	LDR R5, R6, #-3	;; restore base pointer
	LDR R7, R6, #-2	;; restore return address
	RET

		.DATA
blocks_smashed 		.BLKW 1
		.DATA
lives_left 		.BLKW 1
		.DATA
block_colors 		.BLKW 40
		.DATA
paddle_vel_x 		.BLKW 1
		.DATA
paddle_x 		.BLKW 1
		.DATA
ball_vel_y 		.BLKW 1
		.DATA
ball_vel_x 		.BLKW 1
		.DATA
ball_x_scaled 		.BLKW 1
		.DATA
ball_y 		.BLKW 1
		.DATA
ball_x 		.BLKW 1
		.DATA
L136_breakout 		.STRINGZ "Press z to reset game\n"
		.DATA
L135_breakout 		.STRINGZ "Press q to reset/serve ball\n"
		.DATA
L134_breakout 		.STRINGZ "Press l to move paddle right\n"
		.DATA
L133_breakout 		.STRINGZ "Press k to stop the paddle\n"
		.DATA
L132_breakout 		.STRINGZ "Press j to move paddle left\n"
		.DATA
L131_breakout 		.STRINGZ "!!! Welcome to Breakout !!!\n"
		.DATA
L93_breakout 		.STRINGZ "\n"
		.DATA
L92_breakout 		.STRINGZ "SCORE: "
		.DATA
L89_breakout 		.STRINGZ "\n"
		.DATA
L88_breakout 		.STRINGZ "FINAL SCORE: "
		.DATA
L87_breakout 		.STRINGZ "GAME OVER\n"
		.DATA
L73_breakout 		.STRINGZ "0"
