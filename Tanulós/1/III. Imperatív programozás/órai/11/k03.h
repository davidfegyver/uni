#ifndef K03_H
#define K03_H
#include <stdio.h>
#include "random.h"
#include "k02.h"
#define STUD_CNT 10
typedef enum Type{BSC,MSC,PHD} Type;

typedef struct ImpactFactor
{
    double impact;
    int erdos;
}ImpactFactor;


typedef struct AdvStudent
{
    Student s;
    Type type;
    union 
    {
        int courses;
        double gpa;
        ImpactFactor factor;
    };
    
}AdvStudent;

void k03();
#endif