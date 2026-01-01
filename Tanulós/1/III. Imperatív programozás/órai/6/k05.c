#include <stdio.h>
#define MAX_ARR 5

int sum(int* firstElem,int* lastElem){
    int sum = 0;
    int i = 0;
    while(firstElem+i != lastElem+1){
        sum += *(firstElem+i);
        i++;
    }
    return sum;
}

int sumDif(int* firstElem,int* lastElem){
    int sum = 0;
    int n = lastElem - firstElem + 1;
    for(int i = 0;i < n;i++){
        sum += *(firstElem + i);
    }
    return sum;
}

int main(){
    int arr[MAX_ARR] = {1,1,2,2,3}; 
    printf("sum = %d\n",sum(arr,&arr[MAX_ARR-1]));
    printf("sum = %d\n",sumDif(arr,&arr[MAX_ARR-1]));
}