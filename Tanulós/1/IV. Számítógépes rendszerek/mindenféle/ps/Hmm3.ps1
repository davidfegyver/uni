$fileContent = Get-Content test.txt -Raw #--> Stringet ad vissza, tartalmaz újsor karaktereket

foreach ($line in $fileContent.Split("`n")){
    foreach ($szo in $line.Split(" ")){
        Write-Host $szo
    }
}


