clear 

Get-Service | select Name, Status, startType | Where-Object {$_.Status -eq "Stopped"} | Export-Csv -Path C:\Users\champuser\jacksCSI-230-01\week2\status.csv

