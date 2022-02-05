function Get-MDTMakeModelAdministrator {

    [CmdletBinding()]
    PARAM
    (
        [Parameter(ValueFromPipelineByPropertyName=$true, Mandatory=$true)] $id
    )

    Process
    {
        Get-MDTArray $id 'M' 'Settings_Administrators' 'Administrators'
    }
}