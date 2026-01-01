#include <stdio.h>

int main(){
    int a = 0;
    scanf("%d",&a);

    //Nullát kell megvizsgálni először mert arra az a feltétel is igaz hogy 0 % 2 == 0
    if(a == 0){
        printf("Nulla\n");
    }else if(a % 2 == 1){
        printf("Páratlan\n");
    }else{
        printf("Páros\n");
    }
}