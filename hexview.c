/* 
hexview.c - deadPix3l - 05Jun16 
-----------------------------------
Compilations options: (gnu99 is required for isatty() to not throw warnings)
--- gcc hexview.c -std=gnu99 -o hexview -Wall -Werror -pedantic ---
*/
#include <stdio.h>
#include <unistd.h> /* isatty() */
#include <errno.h>

/*prototypes here */
int hexdump(FILE*);

int main(int argc, char** argv) 
{
	/* exit with Usage msg if no arguments */
	/* TODO: add STDIN support for piping when no arguments given */
	if(argc<2 && isatty(fileno(stdin)))
	{
		printf("Usage:\n---------------\n%s [filenames]\nsome-command | %s\n", argv[0], argv[0]);
		return 0;
	}
	
	if(!isatty(fileno(stdin))) 
	{
		printf("-----------------------\nStandard IN (pipe)\n-----------------------\n");
		hexdump(stdin);
	}
	
	/* for each filename provided... */
	for(int f = 1; f<argc; f++)
	{
		FILE *binfile;
		if((binfile = fopen(argv[f],"rb")) == NULL)
		{ 
			printf("there was an error opening %s.\nContinuing...\n\n", argv[f]);
			continue;
		}
		
		/* the file exists, and opened properly. Let's go! */
		printf("-----------------------\n%s\n-----------------------\n",argv[f]); /* print the filename */
		
		/*the file didnt close successfully. Print error and leave it i guess. ehh... */
		if(hexdump(binfile)) perror(argv[f]);	
	}
	
	return 0;
}

int hexdump(FILE *binfile)
{
		// int lineno = 0;
		unsigned char line[16+1]; /* +1 leaves room for '\0' */
		/*  this loop will:
			  - read 16 bytes from the file
			  - print each byte as a hex value
		  	  - swap non-ascii bytes with a '.'
			  - properly terminate the string
			  - printf() the string
		*/
		int x = 16;
		while(x==16)
		{
			//printf("%08x:  ", lineno++); //prints and increments the line number per file
			/*take in 16 bytes */
			x = fread(line, sizeof(char), 16, binfile);
			for(int i = 0; i<x; i++) 
			{
				printf("%02X ", line[i]);
				if(i==7) {printf("  ");} /* print a seperator for formatting */
				if ( line[i] <32 || line[i]>126 ) {line[i]='.';} /* replace non ascii chars with dots */
			}
			
			/* adjust spacing so string display lines up properly for last line*/
			if(x!=16)
				for(int i=x;i<16;i++) {printf("   "); }
			
			/*properly terminate and print line */
			line[x]='\0';
			printf("   %s\n", line);
		}
		
		/* close file and return whether it was successful */
		printf("\n");
		return fclose(binfile);
}