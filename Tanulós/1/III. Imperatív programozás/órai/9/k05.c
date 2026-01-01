#include "k05.h"

void k05(){
    char fileContent[MAX_FILE_LENGTH] = {0};
    FILE* file = fopen("k05.txt","r");
    if(!file){
        printf("Nem sikerült megnyitni a fájlt!");
        return;
    }
    fgets(fileContent,MAX_FILE_LENGTH,file);
    fclose(file);
    printf("%s\n",fileContent);
    int length = 0;
    while(fileContent[length] != '\0'){
        fileContent[length] = toupper(fileContent[length]);
        length++;
    }
    printf("%s\n",fileContent);
}