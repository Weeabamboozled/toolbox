# Rename-WindowsDevice.ps1
# A PowerShell script to rename a Windows device

param (
    [Parameter(Mandatory = $true, HelpMessage = "Enter the new device name.")]
    [string]$NewDeviceName
)

# Function to check if the script is running as an Administrator
function Check-Administrator {
    $currentUser = New-Object Security.Principal.WindowsPrincipal([Security.Principal.WindowsIdentity]::GetCurrent())
    if (-not $currentUser.IsInRole([Security.Principal.WindowsBuiltInRole]::Administrator)) {
        Write-Error "This script requires administrative privileges. Please run as Administrator."
        exit 1
    }
}

# Check if running as Administrator
Check-Administrator

# Confirm the device name change
Write-Host "Renaming the device to '$NewDeviceName'..." -ForegroundColor Yellow

try {
    Rename-Computer -NewName $NewDeviceName -Force -ErrorAction Stop
    Write-Host "The device name has been successfully changed to '$NewDeviceName'." -ForegroundColor Green
    Write-Host "A restart is required for the changes to take effect." -ForegroundColor Cyan
} catch {
    Write-Error "Failed to rename the device. Error: $_"
}