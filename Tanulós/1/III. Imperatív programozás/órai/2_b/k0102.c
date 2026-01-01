#include <stdio.h>

int main(){
    //const változónak kell kezdőértéket adni és utána nem lehet módosítani közvetlenül
    //const int a = 14;
    int a;
    printf("%d\n",a); //Memória szemét
    a = 14;
    printf("%d\n",a);
    if(a % 2 == 0){
        printf("Páros\n");
    }else{
        printf("Páratlan\n");
    }
}