// Írd ki 0-tól 1-ig a valós számokat 0.1-es lépésközzel.
#include <stdio.h>

int main() {
    for (float szam = 0.0; szam <= 1.0 + 0.0005; szam += 0.1) {
        //Szükséges megadnunk a felső határhoz egy úgnevezett delta értéket ami figyelembe vesz azt hogy a lebegőpontos értékek valamennyire pontatlanok
        printf("%.1f\n", szam);
    }
    return 0;
}