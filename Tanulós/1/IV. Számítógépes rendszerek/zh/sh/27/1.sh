#!/bin/sh

oszto=$2
osztando=$1
argc=$#

if ( [ $argc -eq 0 ] ); then
        read -p "Kérem az osztandó értékét: " osztando
        read -p "Kérem az osztó értékét: " oszto
         echo $osztando/$oszto=`expr $osztando / $oszto`

elif ( [ $argc -eq 1 ] ); then
        read -p "Kérem az osztó értékét: " oszto
         echo $osztando/$oszto=`expr $osztando / $oszto`
elif ( [ $argc -eq 2 ] ); then
        echo $osztando/$oszto=`expr $osztando / $oszto`
else
        echo "Több mint 2 paramétert adott meg!"

fi