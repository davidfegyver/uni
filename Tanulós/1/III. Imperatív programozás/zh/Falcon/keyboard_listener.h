#ifndef KEYBOARD_LISTENER_H
#define KEYBOARD_LISTENER_H

#define QUIT 'q'

typedef enum
{
    MoveLeft = 'a',
    MoveRight = 'd',
    Shoot = ' ',
    None = '\0'
} Action;

void start_keyboard_listener_async(Action * c);

#endif // KEYBOARD_LISTENER_H