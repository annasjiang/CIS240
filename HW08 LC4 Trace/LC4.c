/* 
 * LC4.c : routines for decoding instructions
 *
 */

#include "LC4.h"
#include <stdio.h>
#include <stdlib.h>

void init(processor_state *komputer) {
	int i;
	for (i = 0; i < 8; i++) {
		komputer->reg[i] = 0;
	}
	komputer->PC = 0x8200;
	komputer->privilege = 1;
	komputer->NZP = 2; // init at Z/0
	komputer->error = 0; // 1 = error
}

// helper to sign extend
signed short int sextI(unsigned short int y, int length) {
	signed short int sign, final;
	unsigned short int x = y & ((1 << length) - 1); // only keep last chonk
	sign = (x >> (length - 1)) & 0x0001; // make MSB of IMMX LSB to check sign

	if (sign == 0) { // positive
		return x;
	} else { // negative
		int mask = (1 << (length - 1));
		final = (x & ~mask) - (mask);
		return final;
	}
}

// helper to convert instructions to binary char string
char* to_binary(unsigned short int x) {
	char *ptr = malloc(sizeof(char) * 17);
	unsigned int i;
	for (i = 1 << 15; i > 0; i = i / 2) {
		if (x & i) {	
			*ptr = '1';
		} else {	
			*ptr = '0';
		}
		ptr++;
	}
   	*ptr = '\0'; // null termination
   	ptr = ptr - 16; // reset pointer
    return ptr;
}

// helper to find NZP
short int NZP_calc(short int x) {
	if (x == 0) { // 010 (0)
		return 2;
	} else if (((x >> 15) & 0x0001) == 1) { // 100 (-)
		return 4;
	} else { // 001 (+)
		return 1;
	}
}

