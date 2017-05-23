Remove-Module AutoDoc
Import-Module "C:\Users\admin\Documents\GitHub\AutoDoc\AutoDoc.psm1"

InModuleScope AutoDoc {
    Describe 'Get-ComputerMemory' {
        Context 'Fail Checks' {
            It 'Should not throw' {
                { Get-ComputerMemory -ErrorAction Stop } | Should Not Throw
            }

            It 'Should not return null or empty' {
                Get-ComputerMemory | Should Not BeNullOrEmpty
            }
        }
        
        Context 'Type Checks' {
            $ComputerMemory = Get-ComputerMemory

            It 'Should be [PSCustomObject]' {
                $ComputerMemory | Should BeOfType [PSCustomObject]
            }

            It 'Capacity should be [UInt64]' {
                $ComputerMemory.TotalCapacity | Should BeOfType [UInt64]
            }

            It 'Slots should be [Int]' {
                $ComputerMemory.TotalSlots | Should BeOfType [Int]
            }
        }
    }
}
