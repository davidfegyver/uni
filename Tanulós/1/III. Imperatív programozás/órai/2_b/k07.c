#include <stdio.h>
#include <math.h>
#include <limits.h>

int main(){
    //Lehet kiszámítani
    printf("%d\n",sizeof(int));
    int a = pow(2,31);
    printf("%d\n",a);
    a = a + 1;
    printf("%d\n",a);
    //Lehet használni a limits.h-ban definiált makrókat
    int b = INT_MAX;
    printf("%d\n",b);
    b = b + 1;
    printf("%d\n",b);
    //A változóban található érték túlcsordul ezért a legkissebb értéket veszi fel
}