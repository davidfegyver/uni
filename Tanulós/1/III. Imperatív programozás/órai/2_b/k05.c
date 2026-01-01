#include <stdio.h>

int main(){
    int a = 13;
    int b = 2;
    printf("%f\n",a+b/2);         //Castolás nélkül -0.0000
    printf("%f\n",(float)a+b/2);  //Castolással 14.0000
    printf("%f\n",a+b/2.0f);  //Castolás nélkül, de a 2 alapból floatként van megadva (2.0f)
}