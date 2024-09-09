function logging($days){

$loginouts = Get-EventLog system -source Microsoft-Windows-Winlogon -After (Get-Date).AddDays($days)

$loginoutsTable = @()
for ($i=0; $i -lt $loginouts.Count; $i++) {

$event = ""
if($loginouts[$i].InstanceId -eq "7001") {$event="Logon"}
if($loginouts[$i].InstanceId -eq "7002") {$event="Logoff"}

$SID = New-Object System.Security.Principal.SecurityIdentifier($loginouts[$i].ReplacementStrings[1])
$User = $SID.Translate([System.Security.Principal.NTAccount])

$loginoutsTable += [pscustomobject]@{"Time" = $loginouts[$i].TimeGenerated; `
                                       "Id" = $loginouts[$i].InstanceId; `
                                    "Event" = $event; `
                                     "User" = $User.Value;
                                     }
}
return $loginoutsTable
}




function shutting($days){

$loginouts = Get-EventLog system -source Microsoft-Windows-Kernel-Power -After (Get-Date).AddDays($days)

$loginoutsTable = @()
for ($i=0; $i -lt $loginouts.Count; $i++) {

$event = ""
if($loginouts[$i].EventID -eq "172") {$event="Turnon"}
if($loginouts[$i].EventID -eq "109") {$event="Shutoff"}


$User = "System"

$loginoutsTable += [pscustomobject]@{"Time" = $loginouts[$i].TimeGenerated; `
                                       "Id" = $loginouts[$i].EventID; `
                                    "Event" = $event; `
                                     "User" = $User;
                                     }
}
return $loginoutsTable
}
