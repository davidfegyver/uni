#include <stdio.h>
#include <stdbool.h>

int main(){
    int a = 1.234;
    printf("%d\n",a);
    a = 'b';
    printf("%d %c\n",a,a);
    a = true; //Szükséges stdbool.h fájl
    printf("%d\n",a);
    a = "string";
    printf("%d %s\n",a,a); 
    // Az a változónak az új értéke char* ami a "string" első elemére mutat, ezért a printf("%s",a) átkonvertálja a-t egy char* pointerré ezért ki tudja írni a stringet rendesen
}