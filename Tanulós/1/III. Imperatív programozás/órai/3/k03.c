#include <stdio.h>
#include <stdlib.h>

int main(){
    char input[10];
    fgets(input,10,stdin);
    int a = atoi(input);
    fgets(input,10,stdin);
    int b = atoi(input);
    printf("+a = %d\n",+a);
    printf("-a = %d\n",-a);
    printf("a + b = %d\n", a + b);
    printf("a - b = %d\n", a - b);
    printf("a * b = %d\n",a * b);
    printf("a / b = %f\n",(float)a / b);
    printf("a mod b = %d\n",a % b);
    printf("~a = %d\n",~a);
    printf("a & b = %d\n",a & b);
    printf("a | b = %d\n",a | b);
    printf("a ^ b = %d\n",a ^ b);
    printf("a << b = %d\n",a << b);
    printf("a >> b = %d\n",a >> b);
}