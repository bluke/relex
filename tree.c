//Fonctions pour le traitements des arbres
#define true 1
#define false 0


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

int leaf(Tree t)
{
	if(empty(t))
		return false;
	else if (empty(left(t))&&empty(right(t)))
		return true;
	else
		return false;
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
//	printf("Show du noeud de type : %s\ncontent : %s\n\n",type(t),content(t));
}

Tree new(Type type,char* content)
{
	Tree t = malloc(sizeof(struct Tree));
	t->type=type;
	t->content=malloc(strlen(content+1));
	strcpy(content,t->content);
}
