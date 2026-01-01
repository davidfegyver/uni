#include "k02.h"

char previousUserInput[MAX_LENGTH] = {0};

void prepareStrings(){
    readFromStd();
    strcpy(previousUserInput,userInput);
    readFromStd();
}

void compareStrings(){
    int result = strcmp(userInput,previousUserInput);
    if(result > 0){
        printf("Az első előrébb van abc sorrendben!\n");
    }else if(result < 0){
        printf("Az második előrébb van abc sorrendben!\n");
    }else{
        printf("A két string megegyezik!\n");
    }
}

void k02(){
    prepareStrings();
    compareStrings();
}