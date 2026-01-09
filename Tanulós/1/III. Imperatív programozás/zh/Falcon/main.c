#include "asteroid.h"
#include "constants.h"
#include "time.h"
#include <stdio.h>
#include <stdlib.h>
#include <string.h>
#include "main.h"

int main()
{
    srand(time(NULL));

    Action *action = malloc(sizeof(Action));

    if (action == NULL)
    {
        puts("Failed to allocate memory for action");
        return 1;
    }

    start_keyboard_listener_async(action);

    Screen screen;
    get_screen_size(&screen.width, &screen.height);

    Ship falcon = {{(screen.width - 5) / 2, screen.height}};
    Asteroids *asteroids = malloc(sizeof(Asteroids));

    if (asteroids == NULL)
    {
        puts("Failed to allocate memory for asteroids");
        free(action);
        return 1;
    }

    init_asteroids(asteroids, ASTEROIDS_INIT_CAPACITY);
    if (asteroids->data == NULL)
    {
        puts("Failed to allocate memory for asteroids->data");

        free(action);
        free(asteroids);
        return 1;
    }

    while (1)
    {
        if (game_tick(&falcon, asteroids, &screen, action))
            break;
        sleep_ms(MAIN_SLEEP_TIME);
    }
    game_over(screen.width, screen.height);
    destroy_asteroids(asteroids);
    free(action);

    return 0;
}

void game_over(int width, int height)
{
    char *out_str = {GAME_OVER_STR};
    int out_x = (width - strlen(out_str)) / 2;
    int out_y = height / 2;
    print_at(out_x, out_y, out_str);
}

int game_tick(Ship *falcon, Asteroids *asteroids, Screen *screen, Action *action)
{
    if (*action == QUIT)
        return 1;

    clear_screen();
    move_ship(falcon, action, screen->width);

    *action = None;
    draw_mfalcon(falcon);

    move_draw_asteroids(asteroids, screen->height);
    update_asteroids(asteroids, screen->width);

    if (check_collison(asteroids, falcon))
        return 1;
    return 0;
}