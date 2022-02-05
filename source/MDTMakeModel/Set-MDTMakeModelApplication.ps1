function Set-MDTMakeModelApplication {

    [CmdletBinding()]
    PARAM
    (
        [Parameter(ValueFromPipelineByPropertyName=$true, Mandatory=$true)] $id,
        [Parameter(ValueFromPipelineByPropertyName=$true, Mandatory=$true)] $applications
    )

    Process
    {
        Set-MDTArray $id 'M' 'Settings_Applications' 'Applications' $applications
    }
}