
%{
/* C code to be copied verbatim */
#include <stdio.h>
#include <stdlib.h>
#include <string.h>
#include "struct.h"
#include "tree.c"

%}
%x rules
%x trailer
/* This tells flex to read only one input file */
%option noyywrap
%%
"%{"*"%}"       ECHO;
"%%"    BEGIN(rules);
<rules>\[^[^\]] {printf("trucs entre crochets en negatif\n");}
<rules>\[^[^\]]\+ {printf("trucs entre crochets avec un plus en negatif\n");}
<rules>\[^[^\]]\* {printf("trucs entre crochets avec une etoile en negatif\n");}
<rules>\[[^\]]	{printf("simples trucs entre crochets\n");}
<rules>\[[^\]]\+	{printf("trucs entre crochets avec un plus\n");}
<rules>\[[^\]]\* {printf("trucs entre crochets avec une etoile\n");}
<rules>\[[^\]]\? {printf("trucs entre crochets avec un ?\n");}
<rules>\^       {printf("Saw caractere spe: %s\n", yytext);}
<rules>\\	{printf("Saw caractere spe: %s\n", yytext);}
<rules>\[	{printf("Saw caractere spe: %s\n", yytext);}
<rules>\]	{printf("Saw caractere spe: %s\n", yytext);}
<rules>\-       {printf("Saw caractere spe: %s\n", yytext);}
<rules>\.       {printf("Saw caractere spe: %s\n", yytext);}
<rules>\?       {printf("Saw caractere spe: %s\n", yytext);}
<rules>\+       {printf("Saw caractere spe: %s\n", yytext);}
<rules>\*       {printf("Saw caractere spe: %s\n", yytext);}
<rules>\|       {printf("Saw caractere spe: %s\n", yytext);}
<rules>\(       {printf("Saw caractere spe: %s\n", yytext);}
<rules>\)       {printf("Saw caractere spe: %s\n", yytext);}
<rules>\{       {printf("Saw caractere spe: %s\n", yytext);}
<rules>\}       {printf("Saw caractere spe: %s\n", yytext);}
<rules>[a-zA-Z0-9]       {printf("Saw a truc: %s\n", yytext);}
<rules>"%%"     BEGIN(trailer);
<rules>"\n"       {printf("Saw a /n %s\n", yytext);}
<trailer>[a-zA-Z0-9]    ECHO;
%%
/*** C Code section ***/

int main(void)
{
    /* Call the lexer, then quit. */
    yylex();
    return 0;
}
