// Próbálj meg értékül adni az int típusú változónak egy valós számot, egy karaktert, egy logikai ( bool ) értéket, és egy karakter láncot (stringet). Ha sikerül az értékadás, akkor írd ki a változó értékét.
#include <stdio.h>
#include <stdbool.h>
int main(){
    int meow;

    meow = 3.14;
    printf("%d\n", meow);

    meow = 'A';
    printf("%d\n", meow);

    meow = true; //Szükséges stdbool.h fájl
    printf("%d\n", meow);

    //meow = "Hello"; // error: incompatible types when assigning to type ‘int’ from type ‘char *’

    return 0;
}