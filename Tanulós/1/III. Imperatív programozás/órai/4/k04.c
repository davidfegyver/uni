#include <stdio.h>

int main(){
    int year = 0;
    printf("Adjon meg egy évet: ");
    scanf("%d",&year);

    int leapYear = (year % 4 == 0) && ((year % 100 != 0) || (year % 400 == 0));

    printf("%s\n", leapYear ? "Szököév" : "Nem szökőév");
}