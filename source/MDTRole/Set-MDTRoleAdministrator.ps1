function Set-MDTRoleAdministrator {

    [CmdletBinding()]
    PARAM
    (
        [Parameter(ValueFromPipelineByPropertyName=$true, Mandatory=$true)] $id,
        [Parameter(ValueFromPipelineByPropertyName=$true, Mandatory=$true)] $administrators
    )

    Process
    {
        Set-MDTArray $id 'R' 'Settings_Administrators' 'Administrators' $administrators
    }
}