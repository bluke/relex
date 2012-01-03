
%{
/* C code to be copied verbatim */
#include <stdio.h>
#include <stdlib.h>
#include <string.h>
#include "rules.h"
#include "tree.h"
#include "struct.h"

int i=0,j=0,k=0, cpt_ensemble=0, cpt_rules=0;

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
<rules>\\	{printf("Saw \\, on attend un caractere: %s\n", yytext);}
<rules>\]	{printf("Saw caractere spe: %s\n", yytext);}
<rules>\.       {
			printf("Saw un point, on attend tout: %s\n", yytext);
			ensemble_tree[cpt_ensemble]=new(CARACTERE,yytext);
			cpt_ensemble++;
		}
<rules>\?       {
			printf("Saw un ? donc ce qu'il y a avant n'est pas obligatoire : %s\n", yytext);
			ensemble_tree[cpt_ensemble]=new(INTERROGATION,"");
			cpt_ensemble++;
		}
<rules>\+       {printf("Saw un + donc on repete ce qu'on a avant: %s\n", yytext);}
<rules>\*       {printf("Saw une * donc on repete ce qu'on a avant: %s\n", yytext);}
<rules>\|       {printf("Saw un | : %s\n", yytext);}
<rules>\(       {printf("Saw caractere spe: %s\n", yytext);}
<rules>\)       {printf("Saw caractere spe: %s\n", yytext);}
<rules>[a-zA-Z0-9]	{
				printf("Saw a truc: %s\n", yytext);
				ensemble_tree[cpt_ensemble]=new(CARACTERE,yytext);
				cpt_ensemble++;
			}
<rules>"%%"     {printf("C'est la fin, on va dans le trailer\n");BEGIN(trailer);}
<rules>"\n"	{
			
		//	rule[cpt_rules]=empile_tree(ensemble_tree,&cpt_ensemble, REGLE);
		//	cpt_rules++;

			rule[cpt_rules]=new(REGLE,rule_buff_action);
			if(cpt_ensemble>=2)
			{
				//On fait l'union des deux derniers
				tmp=new_union(ensemble_tree[cpt_ensemble-2],ensemble_tree[cpt_ensemble-1],UNION);
				for(i=cpt_ensemble-3;i>=0;i--)//On souhaite ratacher tous les autres ensembles entre eux
				{
					tmp=new_union(ensemble_tree[i],tmp,UNION);
				}
				//Pour finir on attache l'ensemble à la règle qui est ainsi formée
				attach_left_son(rule[cpt_rules],tmp);
			}
			else
				attach_left_son(rule[cpt_rules],ensemble_tree[0]);
				
			
			cpt_ensemble=0;//En recommençant le compteur d'ensemble
			printf("Saw a /n donc fin de la regle en cours, on remet cpt_ensemble a 0 et on affiche l'abre ainsi créé\n");
			tree_show(rule[cpt_rules],0);
			cpt_rules++;//On peut passer à la nouvelle règle
			
		}
<rules>"\t{"	{printf("Saw a /t, on passe donc a l'action\n");BEGIN(action);}
<action>"}"	{printf("C'est la fin de l'action\n");BEGIN(rules);}
<action>[^}]*	{strcpy(rule_buff_action,yytext);}

<trailer>[a-zA-Z0-9]    ECHO;

<ensemble>\]	{
			printf("Saw a ] donc fin d'ensemble : %s\n",yytext);
			BEGIN(rules);
			//printf("On empile ce qu'on a deja\n");
			//ensemble_tree[begin]=empile_tree(ensemble_tree,&cpt_ensemble);
		}
<ensemble>"\n"	{printf("On a vu un \\n au mauvais moment, erreur\n");BEGIN(rules);}
<ensemble>[a-zA-Z0-9_]	{
				printf("Saw un unique caractere dans un ensemble : %s\n", yytext);
				ensemble_tree[cpt_ensemble]=new(CARACTERE,yytext);
				cpt_ensemble++;
			}
<ensemble>\\.	{printf("Saw a caractere special dans un ensemble");}
<ensemble>.\-.	{
			printf("Saw un ensemble : %s\n", yytext);
			char a[2],b[2];
			a[1]=b[1]='\0';
			sscanf(yytext,"%c-%c",a,b);
			printf("PWETTT!!! %c, %c\n",a[0],b[0]);
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
    Tree ttt=new(UNION,"");
    Tree tttt=new(PLUS,"");
    new_family(tt,ttt,new(CARACTERE,"_"));
    attach_left_son(tttt,ttt);
    attach_left_son(t,tttt);
    tree_show(t,0);

    yylex();
    return 0;
}
