. (Join-Path $PSScriptRoot Apache-Logs.ps1)

$results = ipVisited -Page "index.html" -HTTPCode 404 -Browser "Chrome"

$results | Format-Table