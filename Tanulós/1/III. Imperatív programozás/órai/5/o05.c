#include <stdio.h>
#include <stdbool.h>

int osztokOsszege(int szam){
    int osszeg = 0;
    for(int i = 1;i <= szam / 2;i++){
        if(szam % i == 0){
            osszeg += i;
        }
    }
    return osszeg;
}

int main(){
    int szamok[] = {220,110,52,78,284};
    int szamokLength = sizeof(szamok) / sizeof(szamok[0]);
    bool van = false;
    for(int i = 0;i < szamokLength - 1;i++){
        for(int j = i + 1;j < szamokLength;j++){
            int a = szamok[i];
            int b = szamok[j];
            if(osztokOsszege(a) == b && osztokOsszege(b) == a){
                printf("%d és %d barátságos számok\n",a,b);
                van = true;
            }
        }
    }

    if(!van){
        printf("Nincs barátságos szám\n");
    }
}