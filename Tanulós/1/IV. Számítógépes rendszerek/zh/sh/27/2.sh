#!/bin/sh
if [ $# -eq 0 ]; then
        echo "A legnagyobb érték: "
else
        max=$1
        for szam in $*; do
                if [ $szam -gt $max ]; then
                        max=$szam
                fi
        done

        echo "A legnagyébb érték: "$max

fi