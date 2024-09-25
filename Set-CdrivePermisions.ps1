<#
.SYNOPSIS
Adjusts the permissions on the C-drive for the NT AUTHORITY\Authenticated Users group.

.DESCRIPTION
This script retrieves the security principal for the SID S-1-5-11, which corresponds to the NT AUTHORITY\Authenticated Users group. It then adjusts the permissions on the C-drive by removing specific access rights for this group.

.PARAMETER None
This script does not take any parameters.

.EXAMPLE
.\Set-CdrivePermisions.ps1
This example runs the script to adjust the C-drive permissions for the NT AUTHORITY\Authenticated Users group.

.NOTES
File Path: /Set-CdrivePermisions.ps1
#>

# Adjust C-drive permissions
Write-Host "##[C-Drive]Retrieving security principal for SID S-1-5-11 (NT AUTHORITY\Authenticated Users)"
$SID = New-Object System.Security.Principal.SecurityIdentifier("S-1-5-11")
$User = $SID.Translate([System.Security.Principal.NTAccount])
Write-Host "##[C-Drive]NT AUTHORITY\Authenticated Users group name is ($($User.Value))"
Write-Host "##[command][C-Drive]Setting C-Drive permissions"

$aclroot = Get-Acl -Path "C:\"
$accessToRemove = @('AppendData', '-536805376')

foreach ($access in $accessToRemove) {
    $removeAcl = $aclroot.Access | Where-Object { $_.IdentityReference -like $User.Value -and $_.FileSystemRights -like $access }
    if ($removeAcl) {
        $aclroot.RemoveAccessRule($removeAcl)
        Write-Host "##[C-Drive]Removed [$($User.Value)] with access [$access]"
    }
}

Write-Host "##[C-Drive]Start applying new ACL on C-Drive - This might take a while"
$null = Set-Acl -Path "C:\" -AclObject $aclroot