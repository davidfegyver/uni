#!/bin/sh

utolso=`echo $* | cut -d" " -f$#`
elso=$1

echo `expr $elso + $utolso`