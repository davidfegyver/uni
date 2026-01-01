#include <stdio.h>
#include <stdlib.h>
#include <time.h>

int main(){
    int numberToGuess = 0;
    srand(time(NULL));
    int difficulty = 0;
    while (difficulty <= 0 || difficulty > 3)
    {
        printf("Adja meg a nehézségi szintet(1,2,3):");
        scanf("%d",&difficulty);
    }
    switch (difficulty)
    {
    case 1:
        numberToGuess = (rand() % 10) + 1;
        break;
    case 2:
        numberToGuess = (rand() % 100) + 1;
        break;
    default:
        numberToGuess = (rand() % 10000) + 1;
        break;
    }
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