#include "map.h"

void show_map(City* city,BusStop* src,BusStop* dst){
    if(city == NULL || city->size == 0){
        printf("Nincs megjeleníthető buszmegálló.\n");
        return;
    }
    printf(" ");
    for(int i = 1;i <= MAP_SIZE;i++){
        printf("%d ",i);
    }
    printf("\n");
    if(src != NULL && dst != NULL){
        if(src->cords.y > dst->cords.y){
            BusStop* tmp = src;
            src = dst;
            dst = tmp;
        }
    }
    for(int i = 'a';i < 'a' + MAP_SIZE;i++){
        printf("%c",i);
        char* line = malloc(sizeof(char)*(MAP_SIZE*2 + 1));
        for(int i = 0;i < MAP_SIZE*2;i++){
            line[i] = ' ';
        }
        line[MAP_SIZE * 2] = '\0';
        if(src != NULL && dst != NULL){
                if(i - 'a' + 1 > src->cords.y && i - 'a' + 1 < dst->cords.y){
                    //Függőleges
                    line[(src->cords.x - 1)*2] = '|';
                }
                if(i - 'a' + 1 == dst->cords.y){
                    //Kanyar
                    line[(src->cords.x - 1)*2] = 'X';
                }
                if(i - 'a' + 1 == dst->cords.y){
                    //Vízsintes
                    if(dst->cords.x < src->cords.x){
                        for(int i = dst->cords.x + 1;i < src->cords.x;i++){
                            line[(i-1)*2] = '-';
                        }
                    }else{
                        for(int i = src->cords.x + 1;i < dst->cords.x;i++){
                            line[(i-1)*2] = '-';
                        }
                    }
                    
                }
            }
        for(int k = 0;k < city->size;k++){
            BusStop* currentStop = city->stops[k];
            if(currentStop->cords.y == (i - 'a' + 1)){
                line[(currentStop->cords.x - 1) * 2] = 'B';
            }
        }
        printf("%s",line);
        printf("\n");
        free(line);
    }
}

void fastest_road(City* city){
    if(city == NULL || city->size < 2){
        printf("Nincs két kiválasztható buszmegálló.\n");
        return;
    }
    print_bus_stop(city);
    printf("Adja meg a kiinduló megállót: ");
    char* src = readUserInput();
    if(src == NULL){
        return;
    }
    int srcIndex = parseIndex(src);
    if(srcIndex < 0 || srcIndex > city->size){
        free(src);
        src = NULL;
        printf("Hibás index\n");
        return;
    }
    printf("Adja meg a cél megállót: ");
    char* dst = readUserInput();
    if(dst == NULL){
        return;
    }
    int dstIndex = parseIndex(dst);
    if(dstIndex < 0 || dstIndex > city->size){
        free(dst);
        dst = NULL;
        printf("Hibás index\n");
        return;
    }
    free(src);
    free(dst);
    show_map(city,city->stops[srcIndex-1],city->stops[dstIndex-1]);
}