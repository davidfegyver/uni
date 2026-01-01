$s = 0

for ($i = 0; $i -lt $args.Count; $i++){
 $s += $args[$i]



}

Write-Host "A paraméterek összege $s"