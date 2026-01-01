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

int parseValue(char* line){
    int length = 0;
    while(line[length] != '\0'){
        if(!isdigit(line[length])){
            printf("Hibás érték\n");
            return -1;
        }
        length++;
    }
    int value = atoi(line);
    return value;
}