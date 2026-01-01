// Határozd meg két szám átlagát. Figyelj arra, hogy az eredmény valós szám!

#include <stdio.h>
int main() {
    int a, b;
    float atlag;

    printf("Kérem az első számot: ");
    scanf("%d", &a);
    printf("Kérem a második számot: ");
    scanf("%d", &b);

    atlag = (a + b) / 2.0; // Az osztó 2.0 valós szám !! 

    printf("A két szám átlaga: %.2f\n", atlag);

    return 0;
}