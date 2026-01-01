#include "k02.h"


Student* student_init(){
    Student* ret = (Student*)malloc(sizeof(Student));
    ret->id = getRandomInt(0,100);
    ret->grade = getRandomDouble(1,5);
    ret->age = getRandomShort(18,50);

    return ret;
}
void student_print(Student* student){
    if(student != NULL){
        printf("%d %f %d\n",student->id,student->grade,student->age);
    }
}
Student* student_search(Student** arr,int size){
    Student* ret = arr[0];
    double max = ret->grade;
    for(int i = 1;i < size;i++){
        if(max < arr[i]->grade){
            ret = arr[i];
            max = ret->grade;
        }
    }
    return ret;
}

void k02(){
    srand(time(NULL));
    printf("%d\n",sizeof(int));
    printf("%d\n",sizeof(double));
    printf("%d\n",sizeof(short));
    printf("%d\n",sizeof(Student));
    Student* arr[STUD_CNT] = {0};
    for(int i = 0;i < STUD_CNT;i++){
        arr[i] = student_init();
        student_print(arr[i]);
    }
    student_print(student_search(arr,STUD_CNT));
}