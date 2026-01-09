#include "asteroid.h"
#include "constants.h"
#include <stdlib.h>
#include "terminal_draw.h"


void init_asteroids(Asteroids *asteroids, int init_count)
{
    asteroids->capacity = init_count;
    asteroids->count = 0;
    asteroids->data = malloc(sizeof(Asteroid) * asteroids->capacity);
}

void destroy_asteroids(Asteroids *asteroids)
{
    free(asteroids->data);
    asteroids->capacity = 0;
    asteroids->count = 0;

    free(asteroids);
}
void move_draw_asteroids(Asteroids *asteroids, int screen_height)
{
    for (int i = 0; i < asteroids->count; ++i)
    {
        if (asteroids->data[i].speed > 0)
        {
            asteroids->data[i].position.y+= asteroids->data[i].speed;

            if (asteroids->data[i].position.y > screen_height)
            {
                asteroids->data[i].speed = 0;
            }
            else
            {
                draw_char(asteroids->data[i].position.x, asteroids->data[i].position.y, asteroids->data[i].symbol, RED);
            }
        }
    }
}
void update_asteroids(Asteroids *asteroids, int screen_width)
{
    if (rand() % 100 > NEW_ASTEROID_PERCENT)
        return;

    Asteroid new_asteroid = {{rand() % screen_width, 0}, ASTEROID_SPEED, ASTEROID_SYMBOL};
    for (int i = 0; i < asteroids->count; ++i)
    {
        if (asteroids->data[i].speed == 0)
        {
            asteroids->data[i] = new_asteroid;
            return;
        }
    }

    if (asteroids->count == asteroids->capacity && asteroids->capacity <= (ASTEROIDS_MAX_COUNT - ASTEROIDS_NEW_COUNT))
    {
        asteroids->capacity += ASTEROIDS_NEW_COUNT;

        asteroids->data = realloc(asteroids->data, sizeof(Asteroid) * asteroids->capacity);
    }

    asteroids->data[asteroids->count++] = new_asteroid;
}

int check_collison(Asteroids *asteroids, Ship *ship)
{
    int sx = ship->position.x;
    int sy = ship->position.y;

    for (int i = 0; i < asteroids->count; ++i)
    {
        int ax = asteroids->data[i].position.x;
        int ay = asteroids->data[i].position.y;
        
        if (ax >= sx  && ax < sx + 5 && ay > sy - 5 && ay < sy)
        {
            return 1;
        }
    }

    return 0;
}
