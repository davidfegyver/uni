write-host "Másodfokú egyenlet megoldó program"
[double]$a = read-host "Írd be az `"a`" együtthatót"
[double]$b = read-host "Írd be a `"b`" együtthatót"
[double]$c = read-host "Írd be a `"c`" együtthatót"

write-host "Az egyenlet $a*x2+$b*x+$c=0"

$det = $b*$b - 4*$a*$c

if($det -lt 0){
write-host "Nincs megoldás"
}elseif($det -eq 0){
write-host "Egy megoldás van: $(-$b/(2*$a))"
}else{
write-host "Az egyenlet megoldásai $((-$b + [Math]::sqrt($det))/(2*$a)) és $((-$b - [Math]::sqrt($det))/(2*$a))"
}