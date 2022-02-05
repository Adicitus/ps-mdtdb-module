function Set-MDTRoleRole {

    [CmdletBinding()]
    PARAM
    (
        [Parameter(ValueFromPipelineByPropertyName=$true, Mandatory=$true)] $id,
        [Parameter(ValueFromPipelineByPropertyName=$true, Mandatory=$true)] $roles
    )

    Process
    {
        Set-MDTArray $id 'R' 'Settings_Roles' 'Role' $roles
    }
}