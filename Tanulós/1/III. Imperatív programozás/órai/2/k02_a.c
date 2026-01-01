// Adj új értéket az előző változónak, majd írd ki, hogy a változó értéke páros vagy páratlan.

#include <stdio.h>

int main(){
    int meow;

    meow = 1337;

    printf("%d", meow);

    if (meow % 2 == 0){
        printf(" páros\n");
    }
    else{
        printf(" páratlan\n");
    }

    return 0;
}

