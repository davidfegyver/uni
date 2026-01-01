// Adj új értéket az előző változónak, majd írd ki, hogy a változó értéke páros vagy páratlan.

#include <stdio.h>

int main(){
    const int meow;

    meow = 1337; // error: assignment of read-only variable ‘meow’

    printf("%d", meow);

    return 0;
}

