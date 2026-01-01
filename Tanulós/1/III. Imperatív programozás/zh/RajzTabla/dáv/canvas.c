#include "canvas.h"
#include "color_helper.h"

#include <stdio.h>
#include <stdlib.h>

static inline size_t canvas_index(const Canvas *canvas, int x, int y)
{
    return (size_t)y * (size_t)canvas->width + (size_t)x;
}

int canvas_create(Canvas *canvas, int width, int height, color_e background_color)
{
    if (!canvas || width <= 0 || height <= 0) {
        return -1;
    }

    canvas->width = width;
    canvas->height = height;
    canvas->colors = NULL;

    canvas->colors = malloc(sizeof(color_e) * (size_t)width * (size_t)height);
    if (!canvas->colors) {
        return -1;
    }

    for (int i = 0; i < width * height; ++i) {
        canvas->colors[i] = background_color;
    }

    return 0;
}

int canvas_free(Canvas *canvas)
{
    if (!canvas) {
        return 0;
    }

    free(canvas->colors);
    free(canvas);

    return 0;
}

int canvas_print(Canvas *canvas)
{
    if (!canvas || !canvas->colors) {
        return -1;
    }

    for (int y = 0; y < canvas->height; ++y) {
        for (int x = 0; x < canvas->width; ++x) {
            color_e c = canvas->colors[canvas_index(canvas, x, y)];
            print_in_color(c);
        }
        printf("\n");
    }

    return 0;
}

int canvas_fill(Canvas *canvas, Rectangle *rectangle)
{
    if (!canvas || !rectangle || !canvas->colors) {
        return -1;
    }

    int left = rectangle->lt.x;
    int right =  rectangle->br.x;
    int top = rectangle->lt.y;
    int bottom = rectangle->br.y;

    if (left >= canvas->width || top >= canvas->height || right < 0 || bottom < 0) {
        return -1;
    }

    if (left < 0) left = 0;
    if (top < 0) top = 0;
    if (right >= canvas->width) right = canvas->width - 1;
    if (bottom >= canvas->height) bottom = canvas->height - 1;

    for (int y = top; y <= bottom; ++y) {
        for (int x = left; x <= right; ++x) {
            canvas->colors[canvas_index(canvas, x, y)] = rectangle->color;
        }
    }

    return 0;
}

int canvas_load_from_file(Canvas *canvas, const char *filename)
{
    if (!canvas || !filename) {
        return -1;
    }

    FILE *f = fopen(filename, "r");
    if (!f) {
        return -1;
    }

    int width = 0;
    int height = 0;
    char background[32];

    if (fscanf(f, "%d %d %31s", &width, &height, background) != 3) {
        fclose(f);
        return -1;
    }

    if (canvas_create(canvas, width, height, color_converter(background)) != 0) {
        fclose(f);
        return -1;
    }

    Rectangle rect = {0};
    char color_buf[32];

    while (fscanf(f, "%d %d %d %d %31s", &rect.lt.x, &rect.lt.y, &rect.br.x, &rect.br.y, color_buf) == 5) {
        rect.color = color_converter(color_buf);
        canvas_fill(canvas, &rect);
    }

    fclose(f);
    return 0;
}
