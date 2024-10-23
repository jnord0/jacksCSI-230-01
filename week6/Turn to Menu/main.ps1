. "C:\Users\champuser\jacksCSI-230-01\week4\ApacheLogs1.ps1"
. "C:\Users\champuser\jacksCSI-230-01\week6\Event-Logs.ps1"
. "C:\Users\champuser\jacksCSI-230-01\week2\Process Management 1 (Q4).ps1"

$Prompt = "`n"
$Prompt += "Please choose your operation:`n"
$Prompt += "1 - List Apache Logs`n"
$Prompt += "2 - List Last Failed Loginss`n"
$Prompt += "3 - List at Risk Users`n"
$Prompt += "4 - Go to Champlain.edu`n"
$Prompt += "5 - Exit`n"


$operation = $true

while($operation){

    
    Write-Host $Prompt | Out-String
    $choice = Read-Host 

    if($choice -eq 5){
        Write-Host "Goodbye" | Out-String
        $operation = $false 
        exit
    }

    elseif($choice -eq 1){
       $tableRecords = ApacheLogs1
        $tableRecords | Format-Table -AutoSize -Wrap
    }

    elseif($choice -eq 2){
    
        $userLogins = getFailedLogins "90"
       
        Write-Host ($userLogins | Where-Object { $_.User -ilike "*$name"} | Format-Table | Out-String)
    }

    elseif($choice -eq 3){

     $days = Read-Host "Enter the number of days to check for failed logins"
          while (-not ($days -as [int])) {
            Write-Host "Invalid input. Please enter a valid number for days."
            $days = Read-Host "Enter the number of days to check for failed logins"
        }

    $userLogins = getFailedLogins $days
    $riskUsers = $userLogins | Group-Object -Property User | Where-Object { $_.Count -gt 10 }

    if ($riskUsers.Count -eq 0) {
        Write-Host "No users found with more than 10 failed logins in the last $days days."
    } else {
        Write-Host "Users at risk:"
        $riskUsers | ForEach-Object { $_.Name } | Format-Table | Out-String | Write-Host
    }
    
    }

    elseif($choice -eq 4){
    if ($null -eq (Get-Process -Name "chrome")) {
Start-Process "chrome.exe" -ArgumentList "Champlain.edu"}
else {Stop-Process -Name "chrome"}
      }
    }