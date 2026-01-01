while ($true){
    Clear-Host
    Write-Host "Kérem válasszon!"
    Write-Host "1. Első menüpont"
    Write-Host "2. Második menüpont"
    Write-Host "3. Kilépés"
    $val = Read-Host
    switch ($val){
        "1"{
            Write-Host "Ön az első menüpontot választotta"
        }
        "2"{
            Write-Host "Ön a második menüpontot választotta"
        }
        "3"{
            Write-Host "Ciao Miau!"
            exit
        }
        default{
            Write-Host "Hibás választás"
        }
    }
    Start-Sleep -Seconds 2
}

