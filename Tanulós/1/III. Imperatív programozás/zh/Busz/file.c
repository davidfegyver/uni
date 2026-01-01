#include "file.h"
#include "input.h"

City* load_list(){
    printf("Adja meg a betölteni kívánt fájl nevét: ");
    char* userInput = readUserInput();
    if(userInput == NULL){
        return NULL;
    }
    FILE* file = fopen(userInput,"r");
    if(file == NULL){
        free(userInput);
        printf("Nem sikerült megnyitni a fájlt.\n");
        return NULL;
    }
    City* ret = malloc(sizeof(City));
    if(ret == NULL){
        printf("Nem sikerült memóriát lefoglalni!");
        exit(1);
    }
    ret->stops = NULL;
    ret->size = 0;
    BusStop* tmp = malloc(sizeof(BusStop));
    if(tmp == NULL){
        printf("Nem sikerült memóriát lefoglalni!");
        exit(1);
    }
    char* line = NULL;
    int numOfLines = 0;
    int length = 0;
    char currentChar;
    int partial = 0;
    while((currentChar = fgetc(file))!=EOF){
        if(currentChar == '\n'){
            line[length] = '\0';
            if(numOfLines%2==0){
                tmp->name = line;
                line = NULL;
                length = 0;
                partial = 1;
            }else{
                Point p = parseCoordinates(line);
                if(p.x == -1 || p.y == -1){
                    printf("Hibás a fájl tartalma!");
                    return NULL;
                }
                tmp->cords = p;
                if(p.x < 0 || p.x > 10 || p.y < 0 || p.y > 10){
                    free(line);
                    line = NULL;
                    length = 0;
                    freeBusStop(tmp);
                    tmp = malloc(sizeof(BusStop));
                    if(tmp == NULL){
                        printf("Nem sikerült memóriát lefoglalni!");
                        exit(1);
                    }
                    numOfLines++;
                    partial = 0;
                    continue;
                }
                addBusStop(ret,tmp);
                free(line);
                line = NULL;
                length = 0;
                free(tmp);
                tmp = malloc(sizeof(BusStop));
                if(tmp == NULL){
                    printf("Nem sikerült memóriát lefoglalni!");
                    exit(1);
                }
                partial = 0;
            }
            numOfLines++;
        }else{
            line = realloc(line,sizeof(char)*(length+2));
            if(line == NULL){
                printf("Nem sikerült memóriát lefoglalni!");
                exit(1);
            }
            line[length] = currentChar;
            length++;
        }
    }
    //Ha nincs új sor a fájl végén akkor külön felkell dolgozni az utolsó adatot.
    if(partial){
        line[length] = '\0';
        Point p = parseCoordinates(line);
        if(p.x == -1 || p.y == -1){
            printf("Hibás a fájl tartalma!");
            return NULL;
        }
        tmp->cords = p;
        if(p.x < 0 || p.x > 10 || p.y < 0 || p.y > 10){
            free(line);
            line = NULL;
            length = 0;
            freeBusStop(tmp);
            tmp = NULL;
        }
        addBusStop(ret,tmp);
        free(line);
        line = NULL;
    }
    

    free(line);
    free(userInput);
    free(tmp);
    fclose(file);
    return ret;
}

void save_list(City* city){
    if(city == NULL){
        printf("Nincs menthető lista\n");
        return;
    }else{
        if(city->size == 0){
            printf("Nincs menthető lista\n");
            return;
        }
    }
    printf("Adja meg a fájlnevét ahová menteni kívánja: ");
    char* fileName = readUserInput();
    FILE* file = fopen(fileName,"w");
    free(fileName);
    if(file == NULL){
        printf("Nem sikerült a fájl módosítása!");
        return;
    }
    for(int i = 0;i < city->size;i++){
        BusStop* currentStop = city->stops[i];
        fprintf(file,"%s\n",currentStop->name);
        if(i+1 == city->size){
            fprintf(file,"%d %d",currentStop->cords.x,currentStop->cords.y);
        }else{
            fprintf(file,"%d %d\n",currentStop->cords.x,currentStop->cords.y);
        }

    }
    fclose(file);
}