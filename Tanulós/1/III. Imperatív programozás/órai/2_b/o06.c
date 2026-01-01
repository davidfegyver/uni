#include <stdio.h>

int main(){
    for(int i = 1;i <= 10;i++)
	{
		for(int k = 1;k <= 10;k++)
		{
			printf("%d\t",i * k);
		}
		printf("\n");
	}

}