
%{
/* C code to be copied verbatim */
#include <stdio.h>
#include <stdlib.h>
#include <string.h>
#include "struct.h"
#include "tree.c"
#include "parse.c"

%}
%x rules
%x trailer
/* This tells flex to read only one input file */
%option noyywrap
%%
"%{"*"%}"       ECHO;
"%%"    BEGIN(rules);
<rules>\[\^[^\]]*] {printf("trucs entre crochets en negatif %s\n",yytext);}
<rules>\[\^[^\]]*]\+ {printf("trucs entre crochets avec un plus en negatif %s\n",yytext);}
<rules>\[\^[^\]]*]\* {printf("trucs entre crochets avec une etoile en negatif %s\n",yytext);}
<rules>\[[^\]]*]	{printf("simples trucs entre crochets %s\n",yytext);}
<rules>\[[^\]]*]\+	{printf("trucs entre crochets avec un plus %s\n",yytext);}
<rules>\[[^\]]*]\* {printf("trucs entre crochets avec une etoile %s\n",yytext);}
<rules>\[[^\]]*]\? {printf("trucs entre crochets avec un ? %s\n",yytext);}
<rules>\^       {printf("Saw caractere spe: %s\n", yytext);}
<rules>\\	{printf("Saw caractere spe: %s\n", yytext);}
<rules>\[	{printf("Saw caractere spe: %s\n", yytext);}
<rules>\]	{printf("Saw caractere spe: %s\n", yytext);}
<rules>.\-.       {printf("Saw caractere spe intervalle: %s\n", yytext);}
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
    Tree t;
    /* Call the lexer, then quit. */
    printf("coucou\n");
    t=new(REGLE,"master Regle");
    new_left_son(t,OR,"pwet");
    printf("pwet\n");
    show(left(t));
    printf("On fait un test\n");
    char p[7] = "[u[o]u";
    test(p);
    printf("au revoir\n");
    yylex();
    return 0;
}
