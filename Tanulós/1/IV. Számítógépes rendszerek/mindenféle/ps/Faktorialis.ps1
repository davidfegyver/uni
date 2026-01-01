if ($args.Length -ne 1 ) {
    Write-Host "Használat: ./$($MyInvocation.MyCommand.Name) <nemnegativ_szam>"
    exit
}
$number = [int]$args[0]
if ($number -lt 0) {
    Write-Host "🦁Everywhere the light touches, is our kingdom. The negative numbers, they are beyond our border, we should never go there. 🔥"
    exit
}

function Faktorialis($n) {
    if ($n -eq 0) {
        return 1
    } else {
        return $n * (Faktorialis ($n - 1))
    }
}

$result = Faktorialis $number

Write-Host "A $number faktoriálisa: $result"