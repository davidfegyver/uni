#include <stdio.h>
#include <ctype.h>
#define MAX_STRING 50

int main(){
    char word[MAX_STRING];
    int i = 0;
    char c;
    int magan = 0;
    int massal = 0;
    printf("Adjon meg egy szót: ");
    while((c = getchar()) != '\n' && (i+1) < MAX_STRING){
        word[i] = c;
        i++;
        if(isalpha(c)){
            char tmp = tolower(c);
            if(tmp == 'a' || tmp == 'e' || tmp == 'i' || tmp == 'o' || tmp == 'u'){
                magan++;
            }else{
                massal++;
            }
        }
    }
    word[i] = '\0';
    printf("%s\n",word);
    printf("%d db magánhangzó van a szóban.\n",magan);
    printf("%d db mássalhangzó van a szóban.\n",massal);
}