function Get-OperatingSystem
{
    Write-Output (Get-CimInstance Win32_OperatingSystem).Caption
}
