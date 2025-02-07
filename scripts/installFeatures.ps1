# PowerShell Script for Preparing a Windows Server for Active Directory Domain Services


#Checking and installing required features.
Function Install-FeatureIfMissing {
    param([string]$feature)

    # Get the feature status
    $featureStatus = Get-WindowsFeature -Name $feature
    
    # Check if the feature is installed
    if ($featureStatus.Installed -eq $false) {
        Write-Host "Feature $feature is not installed. Installing..." -ForegroundColor Green
        try {
            # Install the feature
            Install-WindowsFeature -Name $feature -Verbose
            Write-Host "Feature $feature installed successfully." -ForegroundColor Green
        } catch {
            Write-Host "Error installing $feature" -ForegroundColor Red
        }
    } else {
        Write-Host "Feature $feature is already installed." -ForegroundColor Yellow
    }
}


# Ensure PowerShell is running with administrator privileges
if (-not (Test-Path "HKLM:\SOFTWARE\Microsoft\PowerShell\1\ShellIds\Microsoft.PowerShell")) {
    Write-Host "Please run PowerShell as Administrator" -ForegroundColor Red
    exit
}
Write-Host "Administrator privileges confirmed." -ForegroundColor Green

# List of features to check and install if missing
$featuresToInstall = @(
    "AD-Domain-Services",      # Active Directory Domain Services
    "RSAT-AD-Tools",           # ADDS Tools
    "DNS",                     # DNS Server Feature
    "Print-Services"           # Print and Document Services
    "NET-Framework-Features"   # .NET Framework 3.5 Features
    "BitLocker"                # BitLocker Drive Encryption
    "BitLocker-NetworkUnlock"  # Bitlocker Network Unlock
    "FS-SMB1"                  # SMB 1.0/CIFS File Sharing Support
    "Search-Service"           # Windows Search Service
    "Windows-Server-Backup"    # Windwos Server Backup
)

# Looping through the list
foreach ($feature in $featuresToInstall) {
    Install-FeatureIfMissing -feature $feature
}
Write-Host "All features have been installed, please restart the server."
