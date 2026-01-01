#include <stdio.h>
#include <stdlib.h>
#include <time.h>

//return miatt elhagyható a break;
int get_target(int difficulty){
switch (difficulty)
    {
    case 1:
        return (rand() % 10) + 1;
    case 2:
        return (rand() % 100) + 1;
    default:
        return (rand() % 10000) + 1;
    }
}

int guessing(){
    int ret = 0;
    printf("Adjon meg egy számot: ");
    scanf("%d",&ret);
    return ret;
}

void evaluate(int userGuess,int numberToGuess){
if(userGuess < numberToGuess){
            printf("Túl kicsi\n");
        }else if(userGuess > numberToGuess){
            printf("Túl nagy\n");
        }else{
            printf("Telitalálat!\n");
        }
}

int main(){
    srand(time(NULL));
    int difficulty = 0;
    while (difficulty <= 0 || difficulty > 3)
    {
        printf("Adja meg a nehézségi szintet(1,2,3):");
        scanf("%d",&difficulty);
    }
    int numberToGuess = get_target(difficulty);
    int userGuess = 0;
    int numOfTries = 0;
    do
    {
        userGuess = guessing();
        numOfTries++;
        evaluate(userGuess,numberToGuess);
    } while (numberToGuess != userGuess);
    printf("%d próbálkozásból sikerült\n",numOfTries);
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