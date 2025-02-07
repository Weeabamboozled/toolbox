function Import-GitHubModule {
    param (
        [string]$ModulePath
    )

    $Repo = "Weeabamboozled/toolbox"
    $Url = "https://raw.githubusercontent.com/$Repo/main/$ModulePath"
    
    # Replace with your GitHub Personal Access Token (or load it securely from environment/secrets)
    $GitHubPAT =  $env:GIT_PAT

    # Prepare headers for authentication
    $Headers = @{
        "Authorization" = "Bearer $GitHubPAT"
        "User-Agent"    = "PowerShellScript"
    }

    Try {
        # Download and Import the module using authentication
        Invoke-WebRequest -Uri $Url -Headers $Headers -OutFile "$env:TEMP\$ModulePath"
        Import-Module "$env:TEMP\$ModulePath" -Force
        Write-Host "Loaded module: $ModulePath" -ForegroundColor Green
    }
    Catch {
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
