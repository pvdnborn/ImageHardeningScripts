#Disable Cached Logons on server
Write-Host "##[command][Cached-Credentials] Disabling Cached Credentials"
$securityCachedLogonsCount = [ordered] @{
    RegistryPath  = "HKLM:\SOFTWARE\Microsoft\Windows NT\CurrentVersion\Winlogon"
    RegistryName  = "CachedLogonsCount"
    RegistryValue = "0"
    RegistryType  = "String"
}
$securityCachedLogonsCount | Format-Table -AutoSize | Write-Output
Set-RegistryValue @securityCachedLogonsCount
Write-Host "[Cached-Credentials] done"