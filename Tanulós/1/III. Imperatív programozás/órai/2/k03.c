#include <stdio.h>

int main(){
    int szam = 0;


    do{
        printf("Adj meg egy páratlan számot: ");
        scanf("%d", &szam);

        if (szam % 2 == 0){
            printf("Eh\n");
        }
    }
    while (szam % 2 == 0);




}