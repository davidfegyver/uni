#ifndef MAP_H
#define MAP_H
#define MAP_SIZE 10
#include "bus.h"
#include "input.h"

void show_map(City* city,BusStop* src,BusStop* dst);
void fastest_road(City* city);
#endif