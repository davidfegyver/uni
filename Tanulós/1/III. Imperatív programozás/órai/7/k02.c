#include <stdio.h>
#include <stdlib.h>
#define N 10

void fillTable(int arr[N][N]){
    for(int i = 0;i < N;i++){
        for(int j = 0;j < N;j++){
            arr[i][j] = (i+1) * (j+1);
            //*(*(arr + i) + j) = (i+1) * (j+1);
        }
    }
}

int main(){
    int szorzoTabla[N][N] = {0};
    fillTable(szorzoTabla);
    for(int i = 0;i < N;i++){
        for(int j = 0;j < N;j++){
            printf("%d x %d = %d\n",i+1,j+1,szorzoTabla[i][j]);
        }
    }
}