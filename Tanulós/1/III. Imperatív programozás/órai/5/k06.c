#include <stdio.h>
#include <stdlib.h>
#include <time.h>
#define ARRAY_LENGTH 10

int getRandom(int max){
    return rand() % max;
}

float getRandomFloat(int max){
    return ((float)rand()/(float)RAND_MAX) * (float)max;
}

int main(){
    srand(time(NULL));
    int arr[ARRAY_LENGTH];
    float weights[ARRAY_LENGTH];
    for(int i = 0;i < ARRAY_LENGTH;i++){
        arr[i] = getRandom(5);
        weights[i] = getRandomFloat(10);
        printf("%.2f * %d\n",weights[i],arr[i]);
    }
    float sum = 0;
    for(int i = 0;i < ARRAY_LENGTH;i++){
        sum += arr[i] * weights[i];
    }
    printf("Sum: %.2f\n",sum);
    printf("Avg: %.2f\n",sum / ARRAY_LENGTH);

}