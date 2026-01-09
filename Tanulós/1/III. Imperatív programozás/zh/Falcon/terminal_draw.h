#ifndef TERMINAL_DRAW_H
#define TERMINAL_DRAW_H

typedef enum Color {
    BLACK = 30,
    RED = 31,
    GREEN = 32,
    YELLOW = 33,
    BLUE = 34,
    MAGENTA = 35,
    CYAN = 36,
    WHITE = 37,
} Color;

#define NUM_COLORS 8

// Clears the terminal screen
void clear_screen();

// Gets terminal dimensions
void get_screen_size(int *width, int *height);

// Draws a character at specified coordinates
void draw_char(int x, int y, char c, Color color);

// Prints formatted text at specified coordinates
void print_at(int x, int y, const char* format, ...);

// Sleeps for a given number of milliseconds
void sleep_ms(int milliseconds);

#endif // TERMINAL_DRAW_H
