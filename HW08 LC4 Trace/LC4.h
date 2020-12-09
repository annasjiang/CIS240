/* 
 * LC4.h : header file for LC4.c
 *
 */

// keep track of processor state
typedef struct processor_state_struct {
	short int reg[8];
	unsigned short int PC;
	// breaking up PSR to make it easier on my math eheh
	unsigned short int privilege;
	unsigned short int NZP; 
	int error;
} processor_state;

// initializes processor state
void init(processor_state *komputer);

// helper to do SEXT of signed numbers
signed short int sextI(unsigned short int x, int length);
// helper to convert instructions to binary string
char* to_binary(unsigned short int x);
// helper to find NZP
short int NZP_calc(short int x);

// main lc4 function that takes in an instruction, the mem array, and the processor state
// will use the instruction to update the processor state and return a string to print
char* LC4(unsigned short int instruction, unsigned short int* lc4mem, processor_state *komputer);