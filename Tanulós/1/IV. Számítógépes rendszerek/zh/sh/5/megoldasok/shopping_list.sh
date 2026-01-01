#!/bin/bash
grep -vFf cart.txt list.txt > temp_list.txt
mv temp_list.txt list.txt
rm -f temp_list.txt
