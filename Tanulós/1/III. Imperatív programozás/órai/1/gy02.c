// Készíts egy Fahrenheit-Celsius átalakító programot ( C = (F-32)/1.8 ). 
// Írd ki a [-20; 200] intervallum Fahrenheit értékeit 10-es léptékkel, és a hozzájuk tartozó Celsius-fokot.

#include <stdio.h>

float f_to_c(int f) {
    return (f - 32) / 1.8;
}

int main(){
    
    for (int f = -20; f <= 200; f += 10){
        float c = f_to_c(f);

        printf("%dF = %.02fC\n", f, c);
    }

    return 0;
}