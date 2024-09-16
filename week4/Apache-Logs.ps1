function ipVisited(){
#couldn't get to work without doing param
 param (
        [string]$Page,          # The page visited or referred from (e.g., index.html, page1.html)
        [int]$HTTPCode,         # The HTTP status code returned
        [string]$Browser        # The name of the web browser (e.g., Chrome, Firefox)
    )

$ipRegex = [regex]'\b(?:\d{1,3}\.){3}\d{1,3}\b'

$logFilePath = "C:\xampp\apache\logs\access.log"
$logContent = Get-Content $logFilePath

 $filteredLogs = $logContent | Where-Object {
        $_ -match $Page -and
        $_ -match $HTTPCode -and
        $_ -match $Browser
    }

$ipAddresses = foreach ($line in $filteredLogs) {
        $ipRegex.Matches($line) | ForEach-Object { $_.Value }
    }

#getting the count
$ipCounts = $ipAddresses | Group-Object | Select-Object Count, Name

return $ipCounts
}