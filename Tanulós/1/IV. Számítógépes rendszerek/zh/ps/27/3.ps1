$files = Get-ChildItem -File -Filter *.dll -Path C:\Windows

for ([int]$i = 1; $i -le $files.Count; $i++){
$nev = $files[$i-1].Name
Write-Host "$i. fájl: $nev"
}
Write-Host "Összesen $($files.Count) fájl"