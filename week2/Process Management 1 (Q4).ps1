clear 

if ($null -eq (Get-Process -Name "chrome")) {
Start-Process "chrome.exe" -ArgumentList "Champlain.edu"}
else {Stop-Process -Name "chrome"}