//Írj programot, ami bekér egy számot és megfordítja azt. Csak aritmetikai műveleteket használj. Pl.: 12345 -> 54321
#include <stdio.h>

int main(){
    int be = 0;

    printf("Adj meg egy számot: ");
    scanf("%d", &be);

    int ki = 0;

    while (be!=0){
        ki *= 10;
        ki += be % 10;
        be /= 10;
    } ;

    printf("%d", ki);

    return 0;
}