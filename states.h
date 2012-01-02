#ifndef _STATES_H_
#define _STATES_H_

typedef enum {D,I} Type;

typedef struct {
	int	name;
	int	transition[255];
	} *State,t_state;

typedef struct maillon{
	int state;
	struct maillon *next;
	} t_list,*List;

typedef struct {
	int 	name;
	List	transition[255];
	} *Istate,t_istate;

typedef union{
	State   d;
        Istate  i;
	} Eta;

typedef struct {
	int 	size;
	Type	type;
	Eta	*etats;
	} *Machine,t_machine;



Machine newMachine(Type);
int newState(Machine);
void newTrans(Machine,int,char,int);
List addDest(List,int);



#endif
