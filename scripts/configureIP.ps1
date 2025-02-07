# Optional IP configuration prompt

Function Configure-IP{
    # Providing a list of all available Network Adapters
    $networkAdapters = Get-NetAdapter | Where-Object { $_.Status -eq 'Up' } | Select-Object -Property Name, InterfaceAlias
    Write-Host "Available network adapters:" 
    $networkAdapters | ForEach-Object { Write-Host "$($_.Name) - Alias: $($_.InterfaceAlias)" }
    
    # Allowing you to select the network adapter by name
    $InterfaceAlias = Read-Host "Enter the network adapter name or Alias you want to configure (e.g., 'Ethernet')"
    # Checking the Validity of the network adapter selected
    $selectedAdapter = $networkAdapters | Where-Object { $_.Name -eq $InterfaceAlias -or $_.InterfaceAlias -eq $InterfaceAlias }

    if ($selectedAdapter) {

    $IP = Read-Host "Enter the IP Address: "
    $Subnet = Read-Host "Enter the Subnet Mask: "
    $Gateway = Read-Host "Enter the Default Gateway: "
    $PrimaryDNS = Read-Host "Enter the DNS Server Address: "
    $SecondaryDNS = Read-Host "Enter the Secondary DNS Server Address: "
    
    # Set default values if input is blank 
    if (-not $IP) { $IP = "192.168.1.10" }
    if (-not $Subnet) { $Subnet = "255.255.255.0" }
    if (-not $Gateway) { $Gateway = "192.168.1.1" }
    if (-not $PrimaryDNS) { $PrimaryDNS = "192.168.1.1" }
    if (-not $SecondaryDNS) { $SecondaryDNS = "8.8.8.8" }
    
    Write-Host "Configuring static IP..."
    Write-Host "Interface Alias: $InterfaceAlias"
    Write-Host "IP Address: $IP"
    Write-Host "Subnet Mask: $Subnet"
    Write-Host "Default Gateway: $Gateway"
    Write-Host "DNS Server: $DNS"
    Write-Host "Secondary DNS Server: $SecondaryDNS"

    # Apply the IP settings
    New-NetIPAddress -InterfaceAlias $InterfaceAlias -IPAddress $IP -PrefixLength 24 -DefaultGateway $Gateway
    Set-DnsClientServerAddress -InterfaceAlias $InterfaceAlias -ServerAddresses ($PrimaryDNS, $SecondaryDNS)

    Write-Host "IP Configuration applied successfully." -ForegroundColor Green
    return
    }  else {
            Write-Host "Invalid network adapter name or alias provided. Skipping IP configuration." -ForegroundColor Red
            return  # Exit the function if the interface alias is invalid
        }

}

Write-Host "Do you want to configure a static IP address? (Y/N)"
$configureIP = Read-Host
if ($configureIP -eq 'Y' -or $configureIP -eq 'y') {
    Configure-IP
} else {
    Write-host "Skipping IP configuration"
}
