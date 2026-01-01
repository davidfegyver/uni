#ifndef TASK_H
#define TASK_H
#include "tree.h"
#include "input.h"
void insert_pkg(Node** tree);
void print_tree(Node* tree);
Node** get_manifest(Node* tree);
void delete_pkg(Node* tree);
void delete_all_pkgs(Node* tree);
#endif