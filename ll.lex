
%{
/* C code to be copied verbatim */
#include <stdio.h>
#include <stdlib.h>
#include <string.h>
#include "rules.h"
#include "tree.h"
#include "struct.h"
#include "automaton-builder.h"
#include "fsmp.h"


int i=0,j=0,k=0, cpt_ensemble=0, cpt_rules=0,begin=0;
int is_or=0;

Tree rule[20];
Tree ensemble_tree[10];
Tree tmp;

char rule_buff_action[1000];

%}
%x rules
%x trailer
%x ensemble
%x action
/* This tells flex to read only one input file */
%option noyywrap

%%

"%{"*"%}"       ECHO;
"%%\n"    {printf("On commence les regles\n");BEGIN(rules);}

<rules>\[	{
			printf("simples trucs entre crochets %s\n",yytext);
			BEGIN(ensemble);
		}

<rules>\[^	{printf("simples negatif trucs entre crochets %s\n",yytext);BEGIN(ensemble);}
<rules>\\.	{
			printf("Saw \\, on attend un caractere: %s\n", yytext);
			char c[2];
			c[1]='\0';
			sscanf(yytext,"\\%c",c);
			ensemble_tree[cpt_ensemble]=new(CARACTERE,c);
			cpt_ensemble++;	
		}
<rules>\]	{printf("Saw caractere spe: %s, ce n'est pas normal, arrêt\n", yytext);return -1;}
<rules>\.       {
			printf("Saw un point, on attend tout: %s\n", yytext);
			ensemble_tree[cpt_ensemble]=new(CARACTERE,yytext);
			cpt_ensemble++;
		}
<rules>\?       {
			printf("Saw un ? donc ce qu'il y a avant n'est pas obligatoire : %s\n", yytext);
			ensemble_tree[cpt_ensemble-1]=new_union(ensemble_tree[cpt_ensemble-1],NULL,INTERROGATION);
		}
<rules>\+       {
			printf("Saw un + donc on repete ce qu'on a avant: %s\n", yytext);
			ensemble_tree[cpt_ensemble-1]=new_union(ensemble_tree[cpt_ensemble-1],NULL,PLUS);
		}
<rules>\*       {
			printf("Saw une * donc on repete ce qu'on a avant: %s\n", yytext);
			ensemble_tree[cpt_ensemble-1]=new_union(ensemble_tree[cpt_ensemble-1],NULL,ETOILE);
			
		}
<rules>\|       {
			is_or=1;printf("Saw un | : %s\nOn empile ce qu'on a avant le OR", yytext);
			ensemble_tree[begin]=empile_tree(ensemble_tree,&cpt_ensemble, UNION,0);
			begin++;
			cpt_ensemble++;
				
		}
<rules>\(       {printf("Saw caractere spe: %s\n", yytext);}
<rules>\)       {printf("Saw caractere spe: %s\n", yytext);}
<rules>[ a-zA-Z0-9]	{
				printf("Saw a truc: %s, on le met dans la case %d\n", yytext,cpt_ensemble);
				ensemble_tree[cpt_ensemble]=new(CARACTERE,yytext);
				cpt_ensemble++;
			}
<rules>"%%\n"     {printf("C'est la fin, on va dans le trailer\n");BEGIN(trailer);}
<rules>"}\n"	{
			if(is_or)
			{
				ensemble_tree[begin]=empile_tree(ensemble_tree,&cpt_ensemble, UNION,begin);
				begin++;
				cpt_ensemble++;
				printf("Il faut d'abrod empiler les OR avant d'empiler la regle\n");
				ensemble_tree[0]=empile_tree(ensemble_tree,&cpt_ensemble,OR,0);
				begin++;
				is_or=0;
			}
			rule[cpt_rules]=new(REGLE,rule_buff_action);	
			attach_left_son(rule[cpt_rules],empile_tree(ensemble_tree,&cpt_ensemble, UNION,0));

			printf("Fin de la regle, on affiche : \n");
			tree_show(rule[cpt_rules],0);
			cpt_rules++;
			begin=0;
			cpt_ensemble=0;
		}
<rules>"\t{"	{printf("Saw a /t, on passe donc a l'action\n");BEGIN(action);}

<action>[^}]*	{strcpy(rule_buff_action,yytext);}

<trailer>[a-zA-Z0-9]    ECHO;

<ensemble>\]	{
			printf("Saw a ] donc fin d'ensemble : %s\n",yytext);
			BEGIN(rules);
			printf("On empile deja ce qu'on a dans l'ensemble\n");
			ensemble_tree[begin]=empile_tree(ensemble_tree,&cpt_ensemble,ENSEMBLE,begin);
			printf("On a empilé ce qu'on a dans l'ensemble dans la case %d\n",begin);
			begin++;
			cpt_ensemble++;
		}
<ensemble>"\n"	{printf("On a vu un \\n au mauvais moment, erreur\n");BEGIN(rules);}
<ensemble>[a-zA-Z0-9_ ]	{
				printf("Saw un unique caractere dans un ensemble : %s\n", yytext);
				ensemble_tree[cpt_ensemble]=new(CARACTERE,yytext);
				cpt_ensemble++;
			}
<ensemble>\\.	{printf("Saw a caractere special dans un ensemble");}
<ensemble>.\-.	{
			printf("Saw un intervalle : %s\n", yytext);
			char a[2],b[2];
			a[1]=b[1]='\0';
			sscanf(yytext,"%c-%c",a,b);
			printf("PWETTT!!! %c, %c\nOn rajoute l'intervalle dans la case %d\n",a[0],b[0],cpt_ensemble);
			ensemble_tree[cpt_ensemble]=new_intervalle(a,b);
			cpt_ensemble++;
		}
<ensemble>.	{printf("Hibou!\n");}

%%
/*** C Code section ***/

int main(int argc, char* argv[])
{
    Tree t;
    /* Call the lexer, then quit. */
    printf("coucou\n");
    
    t=new(REGLE,"master Regle de test");

    Tree tt=new_intervalle("a","z");
    Tree ttt=new(ENSEMBLE,"");
    Tree tttt=new(PLUS,"");
    new_family(tt,ttt,new(CARACTERE,"_"));
    attach_left_son(tttt,ttt);
    attach_left_son(t,tttt);
    tree_show(t,0);

    Tree *rule;
	rule=calloc(20,sizeof(Tree));
	rule[0]=t;
    Machine M;
	M=ruleImachine(rule);
	fsmp(M);

    yylex();
    return 0;
}
