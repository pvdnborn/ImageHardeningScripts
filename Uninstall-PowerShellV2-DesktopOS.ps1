$ErrorActionPreference =  "Stop" #Stops the script if an Error occurs

$featureVariables = [ordered]@{
    Online      = $true
    FeatureName = "MicrosoftWindowsPowershellV2Root"
}

#Logging
Write-Host "Disable: $($featureVariables.FeatureName)"
$featureVariables | Format-Table -AutoSize | Write-output

#Enable Windows Feature
Disable-WindowsOptionalFeature @featureVariables