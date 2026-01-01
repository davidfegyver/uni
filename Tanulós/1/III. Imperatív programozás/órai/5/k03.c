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
    for(int i = 0;i < ARRAY_LENGTH;i++){
        arr[i] = getRandom(50);
        printf("%d\n",arr[i]);
    }
    int max = arr[0];
    for(int i = 1;i < ARRAY_LENGTH;i++){
        if(max < arr[i]){
            max = arr[i];
        }
    }
    printf("Max: %d\n",max);

}