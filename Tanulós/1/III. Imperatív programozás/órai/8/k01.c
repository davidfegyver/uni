#include <stdio.h>

int a;
int b = 10;


int main(){
    printf("a = %d\n",a);
    printf("b = %d\n",b);

    a = 123;
    b = 154;

    printf("a = %d\n",a);
    printf("b = %d\n",b);
}