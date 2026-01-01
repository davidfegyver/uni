// Határozd meg két szám legnagyobb közös osztóját
// Brute-force

#include <stdio.h>
int main(){
    int a = 0;
    int b = 0;

    printf("Adj meg két számot: ");
    scanf("%d %d", &a, &b);

    int lko = 1;
    for (int i = 1; i <= a && i <= b; i++){
        if (a % i == 0 && b % i == 0){
            lko = i;
        }
    }

    printf("A két szám legnagyobb közös osztója: %d", lko);

    return 0;
}