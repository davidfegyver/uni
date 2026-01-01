i=1
s=0
while [ $i -lt 6 ]
do
    echo -n Kérem a $i. számot:
    read szam
    s=$(($s+$szam))
    i=$(($i+1))
done

echo A beirt szamok osszege: $s