#include <stdio.h>
#include <stdlib.h>
#include <time.h>
#define ARRAY_LENGTH 100

float getRandomFloat(int max){
    return ((float)rand()/(float)RAND_MAX) * (float)max;
}

void fillArray(float* arr,int length){
    for(int i = 0;i < length;i++){
        arr[i] = getRandomFloat(100);
    }
}

int main(){
    srand(time(NULL));
    float array[ARRAY_LENGTH] = {0};
    int length = sizeof(array)/sizeof(array[0]);
    fillArray(array,length);
    int db = 0;
    for(int i = 0;i < length;i++){
        if(array[i] > 50.0f){
            db++;
        }
    }
    printf("%d db elem nagyobb 50-nél\n",db);
}