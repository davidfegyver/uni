#!/bin/sh
felh=`who`

echo "Hány felhasználót listázzak?"
read szam

while [ ! $szam -eq 0 ]
do
        who | sort | head -n $szam
        echo "Hány felhasználót listázzak?"
        read szam
done