#include <stdio.h>

int main(){
    int a = 12;
    printf("a = %d\n",a);
    int* aPointer = &a;
    printf("&a = %p\n",(void*)aPointer);
    *(aPointer) = 24;
    printf("a = %d\n",a);
    printf("&a = %p\n",(void*)aPointer);
}