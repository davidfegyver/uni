#include <stdio.h>

int main(){
    int a = 0;
    scanf("%d",&a);
    int b = 0;
    scanf("%d",&b);
    //Brute force
    printf("Brute force\n");
    int maxBrute = 1;
    for(int i = 2;i <= a;i++){
        if(a % i == 0 && b % i == 0){
            maxBrute = i;
        }
    }
    printf("%d\n",maxBrute);
    //Kivonásos
    printf("Kivonásos\n");
    int kivA = a;
    int kivB = b;
    while(kivA != kivB){
        if(kivA > kivB){
            kivA = kivA - kivB;
        }else{
            kivB = kivB - kivA;
        }
    }
    printf("%d\n",kivA); // vagy printf("%d\n",kivB)
    //Euklidesz algoritmus
    printf("Euklideszi algoritmus\n");
    int eukA = a;
    int eukB = b;
    int tmp = 0;
    while(eukB > 0){
        tmp = eukB;
        eukB = eukA % eukB;
        eukA = tmp;
    }
    printf("%d\n",eukA);
}