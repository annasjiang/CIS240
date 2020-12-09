/* 
 * parser.c : main rountine to parse command line arguments
 *
 */

#include "loader.h"
#include "LC4.h"
#include <stdio.h>
#include <stdlib.h>

int main(int argc, char **argv) {

	FILE *out_file = fopen(argv[1], "w");

	// load up mem based on input file(s)
	unsigned short int* lc4mem; 
	lc4mem = malloc(sizeof(unsigned short int) * 65536);

    int i;
	for (i = 0; i < 65536; i++) { // clear mem
	 	lc4mem[i] = 0;
	}

	for(i = 2; i < argc; i++) { // load mem
		loader(argv[i], lc4mem);
	}

	// writing
	unsigned short int addy, value;
	for (i = 0; i < 65536; i++) {
		addy = i;
		value = lc4mem[i];
		if (i < 0x2000) { // user code	
			if (value != 0) {
				char *instr = LC4(lc4mem[i]);
				fprintf(out_file, "%04X : %04X -> %s\n", addy, value, instr);
				free(instr);
			}
		} else if (i < 0x8000 && i >= 0x2000) { // user data
			if (value != 0) {
				fprintf(out_file, "%04X : %04X\n", addy, value);
			}
		} else if (i < 0xA000 && i >= 0x8000){ // os code
			if (value != 0) {
				char *instr = LC4(lc4mem[i]);
				fprintf(out_file, "%04X : %04X -> %s\n", addy, value, instr);
				free(instr);
			}
		} else { // os data
			if (value != 0) {
				fprintf(out_file, "%04X : %04X\n", addy, value);
			}
		}
	}

	free(lc4mem);

	fclose(out_file);
}
