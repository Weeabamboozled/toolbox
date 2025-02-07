WriteHost "Disabling IEESC for Administrators" -ForegroundColor Yellow
$regKey = "HKLM:\SOFTWARE\Microsoft\Active Setup\Installed Components\{A509B1A7-37EF-4b3f-8CFC-4F3A74704073}"
Set-ItemProperty -Path $regKey -Name "IsInstalled" -Value 0
WriteHost "IEESC has been disabled for Administrators" -ForegroundColor Green