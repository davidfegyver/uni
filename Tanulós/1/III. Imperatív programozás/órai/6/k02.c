#include <stdio.h>

int main(){
    int a = 12;
    printf("a = %d\n",a);
    int* aPointer = &a;
    printf("&a = %p\n",(void*)aPointer);
    int** aPointerPointer = &aPointer;
    printf("&aPointer = %p\n",(void*)aPointerPointer);
    int b = 35;
    printf("b = %d\n",b);
    *(aPointerPointer) = &b;
    printf("&a = %p\n",(void*)aPointer);
    **(aPointerPointer) = 78;
    printf("a = %d\n",a);
    printf("b = %d\n",b);
}