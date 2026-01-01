#include "task.h"

void insert_pkg(Node** tree){
    printf("Adja meg a hozzáadni kívánt csomag távolságát: ");
    char* userInput = readUserInput();
    int value = parseValue(userInput);
    if(value < 0){
        return;
    }
    addElement(tree,value);
}

void print_tree(Node* tree){
    printTree(tree,0);
}

Node** get_manifest(Node* tree){
    Node** array = createArray(tree);
    return array;
}

void delete_pkg(Node* tree){
    printf("Adja meg a törölni kívánt raklap értékét: ");
    char* userInput = readUserInput();
    int value = parseValue(userInput);
    if(value < 0){
        return;
    }
    deleteElement(tree,NULL,value);
}

void delete_all_pkgs(Node* tree){
    freeTree(tree);
}