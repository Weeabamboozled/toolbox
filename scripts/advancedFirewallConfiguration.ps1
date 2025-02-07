Function advancedFirewallConfiguration {
# Enable Firewall if it's disabled, then configure inbound rules
Write-Host "Checking Windows Firewall status..."

# Get the status of the firewall for all profiles
$firewallProfiles = Get-NetFirewallProfile

foreach ($profile in $firewallProfiles) {
    # Check if the firewall is disabled for the profile
    if ($profile.Enabled -eq $false) {
        Write-Host "Firewall is disabled for the $($profile.Name) profile. Enabling it now..."
        Set-NetFirewallProfile -Profile $profile.Name -Enabled True
    } else {
        Write-Host "Firewall is already enabled for the $($profile.Name) profile."
    }
}

# Allow inbound connections for all profiles
Write-Host "Configuring inbound connection rules to allow for all profiles..."
Set-NetFirewallProfile -Profile Domain,Private,Public -DefaultInboundAction Allow

Write-Host "Firewall configuration completed successfully."
}
advancedFirewallConfiguration