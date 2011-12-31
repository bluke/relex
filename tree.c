//Fonctions pour le traitements des arbres
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
	printf("Show du noeud de type : %d\ncontent : %s\n\n",type(t),t->content);
}

Tree new(Type type,char* content)
{
	Tree t = malloc(sizeof(struct Tree));
	t->type=type;
	t->content=malloc(strlen(content+1));
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
