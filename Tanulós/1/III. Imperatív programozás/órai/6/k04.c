#include <stdio.h>
#define MAX_ARR 5

int sum(int* firstElem,int n){
    int sum = 0;
    for(int i = 0;i < n;i++){
        sum += *(firstElem + i);
    }
    return sum;
}

int main(){
    int arr[MAX_ARR] = {1,1,2,2,3}; 
    printf("sum = %d\n",sum(arr,MAX_ARR));
}