function Set-MDTRoleApplication {

    [CmdletBinding()]
    PARAM
    (
        [Parameter(ValueFromPipelineByPropertyName=$true, Mandatory=$true)] $id,
        [Parameter(ValueFromPipelineByPropertyName=$true, Mandatory=$true)] $applications
    )

    Process
    {
        Set-MDTArray $id 'R' 'Settings_Applications' 'Applications' $applications
    }
}