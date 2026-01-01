do{
$inp = Read-Host "Szin"

switch ($inp){

"piros"{
Write-Host -BackgroundColor Red "                    "
}
"kék"{
Write-Host -BackgroundColor Blue "                    "
}
"zöld"{
Write-Host -BackgroundColor Green "                    "
}
"sárga"{
Write-Host -BackgroundColor Yellow "                    "
}
"fekete"{
Write-Host -BackgroundColor Black "                    "
}
"fehér"{
Write-Host -BackgroundColor White "                    "
}
"elég"{
exit
}
default{
Write-Host "Nem ismerem ezt a szint!"
}

}

}
while($true)