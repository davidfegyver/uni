// Határozd meg, hogy melyik a legnagyobb és legkisebb ábrázolható egész szám ( sizeof() ). 
// A legnagyobb ábrázolható egész számot tedd egy változóba, majd adj a változóhoz 1-et. 

#include <stdio.h>
#include <limits.h>
#include <math.h>

int main() {
    int max_int = INT_MAX; 
    // int max_int = pow(2, sizeof(int)*8 -1) -1; 
    int min_int = INT_MIN;

    printf("A legnagyobb ábrázolható egész szám: %d\n", max_int);
    printf("A legkisebb ábrázolható egész szám: %d\n", min_int);

    //A változóban található érték túlcsordul ezért a legkisebb értéket veszi fel

    max_int += 1; 

    printf("A legnagyobb szám növelése után: %d\n", max_int);

    return 0;
}
