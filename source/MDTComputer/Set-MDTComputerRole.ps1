function Set-MDTComputerRole {

    [CmdletBinding()]
    PARAM
    (
        [Parameter(ValueFromPipelineByPropertyName=$true, Mandatory=$true)] $id,
        [Parameter(ValueFromPipelineByPropertyName=$true, Mandatory=$true)] $roles
    )

    Process
    {
        Set-MDTArray $id 'C' 'Settings_Roles' 'Role' $roles
    }
}