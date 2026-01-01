#include <stdio.h>
#include <stdlib.h>
#include <string.h>
#include "canvas.h"

color_e color_converter(const char *color_str) {
    if (strcmp(color_str, "black") == 0) return COLOR_BLACK;
    if (strcmp(color_str, "blue") == 0) return COLOR_BLUE;
    if (strcmp(color_str, "red") == 0) return COLOR_RED;
    if (strcmp(color_str, "magenta") == 0) return COLOR_MAGENTA;
    if (strcmp(color_str, "green") == 0) return COLOR_GREEN;
    if (strcmp(color_str, "cyan") == 0) return COLOR_CYAN;
    if (strcmp(color_str, "yellow") == 0) return COLOR_YELLOW;
    if (strcmp(color_str, "white") == 0) return COLOR_WHITE;
    
    return COLOR_WHITE; // Default fallback
}

canvas_t* canvas_create(int width, int height, color_e bg_color) {
    canvas_t *c = (canvas_t*)malloc(sizeof(canvas_t));
    if (!c) {
        perror("Failed to allocate canvas structure");
        exit(1);
    }

    c->width = width;
    c->height = height;
    
    c->pixels = (color_e*)malloc(width * height * sizeof(color_e));
    if (!c->pixels) {
        perror("Failed to allocate pixels");
        free(c);
        exit(1);
    }

    for (int i = 0; i < width * height; i++) {
        c->pixels[i] = bg_color;
    }

    return c;
}

void canvas_free(canvas_t *c) {
    if (c) {
        if (c->pixels) free(c->pixels);
        free(c);
    }
}

void canvas_print(const canvas_t *c) {
    terminal_clear(); 
    
    for (int y = 0; y < c->height; y++) {
        for (int x = 0; x < c->width; x++) {
            int index = y * c->width + x;
            print_in_color(c->pixels[index]); 
        }
        printf("\n"); 
    }
    printf("%s", COLOR_RESET);
}

void canvas_fill(canvas_t *c, rectangle_t rect) {
    int x_start = (rect.x1 < 0) ? 0 : rect.x1;
    int y_start = (rect.y1 < 0) ? 0 : rect.y1;
    int x_end = (rect.x2 >= c->width) ? c->width - 1 : rect.x2;
    int y_end = (rect.y2 >= c->height) ? c->height - 1 : rect.y2;

    for (int y = y_start; y <= y_end; y++) {
        for (int x = x_start; x <= x_end; x++) {
            c->pixels[y * c->width + x] = rect.color; 
        }
    }
}

canvas_t* canvas_load_from_file(const char *filename) {
    FILE *f = fopen(filename, "r");
    if (!f) {
        fprintf(stderr, "Error: Could not open file %s\n", filename);
        exit(1);
    }

    int width, height;
    char color_str[20];
    
    if (fscanf(f, "%d %d %s", &width, &height, color_str) != 3) {
        fprintf(stderr, "Error: Invalid file format in header.\n");
        fclose(f);
        exit(1);
    }

    canvas_t *c = canvas_create(width, height, color_converter(color_str));

    int x1, y1, x2, y2;
    while (fscanf(f, "%d %d %d %d %s", &x1, &y1, &x2, &y2, color_str) == 5) {
        rectangle_t rect;
        rect.x1 = x1;
        rect.y1 = y1;
        rect.x2 = x2;
        rect.y2 = y2;
        rect.color = color_converter(color_str);
        
        canvas_fill(c, rect);
    }

    fclose(f);
    return c;
}