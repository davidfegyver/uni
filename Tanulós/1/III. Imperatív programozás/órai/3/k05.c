#include <stdio.h>
#include <stdlib.h>

int getNumber(char input[9],int start,int end){
    char tmp[5] = {0};
    int k = 0;
    for(int i = start;i <= end;i++){
        tmp[k] = input[i];
        k++;
    }
    return atoi(tmp);
}

int main(){
    char input[9] = {0};
    fgets(input,9,stdin);
    int year = getNumber(input,0,3);
    int month = getNumber(input,4,5);
    int day = getNumber(input,6,7);
    printf("%d-",year);
    if(month < 10){
        printf("0%d-",month);
    }else{
        printf("%d-",month);
    }
    if(day < 10){
        printf("0%d\n",day);
    }else{
        printf("%d\n",day);
    }
    
}