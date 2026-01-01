#include "k01.h"


char userInput[MAX_LENGTH] = {0};

void countCharacters(char* string){
    int count = 0;
    while (string[count] != '\0')
    {
        count++;
    }
    printf("A stringben %d db karakter található.\n",count);
}

void countWords(char* string){
    int wordCount = 0;
    int length = 0;
    while(string[length] == ' '){
        length++;
    }
    char previousCharacter = ' ';
    while (string[length] != '\0')
    {
        if((string[length] == ' ' || string[length] == '\n') && previousCharacter != ' '){
            wordCount++;
        }
        previousCharacter = string[length];
        length++;
    }
    printf("A stringben %d db szó található!\n",wordCount);
}

void readFromStd(){
    printf("Adja meg a vizsgálni kívánt szöveget:\n");
    fgets(userInput,MAX_LENGTH,stdin);
}

void k01(){
    readFromStd();
    countCharacters(userInput);
    countWords(userInput);
}