param (
    [string]$filePath
)

if (Test-Path $filePath) {
    $content = Get-Content $filePath 
    for ($i = 0; $i -lt $content.Length; $i++) {
        if (($i+1) % 2 -eq 0) {
            Add-Content "paros.txt" $content[$i]
        } else {
            Add-Content "paratlan.txt" $content[$i]
        }
    }
} else {
    Write-Host "A megadott fájl nem létezik: $filePath"
}
