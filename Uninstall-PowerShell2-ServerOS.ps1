#Unstall Powershell V2
$FeatureVariables = [ordered]@{
    Name = "PowerShell-V2"
}

# Logging
$FeatureVariables | Format-Table -AutoSize | Write-output

# Install the application
Uninstall-WindowsFeature @FeatureVariables