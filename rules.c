#include <stdio.h>
#include <stdlib.h>
#include "rules.h"
#include "struct.h"

Tree new_intervalle(char* begin, char* end)
{
	Tree t = new(INTERVALLE,"");
	new_left_son(t,CARACTERE,begin);
	new_right_son(t,CARACTERE,end);
	printf("Nouvel intervalle cree\n");
	tree_show(t,0);
	return t;
}

void new_family(Tree left, Tree father, Tree right)
{
	attach_left_son(father,left);
	attach_right_son(father, right);
	printf("Nouvelle famille cree\n");
}

Tree new_union(Tree left, Tree right, Type type)
{
	Tree t = new(type,"");
	attach_left_son(t,left);
	attach_right_son(t, right);
	printf("Nouvelle Union cree (");
	print_type(t);
	printf(")\n");
	return t;
}

Tree empile_tree(Tree ensemble_tree[], int* cpt_ensemble, Type type, int begin)
{
	int i;
	Tree tmp;
	//Tree dest=new(type,"");
	printf("Appel de la fonction empile avec cpt_ensemble=%d et begin =%d\n",*cpt_ensemble,begin);
	if(*cpt_ensemble-begin>=2)
	{
		printf("\nW00t\n");
		//On fait l'union des deux derniers
		tmp=new_union(ensemble_tree[*cpt_ensemble-2],ensemble_tree[*cpt_ensemble-1],type);
		for(i=*cpt_ensemble-3;i>=begin;i--)//On souhaite ratacher tous les autres ensembles entre eux
		{
			tmp=new_union(ensemble_tree[i],tmp,type);
		}
		//Pour finir on attache l'ensemble à la règle qui est ainsi formée
		//attach_left_son(dest,tmp);
	}
	else
	{	//attach_left_son(dest,ensemble_tree[begin]);
		//rien à faire, il n'y a qu'un ensemble, il n'y a rien à empiler
		if(type==ENSEMBLE||type==OR)
		{
			printf("Ensemble ou Or\n");
			tmp=new_union(ensemble_tree[begin],NULL,type);
		}
		else
		{
			printf("Autre\n");
			tmp=ensemble_tree[begin];
		}

	}
			
	*(cpt_ensemble)=begin;//En recommençant le compteur d'ensemble
	printf("Fin de l'empilage en cours, on remet cpt_ensemble a jour et on affiche l'abre ainsi créé\ncpt_ensemble=%d et begin=%d\n",*cpt_ensemble,begin);
	tree_show(tmp,0);
	printf("\n");
	
	return tmp;
}
