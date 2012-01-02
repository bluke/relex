
%{
/* C code to be copied verbatim */
#include <stdio.h>
#include <stdlib.h>
#include <string.h>
#include "rules.h"
#include "tree.h"
#include "struct.h"

int i=0,j=0,k=0;
Tree tabtree[10];

%}
%x rules
%x trailer
%x ensemble
/* This tells flex to read only one input file */
%option noyywrap
%%
"%{"*"%}"       ECHO;
"%%"    {printf("On commence les regles\n");BEGIN(rules);}
<rules>\[	{printf("simples trucs entre crochets %s\n",yytext);BEGIN(ensemble);}
<rules>\[^	{BEGIN(ensemble);printf("simples negatif trucs entre crochets %s\n",yytext);}
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
<rules>"\n"	{printf("Saw a /n donc fin de la règle en cours %s\n", yytext);}
<rules>"\t"	{printf("Saw a /t, on passe donc a l'action\n");}

<trailer>[a-zA-Z0-9]    ECHO;

<ensemble>\]	{printf("Saw a ] donc fin d'ensemble : %s\n",yytext);BEGIN(rules);}
<ensemble>"\n"	{printf("On a vu un \\n au mauvais moment, erreur\n");BEGIN(rules);}
<ensemble>[a-zA-Z0-9_]	{printf("Saw un unique caractere dans un ensemble : %s\n", yytext);}
<ensemble>\\.	{printf("Saw a caractere special dans un ensemble");}
<ensemble>.\-.	{printf("Saw un ensemble : %s\n", yytext);char a[2],b[2];a[1]=b[1]='\0';sscanf(yytext,"%c-%c",a,b);printf("PWETTT!!! %c, %c\n",a[0],b[0]);tabtree[i]=new_intervalle(a,b);i++;}
<ensemble>.	{printf("Hibou!\n");}
<ensemble>[a-zA-Z0-9]{-}[(\\)(\-)]{2,}	{printf("Saw plusieurs caractere dans un ensemble : %s\n", yytext);}

%%
/*** C Code section ***/

int main(void)
{
    Tree t;
    /* Call the lexer, then quit. */
    printf("coucou\n");
    t=new(REGLE,"master Regles test je sais pas");
/*    printf("On crée un fils\n");
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
*/
    t=new(REGLE,"master Regle de test");

    Tree tt=new_intervalle("a","z");
    Tree ttt=new(UNION,"");
    Tree tttt=new(PLUS,"");
    new_family(tt,ttt,new(CARACTERE,"_"));
    attach_left_son(tttt,ttt);
    attach_left_son(t,tttt);
    tree_show(t,0);

    yylex();
    return 0;
}
