#include <stdio.h>

int main(){
    const int numberToGuess = 15;
    int userGuess = 0;
    int numOfTries = 0;
    do
    {        
        printf("Do-while: ");
        scanf("%d",&userGuess);
        numOfTries++;
        printf("%s",userGuess < numberToGuess ? "Túl kicsi!\n" : 
            userGuess > numberToGuess ? "Túl nagy!\n" : "Telitalálat\n");
    } while (numberToGuess != userGuess);
    printf("%d próbálkozásból sikerült!\n",numOfTries);
    int switchCase = numOfTries == 1 ? 0 : 
        numOfTries > 1 && numOfTries < 5 ? 1 : 2;
        switch (switchCase)
        {
        case 0:
            printf("Nagyon ügyes\n");
            break;
        case 1: 
            printf("Ügyes\n");
            break;
        default:
        printf("Nem ügyes\n");
            break;
        }

}