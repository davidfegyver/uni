#include <stdio.h>

void forUpperLower(int n){
    char ch = ' ';
    for(int i = 0;i < n;i++){
        ch = getchar();
        getchar(); //Beragadó enter
        while(ch < 'A' || (ch > 'Z' && ch < 'a') || ch > 'z'){
            printf("Hibás karakter\n");
            ch = getchar();
            getchar(); //Beragadó enter
        }
        if(ch >= 'a' && ch <= 'z'){
            printf("%c\n",ch - 'a' + 'A');
        }else if(ch >= 'A' && ch <= 'Z'){
            printf("%c\n",ch - 'A' + 'a');
        }
    }
}

void whileNotZero(){
    char ch = ' ';
    while((ch = getchar()) != '0'){
        getchar(); //Beragadó enter
        while(ch < 'A' || (ch > 'Z' && ch < 'a') || ch > 'z'){
            printf("Hibás karakter\n");
            ch = getchar();
            getchar(); //Beragadó enter
        }
        if(ch >= 'a' && ch <= 'z'){
            printf("%c\n",ch - 'a' + 'A');
        }else if(ch >= 'A' && ch <= 'Z'){
            printf("%c\n",ch - 'A' + 'a');
        }
    }
    getchar(); //Kilépés után kiszedjük az entert ami beragadt a 0 írásakor
}

void whileNotEOF(){
    char ch = ' ';
    while((ch = getchar()) != EOF){
        getchar(); //Beragadó enter
        while(ch < 'A' || (ch > 'Z' && ch < 'a') || ch > 'z'){
            printf("Hibás karakter\n");
            ch = getchar();
            getchar(); //Beragadó enter
        }
        if(ch >= 'a' && ch <= 'z'){
            printf("%c\n",ch - 'a' + 'A');
        }else if(ch >= 'A' && ch <= 'Z'){
            printf("%c\n",ch - 'A' + 'a');
        }
    }
    //EOF után nincs enter beragadva
}

int main(){
    int n = 5;
    forUpperLower(n);
    whileNotZero();
    whileNotEOF();
}