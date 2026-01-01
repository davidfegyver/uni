#ifndef COLOR_HELPER_H
#define COLOR_HELPER_H
#include "colors.h"
#include <string.h>

static color_e color_converter(const char *color_str)
{
    if (strcmp(color_str, "black") == 0) {
        return COLOR_BLACK;
    } else if (strcmp(color_str, "blue") == 0) {
        return COLOR_BLUE;
    } else if (strcmp(color_str, "red") == 0) {
        return COLOR_RED;
    } else if (strcmp(color_str, "magenta") == 0) {
        return COLOR_MAGENTA;
    } else if (strcmp(color_str, "green") == 0) {
        return COLOR_GREEN;
    } else if (strcmp(color_str, "cyan") == 0) {
        return COLOR_CYAN;
    } else if (strcmp(color_str, "yellow") == 0) {
        return COLOR_YELLOW;
    } else if (strcmp(color_str, "white") == 0) {
        return COLOR_WHITE;
    } else {
        return COLOR_WHITE;
    }
}


#endif