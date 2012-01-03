#include "states.h"
#include <stdlib.h>

Machine newMachine(Det t){

	Machine ret=NULL;
	ret=malloc(sizeof(t_machine));
	ret->size=0;
	ret->type=t;
	ret->etats=NULL;

	return ret;
}

int newState(Machine M,char *code){

	M->size+=1;
	M->etats=realloc(M->etats,M->size*sizeof(Eta));
	switch(M->type){
	case(D):
		M->etats[(M->size)-1].d=calloc(1,sizeof(t_state));
		M->etats[(M->size)-1].d->name=(M->size);
		M->etats[(M->size)-1].d->code=code;
		break;
	case(I):
		M->etats[(M->size)-1].i=calloc(1,sizeof(t_istate));
                M->etats[(M->size)-1].i->name=(M->size);
		M->etats[(M->size)-1].i->code=code;
                break;
	}

	return M->size;
}

void newTrans(Machine M,int source,char c,int dest){

	switch(M->type){
		case(D):
			M->etats[source-1].d->transition[c]=dest;
			break;
		case(I):
			M->etats[source-1].i->transition[c]=addDest(M->etats[source-1].i->transition[c],dest);
			break;
		}
}

List addDest(List l,int dest){
	if(l==NULL)
	{
		List ret=malloc(sizeof(t_list));
		ret->state=dest;
		ret->next=NULL;
		return ret;
	}
	else
	{
		l->next=addDest(l->next,dest);
		return l;
	}	
}
