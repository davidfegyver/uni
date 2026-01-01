#include "my_utils.h"

int main(){
    int k = 123;
    int j = 634;
    printf("k = %d\n",k);
    printf("j = %d\n",j);

    swap(&k,&j);
    printf("k = %d\n",k);
    printf("j = %d\n",j);
}