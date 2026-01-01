#include "tree.h"

void addElement(Node** head,int value){
    if(*head == NULL){
        (*head) = malloc(sizeof(Node));
        if(*head == NULL){
            printf("Nem sikerült memriát lefoglalni!\n");
            exit(1);
        }
        Node* current = *head;
        current->value = value;
        current->left = NULL;
        current->right = NULL;
    }else{
        Node* current = *head;
        if(current->value < value){
            addElement(&current->right,value);
        }else if(current->value > value){
            addElement(&current->left,value);
        }else{
            printf("Már van ilyen távolsággal érték az adatszerkezeteben!\n");
            return;
        }
    }
}

void deleteElement(Node* elem,Node* parent,int value){
    if(elem == NULL){
        return;
    }
    if(elem->value == value){
        if(elem->left != NULL || elem->right != NULL){
            if(parent->left == elem){
                parent->left = elem->left ? elem->left : elem->right;
            }else{
                parent->right = elem->right ? elem->right : elem->left;
            }
        }else{
            if(parent->left == elem){
                parent->left = NULL;
            }else{
                parent->right = NULL;
            }
        }
        
        free(elem);
    }else if(elem->value < value){
        deleteElement(elem->right,elem,value);
    }else{
        deleteElement(elem->left,elem,value);
    }
}

void printTree(Node* elem,int level){
    if(elem){
        printTree(elem->left,level+1);
        for(int i = 0;i < level;i++){
            printf("\t");
        }
        printf("%d\n",elem->value);
        printTree(elem->right,level+1);
    }
}

int countNodes(Node* elem){
    if(elem == NULL){
        return 0;
    }
    return 1 + countNodes(elem->left) + countNodes(elem->right);
}

void placeInArray(Node* elem,Node** array,int* index){
    if(elem){
        placeInArray(elem->left,array,index);
        array[*index] = elem;
        (*index)++;
        placeInArray(elem->right,array,index);
    }
}

Node** createArray(Node* elem){
    int numOfNodes = countNodes(elem);
    Node** array = malloc(sizeof(Node*)*(numOfNodes+1));
    if(array == NULL){
        printf("Nem sikerült memriát lefoglalni!\n");
        exit(1);
    }
    int index = 0;
    placeInArray(elem,array,&index);
    array[numOfNodes] = NULL;
    return array;
}

void freeTree(Node* elem){
    if(elem){
        freeTree(elem->left);
        freeTree(elem->right);
        free(elem);
    }
}