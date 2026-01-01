#include "k01.h"
#include "k02.h"
#include "k03.h"
int main(int argc, char** argv){
    if(argc == 1){
        return 1;
    }
    switch (argv[1][0])
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
    default:
        break;
    }
}