#include "my_utils.h"

void k08(){
    static int numOfCalls = 0;
    numOfCalls++;
    printf("%d\n",numOfCalls);
}

void swap(int* a,int* b){
    int tmp = *a;
    *a = *b;
    *b = tmp;
}

int* larger(int* a,int* b){
    if(*a > *b){
        return a;
    }else{
        return b;
    }
}