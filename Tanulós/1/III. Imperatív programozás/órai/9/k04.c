#include "k04.h"

char charArray[] = "Test";
char* charPointer = "Test";

void switchArray(){
    charArray[1] = 'a';
    printf("%s\n",charArray);
}

void switchPointer(){
    *(charPointer+1) = 'a';
    printf("%s\n",charPointer);
}
void k04(){
    switchArray();
    switchPointer();
}