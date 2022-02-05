function Set-MDTLocationApplication {

    [CmdletBinding()]
    PARAM
    (
        [Parameter(ValueFromPipelineByPropertyName=$true, Mandatory=$true)] $id,
        [Parameter(ValueFromPipelineByPropertyName=$true, Mandatory=$true)] $applications
    )

    Process
    {
        Set-MDTArray $id 'L' 'Settings_Applications' 'Applications' $applications
    }
}