#ifndef LIST_H
#define LIST_H
typedef struct Node Node;

typedef struct Node{
    int elem;
    Node* next;
} Node;

Node* createList(int);
void addElem(Node* head,int elem);
void printList(Node* head);
#endif