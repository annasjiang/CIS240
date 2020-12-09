;; hamming distance
;; R0 = A, R1 = B, R2 = hamming distance, R3 = A XOR B

		;; start code
		.CODE	
		.ADDR 0x0000		

INIT 		CONST R2, #0		; initialize R2 as 0
		XOR R3, R0, R1		; XOR A and B
		JMP TEST

BODY 		CMPI R3, #0		; check sign of R3
		BRp SHIFT		; if R3 is positive, MSB = 0 so skip ham	

HAM		ADD R2, R2, #1		; inc hamming distance

SHIFT		SLL R3, R3, #1		; shift to the left by 1 
		
TEST		CMPI R3, #0		; check if R3 is 0
		BRnp BODY		; if not 0 yet, keep checking
		
END		NOP