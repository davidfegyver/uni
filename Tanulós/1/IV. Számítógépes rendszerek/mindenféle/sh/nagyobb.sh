#!/bin/sh

if [$# -eq 0]
then
	echo Adj meg legalább egy paramétert!
else
	elozo=$1
	mostani=$1
	for i in `seq $#`
	do
		elozo=
		if [$elozo -lt $mostani]
		then
			echo $mostani
		fi
	done