#include <stdio.h>

int main(){
    int a = 0;
    scanf("%d",&a);
    int orig = a;
    int ford = 0;
    int marad = 0;
    while(a > 0){
        marad = a % 10;
        ford = ford * 10 + marad;
        a = a / 10;
    }
    printf("%d\n",ford);
    if(ford == orig){
        printf("Palindrom\n");
    }else{
        printf("Nem palindrom\n");
    }
}