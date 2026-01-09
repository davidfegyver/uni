#ifndef MILLENIUM_FALCON_H
#define MILLENIUM_FALCON_H

#include "keyboard_listener.h"

typedef struct
{
    struct
    {
        int x;
        int const y;
    } position;
} Ship;

void draw_mfalcon(Ship * falcon);
void move_ship(Ship * falcon, Action * action, int screen_width);

#endif // MILLENIUM_FALCON_H
