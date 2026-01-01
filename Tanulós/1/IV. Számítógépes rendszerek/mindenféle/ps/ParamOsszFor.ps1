$ossz = 0
for ($i = 0; $i -lt $args.Length; $i++) {
    $ossz += [int]$args[$i]
}
Write-Host "A paraméterek összege: $ossz"