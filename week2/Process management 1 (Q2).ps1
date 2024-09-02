clear


Get-Process | Where-Object {$_.Path -notcontains "sytems32" }