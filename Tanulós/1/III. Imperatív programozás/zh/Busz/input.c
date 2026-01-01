#include "input.h"

char* readUserInput(){
    char* userString = NULL;
    int length = 0;
    char currentChar;
    while((currentChar = getchar()) != '\n'){
        userString = realloc(userString,sizeof(char)*(length + 2));
        if(userString == NULL){
            printf("Nem sikerült memóriát lefoglalni!");
            exit(1);
        }
        userString[length] = currentChar;
        length++;
    }
    if(length > 0){
        userString[length] = '\0';
    }
    return userString;
}

Point parseCoordinates(char* line){
    Point ret = {-1, -1};
    char* token = strtok(line," ");
    if(!token){
        return ret;
    }
    int x = atoi(token);
    token = strtok(NULL," ");
    if(!token){
        return ret;
    }
    int y = atoi(token);
    ret.x = x;
    ret.y = y;
    return ret;
}

int parseIndex(char* line){
    int length = 0;
    while(line[length] != '\0'){
        if(!isdigit(line[length])){
            printf("Hibás index\n");
            return -1;
        }
        length++;
    }
    int index = atoi(line);
    return index;
}