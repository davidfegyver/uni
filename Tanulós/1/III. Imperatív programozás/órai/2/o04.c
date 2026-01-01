// Írd ki egy szám összes osztóját.
#include <stdio.h>
int main(){
    int szam = 0;

    printf("Adj meg egy számot: ");
    scanf("%d", &szam);

    printf("%d osztói: ", szam);
    for (int i = 1; i <= szam; i++){
        if (szam % i == 0){
            printf("%d ", i);
        }
    }

    return 0;
}