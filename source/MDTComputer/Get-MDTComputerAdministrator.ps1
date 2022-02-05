function Get-MDTComputerAdministrator {

    [CmdletBinding()]
    PARAM
    (
        [Parameter(ValueFromPipelineByPropertyName=$true, Mandatory=$true)] $id
    )

    Process
    {
        Get-MDTArray $id 'C' 'Settings_Administrators' 'Administrators'
    }
}