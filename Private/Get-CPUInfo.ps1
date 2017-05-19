function Get-CPUInfo
{
    $CPUInfo = [PSCustomObject]@{
        'Sockets'           = 0
        'TotalCores'        = 0
        'CurrentClockSpeed' = 0
        'Name'              = ''
    }
    foreach ($cpu in (Get-CimInstance CIM_Processor))
    {
        $CPUInfo.Sockets += 1
        $CPUInfo.TotalCores += $cpu.NumberOfCores
        $CPUInfo.CurrentClockSpeed = $cpu.CurrentClockSpeed
        $CPUInfo.Name = $cpu.Name
    }

    Write-Output $CPUInfo
}
