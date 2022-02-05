function Set-MDTLocationRole {

    [CmdletBinding()]
    PARAM
    (
        [Parameter(ValueFromPipelineByPropertyName=$true, Mandatory=$true)] $id,
        [Parameter(ValueFromPipelineByPropertyName=$true, Mandatory=$true)] $roles
    )

    Process
    {
        Set-MDTArray $id 'L' 'Settings_Roles' 'Role' $roles
    }
}