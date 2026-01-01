#include <stdio.h>

int sum(int n){
    int ret = 0;
    for(int i = 1;i <= n;i++){
        ret += i;
    }
    return ret;
}

int main(){
    int n = 0;
    while(n < 1){
        printf("Adja meg n értékét\n");
        scanf("%d",&n);
    }
    printf("%d\n",sum(n));
}