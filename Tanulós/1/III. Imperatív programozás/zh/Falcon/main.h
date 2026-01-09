#ifndef MAIN_H
#define MAIN_H

#include "falcon.h"
#include "keyboard_listener.h"
#include "terminal_draw.h"
#include "asteroid.h"

typedef struct {
    int width;
    int height;
} Screen;

int main();
void game_over(int width, int height);
int game_tick(Ship *falcon, Asteroids *asteroids, Screen *screen, Action *action);

#endif