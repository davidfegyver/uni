#include "falcon.h"
#include "terminal_draw.h"
#include "constants.h"

#include <time.h>
#include <stdlib.h>

void draw_mfalcon(Ship * falcon)
{
    char thrust = (rand() % 2 == 0 ) ? 94 : 'A';
    Color thrustcolor = (rand() % 2 == 0 ) ? YELLOW : RED;

    draw_char(falcon->position.x + 1, falcon->position.y - 4, '/', BLUE);
    draw_char(falcon->position.x + 2, falcon->position.y - 4, 'H', BLUE);
    draw_char(falcon->position.x + 3, falcon->position.y - 4, '\\', BLUE);

    draw_char(falcon->position.x + 2, falcon->position.y - 3, 'O', BLUE);

    draw_char(falcon->position.x, falcon->position.y - 3, '/', BLUE);
    draw_char(falcon->position.x + 4, falcon->position.y - 3, '\\', BLUE);

    draw_char(falcon->position.x, falcon->position.y - 2, '\\', BLUE);
    draw_char(falcon->position.x + 4, falcon->position.y - 2, '/', BLUE);
    draw_char(falcon->position.x + 1, falcon->position.y - 2, '_', BLUE);
    draw_char(falcon->position.x + 2, falcon->position.y - 2, '_', BLUE);
    draw_char(falcon->position.x + 3, falcon->position.y - 2, '_', BLUE);

    draw_char(falcon->position.x + 1, falcon->position.y - 1, thrust, thrustcolor);
    draw_char(falcon->position.x + 3, falcon->position.y - 1, thrust, thrustcolor);
}

void move_ship(Ship * falcon, Action * action, int screen_width){
    if(*action == MoveLeft && falcon->position.x > 0){
        falcon->position.x-= SHIP_SPEED;
    } else if (*action == MoveRight && falcon->position.x < screen_width - 5){
        falcon->position.x+= SHIP_SPEED;
    }
}