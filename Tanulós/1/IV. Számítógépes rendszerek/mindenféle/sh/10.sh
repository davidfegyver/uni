#!/bin/sh
read -p "Kérek egy számot:" szam

if [ $szam -lt 10 ]; then
 echo "A szám kisebb mint 10"
elif  [ $szam -eq 10 ]
then
 echo "A szám egyenlő 10-el"
else
 echo "A szám nagyobb mint 10"
fi