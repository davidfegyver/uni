#ifndef INPUT_H
#define INPUT_H
#include <stdlib.h>
#include "bus.h"
#include <string.h>
char* readUserInput();
Point parseCoordinates(char* line);
int parseIndex(char* line);
#endif