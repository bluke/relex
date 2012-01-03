#include <stdio.h>
#include "fsmp.h"
#include "states.h"


void fsmp(Machine M){
	Det t=M->type;
	int i;
	
	printf("\nAutomate à %d états \n",M->size);
	
	for(i=0;i<M->size;i++)
		printState(M->etats[i],t);
	
	printf("\n");

}


void printState(Eta etat,Det type){
	
	char i;
	
	switch(type){
		case(D):
			printf("Etat %d\n",etat.d->name);
			for(i=33;i<127;i++)
				if(etat.d->transition[i]!=0)
					printf("\t\'%c\'->%d\n",i,etat.d->transition[i]);
			if(etat.d->transition[' ']!=0)
				printf("\t\' \'->%d\n",etat.d->transition[' ']);
			if(etat.d->code!=NULL)
				printf("\tEtat Final : %s\n",etat.d->code);
			break;
		case(I):
			printf("Etat %d\n",etat.i->name);
			for(i=33;i<127;i++)
				if(etat.i->transition[i]!=NULL){
					printf("\t\'%c\'->",i);
					printList(etat.i->transition[i]);
				}
			if(etat.i->transition[' ']!=NULL){
					printf("\t\' \'->");
					printList(etat.i->transition[' ']);
				}
			if(etat.i->transition['\0']!=NULL){
					printf("\tEpsilon->");
					printList(etat.i->transition['\0']);
				}
			if(etat.i->code!=NULL)
				printf("\tEtat Final : %s\n",etat.i->code);
			break;
	}
	
}

void printList(List l){
	
	if(l==NULL)
		printf("\n");
	else
	{
		printf(" %d",l->state);
		printList(l->next);
	}
}
