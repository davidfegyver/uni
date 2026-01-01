#include <stdio.h>

int main(){
    int a = 1;
    printf("%d\n",a);
    for(int i = 0;i < sizeof(int) * 8;i++){
        a ^= 1 << i;
        printf("%d\n",a);
    }
}