Function DisableIPv6 {

# Disable IPv6 on all network interfaces
Write-Host "Disabling IPv6..." -ForegroundColor Green

# Get all network adapters and disable IPv6 protocol binding
$adapters = Get-NetAdapter

foreach ($adapter in $adapters) {
    Write-Host "Disabling IPv6 on adapter: $($adapter.Name)" -ForegroundColor Yellow
    Disable-NetAdapterBinding -Name $adapter.Name -ComponentID "ms_tcpip6"
}

# Disable Teredo (IPv6 tunneling protocol)
Write-Host "Disabling Teredo..." -ForegroundColor Yellow
Set-NetTeredoConfiguration -Type Disabled

Write-Host "IPv6 has been Disabled." -ForegroundColor Green
return
}
Function EnableIPv6 {
Write-Host "Re-enabling IPv6..." -ForegroundColor Green

# Get all network adapters and enable IPv6 protocol binding
$adapters = Get-NetAdapter

foreach ($adapter in $adapters) {
    Write-Host "Enabling IPv6 on adapter: $($adapter.Name)" -ForegroundColor Yellow
    Enable-NetAdapterBinding -Name $adapter.Name -ComponentID "ms_tcpip6"
}

# Re-enable Teredo (IPv6 tunneling protocol)
Write-Host "Re-enabling Teredo..." -ForegroundColor Yellow
Set-NetTeredoConfiguration -Type Default

Write-Host "IPv6 has been Enabled." -ForegroundColor Green
return
}
Function Done { 
Write-Host "No Changes have been made." -ForegroundColor Green 
return
}

# Hash table for the choices and related actions These are not case sensitive which is a plus
$actions = @{
Enable = {EnableIPv6}
Disable = {DisableIPv6}
Done = {Done}
}

Write-Host "Do you want to Enable or Disable IPv6?" -ForegroundColor Yellow
Write-Host "(Enable) Will Enable IPv6 on all Network Adapters"
Write-Host "(Disable) Will Disable IPv6 on all Network Adapters"
Write-Host "(Done) Will skip configuration and no changes will be made"
$choice = Read-Host

# Execute the action if it exists, else show an error
if ($actions.ContainsKey($choice)) {
    $actions[$choice].Invoke()
} else {
    Done
}