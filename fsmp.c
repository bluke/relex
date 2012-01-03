#include <stdio.h>
#include "fsmp.h"
#include "states.h"


void fsmp(Machine M,FILE *fd){
	Det t=M->type;
	int i;
	
	fprintf(fd,"\nAutomate à %d états \n",M->size);
	
	for(i=0;i<M->size;i++)
		printState(M->etats[i],t,fd);
	
	fprintf(fd,"\n");

}


void printState(Eta etat,Det type,FILE *fd){
	
	char i;
	
	switch(type){
		case(D):
			fprintf(fd,"Etat %d\n",etat.d->name);
			for(i=33;i<127;i++)
				if(etat.d->transition[i]!=0)
					fprintf(fd,"\t\'%c\'->%d\n",i,etat.d->transition[i]);
			if(etat.d->transition[' ']!=0)
				fprintf(fd,"\t\' \'->%d\n",etat.d->transition[' ']);
			if(etat.d->code!=NULL)
				fprintf(fd,"\tEtat Final : %s\n",etat.d->code);
			break;
		case(I):
			fprintf(fd,"Etat %d\n",etat.i->name);
			for(i=33;i<127;i++)
				if(etat.i->transition[i]!=NULL){
					fprintf(fd,"\t\'%c\'->",i);
					printList(etat.i->transition[i],fd);
				}
			if(etat.i->transition[' ']!=NULL){
					fprintf(fd,"\t\' \'->");
					printList(etat.i->transition[' '],fd);
				}
			if(etat.i->transition['\0']!=NULL){
					fprintf(fd,"\tEpsilon->");
					printList(etat.i->transition['\0'],fd);
				}
			if(etat.i->code!=NULL)
				fprintf(fd,"\tEtat Final : %s\n",etat.i->code);
			break;
	}
	
}

void printList(List l,FILE *fd){
	
	if(l==NULL)
		fprintf(fd,"\n");
	else
	{
		fprintf(fd," %d",l->state);
		printList(l->next,fd);
	}
}
