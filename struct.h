typedef struct Tree * Tree;
typedef enum Type Type;

enum Type
{
    REGLE, UNION, OR, PLUS, ETOILE, CARACTERE, ENSEMBLE, INTERVALLE
};

struct Tree
{
	Type type;
	char* content;
	Tree right;
	Tree left;
};
	
