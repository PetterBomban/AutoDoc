
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

function Get-IPAddresses
{
    $IPAddresses = @()
    foreach ($nic in Get-Netadapter)
    {
        ## Skip disabled adapters
        if ($nic.Status -ne 'Up') { continue }

        foreach ($ipAddr in Get-NetIPAddress)
        {
            if ($ipAddr.InterfaceIndex -eq $nic.ifIndex)
            {
                $IPAddress = [ordered]@{}
                $IPAddress['Name'] = $nic.Name
                $IPAddress['IPAddress'] = $ipAddr.IPAddress
                $IPAddress['AddressFamily'] = $ipAddr.AddressFamily
                $IPADdress['MacAddress'] = $nic.MacAddress
                $IPAddresses += ([PSCustomObject]$IPAddress)
            }
        }
    }

    Write-Output $IPAddresses
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
