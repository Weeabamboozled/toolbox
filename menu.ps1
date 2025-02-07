# URL to the raw GitHub file containing the checkAdministrator function
$GitHubUrl = "https://raw.githubusercontent.com/Weeabamboozled/toolbox/main/modules/checkAdministrator.psm1"

# Path to save the module temporarily
$ModulePath = "$env:TEMP\checkAdministrator.psm1"

# Download the module
Invoke-WebRequest -Uri $GitHubUrl -OutFile $ModulePath

# Import the module to make the function available
Import-Module $ModulePath

# Now you can call the checkAdministrator function
checkAdministrator
Pause

function Show-Menu {
    Clear-Host
    Write-Host "========================="
    Write-Host "      Utility Menu       "
    Write-Host "========================="
    Write-Host "1. Run System Info"
    Write-Host "2. Check Network Status"
    Write-Host "3. Exit"
    Write-Host "========================="
}

while ($true) {
    Show-Menu
    $choice = Read-Host "Select an option (1-3)"

    switch ($choice) {
        "1" { Get-ComputerInfo; Pause }
        "2" { Test-Connection google.com -Count 4; Pause }
        "3" { Write-Host "Exiting..."; exit }
        "4" { checkAdministrator; Pause}
        default { Write-Host "Invalid option, please try again."; Pause }
    }
}