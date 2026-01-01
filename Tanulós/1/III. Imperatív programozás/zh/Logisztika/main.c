#include <stdlib.h>
#include <stdio.h>
#include "tree.h"
#include "task.h"
void userSelection(Node** binaryTree){
    int length = 0;
    char currentChar;
    char previousChar = '\0';
    char userInput = '\0';
    Node** array = NULL;
    printf("1) Hozzáadás\n");
    printf("2) Kirajzolás\n");
    printf("3) Rakodási lista\n");
    printf("4) Csomag törlése\n");
    printf("5) Kilépés\n");
    printf("Adja meg a választani kívánt menüt: ");

    while((currentChar = getchar()) != '\n'){
        length++;
        previousChar = currentChar;
    }
    if(length == 1){
        userInput = previousChar;
    }
    switch(userInput){
        case '1':
            insert_pkg(binaryTree);
            break;
        case '2':
            print_tree(*binaryTree);
            break;
        case '3':
            array = get_manifest(*binaryTree);
            if(array != NULL){
                FILE* file = fopen("out.txt","w");
                if(file == NULL){
                    printf("Nem sikerült megnyitni a fájlt írásra.\n");
                    exit(1);
                }
                int index = 0;
                while(array[index] != NULL){
                    fprintf(file,"%p %d\n",(void*)array[index],array[index]->value);
                    index++;
                }
                fclose(file);
                free(array);
                array = NULL;
            }
            break;
        case '4':
            delete_pkg(*binaryTree);
            break;
        case '5':
            delete_all_pkgs(*binaryTree);
            exit(0);
            break;
        default:
        printf("Hibás bemenet!\nKérem adja meg újra!\n");
            break;
    }
}


int main(){
    printf("Üdvözlöm\nEzzel a programmal a MindentRendez Kft.-nél történt kavarodást lehet szimulálni és rendbe hozni.\n");
    Node* binaryTree = NULL;
    while(1){
        userSelection(&binaryTree);
    }
}