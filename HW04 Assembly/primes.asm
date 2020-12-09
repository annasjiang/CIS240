;; sieve of eratosthenes / prime function
;; R0 = n, R1 = nth prime, R2 = numPrimes, R3 = x, R4 = data address, R5 = curr prime, R6 = mod

		;; list of primes stored in data
		.DATA
		.ADDR x4000			; start storing here

global_array
		.FILL #2			; initialize primes list to 2
		
		;; start code
		.CODE
		.ADDR 0x0000
		
INIT	
		CONST R1, 2			; set R1 as last prime on list (2)
		CONST R2, 1			; set numPrimes to 1
		CONST R3, 3			; x = 3		
		JMP TEST	
		
ISPRIME						; check if x is prime				
		MOD R6, R3, R5			; check if x divisible by currPrime
		CMPI R6, #0			
		BRz INCX			; if x is divisible (mod = 0), exit (not prime)
		
		CMPU R1, R5			; check if currPrime (R5) was the largest prime on the list (R1)
		BRz ADDPRIME			; confirmed prime, add to list (largest prime - curr prime = 0)

NEXTPRIME					; updates currPrime
		ADD R4, R4, #1			; inc address for next prime
		LDR R5, R4, #0			; store next prime from the data list in R5	
		BRnzp ISPRIME			; go back to isPrime with new currPrime

ADDPRIME 					; adding a prime to the list
		ADD R4, R4, #1			; inc address
		STR R3, R4, #0			; store x in next data address/add to list
		LDR R1, R4, #0			; load x into R1 as new largest prime	
		ADD R2, R2, #1			; inc numPrimes
		
INCX	
		ADD R3, R3, #1			; inc x 

TEST	
		LEA R4, global_array		; reset R4 to the start address of prime list		
		CONST R5, 2			; reset R5 to 2
		CMP R0 R2			; compare n and numPrimes
		BRp ISPRIME			; if n - numPrimes > 0, check if x prime otherwise END		

END		NOP