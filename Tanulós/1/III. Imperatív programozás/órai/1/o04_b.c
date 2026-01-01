// Írj programot, melyben kiszámolod egy kör kerületét és területét.
// A kör sugarát kérd be a standard inputról.
#include <stdio.h>

int main(){
    
    printf("Add meg a kör sugarát: ");
    
    int r = 0;
    scanf("%d", &r);

    float kerulet = 2 * 3.1415 * r;
    float terulet = 3.1415 * r * r;
    printf("K: %.2f, T: %.2f", kerulet, terulet);

    return 0;
}