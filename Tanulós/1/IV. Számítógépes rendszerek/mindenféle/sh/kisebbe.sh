#!/bin/sh

if [ $1 -lt `expr $2 + $3` ]
then
	echo kisebb
else
	echo nagyobb
fi