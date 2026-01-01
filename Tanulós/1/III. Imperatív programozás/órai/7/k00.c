#include <stdio.h>
#include <stdlib.h>

int main(int argc,char** argv){
    printf("%s a program neve\n",argv[0]);
    if(argc > 1){
        printf("%d a kapott paraméter\n",atoi(argv[1]));
    }
}