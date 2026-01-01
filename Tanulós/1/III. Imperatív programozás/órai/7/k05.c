#include <stdio.h>
#include <ctype.h>
#define MAX_INPUT 300

int main(){
    char userInput[MAX_INPUT] = {0};
    char currentChar;
    int length = 0;
    while((currentChar = getchar()) != '\n' && (length+1) < MAX_INPUT){
        if(isdigit(currentChar)){
            userInput[length++] = currentChar;
        }else{
            printf("Hibás input\n");
            return 0;
        }
    }
    if(length >= 3){
        userInput[length] = '\0';
        printf("%s\n",userInput);
        char tmp = userInput[0];
        userInput[0] = userInput[length - 1];
        userInput[length - 1] = tmp;
        printf("%s\n",userInput);
    }else{
        printf("Túl rövid input\n");
    }
}