$s = 0
$inputArr = @($input)

if($inputArr.count -eq 0){
    foreach($szam in $args){
        $s += $szam
    }
}else{
    foreach($szam in $inputArr){
        $s += $szam
    }
}
write-host "$s"