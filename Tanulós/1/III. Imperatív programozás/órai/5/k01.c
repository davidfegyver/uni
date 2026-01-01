#include <stdio.h>
#define MAX_ARR 10

int main(){
    printf("Értékadás nélkül:\n");
    int arr[MAX_ARR];
    for(int i = 0;i < MAX_ARR;i++){
        printf("%d\n",arr[i]);
    }
    //Két féle képpen is csinálhatjuk
    //Rögtön létrehozáskor nullával inicializáljuk
    printf("Nullával való inicializálás:\n");
    int arrA[MAX_ARR] = {0};
    for(int i = 0;i < MAX_ARR;i++){
        printf("%d\n",arrA[i]);
    }
    //Léterhozás után egy ciklus segítségével
    printf("Ciklus segítségével:\n");
    int arrB[MAX_ARR];
    for(int i = 0;i < MAX_ARR;i++){
        arrB[i] = 0;
    }
    for(int i = 0;i < MAX_ARR;i++){
        printf("%d\n",arrB[i]);
    }
    

}
