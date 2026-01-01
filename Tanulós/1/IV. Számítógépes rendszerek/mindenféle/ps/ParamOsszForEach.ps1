$ossz = 0
foreach ($arg in $args) {
    $ossz += [int]$arg
}
Write-Host "A paraméterek összege: $ossz"