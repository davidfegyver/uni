param (
    [string]$filePath
)
if (Test-Path $filePath) {
    $elso = Read-Host -Prompt "Kérem a kisebb sorszámot"
    $masodik = Read-Host -Prompt "Kérem a nagyobb sorszámot"

    if ($elso -gt $masodik){
        Write-Host "Hibás bemenet: a kisebb sorszám nagyobb a nagyobbnál, de ne aggódj, megoldom!"
        $temp = $elso
        $elso = $masodik
        $masodik = $temp
    }

    Get-Content $filePath | ForEach-Object {
            if ($_.Length -ge $elso -and $_.Length -ge $masodik) {
                $_.Substring($elso-1, $masodik-$elso + 1)
            } elseif ($_.Length -ge $elso) {
                $_.Substring($elso-1)
            } else {
                ""
            }
        }
} else {
    Write-Host "A megadott fájl nem létezik: $filePath"
}
