#include "main.h"


int process_file_input(const char *filename)
{
    Canvas *canvas = malloc(sizeof(Canvas));
    if (!canvas) {
        return 1;
    }

    if (canvas_load_from_file(canvas, filename) != 0) {
        canvas_free(canvas);
        return 1;
    }

    canvas_print(canvas);
    canvas_free(canvas);

    return 0;
}

int process_create_args(int szelesseg, int magassag, color_e hatterszin)
{

    Canvas *canvas = malloc(sizeof(Canvas));
    if (!canvas) {
        return 1;
    }

    if (canvas_create(canvas, szelesseg, magassag, hatterszin) != 0) {
        canvas_free(canvas);
        return 1;
    }

    canvas_print(canvas);

    canvas_free(canvas);
    return 0;
}

int main(int argc, char *argv[])
{
    if (argc == 2)
    {
        return process_file_input(argv[1]);
    }
    else if (argc == 4)
        {
            
        int szelesseg = atoi(argv[1]);
        int magassag = atoi(argv[2]);
        color_e hatterszin = color_converter(argv[3]);

        return process_create_args(szelesseg,magassag,hatterszin);
    }
    else
    {
        printf("Használat:\n");
        printf("%s <szelesseg> <magassag> <hatterszin>\n", argv[0]);
        printf("vagy\n");
        printf("Használat: \n%s <fajlnev>\n", argv[0]);

        return 1;
    }
}
