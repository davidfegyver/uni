#include "k06.h"

void k06(){
    char fileContent[MAX_FILE_LENGTH] = {0};
    FILE* file = fopen("k05.txt","r");
    FILE* outputFile = fopen("k06.txt","w");
    if(!file){
        printf("Nem sikerült megnyitni a fájlt!");
        return;
    }
    if(!outputFile){
        printf("Nem sikerült megnyitni a fájlt!");
        return;
    }
    while(fgets(fileContent,MAX_FILE_LENGTH,file) != NULL){
        int length = 0;
        while(fileContent[length] != '\0'){
            fileContent[length] = toupper(fileContent[length]);
            length++;
        }
        fprintf(outputFile,"%s",fileContent);
    }
    fclose(file);
    fclose(outputFile);
}