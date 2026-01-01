#include <stdio.h>

int foo(int a,int a){
    if(a == a){
        return a;
    }
}


int main(){
    printf("%d\n",foo(1,2));
}