#include <stdio.h>
#include <stdlib.h>
#include <string.h>

typedef struct _entry
{
	char nome[9];
	char settore;
} entry;

entry files[51];
short int n_entry;

int main(int argc, char **argv)
{
	int i;
	int j;
	int size;
	int sector;
	FILE *fp;
	FILE *input;
	unsigned char zero = 0;
	unsigned char input_file[512];
	
	for(i = 0; i < 512; i++)
	{
		input_file[i] = 0;
	}
	
	for(i = 0; i < 51; i++)
	{
		files[i].settore = 0;
		
		for(j = 0; j < 9; j++)
		{
			files[i].nome[j] = 0;
		}
	}
	
	if(argc <= 1)
	{
		fp = fopen("16bitos.flp", "wb");
		
		if(fp == NULL)
		{
			printf("can't write floppy.img...\n");
			exit(0);
		}
		
		for(i = 0; i < 2880; i++)
		{
			for(j = 0; j < 512; j++)
				fwrite(&zero, sizeof(zero), 1, fp);
		}
		

		fclose(fp);
		
		printf("16bitos.flp written...\n");
		exit(0);
	}
	
	input = fopen(argv[1], "rb");
	
	if(input == NULL)
	{
		printf("can't open input file %s...\n", argv[1]);
		exit(0);
	}
	
	fseek(input, 0, SEEK_END); 
	size = ftell(input); 
	fseek(input, 0, SEEK_SET); 
	
	if(size > 512)
	{
		printf("can't write file %s... over 512 bytes\n", argv[1]);
		exit(0);
	}
	
	fread(input_file, sizeof(unsigned char), size, input);
	fclose(input);
	
	sector = atoi(argv[2]);
	
	/*if(sector <= 2)
	{
		printf("can't write file %s... sector must be at least 3\n", argv[1]);
		exit(0);
	}*/
	
	fp = fopen("16bitos.flp", "r+b");
	
	if(fp == NULL)
	{
		printf("can't open 16bitos.flp...\n");
		exit(0);
	}
	
	fseek(fp, 1024, SEEK_SET);
	fread(&n_entry, sizeof(n_entry), 1, fp);
	
	fseek(fp, 1026, SEEK_SET);
	
	for(i = 0; i < n_entry; i++)
	{
		fread(&files[i], sizeof(entry), 1, fp);
		printf("read %d entry...\n", i);
	}
	
	fseek(fp, 512*(sector-1), SEEK_SET);
	size = fwrite(input_file, sizeof(input_file), 1, fp);
	
	files[n_entry].settore = sector;
	strcpy(files[n_entry].nome, argv[1]);
	
	n_entry++;
	fseek(fp, 1024, SEEK_SET);
	fwrite(&n_entry, sizeof(n_entry), 1, fp);
	
	fseek(fp, 1026, SEEK_SET);
	
	for(i = 0; i < n_entry; i++)
	{
		printf("writing %d entry...\n", i);
		fwrite(&files[i], sizeof(entry), 1, fp);
	}
	
	fclose(fp);
	
	printf("written %d file at sector %d\n", size, sector);
	return 0;
}
		
	
	