// translate instruction, update processing state, and return stringg
char* LC4(unsigned short int instruction, unsigned short int* lc4mem, processor_state *komputer) {

	// turn instruction in binary
	char *instruction_bits;
	instruction_bits = to_binary(instruction);

	// full instruction string
	char *instr = malloc(sizeof(char) * 50);

	// first 4 bits
	int opcode;
	opcode = (instruction >> 12) & 0x000F;

	// split into groups of three for most cases
	unsigned int group1, group2, group3, group4;
	group1 = (instruction & 0x0E00) >> 9;
	group2 = (instruction & 0x01C0) >> 6;
	group3 = (instruction & 0x0038) >> 3;
	group4 = (instruction & 0x0007);

	// immediate nums
	unsigned short int immx, uimmx;

	// temp value
	short int value = 0;

	// hagrugajgnraje pattern matching bitches
	if (opcode == 0) { // branch
		immx = sextI(instruction, 9);
		if (group1 == 0) { // NOP
			sprintf(instr, "%04X %s 0 0 0000 0 0 0 0000 0000\n", komputer->PC, instruction_bits);
			komputer->PC++;
		} else if (group1 == 1) { // BRp (001)
			sprintf(instr, "%04X %s 0 0 0000 0 0 0 0000 0000\n", komputer->PC, instruction_bits);
			if (komputer->NZP == 1) {
				komputer->PC = komputer->PC + 1 + immx;
			} else {
				komputer->PC++;
			}
		} else if (group1 == 2) { // BRz (010)
			sprintf(instr, "%04X %s 0 0 0000 0 0 0 0000 0000\n", komputer->PC, instruction_bits);
			if (komputer->NZP == 2) {
				komputer->PC = komputer->PC + 1 + immx;
			} else {
				komputer->PC++;
			}
		} else if (group1 == 3) { // BRzp (010 or 001)
			sprintf(instr, "%04X %s 0 0 0000 0 0 0 0000 0000\n", komputer->PC, instruction_bits);
			if (komputer->NZP == 2 || komputer->NZP == 1) {
				komputer->PC = komputer->PC + 1 + immx;
			} else {
				komputer->PC++;
			}
		} else if (group1 == 4) { // BRn (100)
			sprintf(instr, "%04X %s 0 0 0000 0 0 0 0000 0000\n", komputer->PC, instruction_bits);
			if (komputer->NZP == 4) {
				komputer->PC = komputer->PC + 1 + immx;
			} else {
				komputer->PC++;
			}
		} else if (group1 == 5) { // BRnp (100 or 001)
			sprintf(instr, "%04X %s 0 0 0000 0 0 0 0000 0000\n", komputer->PC, instruction_bits);
			if (komputer->NZP == 4 || komputer->NZP == 1) {
				komputer->PC = komputer->PC + 1 + immx;
			} else {
				komputer->PC++;
			}
		} else if (group1 == 6) { // BRnz (100 or 010)
			sprintf(instr, "%04X %s 0 0 0000 0 0 0 0000 0000\n", komputer->PC, instruction_bits);
			if (komputer->NZP == 4 || komputer->NZP == 2) {
				komputer->PC = komputer->PC + 1 + immx;
			} else {
				komputer->PC++;
			}
		} else if (group1 == 7) { // BRnzp
			sprintf(instr, "%04X %s 0 0 0000 0 0 0 0000 0000\n", komputer->PC, instruction_bits);
			komputer->PC = komputer->PC + 1 + immx;
		} else {
			sprintf(instr, "%s", "INVALID INSTRUCTION");
		}
	} else if (opcode == 1) { // arith
		short int add_immediate;
		add_immediate = (instruction & 0x0020) >> 5;
		if (add_immediate == 1) { // add immediate
			immx = sextI(instruction, 5);
			value = komputer->reg[group2] + immx;
			komputer->reg[group1] = value;
			komputer->NZP = NZP_calc(value);
			sprintf(instr, "%04X %s 1 %01X %04X 1 %01X 0 0000 0000\n", komputer->PC, instruction_bits, group1, (unsigned short) value, komputer->NZP);
			komputer->PC++;
		} else if (group3 == 0) { // add
			value = komputer->reg[group2] + komputer->reg[group4];
			komputer->reg[group1] = value;
			komputer->NZP = NZP_calc(value);		
			sprintf(instr, "%04X %s 1 %01X %04X 1 %01X 0 0000 0000\n", komputer->PC, instruction_bits, group1, (unsigned short) value, komputer->NZP);
			komputer->PC++;
		} else if (group3 == 1) { // mul
			value = komputer->reg[group2] * komputer->reg[group4];
			komputer->reg[group1] = value;
			komputer->NZP = NZP_calc(value);
			sprintf(instr, "%04X %s 1 %01X %04X 1 %01X 0 0000 0000\n", komputer->PC, instruction_bits, group1, (unsigned short) value, komputer->NZP);
			komputer->PC++;
		} else if (group3 == 2) { // sub
			value = komputer->reg[group2] - komputer->reg[group4];
			komputer->reg[group1] = value;
			komputer->NZP = NZP_calc(value);
			sprintf(instr, "%04X %s 1 %01X %04X 1 %01X 0 0000 0000\n", komputer->PC, instruction_bits, group1, (unsigned short) value, komputer->NZP);
			komputer->PC++;
		} else if (group3 == 3) { // div
			value = komputer->reg[group2] / komputer->reg[group4];
			komputer->reg[group1] = value;
			komputer->NZP = NZP_calc(value);
			sprintf(instr, "%04X %s 1 %01X %04X 1 %01X 0 0000 0000\n", komputer->PC, instruction_bits, group1, (unsigned short) value, komputer->NZP);
			komputer->PC++;
		} else {
			sprintf(instr, "%s", "INVALID INSTRUCTION");
		}
	} else if (opcode == 5) { // logic
		int and_immediate;
		and_immediate = (instruction & 0x0020) >> 5;
		if (and_immediate == 1) { // and immediate
			immx = sextI(instruction, 5);
			value = komputer->reg[group2] & immx;
			komputer->reg[group1] = value;
			komputer->NZP = NZP_calc(value);
			sprintf(instr, "%04X %s 1 %01X %04X 1 %01X 0 0000 0000\n", komputer->PC, instruction_bits, group1, (unsigned short) value, komputer->NZP);
			komputer->PC++;
		} else if (group3 == 0) { // and
			value = komputer->reg[group2] & komputer->reg[group4];
			komputer->reg[group1] = value;
			komputer->NZP = NZP_calc(value);
			sprintf(instr, "%04X %s 1 %01X %04X 1 %01X 0 0000 0000\n", komputer->PC, instruction_bits, group1, (unsigned short) value, komputer->NZP);
			komputer->PC++;
		} else if (group3 == 1) { // not
			value = ~komputer->reg[group2];
			komputer->reg[group1] = value;
			komputer->NZP = NZP_calc(value);
			sprintf(instr, "%04X %s 1 %01X %04X 1 %01X 0 0000 0000\n", komputer->PC, instruction_bits, group1, (unsigned short) value, komputer->NZP);
			komputer->PC++;
		} else if (group3 == 2) { // or
			value = komputer->reg[group2] | komputer->reg[group4];
			komputer->reg[group1] = value;
			komputer->NZP = NZP_calc(value);
			sprintf(instr, "%04X %s 1 %01X %04X 1 %01X 0 0000 0000\n", komputer->PC, instruction_bits, group1, (unsigned short) value, komputer->NZP);
			komputer->PC++;
		} else if (group3 == 3) { // xor
			value = komputer->reg[group2] ^ komputer->reg[group4];
			komputer->reg[group1] = value;
			komputer->NZP = NZP_calc(value);
			sprintf(instr, "%04X %s 1 %01X %04X 1 %01X 0 0000 0000\n", komputer->PC, instruction_bits, group1, (unsigned short) value, komputer->NZP);
			komputer->PC++;
		} else {
			sprintf(instr, "%s", "INVALID INSTRUCTION");
		}
	} else if (opcode == 6) { // load
		int address;
		immx = sextI(instruction, 6);
		address = (komputer->reg[group2] + immx) & 0xFFFF;
		if ((komputer->privilege == 1 && address >= 0x2000 && address <= 0x7FFF) || (komputer->privilege == 1 && address >= 0xA000 && address <= 0xFFFF) 
				|| (komputer->privilege == 0 && address >= 0x2000 && address <= 0x7FFF)) {
			value = lc4mem[address];
			komputer->reg[group1] = value;
			komputer->NZP = NZP_calc(value);
			sprintf(instr, "%04X %s 1 %01X %04X 1 %01X 0 %04X %04X\n", komputer->PC, instruction_bits, group1, (unsigned short) value, komputer->NZP, address, (unsigned short) value);
			komputer->PC++;
		} else {
			komputer->error = 1;
		}
	} else if (opcode == 7) { // store
		int address;
		immx = sextI(instruction, 6);
		address = (komputer->reg[group2] + immx) & 0xFFFF;
		if ((komputer->privilege == 1 && address >= 0x2000 && address <= 0x7FFF) || (komputer->privilege == 1 && address >= 0xA000 && address <= 0xFFFF) 
				|| (komputer->privilege == 0 && address >= 0x2000 && address <= 0x7FFF)) {
			value = komputer->reg[group1];
			lc4mem[address] = value;
			sprintf(instr, "%04X %s 0 0 0000 0 0 1 %04X %04X\n", komputer->PC, instruction_bits, address, (unsigned short) value);
			komputer->PC++;
		} else { // error
			komputer->error = 1;
		}		
	} else if (opcode == 9) { // const
		immx = sextI(instruction, 9);
		komputer->reg[group1] = immx;
		komputer->NZP = NZP_calc(immx);
		sprintf(instr, "%04X %s 1 %01X %04X 1 %01X 0 0000 0000\n", komputer->PC, instruction_bits, group1, immx, komputer->NZP);
		komputer->PC++;
	} else if (opcode == 13) { // hiconst
		uimmx = instruction & 0x00FF;
		value = (komputer->reg[group1] & 0x00FF) | (uimmx << 8);		
		komputer->reg[group1] = value;
		komputer->NZP = NZP_calc(value);
		sprintf(instr, "%04X %s 1 %01X %04X 1 %01X 0 0000 0000\n", komputer->PC, instruction_bits, group1, (unsigned short) value, komputer->NZP);
		komputer->PC++;
	} else if (opcode == 2) { // compare
		int compare_type;
		compare_type = (instruction & 0x0180) >> 7;
		if (compare_type == 0) { // cmp
			value = komputer->reg[group1] - komputer->reg[group4];
			komputer->NZP = NZP_calc(value);
			sprintf(instr, "%04X %s 0 0 0000 1 %01X 0 0000 0000\n", komputer->PC, instruction_bits, komputer->NZP);
			komputer->PC++;
		} else if (compare_type == 1) { // cmpu
			value = (unsigned short) komputer->reg[group1] - (unsigned short) komputer->reg[group4];
			komputer->NZP = NZP_calc(value);
			sprintf(instr, "%04X %s 0 0 0000 1 %01X 0 0000 0000\n", komputer->PC, instruction_bits, komputer->NZP);
			komputer->PC++;
		} else if (compare_type == 2) { //cmpi
			immx = sextI(instruction, 7);
			value = komputer->reg[group1] - immx;
			komputer->NZP = NZP_calc(value);
			sprintf(instr, "%04X %s 0 0 0000 1 %01X 0 0000 0000\n", komputer->PC, instruction_bits, komputer->NZP);
			komputer->PC++;
		} else if (compare_type == 3) { //cmpiu
			uimmx = instruction & 0x007F;
			value = (unsigned short) komputer->reg[group1] - uimmx;
			komputer->NZP = NZP_calc(value);
			sprintf(instr, "%04X %s 0 0 0000 1 %01X 0 0000 0000\n", komputer->PC, instruction_bits, komputer->NZP);
			komputer->PC++;
		} else {
			sprintf(instr, "%s", "INVALID INSTRUCTION");
		}
	} else if (opcode == 10) { // shift and mod
		int shift_type;
		shift_type = (instruction & 0x0030) >> 4;
		uimmx = instruction & 0x000F;
		if (shift_type == 0) { // sll
			value = komputer->reg[group2] << uimmx;
			komputer->reg[group1] = value;
			komputer->NZP = NZP_calc(value);
			sprintf(instr, "%04X %s 1 %01X %04X 1 %01X 0 0000 0000\n", komputer->PC, instruction_bits, group1, (unsigned short) value, komputer->NZP);
			komputer->PC++;
		} else if (shift_type == 1) { // sra
			if (komputer->reg[group2] >= 0) { // positive, its gucci
				value = komputer->reg[group2] >> uimmx;
			} else { // negative, sign extend
				value = komputer->reg[group2] >> uimmx;
				value = sextI(value, 16 - uimmx);
			}			
			komputer->reg[group1] = value;
			komputer->NZP = NZP_calc(value);
			sprintf(instr, "%04X %s 1 %01X %04X 1 %01X 0 0000 0000\n", komputer->PC, instruction_bits, group1, (unsigned short) value, komputer->NZP);
			komputer->PC++;
		} else if (shift_type == 2) { // srl
			value = komputer->reg[group2] >> uimmx;
			komputer->reg[group1] = value;
			komputer->NZP = NZP_calc(value);
			sprintf(instr, "%04X %s 1 %01X %04X 1 %01X 0 0000 0000\n", komputer->PC, instruction_bits, group1, (unsigned short) value, komputer->NZP);
			komputer->PC++;
		} else if (shift_type == 3) { // mod
			value = komputer->reg[group2] % komputer->reg[group4];
			komputer->NZP = NZP_calc(value);
			sprintf(instr, "%04X %s 1 %01X %04X 1 %01X 0 0000 0000\n", komputer->PC, instruction_bits, group1, (unsigned short) value, komputer->NZP);
			komputer->PC++;
		} else {
			sprintf(instr, "%s", "INVALID INSTRUCTION");
		}
	} else if (opcode == 4) { // jump subroutine
		int jump_type;
		jump_type = (instruction & 0x0800) >> 11;
		if (jump_type == 0) { // jsrr
			value = komputer->PC + 1;
			komputer->NZP = NZP_calc(value);
			sprintf(instr, "%04X %s 1 7 %04X 1 %01X 0 0000 0000\n", komputer->PC, instruction_bits, value, komputer->NZP);		
			komputer->PC = komputer->reg[group2];
			komputer->reg[7] = value;
		} else if (jump_type == 1) { // jsr
			immx = sextI(instruction, 11);
			value = komputer->PC + 1;
			komputer->NZP = NZP_calc(value);
			sprintf(instr, "%04X %s 1 7 %04X 1 %01X 0 0000 0000\n", komputer->PC, instruction_bits, value, komputer->NZP);
			komputer->PC = (komputer->PC & 0x8000) | (immx << 4);
			komputer->reg[7] = value;
		} else {
			sprintf(instr, "%s", "INVALID INSTRUCTION");
		}
	} else if (opcode == 12) { // jump
		int jump_type;
		jump_type = (instruction & 0x0800) >> 11;
		if (jump_type == 0) { // jmpr
			sprintf(instr, "%04X %s 0 0 0000 0 0 0 0000 0000\n", komputer->PC, instruction_bits);
			komputer->PC = komputer->reg[group2];
		} else if (jump_type == 1) { // jmp
			immx = sextI(instruction, 11);
			sprintf(instr, "%04X %s 0 0 0000 0 0 0 0000 0000\n", komputer->PC, instruction_bits);
			komputer->PC = komputer->PC + 1 + immx;
		} else {
			sprintf(instr, "%s", "INVALID INSTRUCTION");
		}
	} else if (opcode == 15) { // trap
		uimmx = instruction & 0x00FF;
		value = komputer->PC + 1;
		komputer->NZP = NZP_calc(value);
		komputer->privilege = 1;
		sprintf(instr, "%04X %s 1 7 %04X 1 %01X 0 0000 0000\n", komputer->PC, instruction_bits, value, komputer->NZP);
		komputer->PC = (0x8000 | uimmx);
		komputer->reg[7] = value;
	} else if (opcode == 8) { // RTI
		komputer->privilege = 0;
		sprintf(instr, "%04X %s 0 0 0000 0 0 0 0000 0000\n", komputer->PC, instruction_bits);
		komputer->PC = komputer->reg[7];
	} else {
		sprintf(instr, "%s", "INVALID INSTRUCTION");
	}

	// check errors

	// PC trying to access data section and execute as code
	if ((komputer->PC >= 0x2000 && komputer->PC <= 0x7FFF) || (komputer->PC >= 0xA000 && komputer->PC <= 0xFFFF)) {
		komputer->error = 1;
	}

	// in user mode, trying to access os section
	if (komputer->privilege == 0 && komputer->PC >= 0x8000 && komputer->PC >= 0xFFFF) {
		komputer->error = 1;
	}

	free(instruction_bits);
	return instr;
}