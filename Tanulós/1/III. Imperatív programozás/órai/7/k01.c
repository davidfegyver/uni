#include <stdio.h>
#include <stdlib.h>
#include <ctype.h>
#define MAX_INPUT 300

int convertFromHex(char* hexString,int lengthOfString){
    int ret = 0;
    int remainder = 0;
    for(int i = 0;i <= lengthOfString - 1;i++){
        if(hexString[i] >= '0' && hexString[i] <= '9'){
            remainder = hexString[i] - '0';
        }else{
            remainder = hexString[i] - 87;
        }
        ret = ret * 16 + remainder;
        printf("%d\n",ret);
    }
    return ret;
}

int main(){
    int userInput[MAX_INPUT] = {0};
    int userInputCheck[MAX_INPUT] = {0};
    char currentNumber[MAX_INPUT] = {0};
    char currentChar;
    int lengthOfCurrentNumber = 0;
    int numberOfNumbers = 0;
    while((currentChar = getchar()) != EOF && (lengthOfCurrentNumber+1) < MAX_INPUT && numberOfNumbers < MAX_INPUT){
        currentChar = tolower(currentChar);
        if(currentChar >= '0' && currentChar <= '9'){
            currentNumber[lengthOfCurrentNumber++] = currentChar;
        }else if(currentChar >= 'a' && currentChar <= 'f'){
            currentNumber[lengthOfCurrentNumber++] = currentChar;
        }else if(currentChar == '\n'){
            currentNumber[lengthOfCurrentNumber] = '\0';
            userInputCheck[numberOfNumbers] = strtol(currentNumber,NULL,16);
            userInput[numberOfNumbers++] = convertFromHex(currentNumber,lengthOfCurrentNumber);
            for(int i = 0;i < lengthOfCurrentNumber + 1;i++){
                currentNumber[i] = 0;
            }
            lengthOfCurrentNumber = 0;
        }else{
            printf("Hibás bemenet a %d karakternél\n",lengthOfCurrentNumber + 1);
        }
    }
    for(int i = 0;i < numberOfNumbers;i++){
        printf("%d %d\n",userInput[i],userInputCheck[i]);
    }
}