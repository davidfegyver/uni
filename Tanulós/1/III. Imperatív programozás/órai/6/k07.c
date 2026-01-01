#include <stdio.h>

int* foo(){
    int a = 23;
    return &a;
}

int main(){
    int* localPointer = foo();
    printf("a = %d\n",*localPointer);
}