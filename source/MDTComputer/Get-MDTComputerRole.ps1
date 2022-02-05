function Get-MDTComputerRole {

    [CmdletBinding()]
    PARAM
    (
        [Parameter(ValueFromPipelineByPropertyName=$true, Mandatory=$true)] $id
    )

    Process
    {
        Get-MDTArray $id 'C' 'Settings_Roles' 'Role'
    }
}