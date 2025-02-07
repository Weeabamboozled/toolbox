Function RemoteDesktop {

# Enable Remote Desktop
$regPath = "HKLM:\System\CurrentControlSet\Control\Terminal Server"
$regName = "fDenyTSConnections"

# Set fDenyTSConnections to 0 (which enables Remote Desktop)
Set-ItemProperty -Path $regPath -Name $regName -Value 0

# Allow Remote Desktop through Windows Firewall
Enable-NetFirewallRule -DisplayGroup "Remote Desktop"

# Check if Remote Desktop was successfully enabled
if ((Get-ItemProperty -Path $regPath -Name $regName).fDenyTSConnections -eq 0) {
    Write-Host "Remote Desktop has been successfully enabled." -ForegroundColor Green
} else {
    Write-Host "Failed to enable Remote Desktop." -ForegroundColor Red
}
return
}
RemoteDesktop