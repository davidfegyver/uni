#include "keyboard_listener.h"
#include "terminal_draw.h"
#include <pthread.h>

#ifdef _WIN32
    #include <windows.h>
    #include <conio.h>
#else
    #include <termios.h>
    #include <stdio.h>
    static struct termios old, current;

    /* Initialize new terminal i/o settings */
    void initTermios(int echo) 
    {
        tcgetattr(0, &old); /* grab old terminal i/o settings */
        current = old; /* make new settings same as old settings */
        current.c_lflag &= ~ICANON; /* disable buffered i/o */
        if (echo) {
            current.c_lflag |= ECHO; /* set echo mode */
        } else {
            current.c_lflag &= ~ECHO; /* set no echo mode */
        }
        tcsetattr(0, TCSANOW, &current); /* use these new terminal i/o settings now */
    }

    /* Restore old terminal i/o settings */
    void resetTermios(void) 
    {
        tcsetattr(0, TCSANOW, &old);
    }

    /* Read 1 character - echo defines echo mode */
    char getch(void)
    {
        char ch;
        initTermios(0);
        ch = getchar();
        resetTermios();
        return ch;
    }
#endif

void * readchar(void * c)
{
    do
    {
        char tmp = getch();
        if(tmp == MoveLeft || tmp == MoveRight || tmp == Shoot || tmp == QUIT)
            *(Action*)c = (Action)tmp;
        else
            *(Action*)c = None;
        sleep_ms(10);
    } while( *(char*)c != QUIT );
    return NULL;
}

void start_keyboard_listener_async(Action * c)
{
    #ifdef _WN32
        DWORD threadid; 
        HANDLE thread = CreateThread(NULL, 0, (void*)readchar, c, 0, &threadid); 
    #else
        pthread_t thread;
        pthread_create(&thread, NULL, readchar, c);
    #endif
}
