/* 
 * trace.c : main rountine
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
	 	lc4mem[i] = 0x0000;
	}

	for(i = 2; i < argc; i++) { // load mem
		loader(argv[i], lc4mem);
	}

	//initialize processor state
	processor_state *komputer = malloc(sizeof(processor_state));
	init(komputer);

	// writing outfile
	while(komputer->PC != 0x80FF) { // stop when PC 0x80FF
		// go thru lc4mem array using PC to find what code to execute
		char *instr = LC4(lc4mem[komputer->PC], lc4mem, komputer);	
		if (komputer->error == 1) { // error checker
			printf("ERROR: ILLEGAL ACCESS\n");
			free(instr);
			free(lc4mem);
			free(komputer);
			fclose(out_file);
			exit(1);
		}		
		fprintf(out_file, "%s", instr);
		free(instr);			
	}

	free(lc4mem);
	free(komputer);

	fclose(out_file);
}
