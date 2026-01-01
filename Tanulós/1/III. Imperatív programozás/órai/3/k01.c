#include <stdio.h>

int main(){
    int a = 1;
    int b = 1;

    //Postfix
    int n = a++;
    printf("Postfix n: %d a: %d\n",n,a);
    //Prefix
    n = ++b;
    printf("Prefix n: %d b: %d\n",n,b);

}