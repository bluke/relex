#ifndef _AUTO_BUILD_H_
#define _AUTO_BUILD_H_
#include "tree.h"
#include "states.h"

Machine ruleImachine(Tree*);
void addRule(Machine,Tree);
int recRuling(Machine,int,Tree);

#endif
