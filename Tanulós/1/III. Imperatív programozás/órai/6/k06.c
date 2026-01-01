#include <stdio.h>
#define MAX_ARR 5

float avg(int* firstElem,int* lastElem){
    float sum = 0;
    int i = 0;
    while(firstElem+i != lastElem+1){
        sum += *(firstElem+i);
        i++;
    }
    return sum/i;
}

float avgDif(int* firstElem,int* lastElem){
    float sum = 0;
    int n = lastElem - firstElem + 1;
    for(int i = 0;i < n;i++){
        sum += *(firstElem + i);
    }
    return sum/n;
}

int main(){
    int arr[MAX_ARR] = {1,1,2,2,3}; 
    printf("sum = %f\n",avg(arr,&arr[MAX_ARR-1]));
    printf("sum = %f\n",avgDif(arr,&arr[MAX_ARR-1]));
}