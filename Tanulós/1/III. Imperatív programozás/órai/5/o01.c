#include <stdio.h>
#include <stdlib.h>
#include <time.h>

int getRandom(int max){
    return rand() % max;
}

int main(){
    srand(time(NULL));
    const int arrayLength = 10;
    int numbers[arrayLength];

    for(int i = 0; i < arrayLength;i++){
        numbers[i] = getRandom(20);
        printf("%d\n",numbers[i]);
    }

    int max = numbers[0];
    int min = numbers[0];
    int maxIndex = 0;
    int minIndex = 0;
    for(int i = 1;i < arrayLength;i++){
        if(numbers[i] < min){
            min = numbers[i];
            minIndex = i;
        }
        if(numbers[i] > max){
            max = numbers[i];
            maxIndex = i;
        }
    }
    numbers[maxIndex] = min;
    numbers[minIndex] = max;
    printf("Min/Max megcserélva\n");
    for(int i = 0; i < arrayLength;i++){
        printf("%d\n",numbers[i]);
    }

}