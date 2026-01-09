#include <stdio.h>
#include <stdlib.h>
#include <stdarg.h>
#include "terminal_draw.h"

#ifdef _WIN32
    #include <windows.h>
    #include <conio.h>
#else
    #include <unistd.h>
    #include <termios.h>
    #include <sys/ioctl.h>
#endif

#define NUM_COLORS 8

// Clears the terminal screen
void clear_screen() {
    #ifdef _WIN32
        system("cls");
    #else
        printf("\033[2J\033[H");
        fflush(stdout);
    #endif
}

// Gets terminal dimensions
void get_screen_size(int *width, int *height) {
    #ifdef _WIN32
        CONSOLE_SCREEN_BUFFER_INFO csbi;
        GetConsoleScreenBufferInfo(GetStdHandle(STD_OUTPUT_HANDLE), &csbi);
        *width = csbi.srWindow.Right - csbi.srWindow.Left + 1;
        *height = csbi.srWindow.Bottom - csbi.srWindow.Top + 1;
    #else
        struct winsize w;
        ioctl(STDOUT_FILENO, TIOCGWINSZ, &w);
        *width = w.ws_col;
        *height = w.ws_row;
    #endif
}

// Draws a character at specified coordinates
void draw_char(int x, int y, char c, Color color) {
    #ifdef _WIN32
        HANDLE hConsole = GetStdHandle(STD_OUTPUT_HANDLE);
        COORD pos = {(SHORT)(x), (SHORT)(y)};
        SetConsoleCursorPosition(hConsole, pos);
        
        // Convert ANSI color to Windows color
        WORD winColor;
        switch(color) {
            case BLACK: winColor = 0; break;
            case RED: winColor = FOREGROUND_RED; break;
            case GREEN: winColor = FOREGROUND_GREEN; break;
            case YELLOW: winColor = FOREGROUND_RED | FOREGROUND_GREEN; break;
            case BLUE: winColor = FOREGROUND_BLUE; break;
            case MAGENTA: winColor = FOREGROUND_RED | FOREGROUND_BLUE; break;
            case CYAN: winColor = FOREGROUND_BLUE | FOREGROUND_GREEN; break;
            case WHITE: winColor = FOREGROUND_RED | FOREGROUND_GREEN | FOREGROUND_BLUE; break;
            default: winColor = FOREGROUND_RED | FOREGROUND_GREEN | FOREGROUND_BLUE;
        }
        SetConsoleTextAttribute(hConsole, winColor);
        putchar(c);
        SetConsoleTextAttribute(hConsole, FOREGROUND_RED | FOREGROUND_GREEN | FOREGROUND_BLUE);
    #else
        printf("\033[%d;%dH\033[0;%dm%c\033[H", y + 1, x + 1, color, c);
        fflush(stdout);
    #endif
}

// Prints formatted text at specified coordinates
void print_at(int x, int y, const char* format, ...) {
    va_list args;
    va_start(args, format);
    
    #ifdef _WIN32
        HANDLE hConsole = GetStdHandle(STD_OUTPUT_HANDLE);
        COORD pos = {(SHORT)(x), (SHORT)(y)};
        SetConsoleCursorPosition(hConsole, pos);
        vprintf(format, args);
        // Return cursor to home position
        SetConsoleCursorPosition(hConsole, (COORD){0, 0});
    #else
        // Move cursor to position
        printf("\033[%d;%dH", y + 1, x + 1);
        vprintf(format, args);
        // Return cursor to home position
        printf("\033[H");
        fflush(stdout);
    #endif
    
    va_end(args);
}

// Sleeps for a given number of milliseconds
void sleep_ms(int milliseconds) {
    #ifdef _WIN32
        Sleep(milliseconds);
    #else
        usleep(milliseconds * 1000);
    #endif
}
