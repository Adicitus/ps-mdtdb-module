function Clear-MDTRoleAdministrator {

    [CmdletBinding()]
    PARAM
    (
        [Parameter(ValueFromPipelineByPropertyName=$true, Mandatory=$true)] $id
    )

    Process
    {
        Clear-MDTArray $id 'R' 'Settings_Administrators'
    }
}