function Import-GitHubModule {
    param (
        [string]$ModulePath
    )

    # Fetch the GitHub PAT from environment variables (passed from the Worker)
    $GitHubPAT = $env:GITHUB_PAT
    
    # Ensure the PAT is set, otherwise exit with an error
    if (-not $GitHubPAT) {
        Write-Host "GitHub Personal Access Token (PAT) is not set. Please make sure it is passed from the Worker."
        return
    }

    # Define the repository and the URL to fetch the module
    $Repo = "Weeabamboozled/toolbox"
    $Url = "https://raw.githubusercontent.com/$Repo/main/$ModulePath"

    # Prepare headers for authentication
    $Headers = @{
        "Authorization" = "Bearer $GitHubPAT"
        "User-Agent"    = "PowerShellScript"
    }

    Try {
        # Attempt to download and import the module using the GitHub PAT for authentication
        Invoke-WebRequest -Uri $Url -Headers $Headers -OutFile "$env:TEMP\$ModulePath"
        
        # Import the module after downloading it
        Import-Module "$env:TEMP\$ModulePath" -Force
        
        # Output success message
        Write-Host "Loaded module: $ModulePath" -ForegroundColor Green
    }
    Catch {
        # Handle failure and display the error
        Write-Host "Failed to load module: $ModulePath" -ForegroundColor Red
    }
}



Import-GitHubModule "util.modules/checkAdministrator.psm1"
#Import-GitHubModule "Modules/SystemTools.psm1"

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
