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
            It 'Should be [System.Object]' {
                Get-ComputerMemory | Should BeOfType [System.Object]
            }

            It 'Capacity should be [UInt64]' {
                (Get-ComputerMemory).TotalCapacity | Should BeOfType [UInt64]
            }

            It 'Slots should be [Int]' {
                (Get-ComputerMemory).TotalSlots | Should BeOfType [Int]
            }
        }
    }
}
