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
