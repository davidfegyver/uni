#include <stdio.h>
#include <stdlib.h>
#include <time.h>
#define ARRAY_LENGTH 10

int getRandom(int max){
    return rand() % max;
}

int main(){
    srand(time(NULL));
    const int randMax = 50;
    int arr[ARRAY_LENGTH];
    for(int i = 0;i < ARRAY_LENGTH;i++){
        arr[i] = getRandom(randMax);
        printf("%d\n",arr[i]);
    }
    int min = randMax;
    int minSecond = randMax;
    //vagy limits.h-t használva
    //int min = INT_MAX;
    //int minSecond = INT_MAX;
    for(int i = 0;i < ARRAY_LENGTH;i++){
        if(min > arr[i]){
            minSecond = min;
            min = arr[i];
        }else if(minSecond > arr[i] && min != arr[i]){
            minSecond = arr[i];
        }
    }
    printf("Min: %d\n",min);
    printf("Min second: %d\n",minSecond);
}