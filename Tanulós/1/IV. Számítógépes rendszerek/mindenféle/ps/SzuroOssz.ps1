$ossz = 0
if ($input.Count -eq 0) {
    Write-Host "Használat: valami | ./$($MyInvocation.MyCommand.Name)"
    exit
}
$input.Reset()

foreach ($arg in $input) {
    $ossz += [int]$arg
}
Write-Host "A paraméterek összege: $ossz"