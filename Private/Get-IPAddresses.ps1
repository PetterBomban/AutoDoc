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
