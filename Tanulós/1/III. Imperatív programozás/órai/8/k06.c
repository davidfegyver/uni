#include <stdio.h>

double pow(double a,double b);

double pow(double base,double exponent){
    double ret = 1;
    for(int i = 0;i < exponent;i++){
        ret *= base;
    }
    return ret;
}

int main(){
    printf("%f\n",pow(2,5));
}