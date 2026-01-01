#include <stdio.h>
#include <stdlib.h>
#include <math.h>

int main(int argc,char** argv){
    if(argc > 1){
        int szam = atoi(argv[1]);
        int n = 0;
        scanf("%d",&n);
        for(int i = 1;i <= n;i++){
            int tmp = pow(szam,i);
            printf("%d\n",tmp);
        }
    }else{
        printf("Nincs megadva parancssori argumentum\n");
    }
}