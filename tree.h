#ifndef TREE
#define TREE

#include <stdio.h>
#include <stdlib.h>
#include <string.h>
#include "struct.h"
#include "rules.h"

int empty(Tree);
Tree left(Tree);
Tree right(Tree);
Tree right(Tree);
int isfinal(Tree);
int leaf(Tree);
Type type(Tree);
char* content(Tree);
void show(Tree);
void print_type(Tree);
void short_show(Tree);
void print_space(int);
void tree_show(Tree, int);
Tree new(Type,char*);
void new_right_son(Tree, Type, char*);
void new_left_son(Tree, Type, char*);
void attach_left_son(Tree, Tree);
void attach_right_son(Tree, Tree);

#endif



