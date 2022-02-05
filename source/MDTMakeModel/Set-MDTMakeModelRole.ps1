function Set-MDTMakeModelRole {

    [CmdletBinding()]
    PARAM
    (
        [Parameter(ValueFromPipelineByPropertyName=$true, Mandatory=$true)] $id,
        [Parameter(ValueFromPipelineByPropertyName=$true, Mandatory=$true)] $roles
    )

    Process
    {
        Set-MDTArray $id 'M' 'Settings_Roles' 'Role' $roles
    }
}