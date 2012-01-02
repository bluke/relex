
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
%x ensemble
/* This tells flex to read only one input file */
%option noyywrap
%%
"%{"*"%}"       ECHO;
"%%"    BEGIN(rules);
<rules>\[	{BEGIN(ensemble);printf("simples trucs entre crochets %s\n",yytext);}
<rules>\[^       {BEGIN(ensemble);printf("simples negatif trucs entre crochets %s\n",yytext);}
<rules>\\	{printf("Saw \\, on attend un caractere: %s\n", yytext);}
<rules>\]	{printf("Saw caractere spe: %s\n", yytext);}
<rules>\.       {printf("Saw un point, on attend tout: %s\n", yytext);}
<rules>\?       {printf("Saw un ? donc ce qu'il y a avant n'est pas obligatoire : %s\n", yytext);}
<rules>\+       {printf("Saw un + donc on repete ce qu'on a avant: %s\n", yytext);}
<rules>\*       {printf("Saw une * donc on repete ce qu'on a avant: %s\n", yytext);}
<rules>\|       {printf("Saw un | : %s\n", yytext);}
<rules>\(       {printf("Saw caractere spe: %s\n", yytext);}
<rules>\)       {printf("Saw caractere spe: %s\n", yytext);}
<rules>[a-zA-Z0-9]       {printf("Saw a truc: %s\n", yytext);}
<rules>"%%"     BEGIN(trailer);
<rules>"\n"       {printf("Saw a /n donc fin de la règle en cours %s\n", yytext);}
<trailer>[a-zA-Z0-9]    ECHO;
<ensemble>.\-.	{printf("Saw un ensemble : %s\n", yytext);}
<ensemble>"]"	{printf("Saw a ] donc fin d'ensemble : %s\n",yytext);BEGIN(rules);}
<ensemble>"\n"	{printf("On a vu un \\n au mauvais moment, erreur\n");BEGIN(rules);}
<ensemble>.	{printf("Saw a caractere dans un ensemble : %s\n", yytext);}
%%
/*** C Code section ***/

int main(void)
{
    Tree t;
    /* Call the lexer, then quit. */
    printf("coucou\n");
    t=new(REGLE,"master Regles test je sais pas");
    printf("On crée un fils\n");
    new_left_son(t,OR,"pwet");
    printf("Encore un\n");
    new_left_son(left(t),CARACTERE,"A");
    printf("\n%s\n",t->left->left->content);
    printf("\npwet\n");	
    printf("\nEt encore un\n");
    new_right_son(left(t),CARACTERE,"B");
    printf("On va afficher\n");
    tree_show(t,0);
    printf("\n");
    printf("pwetpwet\n");
    show(left(t));
    printf("On fait un test\n");
    char p[7] = "[u[o]u";
    test(p);
    printf("au revoir\n");
    yylex();
    return 0;
}
