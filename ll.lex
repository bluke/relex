
%{
/* C code to be copied verbatim */
#include <stdio.h>
#include <stdlib.h>


%}
%x rules
%x trailer
/* This tells flex to read only one input file */
%option noyywrap
%%
"%{"*"%}"       ECHO;
"%%"    BEGIN(rules);
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
