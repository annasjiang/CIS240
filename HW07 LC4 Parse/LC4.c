/* 
 * LC4.c : routines for decoding instructions
 *
 */

#include "LC4.h"
#include <stdio.h>
#include <stdlib.h>

signed int sextI(unsigned int y, int length) {
	signed int sign, final;
	unsigned int x = y & ((1 << length) - 1); // only keep last chonk
	sign = (x >> (length - 1)) & 0x0001; // make MSB of IMMX LSB to check sign

	if (sign == 0) { // positive
		return x;
	} else { // negative
		int mask = (1 << (length - 1));
		final = (x & ~mask) - (mask);
		return final;
	}
}

char* LC4(unsigned short int instruction) {	
	// first 4 bits
	int opcode;
	opcode = (instruction >> 12) & 0x000F;

	// split into groups of three for most cases
	unsigned int group1, group2, group3, group4;
	group1 = (instruction & 0x0E00) >> 9;
	group2 = (instruction & 0x01C0) >> 6;
	group3 = (instruction & 0x0038) >> 3;
	group4 = (instruction & 0x0007);

	// instruction string
	char *instr = malloc(sizeof(char) * 25);

	// immediate
	unsigned int immx, uimmx;

	// hagrugajgnraje pattern matching bitches
	if (opcode == 0) { // branch
		immx = sextI(instruction, 9);
		if (group1 == 0) { // NOP
			sprintf(instr, "%s", "NOP");
		} else if (group1 == 1) { // BRp
			sprintf(instr, "BRp #%d", immx);
		} else if (group1 == 2) { // BRz
			sprintf(instr, "BRz #%d", immx);
		} else if (group1 == 3) { // BRzp
			sprintf(instr, "BRzp #%d", immx);
		} else if (group1 == 4) { // BRn
			sprintf(instr, "BRn #%d", immx);
		} else if (group1 == 5) { // BRnp
			sprintf(instr, "BRnp #%d", immx);
		} else if (group1 == 6) { // BRnz
			sprintf(instr, "BRnz #%d", immx);
		} else if (group1 == 7) { // BRnzp
			sprintf(instr, "BRnzp #%d", immx);
		} else {
			sprintf(instr, "%s", "INVALID INSTRUCTION");
		}
	} else if (opcode == 1) { // arith
		int add_immediate;
		add_immediate = (instruction & 0x0020) >> 5;
		if (add_immediate == 1) { // add immediate
			immx = sextI(instruction, 5);
			sprintf(instr, "ADD R%d, R%d, #%d", group1, group2, immx);
		} else if (group3 == 0) { // add
			sprintf(instr, "ADD R%d, R%d, R%d", group1, group2, group4);
		} else if (group3 == 1) { // mul
			sprintf(instr, "MUL R%d, R%d, R%d", group1, group2, group4);
		} else if (group3 == 2) { // sub
			sprintf(instr, "SUB R%d, R%d, R%d", group1, group2, group4);
		} else if (group3 == 3) { // div
			sprintf(instr, "DIV R%d, R%d, R%d", group1, group2, group4);
		} else {
			sprintf(instr, "%s", "INVALID INSTRUCTION");
		}
	} else if (opcode == 5) { // logic
		int and_immediate;
		and_immediate = (instruction & 0x0020) >> 5;
		if (and_immediate == 1) { // and immediate
			immx = sextI(instruction, 5);
			sprintf(instr, "AND R%d, R%d, #%d", group1, group2, immx);
		} else if (group3 == 0) { // and
			sprintf(instr, "AND R%d, R%d, R%d", group1, group2, group4);
		} else if (group3 == 1) { // not
			sprintf(instr, "NOT R%d, R%d", group1, group2);
		} else if (group3 == 2) { // or
			sprintf(instr, "OR R%d, R%d, R%d", group1, group2, group4);
		} else if (group3 == 3) { // xor
			sprintf(instr, "XOR R%d, R%d, R%d", group1, group2, group4);
		} else {
			sprintf(instr, "%s", "INVALID INSTRUCTION");
		}
	} else if (opcode == 6) { // load
		immx = sextI(instruction, 6);
		sprintf(instr, "LDR R%d, R%d, #%d", group1, group2, immx);
	} else if (opcode == 7) { // store
		immx = sextI(instruction, 6);
		sprintf(instr, "STR R%d, R%d, #%d", group1, group2, immx);
	} else if (opcode == 9) { // const
		immx = sextI(instruction, 9);
		sprintf(instr, "CONST R%d, #%d", group1, immx);
	} else if (opcode == 13) { // hiconst
		uimmx = instruction & 0x00FF;
		sprintf(instr, "HICONST R%d, #%d", group1, uimmx);
	} else if (opcode == 2) { // compare
		int compare_type;
		compare_type = (instruction & 0x0180) >> 7;
		if (compare_type == 0) { // cmp
			sprintf(instr, "CMP R%d, R%d", group1, group4);
		} else if (compare_type == 1) { // cmpu
			sprintf(instr, "CMPU R%d, R%d", group1, group4);
		} else if (compare_type == 2) { //cmpi
			immx = sextI(instruction, 7);
			sprintf(instr, "CMPI R%d, #%d", group1, immx);
		} else if (compare_type == 3) { //cmpiu
			uimmx = instruction & 0x007F;
			sprintf(instr, "CMPIU R%d, #%d", group1, uimmx);
		} else {
			sprintf(instr, "%s", "INVALID INSTRUCTION");
		}
	} else if (opcode == 10) { // shift and mod
		int shift_type;
		shift_type = (instruction & 0x0030) >> 4;
		uimmx = instruction & 0x000F;
		if (shift_type == 0) { // sll
			sprintf(instr, "SLL R%d, R%d, #%d", group1, group2, uimmx);
		} else if (shift_type == 1) { // sra
			sprintf(instr, "SRA R%d, R%d, #%d", group1, group2, uimmx);
		} else if (shift_type == 2) { // srl
			sprintf(instr, "SRL R%d, R%d, #%d", group1, group2, uimmx);
		} else if (shift_type == 3) { // mod
			sprintf(instr, "MOD R%d, R%d, R%d", group1, group2, group4);
		} else {
			sprintf(instr, "%s", "INVALID INSTRUCTION");
		}
	} else if (opcode == 4) { // jump subroutine
		int jump_type;
		jump_type = (instruction & 0x0800) >> 11;
		if (jump_type == 0) { // jsrr
			sprintf(instr, "JSRR R%d", group2);
		} else if (jump_type == 1) { // jsr
			immx = sextI(instruction, 11);
			sprintf(instr, "JSR #%d", immx);
		} else {
			sprintf(instr, "%s", "INVALID INSTRUCTION");
		}
	} else if (opcode == 12) { // jump
		int jump_type;
		jump_type = (instruction & 0x0800) >> 11;
		if (jump_type == 0) { // jmpr
			sprintf(instr, "JMPR R%d", group2);
		} else if (jump_type == 1) { // jmp
			immx = sextI(instruction, 11);
			sprintf(instr, "JMP #%d", immx);
		} else {
			sprintf(instr, "%s", "INVALID INSTRUCTION");
		}
	} else if (opcode == 15) { // trap
		uimmx = instruction & 0x00FF;
		sprintf(instr, "TRAP #%d", uimmx);
	} else if (opcode == 8) { // RTI
		sprintf(instr, "%s", "RTI");
	} else {
		sprintf(instr, "%s", "INVALID INSTRUCTION");
	}
	return instr;
}