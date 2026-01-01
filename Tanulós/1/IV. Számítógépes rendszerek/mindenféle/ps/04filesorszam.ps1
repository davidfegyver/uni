param(
[Parameter(Mandatory=$true)][string]$file
)

Get-Content $file | Measure-Object -Line | Format-List Line