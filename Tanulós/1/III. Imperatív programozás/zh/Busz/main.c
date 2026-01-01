#include <stdlib.h>
#include <stdio.h>
#include "file.h"
#include "bus.h"
#include "map.h"

void userSelection(City** city){
    int length = 0;
    char currentChar;
    char previousChar = '\0';
    char userInput = '\0';

    printf("1) Térkép\n");
    printf("2) Lista\n");
    printf("3) Új megálló\n");
    printf("4) Megálló törlés\n");
    printf("5) Mentés\n");
    printf("6) Betöltés\n");
    printf("7) Útvonal\n");
    printf("8) Kilépés\n");
    printf("Adja meg a választani kívánt menüt: ");

    while((currentChar = getchar()) != '\n'){
        length++;
        previousChar = currentChar;
    }
    if(length == 1){
        userInput = previousChar;
    }
    switch(userInput){
        case '1':
            show_map(city[0],NULL,NULL);
            break;
        case '2':
            print_bus_stop(city[0]);
            break;
        case '3':
            city[0] = create_bus_stop(city[0]);
            break;
        case '4':
            delete_bus_stop(city[0]);
            break;
        case '5':
            save_list(city[0]);
            break;
        case '6':
            freeCity(city[0]);
            city[0] = load_list();
            break;
        case '7':
            fastest_road(city[0]);
            break;
        case '8':
            freeCity(city[0]);
            city[0] = NULL;
            free(city);
            exit(0);
            break;
        default:
        printf("Hibás bemenet!\nKérem adja meg újra!\n");
            break;
    }
}


int main(){
    printf("Üdvözlöm\nEzzel a programmal különböző városok busz megállóit lehet számontartani és módosítani.\n");
    City** currentCity = malloc(sizeof(City**));
    if(currentCity == NULL){
        printf("Nem sikerült memóriát lefoglalni!");
        exit(1);
    }
    currentCity[0] = NULL;
    while(1){
        userSelection(currentCity);
    }
}