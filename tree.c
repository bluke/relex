//Fonctions pour le traitements des arbres
#include "tree.h"

#define TRUE 1
#define FALSE 0

int empty(Tree t)
{
	return t == NULL;
}

Tree left(Tree t)
{
	if(empty(t))
		return NULL;
	else
		return t->left;
}

Tree right(Tree t)
{
        if(empty(t))
                return NULL;
        else
                return t->right;
}

int isfinal(Tree t)
{
	if(empty(left(t))&&empty(right(t))&&!empty(t))
		return TRUE;
	else
		return FALSE;
}

int leaf(Tree t)
{
	if(empty(t))
		return FALSE;
	else if (empty(left(t))&&empty(right(t)))
		return TRUE;
	else
		return FALSE;
}

Type type(Tree t)
{
	return t->type;
}

char* content(Tree t)
{
	return t->content;
}

void show(Tree t)
{
	if(empty(t))
		printf("Arbre vide\n");
	else
		printf("Show du noeud de type : %d\ncontent : %s\n\n",type(t),t->content);
}

void print_type(Tree t)
{
	Type ty=t->type;

	if(ty == REGLE)
		printf("Regle");
	else if(ty==UNION)
		printf("Union");
        else if(ty==OR)
	        printf("Or");
        else if(ty==PLUS)
		printf("Plus");
        else if(ty==ETOILE)
		printf("Etoile");
        else if(ty==CARACTERE)
		printf("Caractere");
        else if(ty==ENSEMBLE)
		printf("Ensemble");
        else if(ty==INTERVALLE)
		printf("Intervalle");
	else if(ty==INTERROGATION)
		printf("?");
	else
		printf("TYpe inconnu");
}

void short_show(Tree t)
{
	printf("(");
	print_type(t);
	printf(") ");
	printf("%s",t->content);
}

void print_space(int k)
{
	printf("\n");
	int i;
	for(i=0;i<k;i++)
		printf(" ");
}

void tree_show(Tree t, int p)
{
	if(isfinal(t))
	{
		short_show(t);
	}
	else if(!empty(t))
	{
		print_space(p);
		short_show(t);
		print_space(p);
		printf("|- ");
		tree_show(left(t),p+2);
        	print_space(p);
		printf("|- ");
		tree_show(right(t),p+2);
	}
	else if(empty(t))
		printf("(Vide)");
}


Tree new(Type type,char* content)
{
	Tree t = (Tree)malloc(sizeof(struct Tree));
	t->type=type;
	t->content=(char*)malloc(strlen(content));
	strcpy(t->content,content);
	return t;
}

void new_right_son(Tree father, Type type, char* content)
{
	father->right=new(type, content);
}

void new_left_son(Tree father, Type type, char* content)
{
        father->left=new(type, content);
}

void attach_left_son(Tree father, Tree son)
{
	father->left=son;
}

void attach_right_son(Tree father, Tree son)
{
        father->right=son;
}
