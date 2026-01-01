#ifndef BUS_H
#define BUS_H
#include <stdio.h>
#include <stdlib.h>
#include <ctype.h>

typedef struct Point
{
    int x;
    int y;
}Point;

typedef struct BusStop{
    char* name;
    Point cords;
}BusStop;

typedef struct City{
    BusStop** stops;
    int size;
}City;

void addBusStop(City* city,BusStop* bStop);
void freeCity(City* city);
void freeBusStop(BusStop* bStop);
void print_bus_stop(City* city);
City* create_bus_stop(City* city);
void delete_bus_stop(City* city);
#endif