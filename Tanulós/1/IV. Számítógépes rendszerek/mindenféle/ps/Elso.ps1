param (
    [string]$filePath
)

if (Test-Path $filePath) {
    Get-Content $filePath | ForEach-Object {
        $_.Split(" ")[1]
    }
} else {
    Write-Host "A megadott fájl nem létezik: $filePath"
}
