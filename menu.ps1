$ModuleUrl = "https://raw.githubusercontent.com/Weeabamboozled/toolbox/main/util.modules/checkAdministrator.psm1"
$ModulePath = "$env:TEMP\checkAdministrator.psm1"
Invoke-WebRequest -Uri $ModuleUrl -OutFile $ModulePath
Import-Module $ModulePath
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