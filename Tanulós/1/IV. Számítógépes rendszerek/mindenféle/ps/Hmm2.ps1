$fileContent = Get-Content test.txt -Raw #--> Stringet ad vissza, tartalmaz újsor karaktereket
$fileContent = $fileContent.Replace("`n", " ")

    foreach ($szo in $fileContent.Split(" ")){
        Write-Host $szo
    }
