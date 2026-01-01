param(
[Parameter(Mandatory=$true)][string]$file
)

$lines = (Get-Content $file | Measure-Object -Line).Lines

Write-Host "A $file fájl sorainak száma: $lines"