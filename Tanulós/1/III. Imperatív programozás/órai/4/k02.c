#include <stdio.h>

int main(){
    int a = 5;
    int b = 4;
    int c = 8;
    //Balról jobbra törénik a kiértékelés, a<b aminek az eredménye 0 vagy 1 majd
    // 0 vagy 1 < c
    if(a<b<c){
        printf("%d < %d < %d\n",a,b,c);
    }else{
        printf("a<b<c = %d\n",a<b<c);
        printf("a<b = %d\n",a<b);
    }
}