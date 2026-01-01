#ifndef CANVAS_H
#define CANVAS_H

#include "colors.h"
#include "shapes.h"


typedef struct {
    int width; 
    int height;

    color_e *colors;
} Canvas;

int canvas_create(Canvas *canvas, int width, int height, color_e background_color);

int canvas_free(Canvas *canvas);

int canvas_print(Canvas *canvas);

int canvas_fill(Canvas *canvas, Rectangle *rectangle);

int canvas_load_from_file(Canvas *canvas, const char *filename);

#endif