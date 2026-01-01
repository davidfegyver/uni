#ifndef IMPERATIV_COLORS_HEADER__
#define IMPERATIV_COLORS_HEADER__

#include <stdio.h>

#define COLOR_ESCAPE "\33["

#define BACKGROUND_COLOR_BLACK   COLOR_ESCAPE "40m"
#define BACKGROUND_COLOR_RED     COLOR_ESCAPE "41m"
#define BACKGROUND_COLOR_GREEN   COLOR_ESCAPE "42m"
#define BACKGROUND_COLOR_YELLOW  COLOR_ESCAPE "43m"
#define BACKGROUND_COLOR_BLUE    COLOR_ESCAPE "44m"
#define BACKGROUND_COLOR_MAGENTA COLOR_ESCAPE "45m"
#define BACKGROUND_COLOR_CYAN    COLOR_ESCAPE "46m"
#define BACKGROUND_COLOR_WHITE   COLOR_ESCAPE "47m"

#define BACKGROUND_COLOR_DEFAULT BACKGROUND_COLOR_WHITE

#define COLOR_RESET  COLOR_ESCAPE "0m"

typedef enum color {
    COLOR_BLACK,
    COLOR_BLUE,
    COLOR_RED,
    COLOR_MAGENTA,
    COLOR_GREEN,
    COLOR_CYAN,
    COLOR_YELLOW,
    COLOR_WHITE
} color_e;

static const char*
color_e_to_color_escape_str(const color_e color)
{
    switch(color) {
        case COLOR_BLACK:    return BACKGROUND_COLOR_BLACK;
        case COLOR_BLUE:     return BACKGROUND_COLOR_BLUE;
        case COLOR_RED:      return BACKGROUND_COLOR_RED;
        case COLOR_MAGENTA:  return BACKGROUND_COLOR_MAGENTA;
        case COLOR_GREEN:    return BACKGROUND_COLOR_GREEN;
        case COLOR_CYAN:     return BACKGROUND_COLOR_CYAN;
        case COLOR_YELLOW:   return BACKGROUND_COLOR_YELLOW;
        case COLOR_WHITE:    return BACKGROUND_COLOR_WHITE;
    }
    return BACKGROUND_COLOR_DEFAULT;
}

static void print_in_color(const color_e color)
{
    const char *color_sequence = color_e_to_color_escape_str(color);
    printf("%s %s", color_sequence, COLOR_RESET);
}

static const char*
str_to(const color_e color)
{
    switch(color) {
        case COLOR_BLACK:    return BACKGROUND_COLOR_BLACK;
        case COLOR_BLUE:     return BACKGROUND_COLOR_BLUE;
        case COLOR_RED:      return BACKGROUND_COLOR_RED;
        case COLOR_MAGENTA:  return BACKGROUND_COLOR_MAGENTA;
        case COLOR_GREEN:    return BACKGROUND_COLOR_GREEN;
        case COLOR_CYAN:     return BACKGROUND_COLOR_CYAN;
        case COLOR_YELLOW:   return BACKGROUND_COLOR_YELLOW;
        case COLOR_WHITE:    return BACKGROUND_COLOR_WHITE;
    }
    return BACKGROUND_COLOR_DEFAULT;
}

static void terminal_clear()
{
#ifdef __WIN32__
    system("cls");
#else
    printf("\033[2J\033[H");
#endif
}

#endif //IMPERATIV_COLORS_HEADER__