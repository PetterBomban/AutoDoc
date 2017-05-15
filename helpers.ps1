
function Get-ComputerMemory
{
    $memory = 0
    foreach ($stick in ((Get-CimInstance CIM_PhysicalMemory).Capacity))
    {
        $memory += $stick
    }

    Write-Output $memory
}

function Get-CPUInfo
{
    $CPUInfo = [PSCustomObject]@{
        'Number'     = 0
        'TotalCores' = 0
        'MHz'        = 0
        'Name'       = ''
    }
    foreach ($cpu in (Get-CimInstance CIM_Processor))
    {
        $CPUInfo.Number += 1
        $CPUInfo.TotalCores += $cpu.NumberOfCores
        $CPUInfo.MHz = $cpu.CurrentClockSpeed
        $CPUInfo.Name = $cpu.Name
    }

    Write-Output $CPUInfo
}

function Get-IPAddresses
{
    $IPAddress = @()
    foreach ($nic in Get-Netadapter)
    {
        ## Skip disabled adapters
        if ($nic.Status -eq "Disabled") { continue }

        foreach ($ipAddr in Get-NetIPAddress)
        {
            if ($ipAddr.InterfaceIndex -eq $nic.ifIndex)
            {
                $IPAddress += $ipAddr.IPAddress
            }
        }
    }

    Write-Output $IPAddress
}

function Get-InstalledFeatures
{
    $Features = Get-WindowsFeature
    $InstalledFeatures = @()
    foreach ($Feature in $Features)
    {
        if ($Feature.Installed -eq $true) { $InstalledFeatures += $Feature.Name }
    }

    Write-Output $InstalledFeatures
}

function Get-ComputerName
{
    Write-Output ($Env:COMPUTERNAME)
}

function Get-OperatingSystem
{
    Write-Output (Get-CimInstance Win32_OperatingSystem).Caption
}

function Get-GPU
{
    Write-Output (Get-CimInstance CIM_VideoController).Caption
}
