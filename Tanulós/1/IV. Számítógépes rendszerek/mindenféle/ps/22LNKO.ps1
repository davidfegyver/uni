[int]$elso = Read-Host -Prompt "Kérem az első számot"
[int]$masodik = Read-Host -Prompt "Kérem a második számot"

$elso = [Math]::abs($elso)
$masodik = [Math]::abs($masodik)

$lnko = 1

for ([int]$i = 1; $i -le $elso; $i++){
    if(($elso % $i -eq 0) -and ($masodik % $i -eq 0) ){
       $lnko = $i

    }

}

Write-Host "Legnagyobb közös osztójuk: $lnko"