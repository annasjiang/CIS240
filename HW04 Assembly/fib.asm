;; fibonacci program
;; F0 = 0; F1 = 1
;; R0 n/counter, R1 final number, R2 Fn-2, R3 Fn-1, R4 data address

		.DATA				; store sequence in data
		.ADDR x4000

global_array
		.FILL #0			; F0 = 0
		.FILL #1			; F1 = 1

		.CODE				; start code
		.ADDR 0x0000		

INIT		LEA R4, global_array		; R4 contains the address of the data
		ADD R0, R0, #-1			; adjust counter for 0 index
		JMP TEST

BODY		LDR R2, R4, #0			; load Fn-2 into R2
		LDR R3, R4, #1			; load Fn-1 into R3
		ADD R1, R2, R3			; add Fn-1 + Fn-2 = Fn and store into R1
		STR R1, R4, #2			; store Fn as next term in memory

		ADD R4, R4, #1			; inc address
		ADD R0, R0, #-1			; dec counter

TEST		CMPI R0, #0			; see if loop counter is 0 yet
		BRp BODY

END		NOP