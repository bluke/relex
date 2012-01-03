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
	printf("Nouvelle Union cree\n");
	return t;
}
/*
Tree empile_tree(Tree ensemble_tree[], int* cpt_ensemble, Type type)
{
	int i;
	Tree tmp;
	Tree dest=new(type,"");
	if(*cpt_ensemble>=2)
	{
		//On fait l'union des deux derniers
		tmp=new_union(ensemble_tree[*cpt_ensemble-2],ensemble_tree[*cpt_ensemble-1],UNION);
		for(i=*cpt_ensemble-3;i>=0;i--)//On souhaite ratacher tous les autres ensembles entre eux
		{
			tmp=new_union(ensemble_tree[i],tmp,UNION);
		}
		//Pour finir on attache l'ensemble à la règle qui est ainsi formée
		attach_left_son(dest,tmp);
	}
	else
		attach_left_son(dest,ensemble_tree[0]);
		
			
	*cpt_ensemble=0;//En recommençant le compteur d'ensemble
	printf("Saw a /n donc fin de la regle en cours, on remet cpt_ensemble a 0 et on affiche l'abre ainsi créé\n");
	tree_show(dest,0);
//	*cpt_rules++;//On peut passer à la nouvelle règle
	return dest;
}*/
