#ifndef TREE_H
#define TREE_H
#include <stdio.h>
#include <stdlib.h>

typedef struct Node Node;


typedef struct Node
{
    int value;
    Node* left;
    Node* right;
}Node;

void addElement(Node** head,int value);
void deleteElement(Node* elem,Node* parent,int value);
void printTree(Node* elem,int level);
Node** createArray(Node*);
void freeTree(Node* elem);
#endif