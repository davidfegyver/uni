#include <stdio.h>
#include <stdlib.h>
#include <time.h>

int dieRoll(){
    //int result = (rand() % 6) + 1;
    int result = rand();
    return result;
}

int main(){
    //srand(time(NULL));
    for(int i = 0;i < 10;i++){
        printf("%d\n",dieRoll());
    }
}