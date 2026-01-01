// Írd ki, hogy a szám pozitív, negatív, vagy nulla-e.
#include <stdio.h>
int main() {
    int szam = 123;

    if (szam > 0) {
        printf("A szám pozitív.\n");
    } else if (szam < 0) {
        printf("A szám negatív.\n");
    } else {
        printf("A szám nulla.\n");
    }

}