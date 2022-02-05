function Get-MDTMakeModelRole {

    [CmdletBinding()]
    PARAM
    (
        [Parameter(ValueFromPipelineByPropertyName=$true, Mandatory=$true)] $id
    )

    Process
    {
        Get-MDTArray $id 'M' 'Settings_Roles' 'Role'
    }
}