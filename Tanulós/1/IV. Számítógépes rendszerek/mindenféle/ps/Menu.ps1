while ($true){
    Clear-Host
    Write-Host "Valakinek holnap le kell győzni a sötétséget:"
    Write-Host "1. Első"
    Write-Host "2. Második"
    Write-Host "3. Kilépés"

    $choice = Read-Host "Mondd, te kit választanál? (1-3)"
    switch ($choice) {
        "1" {
            Write-Host "Első"
        }
        "2" {
            Write-Host "Második"
        }
        "3" {
            exit 
        }
        default {
            Write-Host "Oly nehéz a választás"
        }

    }
    
        Start-Sleep -Seconds 2
}