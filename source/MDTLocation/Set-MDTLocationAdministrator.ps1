function Set-MDTLocationAdministrator {

    [CmdletBinding()]
    PARAM
    (
        [Parameter(ValueFromPipelineByPropertyName=$true, Mandatory=$true)] $id,
        [Parameter(ValueFromPipelineByPropertyName=$true, Mandatory=$true)] $administrators
    )

    Process
    {
        Set-MDTArray $id 'L' 'Settings_Administrators' 'Administrators' $administrators
    }
}