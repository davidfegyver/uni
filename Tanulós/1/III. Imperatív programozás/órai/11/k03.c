#include "k03.h"

static AdvStudent* student_init(){
    AdvStudent* ret = (AdvStudent*)malloc(sizeof(AdvStudent));
    ret->s.id = getRandomInt(0,100);
    ret->s.grade = getRandomDouble(1,5);
    ret->s.age = getRandomShort(18,50);
    ret->type = getRandomInt(0,3);
    switch (ret->type)
    {
    case BSC:
        ret->courses = getRandomInt(0,15);
        break;
    case MSC:
        ret->gpa = getRandomDouble(1,6);
        break;
    case PHD:
        ret->factor.impact = getRandomDouble(10,100);
        ret->factor.erdos = getRandomInt(1,10);
        break;
    default:
        break;
    }

    return ret;
}
static void student_print(AdvStudent* student){
    if(student != NULL){
        switch (student->type)
        {
        case BSC:
            printf("%d %f %d BSC %d\n",student->s.id,student->s.grade,student->s.age,student->courses);
            break;
        case MSC:
            printf("%d %f %d MSC %f\n",student->s.id,student->s.grade,student->s.age,student->gpa);
            break;
        case PHD:
            printf("%d %f %d PHD %f %d\n",student->s.id,student->s.grade,student->s.age,student->factor.impact,student->factor.erdos);
            break;
        default:
            break;
        }
    }
}
static AdvStudent* student_search(AdvStudent** arr,int size){
    AdvStudent* ret = arr[0];
    double max = ret->s.grade;
    for(int i = 1;i < size;i++){
        if(max < arr[i]->s.grade){
            ret = arr[i];
            max = ret->s.grade;
        }
    }
    return ret;
}

void k03(){
    srand(time(NULL));
    AdvStudent* arr[STUD_CNT] = {0};
    for(int i = 0;i < STUD_CNT;i++){
        arr[i] = student_init();
        student_print(arr[i]);
    }
    student_print(student_search(arr,STUD_CNT));
}