param (
[Parameter(Mandatory=$true)][string]$file
)

[int]$kisebb = Read-Host -Prompt "Kérem a kisebb sorszámot"
[int]$nagyobb = Read-Host -Prompt "Kérem a nagyobb sorszámot"
Write-Host "A paraméterként kapott fájl sorainak $kisebb-$nagyobb. karaktere:"

foreach ($line in (Get-Content $file)){
Write-Host $line.SubString($kisebb-1,$nagyobb-$kisebb+1)
}
