#include <stdio.h>

int main(){
    for(int i = 1;i <= 8;i++)
	{
		for(int k = 1;k <= 8;k++)
		{
			if(i % 2 == 0)
			{
				if(k % 2 == 0)
				{
					printf("[]");
				}else{
					printf("  ");
				}
			}else{
				if(k % 2 == 0)
				{
					printf("  ");
				}else{
					printf("[]");
				}
			}
		}
		printf("\n");
	}
}