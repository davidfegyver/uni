#include <stdio.h>
#define MAX_STRING 300
int main(){
    char userString[MAX_STRING] = {0};
    int lines = 1;
    printf("Adjon meg egy szöveget: ");
    int i = 0;
    char currentChar;
    while((currentChar = getchar()) != EOF && (i+1) < MAX_STRING){
        userString[i] = currentChar;
        i++;
    }
    userString[i] = '\0';
    if(i == 0){
        printf("Nem adott meg szöveget!\n");
        return 0;
    }

    for(int j = 0;j < i;j++){
        if(userString[j] == '\n'){
            lines++;
        }
    }

    printf("A szövegben %d sor van.\n",lines);
}