Tree new_intervalle(char* begin, char* end)
{
	Tree t = new(INTERVALLE,"");
	new_left_son(t,CARACTERE,begin);
	new_right_son(t,CARACTERE,end);

	return t;
}

void new_family(Tree left, Tree father, Tree right)
{
	attach_left_son(father,left);
	attach_right_son(father, right);
}

Tree new_union(Tree left, Tree right, Type type)
{
	Tree t = new(type,"");
	attach_left_son(t,left);
	attach_right_son(t, right);
	return t;
}
