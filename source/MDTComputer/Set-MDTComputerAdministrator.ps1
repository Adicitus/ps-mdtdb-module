function Set-MDTComputerAdministrator {

    [CmdletBinding()]
    PARAM
    (
        [Parameter(ValueFromPipelineByPropertyName=$true, Mandatory=$true)] $id,
        [Parameter(ValueFromPipelineByPropertyName=$true, Mandatory=$true)] $administrators
    )

    Process
    {
        Set-MDTArray $id 'C' 'Settings_Administrators' 'Administrators' $administrators
    }
}