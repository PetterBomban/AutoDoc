function Get-GPU
{
    Write-Output (Get-CimInstance CIM_VideoController).Caption
}
