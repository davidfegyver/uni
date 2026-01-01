#!/bin/bash
n=$1
div1=$2
div2=$3
output=""
for ((i=1; i<=n; i++)); do
    if (( i % div1 == 0 && i % div2 == 0 )); then
        output+="third"
    elif (( i % div1 == 0 )); then
        output+="first"
    elif (( i % div2 == 0 )); then
        output+="second"
    else
        output+="$i"
    fi

    if (( i < n )); then
        output+=", "
    fi
done