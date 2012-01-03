#ifndef _FSMP_H_
#define _FSMP_H_
#include "states.h"
#include <stdio.h>

void fsmp(Machine,FILE *fd);
void printState(Eta,Det,FILE *fd);
void printList(List,FILE *fd);

#endif
