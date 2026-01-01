#ifndef SHAPES_H
#define SHAPES_H
#include "colors.h"


typedef struct {
    int x;
    int y;
} Point;


typedef struct {
    Point lt; 
    Point br;

    color_e color;
} Rectangle;


#endif