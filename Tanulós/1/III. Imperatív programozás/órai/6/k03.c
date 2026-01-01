#include <stdio.h>

int main(){
    int* aPointer = &aPointer;
    printf("&a = %p\n",(void*)aPointer);
    printf("&a = %p\n",(void*)&aPointer);
    printf("&a = %p\n",(void*)*aPointer);
    printf("sizeof(void*) = %d\n",sizeof(void*));
    printf("sizeof(int*) = %d\n",sizeof(int*));
    printf("sizeof(char*) = %d\n",sizeof(char*));
    printf("sizeof(float*) = %d\n",sizeof(float*));
    printf("sizeof(unsigned int*) = %d\n",sizeof(unsigned int*));
}