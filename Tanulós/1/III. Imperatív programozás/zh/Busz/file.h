#ifndef FILE_H
#define FILE_H
#include "bus.h"
#include <stdlib.h>
#include <stdio.h>

City* load_list();
void save_list(City* city);

#endif