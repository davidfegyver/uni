#include <stdio.h>
#include <stdlib.h>
#include "canvas.h"

int main(int argc, char *argv[]) {
    canvas_t *my_canvas = NULL;

    if (argc == 2) {
        printf("Loading from file: %s...\n", argv[1]);
        my_canvas = canvas_load_from_file(argv[1]);
    } 

    else if (argc == 4) {
        int w = atoi(argv[1]);
        int h = atoi(argv[2]);
        color_e bg = color_converter(argv[3]);
        
        if (w <= 0 || h <= 0) {
            fprintf(stderr, "Error: Dimensions must be positive integers.\n");
            return 1;
        }

        my_canvas = canvas_create(w, h, bg);
    } 
    else {
        fprintf(stderr, "Error: Invalid arguments.\n");
        fprintf(stderr, "Usage Mode 1 (File): %s <filename>\n", argv[0]);
        fprintf(stderr, "Usage Mode 2 (Manual): %s <width> <height> <color>\n", argv[0]);
        return 1;
    }

    if (my_canvas) {
        canvas_print(my_canvas);
        canvas_free(my_canvas);
    }

    return 0;
}