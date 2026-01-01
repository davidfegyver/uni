#include "k01.h"
#include "random.h"
void k01(){
    srand(time(NULL));
    int ids[STUD_CNT] = {0};
    double grades[STUD_CNT] = {0};
    short ages[STUD_CNT] = {0};
    for(int i = 0;i < STUD_CNT;i++){
        ids[i] = getRandomInt(0,100);
        grades[i] = getRandomDouble(1,5);
        ages[i] = getRandomShort(18,50);
        printf("%d %f %d\n",ids[i],grades[i],ages[i]);
    }
}