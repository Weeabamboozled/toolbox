# Function to check if the script is running as an Administrator
function checkAdministrator {
    $currentUser = New-Object Security.Principal.WindowsPrincipal([Security.Principal.WindowsIdentity]::GetCurrent())
    if (-not $currentUser.IsInRole([Security.Principal.WindowsBuiltInRole]::Administrator)) {
        Write-Error "This script requires administrative privileges. Please run as Administrator."
        exit 1
    }
}
Export-ModuleMember checkAdministrator