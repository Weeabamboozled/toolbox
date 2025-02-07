Function checkingForAndInstallingUpdates {
# Check if NuGet provider is installed
$nuget = Get-PackageProvider -Name NuGet -ListAvailable

if (-not $nuget) {
    Write-Output "NuGet provider is not installed. Installing it now..."
    # Install the NuGet provider
    Install-PackageProvider -Name NuGet -Force -Scope CurrentUser
    Write-Output "NuGet provider installed successfully."
}

# Check if PSWindowsUpdate module is installed
$module = Get-Module -ListAvailable PSWindowsUpdate

# If the module is not installed, install it
if (-not $module) {
    Write-Output "PSWindowsUpdate module is not installed. Installing it now..."
    
    # Install the PSWindowsUpdate module
    Install-Module -Name PSWindowsUpdate -Force -Scope CurrentUser

    # Import the module after installation
    Import-Module PSWindowsUpdate
    Write-Output "PSWindowsUpdate module installed and imported successfully."
}
else {
    Write-Output "PSWindowsUpdate module found. Proceeding with updates..."
}

# Install updates
Write-Output "Installing updates..."
Install-WindowsUpdate -AcceptAll -AutoReboot -Verbose

Write-Output "Updates installed. The system will restart if required."
}
Export-ModuleMember checkingForAndInstallingUpdates
