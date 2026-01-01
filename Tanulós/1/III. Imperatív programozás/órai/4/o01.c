#include <stdio.h>

int main(){
    const int numberToGuess = 15;
    int userGuess = 0;
    do
    {        
        printf("Do-while: ");
        scanf("%d",&userGuess);
        printf("%s",userGuess < numberToGuess ? "Túl kicsi!\n" : 
            userGuess > numberToGuess ? "Túl nagy!\n" : "Telitalálat\n");
    } while (numberToGuess != userGuess);
    userGuess = 0;
    for(;;){
        printf("For: ");
        scanf("%d",&userGuess);
        if(userGuess < numberToGuess){
            printf("Túl kicsi\n");
        }else if(userGuess > numberToGuess){
            printf("Túl nagy\n");
        }else{
            printf("Telitalálat!\n");
            break;
        }
    }
    userGuess = 0;
    while(numberToGuess != userGuess){
        printf("While: ");
        scanf("%d",&userGuess);
        if(userGuess < numberToGuess){
            printf("Túl kicsi\n");
        }else if(userGuess > numberToGuess){
            printf("Túl nagy\n");
        }else{
            printf("Telitalálat!\n");
        }
    }
}