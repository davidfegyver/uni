#ifndef ASTEROID_H
#define ASTEROID_H

#include "falcon.h"

typedef struct {
    struct {
        int x;
        int y;
    } position;
    int speed;
    char symbol;
} Asteroid;

typedef struct {
    Asteroid* data;
    int count;
    int capacity;
} Asteroids;

void init_asteroids(Asteroids* asteroids, int init_count);
void destroy_asteroids(Asteroids* asteroids);
void move_draw_asteroids(Asteroids* asteroids, int screen_width);
void update_asteroids(Asteroids* asteroids, int screen_height);

int check_collison(Asteroids* asteroids, Ship* ship);

#endif // ASTEROID_H