if($args.Count -gt 3){
    Write-Host "Több mint 3 paramétert adott meg!"
    Write-Host "Használat: $($MyInvocation.MyCommand.Name) A B C" -NoNewline
    exit
}



switch($args.Count){
3{
[int]$a = $args[0]
[int]$b = $args[1]
[int]$c = $args[2]
}
2{
[int]$a = $args[0]
[int]$b = $args[1]
[int]$c = Read-Host -Prompt "Kérem C értékét"
}
1{
[int]$a = $args[0]
[int]$b = Read-Host -Prompt "Kérem B értékét"
[int]$c = Read-Host -Prompt "Kérem C értékét"
}
default{
[int]$a = Read-Host -Prompt "Kérem A értékét"
[int]$b = Read-Host -Prompt "Kérem B értékét"
[int]$c = Read-Host -Prompt "Kérem C értékét"
}
}

$det = $b*$b-4*$a*$c

if($det -lt 0){
Write-Host "Nincs megoldás!" -NoNewline
}

if($det -eq 0){
    Write-Host "X=$((-$b)/(2*$a))" -NoNewline
}

if($det -gt 0){
    Write-Host "X1=$(((-$b)+[Math]::Sqrt($det))/(2*$a))"
    Write-Host "X2=$(((-$b)-[Math]::Sqrt($det))/(2*$a))" -NoNewline
}