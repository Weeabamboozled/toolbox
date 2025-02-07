Function PrivateShareSettings {

# Enable Network Discovery for Private Network
$networkCategory = "Private"
# Enable the required firewall rules for network discovery on the Private network
Set-NetFirewallRule -DisplayGroup "Network Discovery" -Profile Private -Enabled True
# Ensure Network Discovery is enabled for the Private network profile
Set-NetConnectionProfile -NetworkCategory $networkCategory
Write-Host "Network Discovery has been successfully enabled for Private networks." -ForegroundColor Green
return
}
PrivateShareSettings