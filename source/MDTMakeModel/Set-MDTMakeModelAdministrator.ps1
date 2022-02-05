function Set-MDTMakeModelAdministrator {

    [CmdletBinding()]
    PARAM
    (
        [Parameter(ValueFromPipelineByPropertyName=$true, Mandatory=$true)] $id,
        [Parameter(ValueFromPipelineByPropertyName=$true, Mandatory=$true)] $administrators
    )

    Process
    {
        Set-MDTArray $id 'M' 'Settings_Administrators' 'Administrators' $administrators
    }
}