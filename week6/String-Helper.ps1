<# String-Helper
*************************************************************
   This script contains functions that help with String/Match/Search
   operations. 
************************************************************* 
#>

function checkPassword($password) {
    if($password.Length -ge 6) {
        if($password -match "[0-9]") {
            if($password -match "[A-Z]") {
                if($password -match "[^a-zA-Z0-9\s]") {
                    return $true
                }
            }
        }
    }
    Write-Host "Password does not meet requirements" | Out-String
    return $false
}

<# ******************************************************
   Functions: Get Matching Lines
   Input:   1) Text with multiple lines  
            2) Keyword
   Output:  1) Array of lines that contain the keyword
********************************************************* #>
function getMatchingLines($contents, $lookline){

$allines = @()
$splitted =  $contents.split([Environment]::NewLine)

for($j=0; $j -lt $splitted.Count; $j++){  
 
   if($splitted[$j].Length -gt 0){  
        if($splitted[$j] -ilike $lookline){ $allines += $splitted[$j] }
   }

}

return $allines
}