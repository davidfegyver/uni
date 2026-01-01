param(
[Parameter(Mandatory=$true)][int]$elso,
[Parameter(Mandatory=$true)][int]$masodik
)

$osszeg = $elso + $masodik
$szorzat = $elso * $masodik

Write-Host "Kiíratom az első és a második paraméter összegét és szorzatát:"
Write-Host "$elso és $masodik összege: $osszeg, és szorzata: $szorzat"
