. (Join-Path $PSScriptRoot 'gatherClasses.ps1')

$classes = gatherClasses
$results = daysTranslator($classes)
foreach ($result in $results) {
    Write-Host "Class Code    : $($result.'Class Code')"
    Write-Host "Title         : $($result.Title)"
    Write-Host "Days          : $($result.Days)"
    Write-Host "Time Start    : $($result.'Time Start')"
    Write-Host "Time End      : $($result.'Time End')"
    Write-Host "Instructor    : $($result.Instructor)"
    Write-Host "Location      : $($result.Location)"
    Write-Host ""  # Add an empty line for spacing
}