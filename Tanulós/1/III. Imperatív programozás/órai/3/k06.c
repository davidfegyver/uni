#include <stdio.h>

int main(){
    int x1 = 0,y1 = 0;
    int x2 = 0,y2 = 0;
    int x3 = 0,y3 = 0;
    int x4 = 0,y4 = 0;
    scanf("%d %d",&x1,&y1);
    scanf("%d %d",&x2,&y2);
    scanf("%d %d",&x3,&y3);
    scanf("%d %d",&x4,&y4);
    if(((x2 - x1) * (x4-x3) + (y2 -y1) * (y4 - y3)) == 0)
    {
        printf("Merőlegesek\n");
    }else{
        printf("Nem merőlegesek\n");
    }

}