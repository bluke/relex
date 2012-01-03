#ifndef _STATES_H_
#define _STATES_H_

typedef enum {D,I} Det;

typedef struct {
	int	name;
	int	transition[255];
	char	*code;
	} *State,t_state;

typedef struct maillon{
	int state;
	struct maillon *next;
	} t_list,*List;

typedef struct {
	int 	name;
	List	transition[255];
	char	*code;
	} *Istate,t_istate;

typedef union{
	State   d;
        Istate  i;
	} Eta;

typedef struct {
	int 	size;
	Det	type;
	Eta	*etats;
	} *Machine,t_machine;



Machine newMachine(Det);
int newState(Machine,char*);
void newTrans(Machine,int,char,int);
List addDest(List,int);



#endif
