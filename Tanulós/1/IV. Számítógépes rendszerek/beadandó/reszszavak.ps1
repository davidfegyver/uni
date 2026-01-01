param(
    [string]$InputFile = "szavak.txt"
)

$words = Get-Content $InputFile | Where-Object { $_ }

$topCount = -1
$topWord = ""

foreach ($word in $words) {
    $matches = $words -like "*$word*"
    
    $count = $matches.Count - 1

    if ($count -gt $topCount) {
        $topCount = $count
        $topWord = $word
    }
}

Write-Host "A leggyakoribb reszszo: '$topWord', ennyi masik szoban van benne: $topCount"