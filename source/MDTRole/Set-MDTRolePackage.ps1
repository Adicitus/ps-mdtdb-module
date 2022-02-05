function Set-MDTRolePackage {

    [CmdletBinding()]
    PARAM
    (
        [Parameter(ValueFromPipelineByPropertyName=$true, Mandatory=$true)] $id,
        [Parameter(ValueFromPipelineByPropertyName=$true, Mandatory=$true)] $packages
    )

    Process
    {
        Set-MDTArray $id 'R' 'Settings_Packages' 'Packages' $packages
    }
}