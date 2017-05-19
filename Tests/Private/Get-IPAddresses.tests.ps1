Remove-Module AutoDoc
Import-Module "C:\Users\admin\Documents\GitHub\AutoDoc\AutoDoc.psm1"

InModuleScope AutoDoc {
    Describe 'Get-IPAddresses' {
        Context 'Fail Checks' {
            It 'Should not throw' {
                { Get-IPAddresses -ErrorAction Stop } | Should Not Throw
            }

            It 'Should not return null or empty' {
                Get-IPAddresses | Should Not BeNullOrEmpty
            }
        }

        Context 'Type Checks' {
            It 'Should be [System.Array]' {
                ,(Get-IPAddresses) | Should BeOfType [System.Array]
            }
        }

        Context 'Member Checks' {
            $IPAddresses = Get-IPAddresses

            It 'Should contain Name member' {
                ($IPAddresses).Name | Should Be $True
            }

            It 'Should contain IPAddress member' { 
                ($IPAddresses).IPAddress | Should Be $True
            }

            It 'Should contain AddressFamiliy member' {
                ($IPAddresses).AddressFamily | Should Be $True
            }

            It 'Should contain MacAddress member' {
                ($IPAddresses).MacAddress | Should Be $True
            }
        }
    }
}
