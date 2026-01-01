#include <stdio.h>
#include <stdlib.h>
#include <time.h>
#define ARRAY_LENGTH 10

int getRandom(int max){
    return rand() % max;
}

int main(){
    srand(time(NULL));
    int arr[ARRAY_LENGTH];
    int weights[ARRAY_LENGTH];
    for(int i = 0;i < ARRAY_LENGTH;i++){
        arr[i] = getRandom(5);
        weights[i] = getRandom(10);
        printf("%d * %d\n",weights[i],arr[i]);
    }
    int sum = 0;
    for(int i = 0;i < ARRAY_LENGTH;i++){
        sum += arr[i] * weights[i];
    }
    printf("Sum: %d\n",sum);

}