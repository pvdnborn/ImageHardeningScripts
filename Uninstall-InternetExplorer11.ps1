
Write-Host "##[command][Internet Explorer 11] Start removal of Internet Explorer 11"
$paramEXE = @{
    FilePath         = "C:\Windows\System32\dism.exe"
    ArgumentList     = "/online /Remove-Capability /CapabilityName:Browser.InternetExplorer~~~~0.0.11.0 /NoRestart"
    Wait             = $true
    PassThru         = $true
    NoNewWindow      = $true
    WorkingDirectory = "C:\Windows\System32"
}

$ExeInstallResults = Start-Process @ParamEXE -verbose

if ($ExeInstallResults.ExitCode -in @(0, 3, 3010)) {
    Write-Host "[Internet Explorer 11] Removal of Internet Explorer 11 Successful. Exitcode '$($ExeInstallResults.ExitCode)'"
} else {
    Write-Host "##vso[task.logissue type=error][Internet Explorer 11] Removal of Internet Explorer 11 failed $($ExeInstallResults.ExitCode)"
    Write-Host "##vso[task.complete result=Failed;]"
    Exit
}