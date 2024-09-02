clear 
#Q1
#Get-Process | Where-Object {$_.Name -ilike "C*" }

#Q2

Get-Process | Where-Object {$_.Path -notcontains "sytems32" }
