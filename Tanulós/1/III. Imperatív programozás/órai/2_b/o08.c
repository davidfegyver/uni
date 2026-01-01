#include <stdio.h>
#include <stdbool.h>

int main(){
    printf("int: %d\n",sizeof(int));
    printf("long int: %d\n",sizeof(long int));
    printf("unsigned int: %d\n",sizeof(unsigned int));
    printf("unsigned long int: %d\n",sizeof(unsigned long int));
    printf("char: %d\n",sizeof(char));
    printf("bool: %d\n",sizeof(true));
    printf("float: %d\n",sizeof(float));
    printf("double: %d\n",sizeof(double));
    printf("long double: %d\n",sizeof(long double));
}