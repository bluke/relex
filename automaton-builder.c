#include "automaton-builder.h"
#include "tree.h"
#include "states.h"


Machine ruleImachine(Tree rules[20]){

	Machine M=newMachine(I);
	newState(M,NULL);
	int i;

	for(i=0;rules[i]!=NULL;i++)
		addRule(M,rules[i]);

	return M;
}

void addRule(Machine M,Tree rule){
	int state = M->etats[0].i->name;
	
	recRuling(M,state,rule);
	
	return;
}


int recRuling(Machine M,int pos,Tree deriv){
	
		int gauche,droite,new;
		char d,g,i;
	
		switch(deriv->type)
		{
			case(REGLE):
					gauche=recRuling(M,pos,left(deriv));
					droite=newState(M,deriv->content);
					newTrans(M,gauche,'\0',droite);
					return droite;
					break;
			case(UNION):
					gauche=recRuling(M,pos,left(deriv));
					droite=recRuling(M,gauche,right(deriv));
					return droite;
					break;
			case(OR):
					gauche=recRuling(M,pos,left(deriv));
					droite=recRuling(M,pos,right(deriv));
					new=newState(M,NULL);
					newTrans(M,gauche,'\0',new);
					newTrans(M,droite,'\0',new);
					return new;
					break;
			case(PLUS):
					gauche=recRuling(M,pos,left(deriv));
					newTrans(M,gauche,'\0',pos);
					return gauche;
					break;
			case(ETOILE):
					gauche=recRuling(M,pos,left(deriv));
					newTrans(M,gauche,'\0',pos);
					new=newState(M,NULL);
					newTrans(M,pos,'\0',new);
					return new;
					break;
			case(INTERROGATION):
					gauche=recRuling(M,pos,left(deriv));
					new=newState(M,NULL);
					newTrans(M,pos,'\0',new);
					newTrans(M,gauche,'\0',new);
					return new;
					break;
			case(CARACTERE):
					new=newState(M,NULL);
					i=deriv->content[0];
					newTrans(M,pos,i,new);
					return new;
					break;
			case(INTERVALLE):
					new=newState(M,NULL);
					g=left(deriv)->content[0];
					d=right(deriv)->content[0];
					for(i=g;i<=d;i++)
						newTrans(M,pos,i,new);
					return new;
					break;
			case(ENSEMBLE):
					gauche=recRuling(M,pos,left(deriv));
					new=newState(M,NULL);
					newTrans(M,gauche,'\0',new);
					if(!empty(right(deriv))){
						droite=recRuling(M,pos,right(deriv));
						newTrans(M,droite,'\0',new);
					}
					return new;
					break;
		}
}
