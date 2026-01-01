#/bin/bash

sum="0"
if [ "$#" -gt 10 ]
then
    echo "max 10 numbers"
    exit
elif [ "$1" == "-help" ]
then
    echo "Usage: ./program num1 num2 num3 ... num10. It will return the sum of all parameters"
    exit 0
else
for par in "$@"
do
    sum=$(( sum+$par ))
done
echo $sum
fi