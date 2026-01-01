#include <stdio.h>

int main(){
    int a = 0;
    int b = 0;
    int r = 0;
    printf("Adja meg a négyszög egyik oldalának hosszát: ");
    scanf("%d",&a);
    printf("Adja meg a négyszög másik oldalának hosszát: ");
    scanf("%d",&b);
    printf("Adja meg a kör sugarának hosszát: ");
    scanf("%d",&r);
    printf("Négyszög kerülete %d, területe %d\n",2 * a + 2 * b,a * b);
    printf("Kör kerülete %f, területe %f\n",2 * r * 3.1415,r * r * 3.1415);

    return 0;
}