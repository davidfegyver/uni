#include "bus.h"
#include "input.h"

void addBusStop(City* city,BusStop* bStop){
    if(city == NULL || bStop == NULL){
        return;
    }
    BusStop* tmp = malloc(sizeof(BusStop));
    if(tmp == NULL){
        printf("Nem sikerült memóriát lefoglalni!");
        exit(1);
    }
    tmp->name = bStop->name;
    tmp->cords.x = bStop->cords.x;
    tmp->cords.y = bStop->cords.y;
    city->size++;
    city->stops = realloc(city->stops,sizeof(BusStop*) * city->size);
    if(city->stops == NULL){
        printf("Nem sikerült memóriát lefoglalni!");
        exit(1);
    }
    city->stops[city->size-1] = tmp;
}

void deleteBusStop(City* city,int index){
    if(city == NULL || index > city->size){
        return;
    }
    BusStop** newArray = malloc(sizeof(BusStop*)*(city->size-1));
    int i = 0;
    int k = 0;
    while (i < city->size)
    {
        if(i != index){

            newArray[k] = city->stops[i];
            k++;
        }else{
            freeBusStop(city->stops[i]);
        }
        i++;
    }
    city->size = k;
    free(city->stops);
    city->stops = newArray;
}

void print_bus_stop(City* city){
    if(city == NULL || city->size == 0){
        printf("Nincs megjeleníthető buszmegálló.\n");
        return;
    }
    for(int i = 0;i < city->size;i++){
        BusStop* currentStop = city->stops[i];
        printf("%d. %s (%d, %d)\n",i+1,currentStop->name,currentStop->cords.x,currentStop->cords.y);
    }
}

City* create_bus_stop(City* city){
    if(city == NULL){
        city = malloc(sizeof(City));
        if(city == NULL){
            printf("Nem sikerült memóriát lefoglalni!");
            exit(1);
        }
    }
    printf("Adja meg az új megálló nevét: ");
    char* stopName = readUserInput();
    printf("Adja meg az új megálló koordinátáit(pl.3 5): ");
    char* coordinates = readUserInput();
    if(coordinates == NULL){
        return city;
    }
    Point p = parseCoordinates(coordinates);
    while(p.x < 0 || p.x > 10 || p.y < 0 || p.y > 10){
        free(coordinates);
        printf("Hibás koordinátákat adott meg!\n");
        printf("Adja meg az új megálló koordinátáit(pl.3 5): ");
        coordinates = readUserInput();
        p = parseCoordinates(coordinates);
    }
    BusStop* newStop = malloc(sizeof(BusStop));
    newStop->name = stopName;
    newStop->cords = p;
    addBusStop(city,newStop);
    free(coordinates);
    free(newStop);
    return city;
}

void delete_bus_stop(City* city){
    if(city == NULL){
        printf("Nincs aktuálisan betöltött város.\n");
        return;
    }else{
        if(city->size == 0){
            printf("Nincs törölhető buszmegálló!\n");
            return;
        }
    }
    print_bus_stop(city);
    printf("Adja meg a törölni kívánt buszmegálló sorszámát: ");
    char* userInput = readUserInput();
    if(userInput == NULL){
        return;
    }
    int index = parseIndex(userInput);
    free(userInput);
    userInput = NULL;
    if(index == -1){
        return;
    }
    if(index > city->size+1){
        printf("Hibás index\n");
        return;
    }
    deleteBusStop(city,index-1);
}

void freeBusStop(BusStop* bStop){
    if(bStop == NULL){
        return;
    }
    free(bStop->name);
    free(bStop);
}

void freeCity(City* city){
    if(city == NULL){
        return;
    }
    for(int i = 0;i < city->size;i++){
        freeBusStop(city->stops[i]);
    }
    free(city->stops);
    free(city);
}