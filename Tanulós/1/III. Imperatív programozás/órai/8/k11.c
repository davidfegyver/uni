#include <stdio.h>

int main(){
    void swap(int* a, int* b){
        int tmp = *a;
        *a = *b;
        *b = tmp;
    }
    int k = 123;
    int j = 634;
    printf("k = %d\n",k);
    printf("j = %d\n",j);

    swap(&k,&j);
    printf("k = %d\n",k);
    printf("j = %d\n",j);
}