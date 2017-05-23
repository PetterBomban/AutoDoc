Remove-Module AutoDoc
Import-Module "C:\Users\admin\Documents\GitHub\AutoDoc\AutoDoc.psm1"

InModuleScope AutoDoc {
    Describe 'Get-ComputerData' {
        Context 'Fail Checks' {
            It 'Should not throw' {
                { Get-ComputerData -ErrorAction Stop } | Should Not Throw
            }

            It 'Should not return null or empty' {
                Get-ComputerData | Should Not BeNullOrEmpty
            }
        }

        Context 'Type Checks' {
            It 'Should be [PSCustomObject]'{
                ,(Get-ComputerData) | Should BeOfType [PSCustomObject]
            }
        }

        Context 'Object Members' {
            It 'ComputerName should exist' {
                $ComputerData = Get-ComputerData

                $ComputerData.ComputerName | Should BeOfType [String]
            }
        }
    }
}
