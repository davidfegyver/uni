// Írj programot, melyben kiszámolod egy négyszög kerületét és területét.
// A négyszög két oldalát kérd be a standard inputról.

#include <stdio.h>

int main(){
    int a = 0;
    int b = 0;
    
    printf("Add meg a négyszög két oldalát szóközzel elválasztva: ");
    scanf("%d %d", &a, &b);


    int kerulet = 2*(a+b);
    int terulet = a*b;

    printf("K: %d, T: %d", kerulet,terulet);


    return 0;
}