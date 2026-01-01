#include <stdio.h>

int main(){
    for(float i = 0.0f;i <= 1.0;i += 0.1f){
        printf("%f\n",i);
    }
    //Szükséges megadnunk a felső határhoz egy úgnevezett delta értéket ami figyelembe vesz azt hogy a lebegőpontos értékek valamennyire pontatlanok
    for(float i = 0.0f;i <= 1.0 + 0.0005;i += 0.1f){
        printf("%f\n",i);
    }
}