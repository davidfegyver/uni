#!/bin/sh
inp=$1

case $inp in
        "0") echo "Nulla";;
        "1") echo "Egy";;
        "2") echo "Kettő";;
        "3") echo "Három";;
        "4") echo "Négy";;
        "5") echo "Öt";;
        "6") echo "Hat";;
        "7") echo "Hét";;
        "8") echo "Nyolc";;
        "9") echo "Kilenc";;
        *) echo "Nem számjegyet adott meg!";;
esac