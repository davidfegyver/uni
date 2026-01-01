#include <stdio.h>
#include <string.h>
#define ARRAY_LENGTH 20

int main(){
    char charSeqOne[ARRAY_LENGTH];
    char charSeqTwo[ARRAY_LENGTH];
    printf("Adja meg az első szót: ");
    scanf("%s",charSeqOne);
    printf("Adja meg a második szót: ");
    scanf("%s",charSeqTwo);
    // strcmp ha az első előrébb van az abc-ben akkor pozitív
    // ha a második van előrébb akkor negatív
    // ha megegyeznek akkor 0
    // Fontos ez nem működik magyar ékezetes betűkkel
    int ans = strcmp(charSeqOne,charSeqTwo);
    if(ans < 0){
        printf("%s van előrébb az abc sorrendben\n",charSeqOne);
    }else if(ans > 0){
        printf("%s van előrébb az abc sorrendben\n",charSeqTwo);
    }else{
        printf("A két szó megegyezik.\n");
    }
}