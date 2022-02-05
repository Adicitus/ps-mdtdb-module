function Get-MDTRoleRole {

    [CmdletBinding()]
    PARAM
    (
        [Parameter(ValueFromPipelineByPropertyName=$true, Mandatory=$true)] $id
    )

    Process
    {
        Get-MDTArray $id 'R' 'Settings_Roles' 'Role'
    }
}