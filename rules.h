#ifndef RULES
#define RULES

#include "struct.h"
#include "tree.h"

Tree new_intervalle(char*, char*);
void new_family(Tree, Tree , Tree);
Tree new_union(Tree, Tree , Type);

#endif
