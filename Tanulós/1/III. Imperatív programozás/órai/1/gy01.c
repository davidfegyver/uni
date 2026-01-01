// Írj programot, mely a napok számát átszámolja évekre, hetekre és napokra. Pl. 375 nap = 1 év 1 hét 3 nap. Mindig csak a nagyobb egység maradékával dolgozz.

#include <stdio.h>

int main(){
    int napok_be;

    int evek, hetek, napok;

    printf("Kérem a napok számát: ");
    scanf("%d", &napok_be);

    evek = napok_be / 365;
    int maradek = napok_be % 365;
    hetek = maradek / 7;
    napok = maradek % 7;

    printf("%d nap = %d év %d hét %d nap\n", napok_be, evek, hetek, napok);

    return 0;
}