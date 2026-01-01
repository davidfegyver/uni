#ifndef CANVAS_H
#define CANVAS_H

#include "colors.h"

typedef struct {
    int x1, y1;
    int x2, y2;
    color_e color;
} rectangle_t;

typedef struct {
    int width;
    int height;
    color_e *pixels; 
} canvas_t;

canvas_t* canvas_create(int width, int height, color_e bg_color);
void canvas_free(canvas_t *c);
void canvas_print(const canvas_t *c);
void canvas_fill(canvas_t *c, rectangle_t rect);

color_e color_converter(const char *color_str); 
canvas_t* canvas_load_from_file(const char *filename);

#endif // CANVAS_H