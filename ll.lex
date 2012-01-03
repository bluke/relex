
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
"%%"    {printf("On commence les regles\n");BEGIN(rules);}

<rules>\[	{
			printf("simples trucs entre crochets %s\n",yytext);
			BEGIN(ensemble);
			//ensemble_tree[cpt_ensemble]=new(ENSEMBLE,"[]");
			//cpt_ensemble++;
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
<rules>\]	{printf("Saw caractere spe: %s\n", yytext);}
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
<rules>\|       {printf("Saw un | : %s\n", yytext);}
<rules>\(       {printf("Saw caractere spe: %s\n", yytext);}
<rules>\)       {printf("Saw caractere spe: %s\n", yytext);}
<rules>[ a-zA-Z0-9]	{
				printf("Saw a truc: %s\n", yytext);
				ensemble_tree[cpt_ensemble]=new(CARACTERE,yytext);
				cpt_ensemble++;
			}
<rules>"%%"     {Machine M=ruleImachine(rule);fsmp(M);printf("C'est la fin, on va dans le trailer\n");;BEGIN(trailer);}
<rules>"\n"	{
			
			
			rule[cpt_rules]=new(REGLE,rule_buff_action);	
			attach_left_son(rule[cpt_rules],empile_tree(ensemble_tree,&cpt_ensemble, UNION,0));

			printf("Fin de la regle, on affiche : \n");
			tree_show(rule[cpt_rules],0);
			cpt_rules++;
			begin=0;
			cpt_ensemble=0;
		}
<rules>"\t{"	{printf("Saw a /t, on passe donc a l'action\n");BEGIN(action);}
<action>"}"	{printf("C'est la fin de l'action\n");BEGIN(rules);}
<action>[^}]*	{strcpy(rule_buff_action,yytext);}

<trailer>[a-zA-Z0-9]    ECHO;

<ensemble>\]	{
			printf("Saw a ] donc fin d'ensemble : %s\n",yytext);
			BEGIN(rules);
			printf("On empile ce qu'on a deja\n");
			ensemble_tree[begin]=empile_tree(ensemble_tree,&cpt_ensemble,ENSEMBLE,begin);
			printf("On a empilé dans la case %d\n",begin);
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
    Tree ttt=new(ENSEMBLE,"");
    Tree tttt=new(PLUS,"");
    new_family(tt,ttt,new(CARACTERE,"_"));
    attach_left_son(tttt,ttt);
    attach_left_son(t,tttt);
    tree_show(t,0);

    Tree *rule;
	rule=calloc(20,sizeof(Tree));
	rule[1]=t;
    Machine M;
	M=ruleImachine(rule);
	fsmp(M);

    yylex();
    return 0;
}
