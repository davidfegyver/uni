Write-Host "Másodfokú egyenlet megoldó"

[double]$a = Read-Host "Adja meg az 'a' együtthatót"
[double]$b = Read-Host "Adja meg a 'b' együtthatót"
[double]$c = Read-Host "Adja meg a 'c' együtthatót"

$diszkriminans = $b * $b - 4 * $a * $c

if ($diszkriminans -lt 0) {
    Write-Host "Nincs valós megoldás."
} elseif ($diszkriminans -eq 0) {
    $x = -$b / (2 * $a)
    Write-Host "Egy valós megoldás van: x = $x"
} else {
    $sqrtD = [math]::Sqrt($diszkriminans)
    $x1 = (-$b + $sqrtD) / (2 * $a)
    $x2 = (-$b - $sqrtD) / (2 * $a)
    Write-Host "Két valós megoldás van: x1 = $x1, x2 = $x2"
}