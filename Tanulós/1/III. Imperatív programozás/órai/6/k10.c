#include <stdio.h>

void smallerIndex(void* a,void* b){
    if(a < b){
        printf("Az első paraméter mutat kisebb indexű elemre.\n");
    }else if(a > b){
        printf("A második paraméter mutat kisebb indexű elemre.\n");
    }else{
        printf("Ugyanarra az indexű elemre mutatnak.\n");
    }
}

int main(){
    int arr[] = {1,2,3,4,5,6,7,8,9};
    smallerIndex(&arr[0],&arr[3]);
    smallerIndex(&arr[5],&arr[2]);
    smallerIndex(&arr[1],&arr[1]);
}