#!/bin/sh

elozo=0
jelenlegi=1
seged=0

echo $elozo
echo $jelenlegi
szekvencia=`expr $1 - 1`

for i in `seq $szekvencia`
do
	echo `expr $jelenlegi + $elozo`
	seged=$elozo
	elozo=$jelenlegi
	jelenlegi=`expr $jelenlegi + $seged`
done