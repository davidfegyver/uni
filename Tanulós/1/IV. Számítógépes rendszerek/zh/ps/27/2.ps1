$inputArray = $($input)

Write-Host "$($inputArray.Count) db érték érkezett csövön."

foreach ($num in $inputArray){
if($num -lt 0){ $melyik = "negativ"} 
if($num -eq 0){ $melyik = "nulla"} 
if($num -gt 0){ $melyik = "pozitiv"} 

Write-Host "$num $melyik"
}