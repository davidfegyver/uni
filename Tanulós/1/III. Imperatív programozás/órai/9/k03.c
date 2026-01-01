#include "k03.h"

void k03(){
    prepareStrings();
    char newUserString[MAX_LENGTH] = {0};
    strcpy(newUserString,userInput);
    printf("%s",newUserString);
}