#include "random.h"

int getRandomInt(int min,int max){
    return min + rand()/((RAND_MAX + 1u)/max);
}

double getRandomDouble(double min,double max){
    return min + ((double)rand()/(double)RAND_MAX) * max - 1;
}

short getRandomShort(short min,short max){
    return min + rand()/(RAND_MAX / max) - 1;
}