#include <stdio.h>
#include <string.h>
#define ARRAY_LENGTH 20

int ownStrlen(const char* str){
    int length = 0;
    while(*(str + length) != '\0'){
        length++;
    }
    return length;
}

int main(){
    char charSeqOne[ARRAY_LENGTH];
    printf("Adja meg a szót: ");
    scanf("%s",charSeqOne);
    // Használhatjuk az strlen() függvényt ami szintén nem kezeli jól a magyar ékezetes karaktereket
    printf("A %s szó hossza: %d\n",charSeqOne,strlen(charSeqOne));
    // De használhatunk saját implementációt
    printf("A %s szó hossza: %d\n",charSeqOne,ownStrlen(charSeqOne));
    /*
    char badString[] = {'a','l','m','a'};
    printf("A %s szó hossza: %d\n",badString,strlen(badString));
    printf("A %s szó hossza: %d\n",badString,ownStrlen(badString));
    */
}