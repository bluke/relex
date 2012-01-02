#include <stdio.h>
#include <stdlib.h>
#include <string.h>

void decale(int j, char* t)
{       
        int i; 
        for(i=j;i<strlen(t);i++)
        {
                t[i]=t[i+1];
        }       
}

void suppr(char c, char* text)
{
	int i;

	for(i=0;i<strlen(text);i++)
	{
		if(text[i]==c)
		{
			decale(i,text);
		}
	}
}

void test(char* t)
{
	suppr('[',t);
	printf("apres : %s\n",t);
}	
