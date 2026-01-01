#include "k01.h"
#include "k02.h"
#include "k03.h"
#include "k04.h"
#include "k05.h"
#include "k06.h"

int main(int argc,char** argv){
    if(argc == 1){
        printf("Nincs megadva parancssori argumentum!\n");
        return -1;
    }
    switch (*argv[1])
    {
    case '1':
        k01();
        break;
    case '2':
        k02();
        break;
    case '3':
        k03();
        break;
    case '4':
        k04();
        break;
    case '5':
        k05();
        break;
    case '6':
        k06();
        break;
    default:
        break;
    }

}