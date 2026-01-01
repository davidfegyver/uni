#!/bin/bash

if [ "$1" == " " ]
then
    echo "Give me a positive natural number"
else
    fact=1
    for (( i=1; i <= "$1"; i++ ))
    do
        fact=`expr $fact \* $i`
    done
    echo $fact
fi