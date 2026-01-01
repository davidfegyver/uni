#include <stdio.h>
#include <stdlib.h>

int main(){
    char input[10];
    fgets(input,10,stdin);
    float r = atof(input);
    printf("Kör átmérője: %f\n",2 * r);
    printf("Kör kerülete: %f\n",2 * r * 3.14);
    printf("Kör területe: %f\n",r * r * 3.14);
}